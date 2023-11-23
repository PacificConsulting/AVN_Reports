pageextension 50102 Posted_Sales_Invoice extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Print)
        {
            action("Tax Invoice")
            {
                Caption = 'Tax Invoice';
                Promoted = true;
                PromotedCategory = Report;
                //PromotedIsBig = true;
                Image = Print;
                ApplicationArea = all;
                trigger OnAction()
                var
                    SIH: Record "Sales Invoice Header";
                begin
                    SIH.Reset();
                    SIH.SetRange("No.", Rec."No.");
                    if SIH.FindFirst() then
                        Report.RunModal(50003, true, false, SIH);
                end;
            }
        }

        // Add changes to page actions here
    }

    var
        myInt: Integer;
}