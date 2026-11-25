from types import SimpleNamespace as Person
import unittest
from docassemble.ApplicationForNameChange.editing import child_name_row_changes, remember_child_name_answers, felony_recipient_row_changes


class ChildNameEditing(unittest.TestCase):
    def test_deletion_and_readdition_preserve_the_persons_own_answers(self):
        children = [Person(), Person(), Person()]
        rows, changes = child_name_row_changes(children)
        self.assertEqual(changes, {})
        for child, name in zip(children, ["Avery", "Blair", "Casey"]):
            remember_child_name_answers(child, [name, "", "Newname"])
        removed = children.pop(0)
        current, changes = child_name_row_changes(children, rows)
        self.assertEqual(changes, {0: ("Blair", "", "Newname"), 1: ("Casey", "", "Newname")})
        self.assertEqual(child_name_row_changes(children, current)[1], {})
        children.append(Person())
        new_rows, changes = child_name_row_changes(children, current)
        self.assertEqual(changes, {2: None})
        children.append(removed)
        self.assertEqual(child_name_row_changes(children, new_rows)[1], {3: ("Avery", "", "Newname")})

    def test_edits_to_a_person_do_not_reset_requested_names(self):
        child = Person(name="Original")
        rows, _ = child_name_row_changes([child])
        remember_child_name_answers(child, ["Avery", "", "Newname"])
        child.name = "Corrected"
        self.assertEqual(child_name_row_changes([child], rows)[1], {})
        remember_child_name_answers(child, ["Updated", "", "Newname"])
        self.assertEqual(child.name_change_requested_parts, ("Updated", "", "Newname"))


class FelonyNoticeEditing(unittest.TestCase):
    def test_removed_recipient_requires_reselection_and_remaining_people_remap(self):
        applicant, spouse, child = Person(), Person(), Person()
        notices = [Person(person_index=1), Person(person_index=2), Person(person_index=0)]
        rows, changes = felony_recipient_row_changes([applicant, spouse, child], notices)
        self.assertEqual(changes, {})
        current, changes = felony_recipient_row_changes([applicant, child], notices, rows)
        self.assertEqual(changes, {0: None, 1: 1, 2: 0})
        notices[0].person_index = 0
        notices[1].person_index = 1
        self.assertEqual(felony_recipient_row_changes([applicant, child], notices, current)[1], {})

    def test_readding_spouse_does_not_shift_a_childs_notice_to_the_spouse(self):
        applicant, spouse, child = Person(), Person(), Person()
        notices = [Person(person_index=1)]
        rows, _ = felony_recipient_row_changes([applicant, child], notices)
        self.assertEqual(felony_recipient_row_changes([applicant, spouse, child], notices, rows)[1], {0: 2})


if __name__ == "__main__":
    unittest.main()
