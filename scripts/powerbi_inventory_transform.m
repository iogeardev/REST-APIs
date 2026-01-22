let
    BulkUrl = "PASTE_BULK_URL_HERE",

    Raw = Web.Contents(BulkUrl),
    Text = Text.FromBinary(Raw, TextEncoding.Utf8),
    Lines = List.Select(Text.Split(Text, "#(lf)"), each Text.Length(Text.Trim(_)) > 0),
    Records = List.Transform(Lines, each Json.Document(Text.ToBinary(_))),
    T0 = Table.FromList(Records, Splitter.SplitByNothing(), {"r"}),

    Expand1 = Table.ExpandRecordColumn(
        T0, "r",
        {"id","sku","barcode","title","product","inventoryItem"},
        {"variant_id","sku","barcode","variant_title","product","inventoryItem"}
    ),

    ExpandProduct = Table.ExpandRecordColumn(
        Expand1, "product",
        {"id","title","handle","vendor","status"},
        {"product_id","product_title","handle","vendor","product_status"}
    ),

    ExpandInvItem = Table.ExpandRecordColumn(
        ExpandProduct, "inventoryItem",
        {"id","tracked","inventoryLevels"},
        {"inventory_item_id","tracked","inventoryLevels"}
    ),

    Levels = Table.ExpandRecordColumn(ExpandInvItem, "inventoryLevels", {"edges"}, {"edges"}),
    LevelsList = Table.ExpandListColumn(Levels, "edges"),
    LevelNode = Table.ExpandRecordColumn(LevelsList, "edges", {"node"}, {"node"}),
    ExpandLevel = Table.ExpandRecordColumn(LevelNode, "node", {"location","quantities"}, {"location","quantities"}),

    ExpandLoc = Table.ExpandRecordColumn(
        ExpandLevel, "location",
        {"id","name"},
        {"location_id","location_name"}
    ),

    QtyList = Table.ExpandListColumn(ExpandLoc, "quantities"),
    QtyRec = Table.ExpandRecordColumn(
        QtyList, "quantities",
        {"name","quantity"},
        {"state","qty"}
    ),

    Pivot = Table.Pivot(
        QtyRec,
        List.Distinct(QtyRec[state]),
        "state",
        "qty",
        List.Sum
    )
in
    Pivot
