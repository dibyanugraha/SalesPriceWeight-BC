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
        case "Sales Type" of
            "Sales Type"::"All Customers":
                begin
                    Weight := 1;
                end;
            "Sales Type"::Campaign:
                begin
                    Weight := 5;
                end;
            "Sales Type"::"Customer Price Group":
                begin
                    Weight := 10;

                end;
            "Sales Type"::Customer:
                begin
                    Weight := 20;

                end;
            else
        end;
    end;

    trigger OnbeforeRename()
    begin
        if xRec."Sales Type" <> "Sales Type" then
            case "Sales Type" of
                "Sales Type"::"All Customers":
                    begin
                        Weight := 1;
                    end;
                "Sales Type"::Campaign:
                    begin

                        Weight := 5;
                    end;
                "Sales Type"::"Customer Price Group":
                    begin
                        Weight := 10;

                    end;
                "Sales Type"::Customer:
                    begin
                        Weight := 20;

                    end;
                else
            end;
    end;
}