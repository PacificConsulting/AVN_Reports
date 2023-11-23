pageextension 50104 OrderProccessorExt extends "Order Processor Role Center"
{
    layout
    {
        // Add changes to page layout here
        addafter(Emails)
        {
            part(Finance; Finance)
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