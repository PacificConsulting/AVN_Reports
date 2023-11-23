pageextension 50103 Posted_Sales_Credit_Ext extends "Posted Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here


    }

    actions
    {
        addafter(Print)
        {
            action("Sales Credit memo-New")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;
                trigger OnAction()
                var
                    SCMH: record "Sales Cr.Memo Header";

                begin
                    SCMH.Reset();
                    SCMH.SetRange("No.", Rec."No.");
                    if SCMH.FindFirst() then
                        Report.RunModal(50004, true, false, SCMH);
                end;
            }
        }
        //modify()
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}