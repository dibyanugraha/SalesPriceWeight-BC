codeunit 50002 ad_SalesPriceWeightInstall
{
    // Customer Rewards Install Logic 
    Subtype = Install;

    trigger OnInstallAppPerCompany();
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assisted Setup", 'OnRegister', '', true, true)]
    local procedure OnRegisterAssistedSetup()
    var
        AssistedSetup: Codeunit "Assisted Setup";
        CurrentModuleInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(CurrentModuleInfo);
        if AssistedSetup.Exists(Page::ad_SalesPriceWeightWizard) then
            exit;

        AssistedSetup.Add(CurrentModuleInfo.Id,
                          Page::ad_SalesPriceWeightWizard,
                          'Set up sales price weight extension',
                          "Assisted Setup Group"::GettingStarted);
    end;
}