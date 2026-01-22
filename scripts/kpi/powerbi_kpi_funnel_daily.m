let
    Source =
        fnShopifyQL(
"FROM sessions
SHOW sessions, product_views, add_to_carts, checkouts, orders
TIMESERIES day
SINCE -30d UNTIL today
ORDER BY day"
        )
in
    Source
