report 50003 "Tax Invoice"
{
    //PCPL-064
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Reports Layout\Tax Invoice -6.rdl';


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Posting Date";
            column(SIH_No_; "No.")
            {

            }
            // column(Order_No_; "Order No.")
            // {

            // }
            column(Order_No_; "PI No.")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(Compinfo_picture; Compinfo.Picture)
            {

            }
            column(CompName; Compinfo.Name)
            {

            }
            column(Compinfo_Name2; 'For' + ' ' + Compinfo.Name)
            {

            }
            column(CompName2; Compinfo.Name + '' + Compinfo."Name 2")
            {

            }
            column(CompAddress; Compinfo.Address + '' + Compinfo."Address 2" + '' + Compinfo.City + '' + Compinfo."Post Code" + '' + Compinfo."Country/Region Code")
            {
            }
            column(CompPhone; Compinfo."Phone No.")
            {

            }
            column(Compinfo_CIN; Compinfo."Registration No.")
            {

            }
            column(Compinfo_GSTIN; Location."GST Registration No.")
            {

            }

            column(cominfo_mail; compinfo."E-Mail")
            {

            }
            column(Compinfo_PAN; Compinfo."P.A.N. No.")
            {

            }
            column(Compinfo_BankAccNo; Compinfo."Bank Account No.")
            {

            }
            column(Compinfo_BankName; Compinfo."Bank Name")
            {

            }
            column(Compinfo_Branch; Compinfo."Bank Branch No.")
            {

            }

            column(Bill_to_Name; "Bill-to Name")
            {

            }
            column(Bill_to_Address; "Bill-to Address" + '' + "Bill-to Address 2" + ',' + "Bill-to City" + ',' + "Bill-to Post Code" + ',' + "Bill-to Country/Region Code")
            {

            }
            column(BilltoGSTIN; CustGSTIN)
            {

            }
            column(BillPan; BillPan)
            {

            }
            column(State; State)
            {

            }
            column(PANShip; PANShip)
            {

            }
            column(currency_symbol; RecGeneralLedgerSetup."Local Currency Symbol")
            {

            }

            column(Location_State_Code; "Location State Code")
            {

            }
            column(Location_Code; "Location Code")
            {

            }
            column(ShiptoName; ShiptoName)
            {

            }
            column(ShiptoAdd; ShiptoAdd)
            {

            }
            column(ShiptoGSTIN; ShiptoGSTIN)
            {

            }
            column(BankIFSC; RecbankAcc."IFSC Code")
            {

            }
            column(Place_supply; Recstate.Description)
            {

            }
            column(Recstate_name; Recstate.Description + '  ' + 'Code:' + Recstate."State Code (GST Reg. No.)")
            {

            }
            column(comments; comments)
            {

            }
            column(Location; Location.Address + Location."Address 2")
            {

            }
            column(TotalAmount; TotalAmount)
            {

            }

            column(SGST; SGST)
            {

            }
            column(SGSTPer; SGSTPer)
            {

            }
            column(CGST; CGST)
            {

            }
            column(CGSTPer; CGSTPer)
            {

            }
            column(IGST; IGST)
            {

            }
            column(IGSTPer; IGSTPer)
            {

            }
            column(TotalTaxAmount; TotalTaxAmount)
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(EInvoice_picture; EInvoice."E-Invoice QR Code")
            {

            }
            column(EInvoice_IRNNo; EInvoice."E-Invoice IRN No.")
            {

            }


            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Invoice Header";
                column(SrNo; SrNo)
                {

                }
                column(Document_No_; "Document No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Amount; Amount)
                {

                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(Line_No_; "Line No.")
                { }
                // column(TotalAmount; TotalAmount)
                // {

                // }
                column(TotalSGST; TotalSGST)
                {

                }
                column(TotalCGST; TotalCGST)
                {

                }
                column(TotalIGST; TotalIGST)
                {

                }
                column(SGST_1; SGST_1)
                {

                }
                column(SGSTPer_1; SGSTPer_1)
                {

                }
                column(CGST_1; CGST_1)
                {

                }
                column(CGSTPer_1; CGSTPer_1)
                {

                }
                column(IGST_1; IGST_1)
                {

                }
                column(IGSTPer_1; IGSTPer_1)
                {

                }
                column(TotalAmount1; TotalAmount1)
                {

                }
                column(AmountInWords1; AmountInWords1[1])
                {

                }

                column(TaxAmountInWords; TaxAmountInWords[1])
                {

                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No."),
                    "Document Line No." = FIELD("Line No.");
                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
                    {
                        //DataItemLink = "Entry No." = FIELD();
                        DataItemLink = "Entry No." = FIELD("Item Ledger Entry No.");
                        column(Lot_No_; "Lot No.")
                        {

                        }
                        column(Item_No_; "Item No.")
                        {

                        }
                    }
                }
                trigger OnAfterGetRecord()  //SIL
                begin
                    SrNo += 1;
                    CGST_1 := 0;
                    IGST_1 := 0;
                    SGST_1 := 0;
                    CGSTPer_1 := 0;
                    SGSTPer_1 := 0;
                    IGSTPer_1 := 0;
                    Clear(CGST_1);
                    Clear(IGST_1);
                    Clear(SGST_1);
                    // Clear(TotalSGST);
                    // Clear(TotalCGST);
                    // Clear(TotalIGST);

                    //GST Calculate
                    DGLE_1.Reset();
                    DGLE_1.SetRange("Document No.", "Document No.");
                    DGLE_1.SetRange("Document Line No.", "Line No.");
                    DGLE_1.SetRange(DGLE_1."HSN/SAC Code", "Sales Invoice Line"."HSN/SAC Code");
                    //DGLE.SetRange("No.", "No.");
                    DGLE_1.SetRange("Transaction Type", DGLE_1."Transaction Type"::sales);
                    DGLE_1.SetRange("Document Type", DGLE_1."Document Type"::Invoice);
                    if DGLE.findset then begin
                        repeat
                            IF DGLE_1."GST Component Code" = 'SGST' THEN BEGIN

                                SGST_1 := ABS(DGLE_1."GST Amount");
                                SGSTPer_1 := DGLE_1."GST %";

                            END

                            ELSE
                                IF DGLE_1."GST Component Code" = 'CGST' THEN BEGIN
                                    CGST_1 := ABS(DGLE_1."GST Amount");
                                    CGSTPer_1 := DGLE_1."GST %";
                                END

                                ELSE
                                    IF DGLE_1."GST Component Code" = 'IGST' THEN BEGIN
                                        IGST_1 := ABS(DGLE_1."GST Amount");
                                        IGSTPer_1 := DGLE_1."GST %";
                                    END
                        until DGLE_1.Next() = 0;
                        //AoumntInWords



                        // // TotalAmount := TotalAmount1 + SGST + CGST + IGST; 12052023
                        // TotalCGST += CGST;
                        // TotalSGST += SGST;
                        // TotalIGST += IGST;
                        // TotalAmount += TotalAmount1 + TotalSGST + TotalCGST + TotalIGST;
                        // AmountInwords.InitTextVariable();
                        // AmountInwords.FormatNoText(AmountInWords1, ROUND(TotalAmount), '');


                        // //GSTAmountInWords
                        // TotalTaxAmount += SGST_1 + CGST_1 + IGST_1;
                        // AmountInwords.InitTextVariable();
                        // AmountInwords.FormatNoText(TaxAmountInWords, Round(TotalTaxAmount), '');



                    end;
                end;
            }
            trigger OnAfterGetRecord()    //SIH
            begin
                if RecCust.get("Sales Invoice Header"."Sell-to Customer No.") then
                    CustGSTIN := RecCust."GST Registration No.";
                BillPan := RecCust."P.A.N. No.";

                if RecbankAcc.get("Sales Invoice Header"."Company Bank Account Code") then;

                if Recstate.Get("Sales Invoice Header".State) then;

                if Location.Get("Location Code") THEN;
                //LocGSTIN := Location."GST Registration No.";

                //ShiptoAddress
                IF "Sales Invoice Header"."Ship-to Code" <> '' THEN BEGIN
                    PANShip := recCust."P.A.N. No.";

                    ShiptoName := "Ship-to Name";
                    ShiptoAdd := "Ship-to Address" + '' + "Ship-to Address 2" + ' ' + "Ship-to City" + ',' + "Ship-to Post Code" + ' ' + "Ship-to Country/Region Code";
                    //Shiptocity := "Ship-to City" + ',' + "Ship-to Post Code" + ' ' + "Ship-to Country/Region Code";
                    ShiptoGSTIN := "Ship-to GST Reg. No.";

                end
                ELSE begin
                    if "Ship-to Code" = '' then begin
                        recCust.RESET;
                        recCust.SETRANGE(recCust."No.", "Sales Invoice Header"."Bill-to Customer No.");
                        IF recCust.FINDFIRST THEN
                            ShiptoName := "Bill-to Name";
                        ShiptoAdd := "Bill-to Address" + '' + "Bill-to Address 2" + ',' + "Bill-to City" + ',' + "Bill-to Post Code" + ',' + "Bill-to Country/Region Code";
                        // Shiptocity := "Bill-to City" + ',' + "Bill-to Post Code" + ' ' + "Bill-to Country/Region Code";
                        ShiptoGSTIN := CustGSTIN;

                    end;

                end;

                recsalescommentshhet.Reset();
                //recsalescommentshhet.SetRange("Document Type","Sales Invoice Header".);
                recsalescommentshhet.SetRange("No.", "No.");
                if recsalescommentshhet.FindFirst() then begin
                    repeat
                        comments += recsalescommentshhet.Comment;
                    until recsalescommentshhet.Next() = 0;
                end;

                SIL.Reset();
                SIL.SetRange("Document No.", "No.");
                if SIL.FindFirst() then
                    repeat
                        TotalAmount1 += SIL.Amount;
                    until SIL.Next = 0;

                //PCPL-0070 <<
                CGST := 0;
                IGST := 0;
                SGST := 0;
                CGSTPer := 0;
                SGSTPer := 0;
                IGSTPer := 0;
                Clear(CGST);
                Clear(IGST);
                Clear(SGST);
                DGLE.Reset();
                DGLE.SetRange("Document No.", "No.");
                DGLE.SetRange("Transaction Type", DGLE."Transaction Type"::sales);
                DGLE.SetRange("Document Type", DGLE."Document Type"::Invoice);
                if DGLE.findset then begin
                    repeat
                        IF DGLE."GST Component Code" = 'SGST' THEN BEGIN

                            SGST += ABS(DGLE."GST Amount");
                            SGSTPer := DGLE."GST %";

                        END
                        ELSE
                            IF DGLE."GST Component Code" = 'CGST' THEN BEGIN
                                CGST += ABS(DGLE."GST Amount");
                                CGSTPer := DGLE."GST %";
                            END
                            ELSE
                                IF DGLE."GST Component Code" = 'IGST' THEN BEGIN
                                    IGST += ABS(DGLE."GST Amount");
                                    IGSTPer := DGLE."GST %";
                                END
                    until DGLE.Next() = 0;

                    TotalAmount := TotalAmount1 + CGST + SGST + IGST;
                    AmountInwords.InitTextVariable();
                    AmountInwords.FormatNoText(AmountInWords1, ROUND(TotalAmount), '');

                    //GSTAmountInWords
                    TotalTaxAmount += SGST + CGST + IGST;
                    AmountInwords.InitTextVariable();
                    AmountInwords.FormatNoText(TaxAmountInWords, Round(TotalTaxAmount), '');

                end;
                //PCPL-0070 >>


                if EInvoice.Get("No.") then;
                EInvoice.CalcFields("E-Invoice QR Code");

                //QRcode := format(EInvoice."E-Invoice QR Code");
                // IRNno := EInvoice."E-Invoice IRN No.";
            end;

            //end;

            trigger OnPreDataItem() //SIH
            begin
                Compinfo.get();
                Compinfo.CalcFields(Picture);
                RecGeneralLedgerSetup.get();

                //Rstate.Get()

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
        QRcode: Text[250];
        IRNNO: code[70];
        CGST: Decimal;
        IGST: Decimal;
        SGST: Decimal;
        CGSTPer: Decimal;
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        DGLE_1: Record "Detailed GST Ledger Entry";
        CGST_1: Decimal;
        IGST_1: Decimal;
        SGST_1: Decimal;
        CGSTPer_1: Decimal;
        SGSTPer_1: Decimal;
        IGSTPer_1: Decimal;
        DGLE: Record "Detailed GST Ledger Entry";
        SrNo: Integer;
        Compinfo: Record "Company Information";
        RecCust: Record Customer;
        CustGSTIN: Code[20];
        BillPan: code[20];
        Rstate: Record State;
        AmountInwords: codeunit "Amount In Words";
        TotalAmount: Decimal;
        AmountInWords1: array[2] of Text[200];
        TotalTaxAmount: Decimal;
        TaxAmountInWords: array[2] of Text[200];
        ShiptoAdd: Text[200];
        ShiptoName: Text[50];
        Shiptocity: Text[20];
        ShiptoGSTIN: Code[20];
        RecbankAcc: Record "Bank Account";
        Recstate: Record State;
        PANShip: Code[10];
        RecGeneralLedgerSetup: record "General Ledger Setup";
        shiptoaddres: Record "Ship-to Address";
        comments: text[80];
        recsalescommentshhet: Record 44;
        Location: Record Location;
        LocGSTIN: code[20];
        SIL: Record "Sales Invoice Line";
        TotalAmount1: Decimal;
        TotalSGST: decimal;
        TotalCGST: decimal;
        TotalIGST: decimal;
        EInvoice: record "E-Invoice Detail";

}