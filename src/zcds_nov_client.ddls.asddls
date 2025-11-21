@AbapCatalog.sqlViewName: 'ZCDS_NOV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Nov Data Def'
@Metadata.ignorePropagatedAnnotations: true
define root view zcds_Nov_client as select from zclientsept_det
{
    @UI.facet: [{ targetQualifier: 'Main' , type: #FIELDGROUP_REFERENCE, position: 10 , label: 'Client Id'}]
    @UI.selectionField: [{ position : 10 }]
    @UI.lineItem: [{ position : 60 }]
    key client_id ,
    
    @UI.lineItem: [{ position : 20 },
    { type : #FOR_ACTION, position : 10, label : 'Make Booking', dataAction : 'Update_Bank'}]
    @UI.fieldGroup: [{ qualifier: 'Main' ,position: 10 , label: 'Booking Status'}]
    key booking_status ,
    
    
    @UI.lineItem: [{ position : 30 } ]
    @UI.fieldGroup: [{ qualifier: 'Main' ,position: 10 , label: 'Bank_Name'}]
    bank_name ,
    
    @UI.lineItem: [{ position : 40 } ]
    @UI.fieldGroup: [{ qualifier: 'Main' ,position: 10 , label: 'Account'}]
    bank_account ,
    
    @UI.lineItem: [{ position : 50 } ]
    @UI.fieldGroup: [{ qualifier: 'Main' ,position: 10 , label: 'Account Type'}]
    type 
}
