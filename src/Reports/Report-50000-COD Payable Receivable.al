report 50000 "COD Payable Receivable"
{
    //PCPL-064
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Reports Layout\COD Payable Recievable -4.rdl';

    dataset
    {
        dataitem("COD Payable/Receivable"; "Posted COD Payeble Receivable")
        {
            DataItemTableView = sorting("AVN Voucher No.");
            RequestFilterFields = "Tracking No", "Posting Date";
            column(AVN_Voucher_No_; "AVN Voucher No.")
            {

            }
            column(Tracking_No; "Tracking No")
            {

            }
            column(COD_Customer_Code; "COD Customer Code")
            {

            }
            column(COD_Vendor_Code; "COD Vendor Code")
            {

            }
            column(Shipment_Status; "Shipment Status")
            {

            }
            column(Delivery_Date; "Delivery Date")
            {

            }
            column(COD_Amount_; "COD Amount ")
            {

            }
            column(customername; customername)
            {

            }
            column(CODReceivedamount; CODReceivedamount)
            {

            }
            column(CODPaidamount; CODPaidamount)
            {

            }
            column(CODPaidbutnotreceived; CODPaidbutnotreceived)
            {

            }
            column(CODReceivedbutnotpaid; CODReceivedbutnotpaid)
            {

            }
            column(VLEAmount; VLEAmount)
            {

            }
            column(CLEAmount; CLEAmount)
            {

            }
            trigger OnAfterGetRecord()

            begin
                Clear(CLEAmount);
                Clear(VLEAmount);
                Clear(CODReceivedamount);
                Clear(CODPaidamount);
                Clear(CODReceivedbutnotpaid);
                Clear(CODPaidbutnotreceived);

                if customer.GET("COD Customer Code") then
                    customername := customer.Name;// + ' ' + customer."Name 2";

                /*if "COD Customer Code" <> '' then begin
                    CODReceivedamount := "COD Amount ";
                    VLE.Reset();
                    VLE.SetRange("External Document No.", "Tracking No");
                    VLE.SetRange("Document Type", VLE."Document Type"::Payment);
                    if VLE.FindFirst() then begin
                        vle.CalcFields(Amount);
                        CODPaidbutnotreceived := CODReceivedamount - VLE.Amount;
                        //Message(format(CODPaidbutnotreceived));

                    end;
                end else begin
                    CODPaidamount := "COD Amount ";
                    CLE.Reset();
                    CLE.SetRange("External Document No.", "Tracking No");
                    CLE.SetRange("Document Type", VLE."Document Type"::Payment);
                    if CLE.FindFirst() then begin
                        CLE.CalcFields(Amount);
                        CODReceivedbutnotpaid := CODPaidamount - CLE.Amount;
                    end;
                end;*/ //18April2023


                CLE1.Reset();
                CLE1.SetRange("External Document No.", "Tracking No");
                IF CLE1.FindFirst() THEN begin
                    if CLE1."Document Type" = CLE1."Document Type"::" " then
                        CLE1.CalcFields(Amount);
                    CODReceivedamount := CLE1.Amount;
                end;

                VLE1.Reset();
                VLE1.SetRange("External Document No.", "Tracking No");
                if VLE1.FindFirst() then begin
                    if VLE1."Document Type" = VLE1."Document Type"::" " then
                        VLE1.CalcFields(Amount);
                    CODPaidamount := VLE1.Amount;
                end;

                CLE.Reset();
                CLE.SetRange("External Document No.", "Tracking No");
                CLE.SetRange("Document Type", VLE."Document Type"::Payment);
                if CLE.FindFirst() then begin
                    CLE.CalcFields(Amount);
                    CODReceivedbutnotpaid := CLE.Amount;
                end;

                VLE.Reset();
                VLE.SetRange("External Document No.", "Tracking No");
                VLE.SetRange("Document Type", VLE."Document Type"::Payment);
                if VLE.FindFirst() then begin
                    VLE.CalcFields(Amount);
                    CODPaidbutnotreceived := VLE.Amount;
                end;
            end;

            // end;

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
        customer: Record Customer;
        customername: text[100];
        PostedCodPayableReceivable: Record "Posted COD Payeble Receivable";
        CODReceivedamount: Decimal;
        CODPaidamount: Decimal;
        CODPaidbutnotreceived: Decimal;
        CODReceivedbutnotpaid: Decimal;
        VLE: Record "Vendor Ledger Entry";
        CLE: Record "Cust. Ledger Entry";
        VLEAmount: Decimal;
        CLEAmount: Decimal;
        CLE1: record "Cust. Ledger Entry";
        VLE1: Record "Vendor Ledger Entry";

}