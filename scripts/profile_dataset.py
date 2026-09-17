"""Profile the source CSV without modifying it. Requires Python 3 only."""
from __future__ import annotations
import csv
from collections import Counter
from datetime import datetime
from pathlib import Path

RAW = Path("data/raw/DataCoSupplyChainDataset.csv")
OUT = Path("data/processed/profile-summary.md")
DATE_COLUMNS = ["order date (DateOrders)", "shipping date (DateOrders)"]

def parse_date(value: str):
    for fmt in ("%m/%d/%Y %H:%M", "%m/%d/%Y %H:%M:%S"):
        try: return datetime.strptime(value.strip(), fmt)
        except (ValueError, AttributeError): pass
    return None

if not RAW.exists():
    raise SystemExit(f"Missing {RAW}. Download the source CSV first.")

with RAW.open("r", encoding="latin-1", newline="") as f:
    reader = csv.DictReader(f)
    headers = reader.fieldnames or []
    nulls, unique, duplicates = Counter(), {h: set() for h in headers}, 0
    seen, total, date_values = set(), 0, {h: [] for h in DATE_COLUMNS}
    for row in reader:
        total += 1
        signature = tuple(row.get(h, "") for h in headers)
        duplicates += signature in seen
        seen.add(signature)
        for h in headers:
            value = (row.get(h) or "").strip()
            nulls[h] += not bool(value)
            if len(unique[h]) < 100_000: unique[h].add(value)
        for h in DATE_COLUMNS:
            parsed = parse_date(row.get(h, ""))
            if parsed: date_values[h].append(parsed)

lines = ["# Generated Dataset Profile", "", f"- Rows: {total:,}", f"- Columns: {len(headers)}",
         f"- Exact duplicate rows: {duplicates:,}", "", "## Columns", "", "| Column | Missing | Distinct (capped) |",
         "|---|---:|---:|"]
lines += [f"| {h} | {nulls[h]:,} | {len(unique[h]):,} |" for h in headers]
lines += ["", "## Date ranges", ""]
for h, values in date_values.items():
    lines.append(f"- {h}: {min(values).date() if values else 'not parsed'} to {max(values).date() if values else 'not parsed'}")
OUT.parent.mkdir(parents=True, exist_ok=True)
OUT.write_text("\n".join(lines) + "\n", encoding="utf-8")
print(f"Wrote {OUT}")
