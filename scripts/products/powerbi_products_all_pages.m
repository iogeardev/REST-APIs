let
    Store = "{store}",
    Token = "{ACCESS_TOKEN}",
    ApiVersion = "2026-01",

    BaseUrl = "https://" & Store & ".myshopify.com/admin/api/" & ApiVersion & "/products.json",
    PageSize = 250,

    // Reads the "Link" response header and extracts the next page_info token (if any)
    GetNextPageInfo = (Headers as record) as nullable text =>
        let
            Link = try Headers[Link] otherwise null,
            LinkText = if Link is list then Text.Combine(List.Transform(Link, Text.From), ",") else Text.From(Link),
            HasNext = LinkText <> null and Text.Contains(LinkText, "rel=""next"""),
            // Pull page_info=... from the next link
            PageInfo =
                if HasNext then
                    try Text.BetweenDelimiters(LinkText, "page_info=", ">", 0, 0) otherwise null
                else
                    null
        in
            PageInfo,

    // Fetch one page. If PageInfo is null, fetch first page.
    GetPage = (PageInfo as nullable text) as record =>
        let
            Query =
                if PageInfo = null then
                    [ limit = Text.From(PageSize) ]
                else
                    [ limit = Text.From(PageSize), page_info = PageInfo ],

            Response = Web.Contents(
                BaseUrl,
                [
                    Headers = [ #"X-Shopify-Access-Token" = Token ],
                    Query = Query,
                    ManualStatusHandling = {429, 500, 502, 503, 504}
                ]
            ),

            Meta = Value.Metadata(Response),
            Headers = try Meta[Headers] otherwise [],
            Body = Json.Document(Response),
            Items = Body[products],
            NextPageInfo = GetNextPageInfo(Headers)
        in
            [ Items = Items, NextPageInfo = NextPageInfo ],

    // Loop pages
    Pages =
        List.Generate(
            () => GetPage(null),
            each [Items] <> null,
            each if [NextPageInfo] <> null then GetPage([NextPageInfo]) else [Items = null, NextPageInfo = null],
            each [Items]
        ),

    AllProducts = List.Combine(Pages),
    T0 = Table.FromList(AllProducts, Splitter.SplitByNothing(), {"product"}, null, ExtraValues.Error),

    Expand = Table.ExpandRecordColumn(
        T0, "product",
        {"id","title","handle","vendor","product_type","status","tags","body_html","created_at","updated_at"},
        {"product_id","title","handle","vendor","product_type","status","tags","body_html","created_at","updated_at"}
    ),

    TagsText = Table.TransformColumns(
        Expand,
        {{"tags", each if _ is list then Text.Combine(List.Transform(_, Text.From), ", ") else Text.From(_), type text}}
    )
in
    TagsText
