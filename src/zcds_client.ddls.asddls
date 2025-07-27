@AbapCatalog.sqlViewName: 'ZCDSVIEW_CLIENT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'client view'
@Metadata.ignorePropagatedAnnotations: true
define view zCds_client as select from zmat_client
{
    key client_id as ClientId,
    name as Name,
    surname as Surname
}
