# Data

## Selected dataset

**DataCo SMART SUPPLY CHAIN FOR BIG DATA ANALYSIS**  
Provider: Shashwat Tiwari on Kaggle  
Source: [Kaggle dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)  
Upstream attribution: Fabian Constante, Instituto Politécnico de Leiria (as credited on Kaggle)  
Expected file: `DataCoSupplyChainDataset.csv`

The Kaggle listing describes a structured supply-chain dataset spanning provisioning, production, sales, and commercial distribution. Its data explorer reports 53 columns. Published descriptions report approximately 180,519 order-item records, with dates from 2015 through early 2018. The listing declares **CC0: Public Domain**. This project does not redistribute the source CSV: it is large and must be downloaded from the authoritative listing.

## Why this dataset

It offers order-line sales, profit, actual and scheduled shipping days, delivery status, product, customer, market, and geography fields. That makes it suitable for a fresher-level SQL star schema and three Tableau dashboards. It has no trustworthy inventory, supplier, warehouse, or expected-delivery-date fields, so those analyses are deliberately excluded.

## Download and placement

1. Sign in to Kaggle and download the structured-data CSV from the link above.
2. Keep its name unchanged.
3. Place it at `data/raw/DataCoSupplyChainDataset.csv`.
4. Run `scripts/profile_dataset.py` before loading MySQL.

The raw file is ignored by Git. The profiling script writes `data/processed/profile-summary.md` locally; that generated file is also ignored.

## Known limitations

The dataset is public and presented as DataCo Global data; this project treats it as a teaching/portfolio dataset, not as a verified company operating record. Customer-shaped fields are excluded from dashboard outputs except for a surrogate customer key and non-sensitive segment/location attributes. There is no inventory, supplier, carrier, cost-of-goods, promised-date, or real-time operational feed.
