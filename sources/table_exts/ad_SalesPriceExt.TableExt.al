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
        if not PriceWeight.Get("Sales Type") then begin
            PriceWeight.Reset();
            PriceWeight.SetRange(OldSalesType, "Sales Type");
            if not PriceWeight.FindFirst() then
                exit;
        end;
        Message('%1 - %2', Format(PriceWeight.Code), Format(PriceWeight.Weight));
        Weight := PriceWeight.Weight;
    end;

    trigger OnbeforeRename()
    begin
        if "Item No." = '' then
            exit;
        if not PriceWeight.Get("Sales Type") then begin
            PriceWeight.Reset();
            PriceWeight.SetRange(OldSalesType, "Sales Type");
            if not PriceWeight.FindFirst() then
                exit;
        end;
        Message('%1 - %2', Format(PriceWeight.Code), Format(PriceWeight.Weight));
        Weight := PriceWeight.Weight;
    end;

    var
        PriceWeight: Record ad_SalesPriceSourceTypeWeight;
}