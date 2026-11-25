from pathlib import Path
import re
from docx import Document
from docx.shared import Pt
from docx.shared import RGBColor
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.opc.constants import RELATIONSHIP_TYPE as RT

LINK_LABELS = {
 'https://mncourts.gov/getforms/name-change': 'Court name change forms',
 'https://mncourts.gov/getforms/fee-waiver': 'Court fee-waiver forms',
 'https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information': 'Name Change on LawHelpMN',
 'https://mncourts.gov/getforms/name-change/form-nam101-supp-dist-4-fourth-judicial-district-supplemental-name-change-guide': 'Hennepin court guide',
}

def styles(document):
 document.styles['Normal'].font.name='Arial'
 document.styles['Normal'].font.size=Pt(11)
 document.styles['Normal'].paragraph_format.space_after=Pt(6)
 heading=document.styles['Heading 1']
 heading.font.name='Arial';heading.font.size=Pt(16);heading.font.color.rgb=RGBColor(0,0,0)

def add_text(document,text,heading=False):
 paragraph=document.add_paragraph(style='Heading 1' if heading else None)
 if text.startswith('https://'):
  link=OxmlElement('w:hyperlink');link.set(qn('r:id'),document.part.relate_to(text,RT.HYPERLINK,is_external=True))
  run=OxmlElement('w:r');properties=OxmlElement('w:rPr');style=OxmlElement('w:rStyle');style.set(qn('w:val'),'Hyperlink');properties.append(style);run.append(properties)
  value=OxmlElement('w:t');value.text=text;run.append(value);link.append(run);paragraph._p.append(link)
 else:
  for part in re.split(r'(https://[^ ]+)',text):
   if part.startswith('https://'):
    url=part.rstrip('.')
    link=OxmlElement('w:hyperlink');link.set(qn('r:id'),document.part.relate_to(url,RT.HYPERLINK,is_external=True))
    run=OxmlElement('w:r');value=OxmlElement('w:t');value.text=LINK_LABELS.get(url,url);run.append(value);link.append(run);paragraph._p.append(link)
    if part.endswith('.'):paragraph.add_run('.')
   else:paragraph.add_run(part)
 return paragraph
