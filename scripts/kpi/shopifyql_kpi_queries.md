```sql
-- Daily Sales KPIs
FROM sales
SHOW gross_sales, discounts, returns, net_sales, shipping, taxes, total_sales, orders
TIMESERIES day
SINCE -30d UNTIL today
ORDER BY day

-- Traffic & Conversion
FROM sales, sessions
SHOW day, total_sales, sessions, orders
GROUP BY day
SINCE -30d UNTIL today
ORDER BY day

-- Funnel Performance
FROM sessions
SHOW sessions, product_views, add_to_carts, checkouts, orders
TIMESERIES day
SINCE -30d UNTIL today
ORDER BY day

-- Customer Acquisition
FROM customers
SHOW new_customers, returning_customers
TIMESERIES week
SINCE -12w UNTIL today
ORDER BY week

```
