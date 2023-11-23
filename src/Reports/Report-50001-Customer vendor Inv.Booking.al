report 50001 "Customer Vendor Inv. Booking"
{
    //PCPL-064
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Reports Layout\Customer Vendor Invoice Booking -3.rdl';
    EnableHyperlinks = true;


    dataset
    {
        dataitem("Customer/Vendor Inv. Booking"; "Posted Cust\vend Inv Booking")
        {
            DataItemTableView = sorting();
            RequestFilterFields = "Tracking No", "Posting Date";
            column(AVN_Document_No_; "AVN Document No.")
            {
            }
            column(Tracking_No; "Tracking No")
            {

            }
            column(Shipment_Status; "Shipment Status")
            {

            }
            column(Business_Vertical__G2_; "Business Vertical (G2)")
            {

            }
            column(Amount_Before_GST; "Amount Before GST")
            {

            }
            column(customername; customername)
            {

            }
            column(courierPartenername; courierPartenername)
            {

            }
            column(TotalbilledamountbeforeGST; TotalbilledamountbeforeGST)
            {

            }
            column(TotalPurchasewitoutGST; TotalPurchasewitoutGST)
            {

            }
            column(Profitloss; Profitloss)
            {

            }
            column(Customeramout; Customeramout)
            {

            }
            column(VendorAmount; VendorAmount)
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                // Clear(TotalbilledamountbeforeGST);
                // Clear(TotalPurchasewitoutGST);
                // Clear(Customeramout);
                // Clear(VendorAmount);
                // clear(Profitloss);
                if customer.GET("Customer Code") then
                    customername := customer.Name;// + ' ' + customer."Name 2";

                if Recvendor.Get("Vendor Code") then
                    courierPartenername := Recvendor.Name;
                //<< 13April2023
                PostedCustvendBooking.Reset();
                PostedCustvendBooking.SetRange("Customer Code", "Customer Code");
                //PostedCustvendBooking.SetRange("Vendor Code", "Vendor Code");
                if PostedCustvendBooking.FindFirst() then begin
                    if PostedCustvendBooking."Customer Code" <> '' then
                        TotalbilledamountbeforeGST := PostedCustvendBooking."Amount Before GST";
                end;
                PostedCustvendBooking1.Reset();
                PostedCustvendBooking1.SetRange("Vendor Code", "Vendor Code");
                if PostedCustvendBooking1.FindFirst() then begin
                    if PostedCustvendBooking1."Vendor Code" <> '' then
                        TotalPurchasewitoutGST := PostedCustvendBooking."Amount Before GST";

                    // Message(FORMAT(TotalPurchasewitoutGST));
                    // Message(format(Profitloss))
                    Profitloss := TotalbilledamountbeforeGST - TotalPurchasewitoutGST;

                end;

            end;

            //end;

            // Message(format(TotalbilledamountbeforeGST));
            //Message(Format(TotalPurchasewitoutGST));
            //<< 13April2023
            //end;





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
        customername: Text[100];

        PostedCustvendBooking: Record "Posted Cust\vend Inv Booking";
        TotalbilledamountbeforeGST: Decimal;
        TotalPurchasewitoutGST: Decimal;
        Profitloss: decimal;
        PostedCustvendBooking1: Record "Posted Cust\vend Inv Booking";
        courierPartenername: text[100];
        Recvendor: record vendor;
        Reccustomerbooking: Record "Posted Cust\vend Inv Booking";
        Recvendorbooking: record "Posted Cust\vend Inv Booking";
        Customeramout: Decimal;
        VendorAmount: Decimal;


}