pageextension 50105 PostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("E-InvoiceIRN No."; Rec."E-InvoiceIRN No.")
            {
                ApplicationArea = ALL;
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