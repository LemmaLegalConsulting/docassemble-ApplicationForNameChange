from decimal import Decimal
from types import SimpleNamespace as Person
import unittest
import ast
from pathlib import Path
import yaml
from docassemble.ApplicationForNameChange.validation import (
    fee_threshold, money_total, expense_summary, property_summary,
    household_summary, household_income_summary, requested_name_complete,
)

class FinancialValidation(unittest.TestCase):
    def test_current_thresholds_and_larger_households(self):
        self.assertEqual(fee_threshold(1, 2026), Decimal('19950.00'))
        self.assertEqual(fee_threshold(8, 2026), Decimal('69650.00'))
        self.assertEqual(fee_threshold(9, 2026), Decimal('76750.00'))

    def test_unknown_year_does_not_reuse_stale_guidelines(self):
        self.assertIsNone(fee_threshold(2, 2027))
        for invalid in [0, -1, 1.5, True]:
            with self.subTest(invalid=invalid), self.assertRaises(ValueError):
                fee_threshold(invalid, 2026)

    def test_future_year_manual_answer_is_invalidated_after_household_edits(self):
        source=Path(__file__).resolve().parents[1]/'docassemble/ApplicationForNameChange/data/questions/Application_for_name_change.yml'
        blocks=list(yaml.safe_load_all(source.read_text(encoding='utf-8')))
        flow=next(block['code'] for block in blocks if block and block.get('mandatory'))
        branch=next(node for node in ast.walk(ast.parse(flow)) if isinstance(node,ast.If) and ast.unparse(node.test)=='fee_poverty_threshold is None')
        compiled=compile(ast.fix_missing_locations(ast.Module(body=[branch],type_ignores=[])),str(source),'exec')
        for size,year,prior,invalidates in [(2,2027,'2027:2',False),(1,2027,'2027:2',True),(2,2028,'2027:2',True)]:
            with self.subTest(size=size,year=year):
                values={'fee_poverty_threshold':None,'fee_household_size':size,'fee_manual_context':prior,'fee_manual_below_guideline':True,'today':lambda:Person(year=year)}
                values['defined']=lambda name:name in values
                values['undefine']=lambda name:values.pop(name,None)
                exec(compiled,values)
                self.assertEqual('fee_manual_below_guideline' not in values,invalidates)
                self.assertEqual(values['fee_manual_context'],f'{year}:{size}')

    def test_expense_totals_use_decimal_money(self):
        self.assertEqual(money_total([0.1, 0.2]), Decimal('0.30'))
        self.assertIn('Total monthly expenses: $1740.00', expense_summary({'Rent':1000,'Utilities':150,'Food':300,'Car':100,'Insurance':75,'Medical':50,'Phone':40,'Internet':25}))
        for invalid in [-1, 'NaN', 'Infinity']:
            with self.subTest(invalid=invalid), self.assertRaises(ValueError):
                money_total([invalid])

    def test_property_equity_preserves_underwater_loans(self):
        items=[Person(kind='vehicle',description='2015 Example',estimated_value=5000,amount_owed=6000),Person(kind='personal',description='Savings bonds',estimated_value=200,amount_owed=0)]
        result=property_summary(items)
        self.assertIn('equity $-1000.00',result)
        self.assertIn('Total equity: $-800.00',result)
        self.assertEqual(property_summary([]),'None')

    def test_household_totals_and_income_update_after_removal(self):
        spouse=Person(full_name='Jamie Spouse',age=40,relationship='spouse')
        child=Person(full_name='Avery Child',age=17,relationship='child',monthly_take_home=125,income_source='Part-time job')
        self.assertIn('Avery Child, age 17, child',household_summary([spouse,child]))
        self.assertEqual(household_income_summary([spouse,child]),'Avery Child: $125.00 monthly take-home; Part-time job')
        self.assertEqual(household_income_summary([spouse]),'None')
        self.assertEqual(household_summary([]),'None')

    def test_other_dependent_retains_the_actual_relationship(self):
        person=Person(full_name='Pat Relative',age=65,relationship='dependent',relationship_detail='mother')
        self.assertEqual(household_summary([person]),'Pat Relative, age 65, mother')

    def test_complete_child_names_allow_unicode_and_blank_nonapplicants(self):
        self.assertTrue(requested_name_complete('','',''))
        self.assertTrue(requested_name_complete('  José  ','','Nguyễn-Smith'))
        for parts in [('Avery','',''),('','Only Middle',''),('','','Original'),('   ','','Original')]:
            with self.subTest(parts=parts):
                self.assertFalse(requested_name_complete(*parts))

if __name__=='__main__':
    unittest.main()
