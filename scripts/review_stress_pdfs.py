"""Render locally downloaded stress PDFs and record geometry for visual review.

Usage: python scripts/review_stress_pdfs.py ARTIFACT_DIR OUTPUT_DIR
Geometry flags are review prompts, not a substitute for inspecting page images.
Requires optional local PyMuPDF and Pillow; does not modify source PDFs.
"""
from pathlib import Path
import argparse
import json
import re
import pymupdf as fitz
from PIL import Image, ImageDraw


def review(artifacts, output):
    output.mkdir(parents=True, exist_ok=True)
    result = []
    for number, source in enumerate(sorted(artifacts.rglob('*.pdf')), 1):
        folder = output / f'{number:02d}-{source.stem}'
        folder.mkdir(exist_ok=True)
        document = fitz.open(source)
        pages, thumbnails = [], []
        for index, page in enumerate(document):
            text = page.get_text()
            spans = [span for block in page.get_text('dict')['blocks'] if 'lines' in block
                     for line in block['lines'] for span in line['spans'] if span['text'].strip()]
            outside = [span['text'] for span in spans if not page.rect.contains(fitz.Rect(span['bbox']))]
            small = [{'text': s['text'], 'size': round(s['size'], 2)} for s in spans if s['size'] < 8]
            signatures = [{'text': s['text'], 'bbox': list(s['bbox'])} for s in spans
                          if re.search(r'signature|sign here|judge of|notary', s['text'], re.I)]
            page.get_pixmap(matrix=fitz.Matrix(1.5, 1.5), alpha=False).save(folder / f'page-{index+1:02d}.png')
            thumb = Image.open(folder / f'page-{index+1:02d}.png').convert('RGB')
            thumb.thumbnail((306, 396))
            tile = Image.new('RGB', (326, 426), '#ddd')
            tile.paste(thumb, ((326-thumb.width)//2, 20))
            ImageDraw.Draw(tile).text((10, 408), f'Page {index+1}', fill='black')
            thumbnails.append(tile)
            pages.append({'page': index+1, 'width': page.rect.width, 'height': page.rect.height,
                          'characters': len(text), 'outside_page': outside, 'small_text': small,
                          'signature_labels': signatures, 'replacement_characters': text.count('\ufffd')})
        for start in range(0, len(thumbnails), 12):
            batch = thumbnails[start:start+12]
            sheet = Image.new('RGB', (326*3, 426*((len(batch)+2)//3)), 'white')
            for i, thumb in enumerate(batch): sheet.paste(thumb, ((i%3)*326, (i//3)*426))
            sheet.save(folder / f'contact-{start//12+1:02d}.png')
        extracted = '\n\f\n'.join(page.get_text() for page in document)
        (folder / 'text.txt').write_text(extracted, encoding='utf-8')
        result.append({'source': str(source.resolve()), 'render_folder': str(folder.resolve()),
                       'page_count': len(document), 'pages': pages})
    (output / 'geometry.json').write_text(json.dumps(result, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    print(json.dumps([{'file': Path(r['source']).name, 'scenario': Path(r['source']).parent.name,
                       'pages': r['page_count'], 'folder': r['render_folder'],
                       'outside_spans': sum(len(p['outside_page']) for p in r['pages']),
                       'small_spans': sum(len(p['small_text']) for p in r['pages'])} for r in result], indent=2))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('artifacts', type=Path)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    review(args.artifacts, args.output)
