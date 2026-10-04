from pathlib import Path
import unittest
import yaml
from pypdf import PdfReader
ROOT=Path(__file__).resolve().parents[1]
class NameChangeFieldRegression(unittest.TestCase):
 def test_second_and_third_child_surnames_are_independent(self):
  data=ROOT/'docassemble/ApplicationForNameChange/data'
  reader=PdfReader(data/'templates/Application_for_name_change.pdf')
  fields=reader.get_fields()
  self.assertIn('children2_name_last',fields)
  self.assertIn('children3_name_last',fields)
  blocks=list(yaml.safe_load_all((data/'questions/Application_for_name_change.yml').read_text()))
  mapping={}
  for block in blocks:
   attachment=(block or {}).get('attachment',{})
   if attachment.get('pdf template file'):
    mapping={key:value for row in attachment['fields'] for key,value in row.items()}
  self.assertIn('children[1].name.last',mapping['children2_name_last'])
  self.assertIn('children[2].name.last',mapping['children3_name_last'])
  self.assertNotIn('children[2].name.last',mapping['children2_name_last'])
  self.assertEqual(set(fields),set(mapping))
  self.assertTrue(all(str(field.get('/TU','')).strip() for field in fields.values()))
if __name__=='__main__':unittest.main()
