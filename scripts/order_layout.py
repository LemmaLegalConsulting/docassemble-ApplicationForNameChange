"""Keep each repeated NAM107 order's findings and page breaks independent."""
from docx import Document
from docx.shared import Pt


def repair_order_template(path):
    document = Document(path)
    # The original has three decimal list groups: findings 1-4, 5, and 6-9.
    numbers = {3: 0, 5: 4, 6: 5}
    for paragraph in document.paragraphs:
        if 'IT IS ORDERED' in paragraph.text:
            break
        numbering = paragraph._p.xpath('./w:pPr/w:numPr')
        if numbering and numbering[0].numId.val in numbers:
            group = numbering[0].numId.val
            numbers[group] += 1
            numbering[0].getparent().remove(numbering[0])
            paragraph.runs[0].text = f'{numbers[group]}. ' + paragraph.runs[0].text
    # The loop's explicit page-break paragraph must not itself take a normal
    # line of space at the end of a full order, producing a footer-only page.
    for paragraph in document.paragraphs:
        if paragraph._p.xpath('.//w:br[@w:type="page"]'):
            formatting = paragraph.paragraph_format
            formatting.space_before = Pt(0)
            formatting.space_after = Pt(0)
            formatting.line_spacing = Pt(1)
            formatting.keep_with_next = False
            formatting.keep_together = False
            for run in paragraph.runs:
                run.font.size = Pt(1)
    document.save(path)


if __name__ == '__main__':
    from pathlib import Path
    repair_order_template(Path(__file__).resolve().parents[1] / 'docassemble/ApplicationForNameChange/data/templates/proposed_name_change_order.docx')
