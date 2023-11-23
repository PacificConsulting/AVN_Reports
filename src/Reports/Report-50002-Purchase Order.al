report 50002 "Purchase Order"
{
    //PCPL-064
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Reports Layout\Purchase Order -4.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Posting Date";
            column(No_; "No.")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(cominfo_Picture; cominfo.Picture)
            {

            }
            column(cominfo_name; cominfo.Name)
            {

            }
            column(cominfo_name2; cominfo.Name + '' + cominfo."Name 2")
            {

            }
            column(cominfo_address; cominfo.Address + '' + cominfo."Address 2" + '' + cominfo.City + '' + cominfo."Post Code")
            {

            }
            column(cominfo_mail; cominfo."E-Mail")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(ShiptoGSTIN; ShiptoGSTIN)
            {

            }
            column(shiptoadd; shiptoadd)
            {

            }
            column(ShipfromGSTIN; ShipfromGSTIN)
            {

            }
            column(shipfromadd; shipfromadd)
            {

            }
            column(Shipfrompanno; Shipfrompanno)
            {

            }

            column(IGSTPer; IGSTPer)
            {

            }
            column(CGSTPer; CGSTPer)
            {

            }
            column(SGSTPer; SGSTPer)
            {

            }
            column(CGSTLbl; CGSTLbl)
            {

            }
            column(SGSTLbl; SGSTLbl)
            {

            }
            column(IGSTLbl; IGSTLbl)
            {

            }
            column(Currency_symbol; RecGeneralLedgerSetup."Local Currency Symbol")
            {

            }
            column(Amount_1; Amount)
            {

            }
            column(TotalAmount1; TotalAmount1)
            {

            }
            column(SGSTAmount; SGSTAmount)
            {

            }
            column(CGSTAmount; CGSTAmount)
            {

            }
            column(IGSTAmount; IGSTAmount)
            {

            }


            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Purchase Header";
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(Amount; Amount)
                {

                }
                column(TotalGSTAmountFinal; TotalGSTAmountFinal)
                {

                }

                trigger OnAfterGetRecord()  //PL
                begin
                    //IF PurchHedr.get("Purchase Line"."Document Type", "Purchase Line"."Document No.") then
                    //TotalGSTAmountFinal := GSTFooterTotal(PurchHedr);
                    //GST Calculated
                    // GetGSTAmountLinewise("Purchase Line", TotalGSTAmountlinewise, TotalGSTPercent);
                    //GetGSTCaptions("Purchase Line",);


                end;
            }
            trigger OnAfterGetRecord()  //PH
            begin

                //Shipfrom
                IF RVend.GET("Purchase Header"."Buy-from Vendor No.") THEN
                    ShipfromGSTIN := RVend."GST Registration No.";
                Shipfrompanno := RVend."P.A.N. No.";
                shipfromadd := RVend.Address + '' + RVend."Address 2" + ' ' + RVend.City + '' + RVend."Post Code";

                //Shipto
                IF Rlocation.GET("Location Code") THEN;
                ShiptoGSTIN := Rlocation."GST Registration No.";
                //PayPanno := Rlocation."P.A.N. No.";
                shiptoadd := Rlocation.Address + '' + Rlocation."Address 2" + '' + Rlocation.City + '' + Rlocation."Post Code";
                RecGeneralLedgerSetup.Get();

                PL.Reset();
                PL.SetRange("Document No.", "No.");
                if PL.FindFirst() then
                    repeat
                        TotalAmount1 += PL.Amount;
                    until PL.Next = 0;
                //for total line gst value
                GetPurchaseStatisticsAmount("Purchase Header", TotalGSTAmount, TotalGSTPercent); //8aug2023
            end;


            trigger OnPreDataItem()  //PH
            begin
                cominfo.get();
                cominfo.CalcFields(Picture);

                //RecGeneralLedgerSetup.Get();
            end;


        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;
        cominfo: Record "Company Information";
        RVend: Record Vendor;
        ShipfromGSTIN: Code[20];
        ShiptoGSTIN: Code[20];
        PurchHedr: Record "Purchase Header";
        //TotalGSTAmountFinal: Decimal;
        Shipfrompanno: Code[20];
        ShiPanno: Code[20];
        Rlocation: Record Location;
        shiptoadd: Text[200];
        shipfromadd: Text[200];
        CGSTPer: Decimal;
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        TotalGSTAmountFinal: Decimal;
        CGSTAmount: Decimal;
        SGSTAmount: Decimal;
        IGSTAmount: Decimal;
        //PurchHedr: Record "Purchase Header";
        recPurchLine: Record "Purchase Line";
        CessAmount: Decimal;
        GSTComponentCodeName: array[20] of Code[20];
        TotalGSTAmountlinewise: Decimal;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        TotalAmount: decimal;
        TotalGSTPercent: Decimal;
        RecGeneralLedgerSetup: Record "General Ledger Setup";
        PL: Record "Purchase Line";
        TotalAmount1: Decimal;
        TotalGSTAmount: Decimal;

    //GST Calculated 
    procedure GetPurchaseStatisticsAmount(
             PurchaseHeader: Record "Purchase Header";
             var GSTAmount: Decimal; var GSTPercent: Decimal)
    var
        PurchaseLine: Record "Purchase Line";
    begin
        Clear(GSTAmount);
        Clear(GSTPercent);
        Clear(TotalAmount);
        Clear(CGSTAmount);
        Clear(SGSTAmount);
        Clear(IGSTAmount);
        Clear(IGSTPer);
        Clear(SGSTPer);
        Clear(CGSTPer);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document no.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount(PurchaseLine.RecordId());
                GSTPercent += GetGSTPercent(PurchaseLine.RecordId());
                TotalAmount += PurchaseLine."Line Amount" /*- PurchaseLine."Line Discount Amount"*/ - PurchaseLine."Inv. Discount Amount";//PCPL/NSW/170222
                GetGSTAmountsTotal(PurchaseLine);
            until PurchaseLine.Next() = 0;
    end;

    local procedure GetGSTAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then begin
            TaxTransactionValue.CalcSums(Amount);
            TaxTransactionValue.CalcSums(Percent);
            /*
            if TaxTransactionValue."Value ID" = 6 then begin
                SGSTAmount += TaxTransactionValue.Amount;
                SGSTPer += TaxTransactionValue.Percent;
                // message('%1', SGSTAmt);
            end;
            if TaxTransactionValue."Value ID" = 2 then begin
                CGSTAmount += TaxTransactionValue.Amount;
                CGSTPer += TaxTransactionValue.Percent;
            end;
            if TaxTransactionValue."Value ID" = 3 then begin
                IGSTAmount += TaxTransactionValue.Amount;
                IGSTPer += TaxTransactionValue.Percent;
            end;
            */
        end;


        exit(TaxTransactionValue.Amount);
    end;

    local procedure GetGSTPercent(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Percent);

        exit(TaxTransactionValue.Percent);
    end;

    local procedure GetGSTAmounts(PurchaseLine: Record "Purchase Line")
    var
        ComponentName: Code[30];
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        ComponentName := GetComponentName("Purchase Line", GSTSetup);

        if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                SGSTAmount := Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                SGSTPer := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                CGSTAmount := Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                CGSTPer := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGSTAmount := Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                IGSTPer := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
        end;
    end;

    local procedure GetGSTAmountsTotal(PurchaseLine: Record "Purchase Line")
    var
        ComponentName: Code[30];
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        ComponentName := GetComponentName("Purchase Line", GSTSetup);

        if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                SGSTAmount += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                SGSTPer := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                CGSTAmount += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                CGSTPer := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGSTAmount += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                IGSTPer := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
        end;
    end;


    local procedure GetCessAmount(TaxTransactionValue: Record "Tax Transaction Value";
        PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup")
    begin
        if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."Cess Tax Type");
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    CessAmount += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(GetComponentName(PurchaseLine, GSTSetup)));
                until TaxTransactionValue.Next() = 0;
        end;
    end;

    local procedure GetGSTCaptions(TaxTransactionValue: Record "Tax Transaction Value";
        PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup")
    begin
        TaxTransactionValue.Reset();
        TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
        TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                case TaxTransactionValue."Value ID" of
                    6:
                        GSTComponentCodeName[6] := SGSTLbl;
                    2:
                        GSTComponentCodeName[2] := CGSTLbl;
                    3:
                        GSTComponentCodeName[3] := IGSTLbl;
                end;
            until TaxTransactionValue.Next() = 0;
    end;

    local procedure GetComponentName(PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if PurchaseLine."GST Jurisdiction Type" = PurchaseLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
    end;

    // local procedure GetTDSAmount(TaxTransactionValue: Record "Tax Transaction Value";
    //     PurchaseLine: Record "Purchase Line";
    //     TDSSetup: Record "TDS Setup")
    // begin
    //     if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
    //         TaxTransactionValue.Reset();
    //         TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
    //         TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
    //         TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
    //         TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
    //         if TaxTransactionValue.FindSet() then
    //             repeat
    //                 TDSAmt += TaxTransactionValue.Amount;
    //             until TaxTransactionValue.Next() = 0;
    //     end;
    //     TDSAmt := Round(TDSAmt, 1);
    // end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
    var
        TaxComponent: Record "Tax Component";
        GSTSetup: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup.Get() then
            exit;
        GSTSetup.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;

    procedure GetGSTAmountLinewise(
        PurchaseLine: Record 39;
        var GSTAmount: Decimal; var GSTPercent: Decimal)
    var
        PurchaseLine1: Record "Purchase Line";
    begin
        Clear(GSTAmount);
        Clear(GSTPercent);
        Clear(TotalAmount);
        Clear(CGSTAmount);
        Clear(SGSTAmount);
        Clear(IGSTAmount);
        Clear(IGSTPer);
        Clear(SGSTPer);
        Clear(CGSTPer);

        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type");
        PurchaseLine.SetRange("Document no.", PurchaseLine."Document No.");
        PurchaseLine.SetRange(PurchaseLine."Line No.", PurchaseLine."Line No.");
        if PurchaseLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount(PurchaseLine.RecordId());
                GSTPercent += GetGSTPercent(PurchaseLine.RecordId());
                TotalAmount += PurchaseLine."Line Amount" /*- PurchaseLine."Line Discount Amount"*/ - PurchaseLine."Inv. Discount Amount";//PCPL/NSW/170222
                GetGSTAmounts(PurchaseLine);
            until PurchaseLine.Next() = 0;
    end;


    procedure GSTFooterTotal(PurchaseHeader: Record "Purchase Header"): Decimal

    var
        PurchaseLine: Record "Purchase Line";
        GSTAmountFooter: Decimal;
    begin
        // Clear(GSTAmount);
        // Clear(GSTPercent);
        // Clear(TotalAmount);
        // Clear(CGSTAmount);
        // Clear(SGSTAmount);
        // Clear(IGSTAmount);
        // Clear(IGSTPer);
        // Clear(SGSTPer);
        // Clear(CGSTPer);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document no.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                GSTAmountFooter += GetGSTAmountFooter(PurchaseLine.RecordId());
            until PurchaseLine.Next() = 0;
        exit(GSTAmountFooter);
    end;

    local procedure GetGSTAmountFooter(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then begin
            TaxTransactionValue.CalcSums(Amount);
            TaxTransactionValue.CalcSums(Percent);

        end;


        exit(TaxTransactionValue.Amount);
    end;
}