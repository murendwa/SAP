

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zcds view september client details'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo : {typeName: 'Client' , typeNamePlural: 'Clients' , typeImageUrl: 'https://cdn.britannica.com/27/4227-050-00DBD10A/Flag-South-Africa.jpg'}
define root view entity zcds_sep_client as select from zclientsept_info
                                    inner join zclientsept_det on zclientsept_info.client_id = zclientsept_det.client_id
{

    
    @UI.facet: [{ targetQualifier: 'Main' , type: #FIELDGROUP_REFERENCE, position: 10 , label: 'Client Info'}]
    
    @UI.selectionField: [{ position : 10 }]
    @UI.lineItem: [{ position : 60 }]
    
    key zclientsept_info.client_id as ClientId,
    @UI.lineItem: [{ position : 10 },
    { type : #FOR_ACTION, position : 10, label : 'Make Booking', dataAction : 'Update_Bank'}]
    @UI.fieldGroup: [{ qualifier: 'Main' ,position: 10 , label: 'Name'}]
    zclientsept_info.name as Name,
    
    @UI.lineItem: [{ position : 50 } ]
    @UI.fieldGroup: [{ qualifier: 'Main' ,position: 10 , label: 'Booking Status'}]
    zclientsept_det.booking_status as Booking_Status,
    
    @UI.lineItem: [{ position : 20 , type : #WITH_URL , url : 'custoUrl'  }]
   // @UI.lineItem.iconUrl: 'iconurl'
   
    @UI.fieldGroup: [{ qualifier: 'Main' ,position: 20 , label: 'Surname'}]
    zclientsept_info.surname as Surname,
    @UI.fieldGroup: [{ qualifier: 'Details' ,position: 20 , label: 'Account Number'}]
    @UI.lineItem: [{ position : 30 }]
    zclientsept_det.bank_account as Account,
    
    @UI.facet: [{ targetQualifier: 'Details' , type: #FIELDGROUP_REFERENCE, position: 20 , label: 'Account Info' }]
    @UI.fieldGroup: [{ qualifier: 'Details' ,position: 10 , label: 'Bank Name'}]
    @UI.lineItem: [{ position : 40 }]
    zclientsept_det.bank_name as Bank_Name,
    
    
    
   
    
    @UI.lineItem: [{ position : 60 }]
    
    zclientsept_det.type as Type,
    
    zclientsept_info.gender as Gender,
    
    // 'https://www.sap.com' as custoUrl,
    // 'https://www.google.com/search?&q=cat' as custoUrl
     concat(concat('https://www.google.com/search?q=', zclientsept_info.name), zclientsept_info.surname) as custoUrl
     // New field to conditionally generate the URL
    //case zclientsept_info.surname
        //when 'Doe' then 'https://www.sap.com'
       // when 'Black' then 'https://www.pexels.com'
       // when 'Lacey' then 'https://chatgpt.com/'
       // else 'https://www.google.com' // or null
    //end as custoUrl
    
    
}
