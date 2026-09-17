# Data Dictionary

This dictionary is verified against the published source description. The semantic type is the intended analytical interpretation; physical source types are not claimed because the CSV was not readable in this environment.

| Source column | Semantic type | Business meaning | KPI / SQL / Tableau use |
|---|---|---|---|
| Type | text | Transaction type | Filtering and quality review |
| Days for shipping (real) | integer | Actual shipping duration | Delivery KPIs |
| Days for shipment (scheduled) | integer | Scheduled shipping duration | Variance calculation |
| Benefit per order | decimal | Source earnings per order | Quality context |
| Sales per customer | decimal | Source customer sales | Quality context |
| Delivery Status | text | Published delivery outcome | Delivery charts |
| Late_delivery_risk | binary | Source late-risk flag | Delivery-risk KPI |
| Category Id, Category Name | key, text | Product classification | Category analysis |
| Customer Id, Customer Segment | key, text | Customer identity and segment | Dimension and segmentation |
| Customer City, State, Country | text | Customer location | Customer dimension only |
| Department Id, Department Name | key, text | Product department | Product analysis |
| Latitude, Longitude | decimal | Source location coordinates | Geography context |
| Market | text | Delivery market | Regional analysis |
| Order City, Country, Region, State | text | Order destination geography | Geography dimension |
| Order Customer Id | key | Order customer reference | Source quality review |
| order date (DateOrders) | datetime | Order timestamp | Date dimension and trends |
| Order Id | key | Commercial order identifier | Distinct order KPI |
| Order Item Cardprod Id | key | RFID product reference | Source traceability |
| Order Item Discount | decimal | Item discount value | Profitability investigation |
| Order Item Discount Rate | decimal | Item discount rate | Profitability investigation |
| Order Item Id | key | Order-item identifier | Fact-table grain |
| Order Item Product Price | decimal | Pre-discount item price | Fact measure |
| Order Item Profit Ratio | decimal | Source item profit ratio | Fact measure |
| Order Item Quantity | integer | Units in the order item | Units KPI |
| Sales | decimal | Source sales amount | Gross-sales measure |
| Order Item Total | decimal | Source item total | Net revenue measure |
| Order Profit Per Order | decimal | Source profit measure | Total-profit KPI |
| Order Status | text | Commercial order status | Executive chart |
| Product Card Id | key | Product identifier | Product dimension |
| Product Category Id | key | Product-category key | Product dimension |
| Product Description, Image | text | Product metadata | Excluded from analytics output |
| Product Name | text | Product label | Top-product analysis |
| Product Price | decimal | Catalog price | Product dimension |
| Product Status | binary | Source product-availability status | Source context only |
| Shipping date (DateOrders) | datetime | Shipment timestamp | Profiling and delivery validation |
| Shipping Mode | text | Service level | Delivery analysis |

Sensitive or unnecessary fields including customer email, name, password, street, and product image are intentionally excluded from the analytical model.