p=Path(__file__).resolve().parents[1]/'docassemble/ApplicationForNameChange/data/templates'
d=Document();styles(d)
paragraphs=[
'CONFIDENTIAL',
'State of Minnesota — District Court',
'County: {{ district_court_county }}    Judicial district: {{ judicial_district }}',
'Court file number: {{ docket_number }}    Case type: Name Change',
'In the Matter of the Application of: {{ packet_caption }}',
'Affidavit to Request Fee Waiver — FEE102',
'Minn. Stat. § 563.01',
'1. I am a party in this action. I am not filing on behalf of a business. In good faith, I ask for a court order waiving court fees and costs. I cannot support my family and myself and also pay or give security for costs.',
'2. I believe that I have good reasons for making this request.',
'☒ I am including my pleadings with this Affidavit (or I have already filed my pleadings but have not yet paid the filing fee).',
'☐ I only want to have copy fees waived. I do not have any pleadings to file at this time.',
'3. {{ "☒" if fee_legal_services else "☐" }} I have a lawyer through a civil legal services program or volunteer attorney program that gives legal services to people with low incomes.',
'My lawyer’s name: {{ fee_lawyer_name if fee_legal_services else "" }}',
'My lawyer works or volunteers for: {{ fee_lawyer_program if fee_legal_services else "" }}',
'4. {{ "☒" if not fee_legal_services and fee_public_assistance == "none" else "☐" }} I do not receive public assistance.',
'{{ "☒" if not fee_legal_services and fee_public_assistance != "none" else "☐" }} I receive public assistance.',
'4a. {{ "☒" if not fee_legal_services and fee_public_assistance == "listed" else "☐" }} I receive public assistance under one or more of these programs:',
'{{ fee_benefits.true_values() | join("; ") if not fee_legal_services and fee_public_assistance == "listed" else "" }}',
'4b. {{ "☒" if not fee_legal_services and fee_public_assistance == "other" else "☐" }} I receive public assistance through a different program based on my income: {{ fee_other_program if not fee_legal_services and fee_public_assistance == "other" else "" }}',
'I will include proof that I receive public assistance listed in 4a and 4b.',
'5. My household size is {{ fee_household_size if fee_financial_details else "" }}.',
'My household, other than myself, includes (name, age, relationship): {{ fee_household_members if fee_financial_details else "" }}',
'6. Income sources: {{ fee_income_sources if fee_financial_details else "" }}',
'My {{ "average" if fee_financial_details and fee_income_is_average else "total" }} monthly income (before taxes and deductions) is ${{ "%.2f" | format(fee_monthly_income) if fee_financial_details else "" }}.',
'7. I am {{ "☒" if fee_financial_details and not_married else "☐" }} not married. {{ "☒" if fee_financial_details and not not_married else "☐" }} married.',
'My spouse’s total monthly income (before taxes and deductions) is ${{ "%.2f" | format(fee_spouse_monthly_income) if fee_financial_details and not not_married and fee_spouse_income_known else "" }}.',
'The source of that income is {{ fee_spouse_income_sources if fee_financial_details and not not_married and fee_spouse_income_known else "" }}.',
'I do not know my spouse’s income because: {{ fee_spouse_income_unknown_reason if fee_financial_details and not not_married and not fee_spouse_income_known else "" }}',
'8. Other family members or dependents who live with me and have income (name, monthly take-home income, source): {{ fee_other_household_income if fee_financial_details else "" }}',
'9. My household’s total yearly income (before taxes and deductions) is ${{ "%.2f" | format(fee_yearly_income) if fee_financial_details else "" }}.',
'{{ "☒" if fee_financial_details and fee_below_poverty_guideline else "☐" }} This is less than 125% of the Federal Poverty Line for my household size.',
'{{ "☒" if fee_financial_details and not fee_below_poverty_guideline else "☐" }} This is more than or equal to 125% of the Federal Poverty Line for my household size.',
'I have attached proof of my household income.',
'10. Monthly expenses (rent or mortgage, utilities, food, car payments, car insurance, spousal support, child support, childcare, medical insurance, cell phone, and other explained expenses): {{ fee_expenses if fee_full_details else "" }}',
'11. I am ${{ "%.2f" | format(fee_debt) if fee_full_details else "" }} in debt (excluding car loans, real estate loans, and mortgages).',
'12. Available cash: ${{ "%.2f" | format(fee_cash) if fee_full_details else "" }}. Available checking, savings, and credit union accounts: ${{ "%.2f" | format(fee_accounts) if fee_full_details else "" }}.',
'13. Property and equity values (vehicle year and make, home, other real estate, and personal property): {{ fee_assets if fee_full_details else "" }}',
'14. Other reasons I cannot afford to pay court fees: {{ fee_other_reasons if fee_full_details else "" }}',
'I declare under penalty of perjury that everything I have stated in this document is true and correct. Minn. Stat. § 358.116.',
'Date: ____________________    Signature: ______________________________',
'County and state where signed: ________________________________________',
'Name: {{ users[0].name.full() }}',
'Address: {{ users[0].address.address }}',
'City, state, ZIP: {{ users[0].address.line_two() }}',
'Phone: {{ users[0].phone_number }}    Email: {{ users[0].email }}',
'File this confidential affidavit with your pleadings and proof of public assistance or financial need. A judicial officer will decide whether to grant a full or partial waiver.'
]
for i,t in enumerate(paragraphs):add_text(d,t,heading=i == 5)
d.core_properties.title='Affidavit to request fee waiver'
d.sections[0].footer.paragraphs[0].text='Adapted from Minnesota Judicial Branch FEE102, Rev. 07/24 — financial details expand as needed.'
d.save(p/'fee_waiver_affidavit.docx')
# Fresh packet checklist, rather than the old application-only instructions.
d=Document();styles(d)
for t in [
'Minnesota name change — your next steps',
'For {{ users[0].name.full() }}',
'Nothing has been filed or approved. Review every page of the packet.',
'1. Review and sign the application (NAM102). Any included spouse must sign. Each included child age 14 or older must sign. Use an additional signature sheet for more than one child needing to sign.',
'2. Sign one criminal-history release (NAM103) for each covered person age 10 or older. The packet includes {{ release_people | length }} release(s). If the binary sex choices do not fit, ask court administration how to complete that field before filing.',
'3. Review the proposed order(s) (NAM107). The portions below IT IS ORDERED and the judge’s signature are for the court. The hearing date and service/no-objection findings are left blank.',
'{%p if hennepin_packet %}',
'Hennepin: This packet includes a separate proposed order for each person requesting a change. Read the current February 2026 supplemental guide: https://mncourts.gov/getforms/name-change/form-nam101-supp-dist-4-fourth-judicial-district-supplemental-name-change-guide. For a known-address parent, send the hearing letter and application by certified mail, return receipt requested, at least 14 days before the hearing. File the required affidavit and bring the mailing receipt, letter copy, and signed return receipt if available. Obtain the mailing affidavit the court specifies; NAM205 does not prove mailing.',
'{%p endif %}',
'{%p if included_children %}',
'Bring records establishing your relationship to each included child, such as a certified birth certificate or court parentage/adoption order. Children must attend the hearing; children age 14 or older must sign the application as directed by the court.',
'{%p endif %}',
'4. Read the included official instructions (NAM101). File in the county where you live. Pay the fee or submit the applicable fee-waiver or exemption documents. Ask court administration how to schedule your hearing.',
'5. Bring two witnesses who know you to the hearing unless the court confirms an exception. Included minors must attend. Obtain certified copies of a signed order after approval.',
'{%p if users1_divorced_seeking_change_to_legal_name_on_birth_certificate %}',
'Divorce exception: File certified copies of your birth certificate and dissolution document. Confirm the exception with court administration. This packet omits the criminal-history release for the verified single-adult exception.',
'{%p endif %}',
'{%p if has_felony %}',
'Felony conviction: Serve the prosecuting authority that obtained each conviction with NAM104 and a copy of the application. Federal or out-of-state convictions also require notice to the Minnesota Attorney General. File proof of service. The authority has 30 days after service to object. This packet does not certify that notice has occurred. Contact a lawyer if an objection is filed.',
'Court administrator mailing address: {{ court_administrator_address }}, {{ court_administrator_city_state_zip }}',
'{%p endif %}',
'{%p if users1_inmate_in_correctional_facility_and_submitting_inmate_aff %}',
'Incarceration: Review and sign NAM105 only if every statement is true. A repeated name change request during confinement needs legal review.',
'{%p endif %}',
'{%p if parental_notice_needed %}',
"{%p if parent_service_method_active | default('personal_service') == 'personal_service' %}",
'Personal service: Use a person age 18 or older as described in NAM204. The person who actually serves the papers completes NAM205 with the true date, place, and delivery facts. Do not use NAM205 to prove mailing.',
'{%p endif %}',
"{%p if parent_service_method_active | default('personal_service') == 'certified_mail' %}",
'Certified mail: The packet does not include a mailing affidavit. Obtain the form required by court administration. Keep actual mailing and delivery records; do not certify service before it happens.',
'{%p endif %}',
'Children’s other parent: Fill in the hearing notice after the court schedules the hearing. Attach the application. Use the notice method stated in your court instructions. You are responsible for arranging notice and filing the required proof.',
'{%p if not parent_address_known %}',
'Unknown address: Review the search-effort statements in NAM207. Its first statement says the application has been filed: file the application before signing that statement. Ask the judge to permit publication or other notice; wait for an order before arranging publication. The newspaper supplies proof of publication. The publication order fields are left blank for the judge.',
'{%p endif %}',
'{%p endif %}',
'{%p if included_children and parents_nonapplicant_unknown %}',
'No identified other parent: Bring each certified birth certificate and relevant parentage records. You confirmed the four parentage facts for each included child. Outside the districts covered by those instructions, you also confirmed the notice exception with court administration. Do not treat a known person as unknown or omit notice solely because you have sole custody.',
'{%p endif %}',
'{%p if request_fee_waiver %}',
'{%p if users1_inmate_in_correctional_facility_and_submitting_inmate_aff %}',
'Inmate fee waiver: Complete the included blank FEE201 separately if its eligibility statements apply. Include the correctional account records and authorization it requires. A standard FEE102 affidavit is not generated for this route.',
'{%p else %}',
'Fee waiver: Review and sign the confidential FEE102 adaptation. Attach proof of public assistance or household income as applicable. Confirm that expenses and assets are complete. The court decides whether fees will be waived. Submit it as a confidential document, separately from publicly accessible forms.',
'{%p endif %}',
'{%p endif %}',
'After approval, follow NAM106 and the signed order to update records. If you have criminal history, report the approved name change to the BCA within the required 10-day period. File a certified order with each county recorder where there is an interest in land.',
'Resources: https://mncourts.gov/getforms/name-change | https://mncourts.gov/getforms/fee-waiver | https://www.lawhelpmn.org/self-help-library/legal-resource/name-change-minnesota-court-forms-and-information'
]:
 add_text(d,t,heading=t == 'Minnesota name change — your next steps')
d.core_properties.title='Minnesota name change — your next steps'
d.save(p/'Application_for_name_change_next_steps.docx')
