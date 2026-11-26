"""Portable, editable NAM102 appearances and complete continuation/signature pages.

The court's page content and checkbox selections are preserved. Text widgets
get embedded-font appearance streams; values that cannot fit at 9pt move in full
to a referenced continuation instead of being clipped or reduced indefinitely.
"""
from io import BytesIO
from pathlib import Path
import re

from pypdf import PdfReader, PdfWriter
from pypdf.generic import (
    ArrayObject, BooleanObject, DecodedStreamObject, DictionaryObject,
    FloatObject, NameObject, NumberObject, TextStringObject,
)
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfgen.canvas import Canvas

FONT_DIR = Path(__file__).parent / 'data/static/fonts'
VERSION = '1'


def register_fonts():
    for name, filename in [('NameChangeLatin', 'DejaVuSans.ttf'),
                           ('NameChangeCJK', 'DroidSansFallbackFull.ttf')]:
        if name not in pdfmetrics.getRegisteredFontNames():
            pdfmetrics.registerFont(TTFont(name, str(FONT_DIR / filename)))


def font_for(character):
    for name in ('NameChangeLatin', 'NameChangeCJK'):
        if ord(character) in pdfmetrics.getFont(name).face.charToGlyph:
            return name
    raise ValueError(f'No bundled font covers U+{ord(character):04X}')


def runs(text):
    current, result = None, []
    for character in text:
        font = font_for(character)
        if current == font:
            result[-1][1] += character
        else:
            result.append([font, character])
            current = font
    return result


def width(text, size):
    return sum(pdfmetrics.stringWidth(value, font, size) for font, value in runs(text))


def draw(canvas, text, x, y, size):
    for font, value in runs(text):
        canvas.setFont(font, size)
        canvas.drawString(x, y, value)
        x += pdfmetrics.stringWidth(value, font, size)


def wrap(text, size, available):
    """Wrap on whitespace where possible; split a single oversized token safely."""
    lines = []
    for paragraph in text.split('\n'):
        line = ''
        for token in re.findall(r'\S+\s*', paragraph):
            if line and width((line + token).rstrip(), size) > available:
                lines.append(line.rstrip())
                line = ''
            for char in token:
                if line and width(line + char, size) > available:
                    lines.append(line.rstrip())
                    line = ''
                line += char
        lines.append(line.rstrip())
    return lines


def field_layout(value, available_width, available_height, multiline):
    for size in (11, 10, 9):
        lines = wrap(value, size, available_width) if multiline else [value.replace('\n', ' ')]
        if all(width(line, size) <= available_width for line in lines) and len(lines) * size * 1.2 <= available_height:
            return size, lines
    return None


def form_stream(writer, buffer, w, h):
    page = PdfReader(buffer).pages[0]
    stream = DecodedStreamObject()
    stream.set_data(page.get_contents().get_data())
    stream.update({NameObject('/Type'): NameObject('/XObject'),
                   NameObject('/Subtype'): NameObject('/Form'),
                   NameObject('/FormType'): NumberObject(1),
                   NameObject('/BBox'): ArrayObject([FloatObject(n) for n in (0, 0, w, h)]),
                   NameObject('/Resources'): page['/Resources'].clone(writer)})
    return writer._add_object(stream)


def checkbox_appearance(writer, rect, checked):
    w, h = float(rect[2]-rect[0]), float(rect[3]-rect[1])
    buffer = BytesIO()
    canvas = Canvas(buffer, pagesize=(w, h))
    if checked:
        canvas.setLineWidth(1.1)
        path = canvas.beginPath()
        path.moveTo(w*.16, h*.48)
        path.lineTo(w*.40, h*.20)
        path.lineTo(w*.86, h*.86)
        canvas.drawPath(path)
    canvas.showPage()
    canvas.save()
    return form_stream(writer, buffer, w, h)


def appearance(writer, text, rect, multiline):
    w, h = float(rect[2] - rect[0]), float(rect[3] - rect[1])
    layout = field_layout(text, w - 4, h - 2, multiline)
    if layout is None:
        raise ValueError('Reference does not fit in its field')
    size, lines = layout
    buffer = BytesIO()
    canvas = Canvas(buffer, pagesize=(w, h))
    y = h - 1 - size
    for line in lines:
        draw(canvas, line, 2, y, size)
        y -= size * 1.2
    canvas.save()
    return form_stream(writer, buffer, w, h)


