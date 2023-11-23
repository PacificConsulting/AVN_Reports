tableextension 50101 SalesInvHeader extends "Sales Invoice Header"
{
    fields
    {

        field(50001; "E-InvoiceIRN No."; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("E-Invoice Detail"."E-Invoice IRN No." where("Document No." = field("No.")));

        }
        // Add changes to table fields here
    }

    var
        EInvoiceDetail: Record "E-Invoice Detail";

}