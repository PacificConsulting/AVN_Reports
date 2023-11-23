pageextension 50101 Purchase_order_Ext extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Print)
        {
            action("Purchase Order")
            {
                Caption = 'Purchase Order';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                ApplicationArea = all;
                trigger OnAction()
                var
                    PH: Record "Purchase Header";
                begin
                    PH.Reset();
                    PH.SetRange("No.", rec."No.");
                    if PH.FindFirst() then
                        Report.RunModal(50002, true, false, PH);

                end;
            }
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}