class Continuations:
    def __init__(self, county, applicant):
        self.buffer = BytesIO()
        self.canvas = Canvas(self.buffer, pagesize=(612, 792))
        self.county, self.applicant = county, applicant
        self.page = 0
        self.y = 0

    def new_page(self, title):
        if self.page:
            self.canvas.showPage()
        self.page += 1
        self.title = title
        draw(self.canvas, title, 54, 744, 12)
        draw(self.canvas, f'County: {self.county}', 54, 724, 10)
        self.y = 704
        heading = 'Applicant: ' + self.applicant
        if len(wrap(heading, 10, 504)) > 2:
            heading = 'Applicant: see NAM102 page 1 and the referenced name continuations'
        self.paragraph(heading, 10)
        self.y -= 8
        draw(self.canvas, f'NAM102 supplement - {self.page}', 54, 30, 9)

    def paragraph(self, text, size=11):
        for line in wrap(text, size, 504):
            if self.y < 64:
                self.new_page(self.title + ' continued' if not self.title.endswith('continued') else self.title)
            draw(self.canvas, line, 54, self.y, size)
            self.y -= size * 1.4

    def add_fields(self, entries):
        if not entries:
            return
        self.new_page('Application for name change continuation')
        for ref, page, label, value in entries:
            if self.y < 110:
                self.new_page(self.title)
            self.paragraph(f'[{ref}] Page {page}: {label}', 10)
            self.paragraph(value)
            self.y -= 14

    def add_signatures(self, signers):
        if not signers:
            return
        self.new_page('Additional minor signatures for NAM102')
        for name in signers:
            if self.y < 235:
                self.new_page('Additional minor signatures for NAM102')
            self.paragraph('Minor: ' + name)
            self.paragraph('I declare under penalty of perjury that everything I have stated in this document is true and correct. Minn. Stat. § 358.116.', 10)
            self.y -= 26
            draw(self.canvas, 'Signature: __________________________   Date: ______________', 54, self.y, 10)
            self.y -= 26
            draw(self.canvas, 'County and state where signed: ______________________________', 54, self.y, 10)
            self.y -= 30

    def finish(self):
        self.canvas.save()
        return PdfReader(self.buffer) if self.page else None


def repair_application(source, destination, minor_signers=()):
    """Repair generated PDF text without flattening fields or filling signatures."""
    register_fonts()
    reader = PdfReader(source)
    if reader.trailer['/Root'].get('/NameChangeLayout') == VERSION:
        Path(destination).write_bytes(Path(source).read_bytes())
        return
    writer = PdfWriter()
    writer.clone_document_from_reader(reader)
    # AssemblyLine's concatenation may leave widgets without a field tree.
    # Only recover a wholly absent tree, never add duplicate canonical fields.
    if not writer.get_fields():
        writer.reattach_fields()
    fields = writer.get_fields() or {}
    values = {name: str(field.get('/V', '')) for name, field in fields.items()}
    entries = []
    for page_number, page in enumerate(writer.pages, 1):
        for reference in page.get('/Annots', []):
            widget = reference.get_object()
            field = widget
            while '/T' not in field and '/Parent' in field:
                field = field['/Parent']
            if field.get('/FT') == '/Btn':
                states = set(widget.get('/AP', {}).get('/N', {}).keys()) | {'/Off'}
                widget[NameObject('/AP')] = DictionaryObject({NameObject('/N'): DictionaryObject({NameObject(state): checkbox_appearance(writer, widget['/Rect'], state != '/Off') for state in states})})
                continue
            if field.get('/FT') != '/Tx':
                continue
            name = str(field['/T'])
            value = str(field.get('/V', ''))
            if not value:
                continue
            if name == 'minor_fourteen_years_old_name_full' and minor_signers:
                value = 'See signature sheet'
            rect = widget['/Rect']
            multiline = bool(int(field.get('/Ff', 0)) & 4096)
            if field_layout(value, float(rect[2]-rect[0])-4, float(rect[3]-rect[1])-2, multiline) is None:
                ref = str(len(entries) + 1)
                entries.append((ref, page_number, str(field.get('/TU', name)), value))
                value = f'[{ref}]'
            field[NameObject('/V')] = TextStringObject(value)
            if widget is not field and '/V' in widget:
                widget[NameObject('/V')] = TextStringObject(value)
            widget[NameObject('/AP')] = DictionaryObject({NameObject('/N'): appearance(writer, value, rect, multiline)})
    supplement = Continuations(values.get('district_court_county', ''), ' '.join(values.get(f'users1_name_{part}', '') for part in ('first', 'middle', 'last')).strip())
    supplement.add_fields(entries)
    supplement.add_signatures(minor_signers)
    extra = supplement.finish()
    if extra:
        for page in extra.pages:
            writer.add_page(page)
    writer.root_object['/AcroForm'][NameObject('/NeedAppearances')] = BooleanObject(False)
    writer.root_object[NameObject('/NameChangeLayout')] = TextStringObject(VERSION)
    writer.write(destination)
