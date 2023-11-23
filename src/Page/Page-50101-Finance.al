page 50101 "Finance"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            cuegroup("Pending E-Invoice")
            {
                field("Posted Sales Invoice"; TotalSalesValue)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    Begin
                        PostedSalesInv.Reset();
                        PostedSalesInv.SetFilter("Nature of Supply", 'B2B');
                        PostedSalesInv.SetRange("E-InvoiceIRN No.", '');
                        if PostedSalesInv.FindFirst() then begin
                            repeat
                                PostedSalesInv.Mark(true);
                            until PostedSalesInv.Next() = 0;
                        end;
                        PostedSalesInv.MarkedOnly(true);
                        IF Page.RunModal(143, PostedSalesInv) = Action::None then;
                        //end;


                    end;


                }
            }
            cuegroup("")
            {
                field("Posted Sales Credit Memos"; TotalCreditValue)
                {
                    ApplicationArea = All;
                    // trigger OnDrillDown()
                    // Begin
                    //     PostedSalesCrMemoHeader.Reset();
                    //     PostedSalesCrMemoHeader.SetFilter("Nature of Supply", 'B2B');


                    //     if PostedSalesCrMemoHeader.FindSet() then begin


                    //         EInvoiceDetail1.Reset();
                    //         EInvoiceDetail1.SetRange("E-Invoice IRN No.", '');
                    //         EInvoiceDetail1.SetRange("Document No.", PostedSalesCrMemoHeader."No.");
                    //         if EInvoiceDetail1.FindFirst() then begin
                    //             repeat
                    //                 PostedSalesCrMemoHeader.Mark(true);
                    //             until PostedSalesCrMemoHeader.Next() = 0;
                    //         end;
                    //         PostedSalesCrMemoHeader.MarkedOnly(true);
                    //         IF Page.RunModal(144, PostedSalesCrMemoHeader) = Action::None then;
                    //         //end;
                    //     end;

                    // end;

                    trigger OnDrillDown()
                    Begin
                        PostedSalesCrMemoHeader.Reset();
                        PostedSalesCrMemoHeader.SetFilter("Nature of Supply", 'B2B');
                        PostedSalesCrMemoHeader.SetRange("E-Invoice_IRN_No.", '');
                        if PostedSalesCrMemoHeader.FindFirst() then begin
                            repeat
                                PostedSalesCrMemoHeader.Mark(true);
                            until PostedSalesCrMemoHeader.Next() = 0;
                        end;
                        PostedSalesCrMemoHeader.MarkedOnly(true);
                        IF Page.RunModal(144, PostedSalesCrMemoHeader) = Action::None then;
                        //end;


                    end;
                }
            }

        }
    }

    trigger OnOpenPage()
    begin

        TotalSalesValue := 0;
        PostedSalesInv.Reset();
        PostedSalesInv.SetFilter("Nature of Supply", 'B2B');
        PostedSalesInv.SetRange("E-InvoiceIRN No.", '');
        repeat
            if PostedSalesInv.FindSet() then
                repeat
                    TotalSalesValue := TotalSalesValue + 1;

                until PostedSalesInv.Next() = 0;

        until PostedSalesInv.Next() = 0;



        TotalCreditValue := 0;
        PostedSalesCrMemoHeader.Reset();
        PostedSalesCrMemoHeader.SetFilter("Nature of Supply", 'B2B');
        PostedSalesCrMemoHeader.SetRange("E-Invoice_IRN_No.", '');
        repeat
            if PostedSalesCrMemoHeader.FindSet() then
                repeat
                    TotalCreditValue := TotalCreditValue + 1;

                until PostedSalesCrMemoHeader.Next() = 0;

        until PostedSalesCrMemoHeader.Next() = 0;

    end;

    var

        myInt: Integer;
        TotalSalesValue: Integer;
        TotalCreditValue: Integer;
        PostedSalesInv: Record "Sales Invoice Header";
        PostedSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        EInvoiceDetail: Record "E-Invoice Detail";
        EInvoiceDetail1: Record "E-Invoice Detail";

}