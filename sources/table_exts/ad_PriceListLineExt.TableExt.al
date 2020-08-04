tableextension 50001 ad_PriceListLineExt extends "Price List Line"
{
    fields
    {
        field(50000; Weight; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    trigger OnBeforeInsert()
    begin
        if "Asset Type" <> "Asset Type"::Item then
            exit;

        if not PriceWeight.Get("Source Type") then
            exit;

        Weight := PriceWeight.Weight;
    end;

    trigger OnbeforeRename()
    begin
        if "Asset Type" <> "Asset Type"::Item then
            exit;

        if not PriceWeight.Get("Source Type") then
            exit;

        Weight := PriceWeight.Weight;
    end;

    var
        PriceWeight: Record ad_SalesPriceSourceTypeWeight;
}