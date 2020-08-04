tableextension 50000 ad_SalesPriceExt extends "Sales Price"
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
        if "Item No." = '' then
            exit;
        if not PriceWeight.Get("Sales Type") then
            exit;

        Weight := PriceWeight.Weight;
    end;

    trigger OnbeforeRename()
    begin
        if "Item No." = '' then
            exit;

        if not PriceWeight.Get("Sales Type") then
            exit;

        Weight := PriceWeight.Weight;
    end;

    var
        PriceWeight: Record ad_SalesPriceSourceTypeWeight;
}