"""Financial summaries and form-field validation without docassemble dependencies."""
from decimal import Decimal, ROUND_HALF_UP
from pathlib import Path
import json

__all__ = ["fee_threshold", "money_total", "expense_summary", "property_summary", "household_summary", "household_income_summary", "requested_name_complete"]


def _money(value):
    amount = Decimal(str(value))
    if not amount.is_finite() or amount < 0:
        raise ValueError("Enter a nonnegative dollar amount.")
    return amount.quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)


def money_total(values):
    return sum((_money(value) for value in values), Decimal("0.00"))


def fee_threshold(household_size, year):
    """Return the annual 125% figure, or None when that year's data is absent."""
    if isinstance(household_size, bool) or int(household_size) != household_size or household_size < 1:
        raise ValueError("Household size must be a positive whole number.")
    source = Path(__file__).parent / "data/sources/poverty_guidelines.json"
    data = json.loads(source.read_text(encoding="utf-8"))
    guideline = data["years"].get(str(year))
    if guideline is None:
        return None
    base = Decimal(str(guideline["one_person"]))
    increment = Decimal(str(guideline["additional_person"]))
    return ((base + increment * (household_size - 1)) * Decimal("1.25")).quantize(Decimal("0.01"))


def expense_summary(expenses):
    rows = [f"{label}: ${_money(amount):.2f}" for label, amount in expenses.items()]
    return "; ".join(rows) + f". Total monthly expenses: ${money_total(expenses.values()):.2f}."


def property_summary(items):
    labels = {"vehicle": "Vehicle", "home": "Home", "real_estate": "Other real estate", "personal": "Other personal property"}
    rows = []
    equity = Decimal("0.00")
    for item in items:
        value, owed = _money(item.estimated_value), _money(item.amount_owed)
        equity += value - owed
        rows.append(f"{labels[item.kind]}: {item.description.strip()}; value ${value:.2f}; amount owed ${owed:.2f}; equity ${value - owed:.2f}")
    return "; ".join(rows) + f". Total equity: ${equity:.2f}." if rows else "None"


def household_summary(people):
    labels = {"spouse": "spouse", "partner": "partner", "child": "child", "dependent": "other dependent"}
    rows = []
    for person in people:
        relationship = person.relationship_detail.strip() if person.relationship == "dependent" else labels[person.relationship]
        rows.append(f"{person.full_name.strip()}, age {person.age}, {relationship}")
    return "; ".join(rows) or "None"


def household_income_summary(people):
    rows = []
    for person in people:
        if person.relationship != "spouse" and _money(person.monthly_take_home) > 0:
            rows.append(f"{person.full_name.strip()}: ${_money(person.monthly_take_home):.2f} monthly take-home; {person.income_source.strip()}")
    return "; ".join(rows) or "None"


def requested_name_complete(first, middle, last):
    """All blank means no request; any requested name needs first and last names."""
    return not any(part.strip() for part in (first, middle, last)) or bool(first.strip() and last.strip())
