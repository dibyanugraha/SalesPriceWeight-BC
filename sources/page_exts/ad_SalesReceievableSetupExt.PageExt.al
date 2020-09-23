pageextension 50002 ad_SalesReceivableSetup extends "Sales & Receivables Setup"
{
    layout
    {
        modify("Price Calculation Method")
        {
            Visible = true;
        }
    }

    actions
    {
        addlast(Processing)
        {
            group(Extensions)
            {
                action(ResetWeight)
                {
                    Image = ResetStatus;
                    Caption = 'Reset Sales Price Wieght';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Codeunit.Run(codeunit::ad_PriceCalculationByWeight);
                    end;
                }
            }
        }
    }
}