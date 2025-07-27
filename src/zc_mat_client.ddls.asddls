@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.sapObjectNodeType.name: 'ZMAT_CLIENT'
define root view entity ZC_MAT_CLIENT
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_MAT_CLIENT
{
  key ClientId,
  Name,
  Surname,
  LocalLastChanged,
  LastChanged,
  Createdby,
  Changedby
  
}
