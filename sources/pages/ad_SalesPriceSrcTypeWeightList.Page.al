page 50001 ad_SalesPriceSrcTypeWeightList
{
    Caption = 'Source Type Weight';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
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
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ResetWeight)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}