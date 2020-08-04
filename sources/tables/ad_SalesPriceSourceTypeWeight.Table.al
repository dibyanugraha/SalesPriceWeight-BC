table 50000 ad_SalesPriceSourceTypeWeight
{
    Caption = 'Sales Price Source Type Weight';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Enum "Sales Price Source Type")
        {
            DataClassification = CustomerContent;
        }
        field(2; Weight; Integer)
        {
            DataClassification = CustomerContent;
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