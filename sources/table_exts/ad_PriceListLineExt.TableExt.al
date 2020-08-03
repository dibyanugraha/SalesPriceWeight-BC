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

        case "Source Type" of
            "Source Type"::"All Customers":
                begin
                    Weight := 1;
                end;
            "Source Type"::Campaign:
                begin
                    Weight := 5;
                end;
            "Source Type"::"Customer Price Group":
                begin
                    Weight := 10;

                end;
            "Source Type"::Customer:
                begin
                    Weight := 20;

                end;
            else
        end;
    end;

    trigger OnbeforeRename()
    begin
        if xRec."Source Type" <> "Source Type" then
            case "Source Type" of
                "Source Type"::"All Customers":
                    begin
                        Weight := 1;
                    end;
                "Source Type"::Campaign:
                    begin

                        Weight := 5;
                    end;
                "Source Type"::"Customer Price Group":
                    begin
                        Weight := 10;

                    end;
                "Source Type"::Customer:
                    begin
                        Weight := 20;

                    end;
                else
            end;
    end;
}