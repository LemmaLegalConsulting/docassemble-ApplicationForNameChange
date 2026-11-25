from io import BytesIO
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from pypdf import PdfReader, PdfWriter
from pypdf.generic import NameObject, TextStringObject
from reportlab.pdfgen.canvas import Canvas

from docassemble.ApplicationForNameChange.pdf_layout import repair_application


class PortableApplication(unittest.TestCase):
    def source(self, path, values, checkboxes=False):
        buffer = BytesIO()
        canvas = Canvas(buffer)
        for offset, name in enumerate(values):
            canvas.acroForm.textfield(name=name, x=72, y=700-offset*30, width=100, height=22)
        if checkboxes:
            canvas.acroForm.checkbox(name='checked', x=72, y=650, checked=True)
            canvas.acroForm.checkbox(name='unchecked', x=72, y=620, checked=False)
        canvas.showPage()
        canvas.save()
        writer = PdfWriter()
        writer.clone_document_from_reader(PdfReader(buffer))
        for page in writer.pages:
            for ref in page['/Annots']:
                field = ref.get_object()
                if field['/T'] in values:
                    field[NameObject('/V')] = TextStringObject(values[field['/T']])
        writer.write(path)

    def test_unicode_has_embedded_appearances_and_matching_canonical_values(self):
        with TemporaryDirectory() as folder:
            source, output = [Path(folder)/n for n in ('source.pdf', 'output.pdf')]
            values = {'latin': 'Dvořák', 'cjk': '美咲 山田'}
            self.source(source, values)
            repair_application(source, output)
            reader = PdfReader(output)
            self.assertFalse(reader.trailer['/Root']['/AcroForm']['/NeedAppearances'].value)
            for ref in reader.pages[0]['/Annots']:
                widget = ref.get_object()
                self.assertEqual(reader.get_fields()[widget['/T']]['/V'], values[widget['/T']])
                self.assertEqual(widget['/V'], values[widget['/T']])
                appearance = widget['/AP']['/N']
                self.assertTrue(appearance.get_data())
                fonts = [f.get_object() for f in appearance['/Resources']['/Font'].values()]
                self.assertTrue(any('/FontDescriptor' in f and '/FontFile2' in f['/FontDescriptor'] for f in fonts))

    def test_overflow_keeps_the_complete_value_and_adds_each_minor_signature(self):
        with TemporaryDirectory() as folder:
            source, output, repeated = [Path(folder)/n for n in ('source.pdf', 'output.pdf', 'repeated.pdf')]
            name = 'Alexandria-Cassandre Éléonore García-Montgomery-Washington-Świątek'
            self.source(source, {'long_name': name})
            signers = ['Élodie Original', 'Søren Original', 'Zoë Original']
            repair_application(source, output, signers)
            reader = PdfReader(output)
            self.assertEqual(reader.get_fields()['long_name']['/V'], '[1]')
            text = '\n'.join(p.extract_text() for p in reader.pages[1:])
            self.assertIn(name, text)
            for signer in signers:
                self.assertIn(signer, text)
            self.assertEqual(text.count('Signature:'), 3)
            self.assertEqual(text.count('under penalty of perjury'), 3)
            repair_application(output, repeated, signers)
            self.assertEqual(len(reader.pages), len(PdfReader(repeated).pages))

    def test_checkbox_states_remain_selected_or_unselected_without_font_fallback(self):
        with TemporaryDirectory() as folder:
            source, output = [Path(folder)/n for n in ('source.pdf', 'output.pdf')]
            self.source(source, {}, checkboxes=True)
            before = PdfReader(source).get_fields()
            repair_application(source, output)
            reader = PdfReader(output)
            for ref in reader.pages[0]['/Annots']:
                widget = ref.get_object()
                self.assertEqual(widget['/V'], before[widget['/T']]['/V'])
                self.assertEqual(widget['/AS'], widget['/V'])
                content = widget['/AP']['/N'][widget['/AS']].get_data()
                self.assertNotIn(b'Tj', content)
                self.assertEqual(b' l' in content, widget['/T'] == 'checked')


if __name__ == '__main__':
    unittest.main()
