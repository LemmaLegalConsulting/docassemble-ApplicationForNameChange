"""Supported packet routes, not determinations of legal eligibility.

Sources: NAM101/NAM201 Rev 2/25, NAM102 Rev 7/23, NAM202 Rev 1/20,
Hennepin supplement 2/26, and Third District supplement July 2025.
"""
__all__ = ['parent_authority_route', 'parent_notice_group', 'parent_notice_method']


def parent_authority_route(role, basis=None, disputed=False):
    if role != 'legal_parent':
        return 'authority'
    if basis not in ('birth_certificate', 'court_order') or disputed:
        return 'parentage_review'
    return 'supported'


def parent_notice_group(statuses):
    statuses = list(statuses)
    if not statuses:
        return 'none'
    if all(status == 'one_known' for status in statuses):
        return 'one_known'
    if all(status == 'none_unknown' for status in statuses):
        return 'none_unknown'
    return 'notice_review'


def parent_notice_method(county, address_known, confirmed_method=None):
    hennepin = county.strip().casefold().removesuffix(' county') == 'hennepin'
    if not address_known:
        return 'notice_review' if hennepin else 'publication_request'
    if hennepin:
        return 'certified_mail'
    if confirmed_method in ('personal_service', 'certified_mail'):
        return confirmed_method
    return 'notice_review'
