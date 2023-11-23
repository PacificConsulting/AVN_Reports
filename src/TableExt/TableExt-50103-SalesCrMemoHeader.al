tableextension 50104 SalesCrMemoExt extends "Sales Cr.Memo Header"
{
    fields
    {

        field(50001; "E-Invoice_IRN_No."; Code[100])
        {

            FieldClass = FlowField;
            CalcFormula = lookup("E-Invoice Detail"."E-Invoice IRN No." where("Document No." = field("No.")));

        }
        // Add changes to table fields here
    }

    var
    // RecEInvoiceDetail: Record "E-Invoice Detail";


}