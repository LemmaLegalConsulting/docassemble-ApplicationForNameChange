import unittest
from docassemble.ApplicationForNameChange.family_eligibility import (
    parent_authority_route, parent_notice_group, parent_notice_method,
)


class FamilyEligibility(unittest.TestCase):
    def test_supported_parentage_and_referrals(self):
        for basis in ('birth_certificate', 'court_order'):
            self.assertEqual(parent_authority_route('legal_parent', basis), 'supported')
            self.assertEqual(parent_authority_route('legal_parent', basis, True), 'parentage_review')
        for role in ('guardian', 'next_of_kin', 'spouse_parent', 'caregiver', 'unsure'):
            self.assertEqual(parent_authority_route(role), 'authority')
        for basis in ('other_basis', 'unsure', None):
            self.assertEqual(parent_authority_route('legal_parent', basis), 'parentage_review')

    def test_mixed_parent_groups_require_review(self):
        self.assertEqual(parent_notice_group([]), 'none')
        for status in ('one_known', 'none_unknown'):
            self.assertEqual(parent_notice_group([status] * 3), status)
        for status in ('none_unknown', 'none_known', 'joining_spouse', 'multiple', 'special', 'unsure'):
            self.assertEqual(parent_notice_group(['one_known', status]), 'notice_review')

    def test_county_notice_methods(self):
        for county in ('Hennepin', 'HENNEPIN COUNTY'):
            self.assertEqual(parent_notice_method(county, True, 'personal_service'), 'certified_mail')
            self.assertEqual(parent_notice_method(county, False), 'notice_review')
        for method in ('personal_service', 'certified_mail'):
            self.assertEqual(parent_notice_method('Ramsey', True, method), method)
        self.assertEqual(parent_notice_method('Ramsey', True, 'unsure'), 'notice_review')
        self.assertEqual(parent_notice_method('Ramsey', False), 'publication_request')
