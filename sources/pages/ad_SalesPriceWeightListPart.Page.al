page 50003 ad_SalesPriceWeightListPart
{
    Caption = 'Source Type Weight';
    PageType = ListPart;
    SourceTable = ad_SalesPriceSourceTypeWeight;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Weight; Weight)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}