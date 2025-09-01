@AbapCatalog.sqlViewName: 'ZCDS_SEPTEMBER'
@AbapCatalog.compiler.compareFilter: true

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zcds view september client details'
@Metadata.ignorePropagatedAnnotations: true
define view zcds_sep_client as select from zclientsept_info
                                    inner join zclientsept_det on zclientsept_info.client_id = zclientsept_det.client_id
{
    @UI.selectionField: [{ position : 10 }]
    key zclientsept_info.client_id as ClientId,
    @UI.lineItem: [{ position : 10 }]
    zclientsept_info.name as Name,
    @UI.lineItem: [{ position : 20 }]
    zclientsept_info.surname as Surname,
    @UI.lineItem: [{ position : 30 }]
    zclientsept_det.bank_account as Account
    
    
}
