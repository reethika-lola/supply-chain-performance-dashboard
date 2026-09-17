# Static Validation Record

Performed on 17 September 2026.

## Completed checks

- Repository tree inspected through the GitHub API.
- Every README link target was checked against the committed file tree.
- Raw data, generated processed data, Tableau workbooks, and local secrets are ignored.
- Source-column mappings were checked against the published DescriptionDataCoSupplyChain.csv file.
- The SQL layer consistently uses the supply_chain_analytics database, fact_order_items fact table, and vw_tableau_order_items Tableau source.
- Inventory and supplier claims are excluded.
- Numerical insights, Tableau screenshots, native workbooks, row counts, and SQL execution outcomes are not claimed.

## Runtime limitation

MySQL client, Python runtime, and SQL lint tooling are not installed in this environment. Accordingly, this is a static review, not a successful execution claim.
