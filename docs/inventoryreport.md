# Shopify Comprehensive Inventory Report

## Purpose
Provide a complete inventory dataset from Shopify including
all inventory states per SKU and per location, suitable for analytics.

This report is designed for:
- Power BI
- Inventory reconciliation
- Forecasting
- Ops / Finance alignment

---

## Why GraphQL Bulk Operations
- REST `inventory_levels` only returns `available`
- Inventory states are stored as quantities on InventoryLevel
- Bulk operations are required for scale and performance

---

## Inventory States
Inventory states are explicitly requested from Shopify.
There is no wildcard support.

States currently requested:
- available
- on_hand
- incoming
- committed
- reserved
- damaged
- safety_stock
- quality_control

> State names are shop-specific and must be discovered via `inventoryProperties.quantityNames`.

---

## Shopify API Requirements

- Admin API access token
- Scopes:
  - read_products
  - read_inventory
  - read_locations

API Version: `2026-01`

---

## Step 1: Discover inventory quantity names

GraphQL query:
```graphql
query {
  inventoryProperties {
    quantityNames(first: 50) {
      edges {
        node {
          name
        }
      }
    }
  }
}
