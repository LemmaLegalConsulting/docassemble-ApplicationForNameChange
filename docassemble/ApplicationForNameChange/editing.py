"""Keep requested-name answers attached to people when list rows move."""
from uuid import uuid4

__all__ = ["child_name_row_changes", "remember_child_name_answers", "synchronize_child_name_rows", "felony_recipient_row_changes"]


def child_name_row_changes(children, previous_rows=None):
    """Return stable row IDs and replacements for rows whose person changed.

    None is a new child: ask for that child's requested name rather than reusing
    an answer from a deleted row. The first pass preserves existing flat fields.
    """
    rows = []
    changes = {}
    for index, child in enumerate(children):
        data = vars(child)
        if "name_change_row_id" not in data:
            child.name_change_row_id = str(uuid4())
        row = data["name_change_row_id"]
        rows.append(row)
        if previous_rows is not None and (index >= len(previous_rows) or previous_rows[index] != row):
            changes[index] = data.get("name_change_requested_parts")
    return rows, changes


def remember_child_name_answers(child, parts):
    child.name_change_requested_parts = tuple(parts)


def synchronize_child_name_rows(children, previous_rows, define, undefine):
    rows, changes = child_name_row_changes(children, previous_rows)
    for index, parts in changes.items():
        if index >= 5:
            continue
        for offset, part in enumerate(["first", "middle", "last"]):
            variable = "children" + str(index + 1) + "_name_" + part + "_change"
            if parts is None:
                undefine(variable)
            else:
                define(variable, parts[offset])
    return rows


def felony_recipient_row_changes(people, notices, previous_rows=None):
    """Remap notice selections by person; None requires a new selection."""
    rows, _ = child_name_row_changes(people)
    changes = {}
    if previous_rows is not None and rows != previous_rows:
        for index, notice in enumerate(notices):
            selected = vars(notice).get("person_index")
            if selected is None:
                continue
            if not isinstance(selected, int) or selected < 0 or selected >= len(previous_rows):
                changes[index] = None
                continue
            previous_person = previous_rows[selected]
            changes[index] = rows.index(previous_person) if previous_person in rows else None
    return rows, changes
