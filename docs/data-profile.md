# Data Profile and Access Record

## Status

The source CSV was not profiled in this environment. This is not a claim that the data is unavailable publicly: the public source repository exposes a 95,729,629-byte CSV blob, but the available approved fetch capability rejected the file as too large. The Kaggle API download path also required authentication in this environment.

No dataset row count, CSV column count, missing-value count, duplicate count, date range, numerical distribution, or business result is reported here because none was computed from the CSV.

## Verified source metadata

- Dataset: DataCo SMART SUPPLY CHAIN FOR BIG DATA ANALYSIS.
- Structured file: DataCoSupplyChainDataset.csv.
- Public source blob size: 95,729,629 bytes.
- Public source also provides DescriptionDataCoSupplyChain.csv.
- The source description confirms fields for transaction type, shipping days, revenue, profit, delivery status, product/category, customer segment, market/region, order dates, and shipping mode.

## Profile script behavior

The repository profiler reads the unmodified local CSV with Latin-1 encoding, records row and column counts, missing values, capped distinct values, exact duplicate rows, and parsed order/shipping date ranges. It writes a local generated summary under data/processed, which is ignored by Git.

## Required evidence before numerical publication

When an execution environment has both the source CSV and Python, populate this document from the generated profile. Until then, all other documentation deliberately uses only source-field semantics and static design validation.
