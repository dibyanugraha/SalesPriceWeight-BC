codeunit 50000 ad_ReplSalesPricesRetrMethod
{
    // var
    //     LineDiscPerCent: Decimal;
    //     QtyPerUOM: Decimal;
    //     Qty: Decimal;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnAfterCalcBestUnitPrice', '', false, false)]
    // local procedure OnAfterCalcBestUnitPrice(var SalesPrice: Record "Sales Price")
    // var
    //     salesPriceCode: Codeunit "Sales Price Calc. Mgt.";
    //     BestSalesPrice: Record "Sales Price";
    //     BestSalesPriceFound: Boolean;
    //     Item: Record Item;
    // begin
    //     //  redo the operation, however now it includes the weight
    //     Item.get(SalesPrice."Item No.");

    //     SalesPrice.FindFirst();
    //     with SalesPrice do begin
    //         repeat
    //             if IsInMinQty("Unit of Measure Code", "Minimum Quantity") then begin
    //                 salesPriceCode.ConvertPriceToVAT(
    //                   "Price Includes VAT", Item."VAT Prod. Posting Group",
    //                   "VAT Bus. Posting Gr. (Price)", "Unit Price");
    //                 ConvertPriceToUoM("Unit of Measure Code", "Unit Price");
    //                 salesPriceCode.ConvertPriceLCYToFCY("Currency Code", "Unit Price");
    //                 case true of
    //                     ((BestSalesPrice."Currency Code" = '') and ("Currency Code" <> ''))
    //                     or ((BestSalesPrice."Variant Code" = '') and ("Variant Code" <> '')):
    //                         if (BestSalesPrice.Weight < SalesPrice.Weight) then begin
    //                             BestSalesPrice := SalesPrice;
    //                             BestSalesPriceFound := true;
    //                         end;
    //                     ((BestSalesPrice."Currency Code" = '') or ("Currency Code" <> ''))
    //                     and ((BestSalesPrice."Variant Code" = '') or ("Variant Code" <> '')):
    //                         if (BestSalesPrice."Unit Price" = 0) or
    //                            (CalcLineAmount(BestSalesPrice) > CalcLineAmount(SalesPrice))
    //                         then
    //                             if (BestSalesPrice.Weight < SalesPrice.Weight) then begin
    //                                 BestSalesPrice := SalesPrice;
    //                                 BestSalesPriceFound := true;
    //                             end;
    //                 end;
    //             end;
    //         until Next = 0;
    //     end;
    //     if BestSalesPriceFound then
    //         SalesPrice := BestSalesPrice;
    // end;

    // local procedure CalcLineAmount(SalesPrice: Record "Sales Price") LineAmount: Decimal
    // begin
    //     with SalesPrice do
    //         if "Allow Line Disc." then
    //             LineAmount := "Unit Price" * (1 - LineDiscPerCent / 100)
    //         else
    //             LineAmount := "Unit Price";
    // end;

    // local procedure IsInMinQty(UnitofMeasureCode: Code[10]; MinQty: Decimal): Boolean
    // begin
    //     if UnitofMeasureCode = '' then
    //         exit(MinQty <= QtyPerUOM * Qty);
    //     exit(MinQty <= Qty);
    // end;

    // local procedure ConvertPriceToUoM(UnitOfMeasureCode: Code[10]; var UnitPrice: Decimal)
    // begin
    //     if UnitOfMeasureCode = '' then
    //         UnitPrice := UnitPrice * QtyPerUOM;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CopyFromToPriceListLine, 'OnCopyFromSalesPrice', '', false, false)]
    local procedure OnCopyFromSalesPrice(var SalesPrice: Record "Sales Price"; var PriceListLine: Record "Price List Line")
    begin
        PriceListLine.Weight := SalesPrice.Weight;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Price Calculation Mgt.", 'OnIsExtendedPriceCalculationEnabled', '', false, false)]
    local procedure OnIsExtendedPriceCalculationEnabled(var Result: Boolean)
    begin
        Result := true;
    end;
}