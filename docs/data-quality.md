# Data Quality and Cleaning Decisions

| Check | Detection | Treatment | Limitation |
|---|---|---|---|
| Duplicate order-item IDs | Group by source Order Item Id | Primary key blocks duplicate fact loads; investigate source duplicates | Counts depend on executed source load |
| Missing business keys | Blank-ID checks | Exclude fact rows with missing required keys and count them | Do not invent keys |
| Empty text | TRIM and empty checks | Convert blanks to NULL; use Unknown only for grouping dimensions | Preserves source uncertainty |
| Invalid numeric values | Regex and nonpositive-quantity checks | Review before loading; never silently delete | Results pending source execution |
| Dates | MySQL parsing check | Exclude unparseable dates from date-backed facts | Parser expects m/d/Y H:i |
| Sensitive fields | Schema review | Exclude email, names, password, street, and image URL | Not needed for analysis |
| Join completeness | Staging-minus-fact and orphan checks | Investigate mapping failure before publishing KPIs | Prevents lost/duplicated revenue |

Run the checks after loading and append actual counts before presenting the project as executed.
