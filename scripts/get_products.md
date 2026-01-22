# Shopify Product GET Calls

## Get All Products
```http
GET https://{store}.myshopify.com/admin/api/2026-01/products.json?limit=250
X-Shopify-Access-Token: {ACCESS_TOKEN}
```
## Get Product Variants
```http
GET https://{store}.myshopify.com/admin/api/2026-01/products/{product_id}/variants.json
X-Shopify-Access-Token: {ACCESS_TOKEN}
```
## Get Product Metafields
```http
GET https://{store}.myshopify.com/admin/api/2026-01/products/{product_id}/metafields.json?limit=250
X-Shopify-Access-Token: {ACCESS_TOKEN}
```
## Get Variant Metafields
```http
GET https://{store}.myshopify.com/admin/api/2026-01/variants/{variant_id}/metafields.json?limit=250
X-Shopify-Access-Token: {ACCESS_TOKEN}
```
## Get Inventory Item Metafields
```http
GET https://{store}.myshopify.com/admin/api/2026-01/inventory_items/{inventory_item_id}/metafields.json?limit=250
X-Shopify-Access-Token: {ACCESS_TOKEN}
```
