table 50000 ad_SalesPriceSourceTypeWeight
{
    Caption = 'Sales Price Source Type Weight';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Enum "Sales Price Source Type")
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                case Code of
                    code::"All Customers":
                        OldSalesType := OldSalesType::"All Customers";
                    code::Customer:
                        OldSalesType := OldSalesType::Customer;
                    code::Campaign:
                        OldSalesType := OldSalesType::Campaign;
                    code::"Customer Price Group":
                        OldSalesType := OldSalesType::"Customer Price Group";

                end;
            end;
        }
        field(2; Weight; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(10; OldSalesType; Option)
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'To accomodate older v15';

            DataClassification = CustomerContent;
            Caption = 'Sales Type';
            OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign';
            OptionMembers = Customer,"Customer Price Group","All Customers",Campaign;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}