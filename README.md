# Shopify-REST-APIs

This repository contains **Shopify API integrations (GET-only)**
used for data extraction and reporting into Power BI.

Although named `Rest-API`, the repository includes:
- Shopify GraphQL Admin API
- Shopify GraphQL Bulk Operations
- ShopifyQL (analytics queries)

No write operations are performed.

---

## Shopify Data Reporting → Power BI

This repository provides a complete Shopify data extraction
and reporting framework for Power BI.

It includes both **operational inventory reporting** and **business KPI reporting**.

---

## Modules

### Inventory Reporting
- Inventory Reporting
- KPI Reporting
- Product & Metadata Download (GET-only)

#### What this solves
- Shopify Admin inventory views are not analytics-friendly
- REST inventory endpoints only expose `available`
- GraphQL + Bulk Operations expose full inventory state visibility

#### Inventory states included
- available
- on_hand
- incoming
- committed
- reserved
- damaged
- safety_stock
- quality_control

#### Inventory output
- One row per **SKU + Location**
- Inventory states pivoted as columns

---

### KPI Reporting
Provides **Shopify business KPIs** for analytics and executive reporting.

#### KPI coverage
- Sales & Revenue
- Traffic & Conversion
- Funnel Performance
- Customer Acquisition
- Orders & Refunds

---

## Data Sources
- Shopify REST Admin API (GET only)
- Shopify GraphQL Admin API
- Shopify GraphQL Bulk Operations
- ShopifyQL

---

## Documentation
- Inventory: /docs/inventory-report.md
- KPIs: /docs/shopify-kpi-report.md
- Products: /docs/product-report.md
