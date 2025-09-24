let
    Source = Folder.Files("C:\Users\ADMIN\Downloads 2\Data"),
    #"Removed Other Columns" = Table.SelectColumns(Source,{"Content", "Name"}),
    #"Added Custom" = Table.AddColumn(#"Removed Other Columns", "Custom", each Csv.Document([Content])),
    #"Removed Other Columns1" = Table.SelectColumns(#"Added Custom",{"Custom"}),
    #"Added Custom1" = Table.AddColumn(#"Removed Other Columns1", "Custom.1", each Table.FirstN([Custom],7) & Table.LastN([Custom], 1)),
    #"Removed Other Columns2" = Table.SelectColumns(#"Added Custom1",{"Custom.1"}),
    #"Added Custom2" = Table.AddColumn(#"Removed Other Columns2", "Custom", each Table.RemoveColumns([Custom.1],{"Column2"})),
    #"Removed Columns" = Table.RemoveColumns(#"Added Custom2",{"Custom.1"}),
    #"Added Custom3" = Table.AddColumn(#"Removed Columns", "Custom.1", each Table.Transpose([Custom])),
    #"Removed Columns1" = Table.RemoveColumns(#"Added Custom3",{"Custom"}),
    #"Added Custom4" = Table.AddColumn(#"Removed Columns1", "Custom", each Table.PromoteHeaders([Custom.1], [PromoteAllScalars=true])),
    #"Removed Columns2" = Table.RemoveColumns(#"Added Custom4",{"Custom.1"}),
    #"Added Custom5" = Table.AddColumn(#"Removed Columns2", "Custom.1", each Table.RenameColumns([Custom],{{"", "Final"}})),
    #"Removed Columns3" = Table.RemoveColumns(#"Added Custom5",{"Custom"}),
    #"Added Custom6" = Table.AddColumn(#"Removed Columns3", "Custom", each Table.RemoveLastN([Custom.1],1)),
    #"Removed Columns4" = Table.RemoveColumns(#"Added Custom6",{"Custom.1"}),
    #"Expanded Custom" = Table.ExpandTableColumn(#"Removed Columns4", "Custom", {"Seller Name", "Source Region", "Source Entity", "Destination Region", "Buyer Entity", "Document URL", "Approval Code", "Final"}, {"Seller Name", "Source Region", "Source Entity", "Destination Region", "Buyer Entity", "Document URL", "Approval Code", "Final"})
in
    #"Expanded Custom"