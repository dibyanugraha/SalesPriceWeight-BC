page 50002 ad_SalesPriceWeightWizard
{
    Caption = 'Sales Price Weight Setup';
    PageType = NavigatePage;

    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                ShowCaption = false;
                Editable = false;
                Visible = TopBannerVisible and not DoneVisible;
                field(MediaResourcesStd; MediaResourcesStd."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(FinishedBanner)
            {
                ShowCaption = false;
                Editable = false;
                Visible = TopBannerVisible and DoneVisible;
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(WelcomeScreen)
            {
                ShowCaption = false;
                Visible = Step1Visible;
                group("Welcome to Sales Price Weight Setup")
                {
                    Visible = Step1Visible;
                    Caption = 'Welcome to Sales Price Weight Setup';
                    InstructionalText = 'To prepare Dynamics 365 Business Central Sales Price Weight extension.';
                }
                group("Let's go!")
                {
                    Visible = Step1Visible;
                    Caption = 'Let''s go!';
                    InstructionalText = 'Choose Next so you can specify weight of sales prices.';
                }
            }
            group(Step2)
            {
                ShowCaption = false;
                InstructionalText = 'Please enter weight for following sales price type. The lower the value, the higher the priority is.';
                Visible = Step2Visible;

                part(SalesPriceTypeWeight; ad_SalesPriceWeightListPart)
                {
                    ApplicationArea = All;
                    Caption = '';
                }
            }
            group(Step3)
            {
                Visible = Step3Visible;

                //  run ad_PriceCalculationByWeight to set price calculation default
                //  make sure new weight default is on
                //  activate sales price calculation in sales setup
                group(Activate)
                {
                    Visible = Step3Visible;
                    Caption = 'You will need to change ';
                    InstructionalText = 'To prepare Dynamics 365 Business Central Sales Price Weight extension.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ActionBack)
            {
                ApplicationArea = All;
                Caption = 'Back';
                Enabled = BackEnabled;
                Image = PreviousRecord;
                InFooterBar = true;

                trigger OnAction();
                begin
                    NextStep(true);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = All;
                Caption = 'Next';
                Enabled = NextEnabled;
                Image = NextRecord;
                InFooterBar = true;

                trigger OnAction();
                begin
                    NextStep(false);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = All;
                Caption = 'Finish';
                Enabled = DoneVisible;
                Image = Approve;
                InFooterBar = true;
                trigger OnAction();
                begin
                    FinishAction();
                end;
            }
        }
    }
    local procedure NextStep(Backwards: Boolean);
    begin
        if Backwards then
            Step := Step - 1
        else
            Step := Step + 1;

        EnableControls();
    end;

    local procedure EnableControls();
    begin
        ResetWizardControls();

        case Step of
            Step::Start:
                ShowStep1();
            Step::Step2:
                ShowStep2();
            Step::Finish:
                ShowStep3();
        end;
    end;

    local procedure ShowStep1();
    begin
        Step1Visible := true;
        BackEnabled := false;
    end;

    local procedure ShowStep2();
    begin
        Step2Visible := true;
    end;

    local procedure ShowStep3();
    begin
        Step3Visible := true;

        NextEnabled := false;
        DoneVisible := true;
    end;

    local procedure ResetWizardControls();
    begin
        //  buttons
        DoneVisible := false;
        BackEnabled := true;
        NextEnabled := true;

        //  tabs
        Step1Visible := false;
        Step2Visible := false;
        Step3Visible := false;
    end;

    local procedure FinishAction();
    begin
        StoreRecordVar();
        CurrPage.Close();
    end;

    local procedure StoreRecordVar();
    begin
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStd.Get('AssistedSetup-NoText-400px.png',
           Format(CurrentClientType())) and
           MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png',
           Format(CurrentClientType()))
        then
            if MediaResourcesStd.Get(MediaRepositoryStd."Media Resources Ref") and
               MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue();
    end;

    local procedure WizardIsAllowed(): Boolean
    var
        SalesPriceWeight: Record ad_SalesPriceSourceTypeWeight;
    begin
        exit(SalesPriceWeight.IsEmpty);
    end;

    trigger OnInit();
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage()
    begin
        if not WizardIsAllowed then
            Step := Step::Finish;

        EnableControls;
    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        AssistedSetup: Codeunit "Assisted Setup";
    begin
        if not (CloseAction = ACTION::OK) then
            exit;

        if WizardIsAllowed and AssistedSetup.ExistsAndIsNotComplete(PAGE::ad_SalesPriceWeightWizard) then
            if not Confirm(SetupNotFinished, false) then
                Error('');
    end;

    var
        SetupNotFinished: Label 'Sales price weight has not been set up.\\Are you sure you want to exit?';
        MediaRepositoryDone: Record "Media Repository";
        MediaRepositoryStd: Record "Media Repository";
        MediaResourcesDone: Record "Media Resources";
        MediaResourcesStd: Record "Media Resources";
        TopBannerVisible: Boolean;
        BackEnabled: Boolean;
        DoneVisible: Boolean;
        NextEnabled: Boolean;
        Step1Visible: Boolean;
        Step2Visible: Boolean;
        Step3Visible: Boolean;
        Step: Option Start,Step2,Finish;
}