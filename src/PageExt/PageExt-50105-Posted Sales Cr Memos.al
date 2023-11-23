pageextension 50106 PostedSalesCrMemosExt extends "Posted Sales Credit Memos"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("E-Invoice IRN No."; Rec."E-Invoice_IRN_No.")
            {
                Caption = 'E-Invoice IRN No.';
                ApplicationArea = all;
            }
            field("Nature of Supply"; Rec."Nature of Supply")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}