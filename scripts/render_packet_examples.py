"""Render synthetic companion forms for visual review (outside tracked files)."""
from pathlib import Path
import importlib.util,subprocess,json
from docxtpl import DocxTemplate
from jinja2 import Environment,StrictUndefined
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('packet_samples',ROOT/'tests/test_packet_templates.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
out=ROOT.parent/'template-previews/ApplicationForNameChange/packet';out.mkdir(parents=True,exist_ok=True)
c=m.context()
names=['criminal_history_releases','proposed_name_change_order','felony_name_change_notices','inmate_name_change_affidavit','parental_hearing_notice','parental_personal_service','parental_publication_request','fee_waiver_affidavit','Application_for_name_change_next_steps']
for name in names:
 d=DocxTemplate(ROOT/'docassemble/ApplicationForNameChange/data/templates'/(name+'.docx'))
 d.render(c,jinja_env=Environment(undefined=StrictUndefined),autoescape=True);d.save(out/(name+'.docx'))
subprocess.run(['libreoffice','--headless','-env:UserInstallation=file:///tmp/mn-packet-preview','--convert-to','pdf','--outdir',str(out),*[str(p) for p in out.glob('*.docx')]],check=True)
for name in names:
 assert (out/(name+'.pdf')).exists(), 'PDF conversion failed: '+name
from pypdf import PdfReader
report=[]
for p in out.glob('*.pdf'):
 r=PdfReader(p);text=' '.join(page.extract_text() for page in r.pages);assert '{{' not in text and '{%' not in text,p
 report.append({'file':p.name,'pages':len(r.pages),'unrendered_tags':False})
(ROOT/'validation/packet-template-verification.json').write_text(json.dumps({'date':'2026-10-04','method':'Strict Jinja renders and LibreOffice PDF conversion; synthetic examples from template regression context','renders':report},indent=2)+'\n')
print(json.dumps(report,indent=2))
