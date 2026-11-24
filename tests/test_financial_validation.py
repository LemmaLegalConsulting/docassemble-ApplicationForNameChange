from decimal import Decimal
from types import SimpleNamespace as Person
import unittest
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

    def test_complete_child_names_allow_unicode_and_blank_nonapplicants(self):
        self.assertTrue(requested_name_complete('','',''))
        self.assertTrue(requested_name_complete('  José  ','','Nguyễn-Smith'))
        for parts in [('Avery','',''),('','Only Middle',''),('','','Original'),('   ','','Original')]:
            with self.subTest(parts=parts):
                self.assertFalse(requested_name_complete(*parts))

if __name__=='__main__':
    unittest.main()
