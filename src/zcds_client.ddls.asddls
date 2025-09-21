@AbapCatalog.sqlViewName: 'ZCDSVIEW_CLIENT'
@AbapCatalog.compiler.compareFilter: true

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'client view'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo.typeNamePlural: 'Header Title'
define view zCds_client as select from zmat_client
{
    key client_id as ClientId,
    @UI.selectionField: [{ position : 10 }]
    @EndUserText.label: 'First Name'
    @UI.lineItem: [{ position : 10 }]
    name as Name,
    @UI.lineItem: [{ position : 30 }]
    surname as Surname
}
