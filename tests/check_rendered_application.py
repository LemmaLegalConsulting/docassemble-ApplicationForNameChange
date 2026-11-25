"""Validate a downloaded NAM102's fields and portable appearances independently."""
import argparse
import json
from pypdf import PdfReader
from pypdf.generic import ContentStream


def check(path):
    reader = PdfReader(path)
    fields = reader.get_fields() or {}
    assert len(fields) == 152, 'NAM102 canonical field tree is incomplete'
    assert reader.trailer['/Root']['/AcroForm']['/NeedAppearances'].value is False
    text_count = button_count = 0
    for page in reader.pages:
        for ref in page.get('/Annots', []):
            widget = ref.get_object()
            field = widget
            while '/T' not in field and '/Parent' in field:
                field = field['/Parent']
            if '/T' not in field:
                continue
            name = str(field['/T'])
            canonical = fields[name].get('/V', '')
            assert widget.get('/V', field.get('/V', '')) == canonical, name
            if field.get('/FT') == '/Btn':
                assert widget['/AS'] in widget['/AP']['/N'], name
                button_count += 1
            if field.get('/FT') != '/Tx' or not str(canonical):
                continue
            appearance = widget['/AP']['/N']
            assert appearance.get_data(), name
            font = None
            for operands, operator in ContentStream(appearance, reader).operations:
                if operator == b'Tf':
                    font = appearance['/Resources']['/Font'][operands[0]]
                    assert float(operands[1]) >= 9, name
                if operator in (b'Tj', b'TJ', b"'", b'"'):
                    assert font is not None and '/FontDescriptor' in font, name
                    assert '/FontFile2' in font['/FontDescriptor'], name
                    assert '/ToUnicode' in font, name
            text_count += 1
    return {'fields': len(fields), 'text_appearances': text_count,
            'checkbox_states': button_count, 'pages': len(reader.pages)}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('pdf')
    args = parser.parse_args()
    print(json.dumps(check(args.pdf)))
