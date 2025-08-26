CLASS zleftjoin DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

  TYPES:BEGIN OF ztable,
        name type zleftmaintable,
        account_id type zrightmaintable,
        end of ZTABLE.
    TYPES: tt_ztable type TABLE of ztable.

  INTERFACES if_oo_adt_classrun.
  Class-METHODS:Left_Join EXPORTING out type ANY TABLE.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZLEFTJOIN IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA: lt_accounts type table of ZLEFTMAINTABLE ,
        lt_accounts2 type table of ZRIGHTMAINTABLE.

  GET TIME STAMP FIELD DATA(zv_tsl).


lt_accounts = VALUE #(
        ( client = '100' name = 'murendwa' surname = 'matumba' account_id = '15' )



).
lt_accounts2 = VALUE #(
        ( client = '100' bank_name = 'absa' account_number = '11221' account_id = '16' )

 ).

DELETE FROM ZLEFTMAINTABLE.
DELETE FROM ZRIGHTMAINTABLE.


INSERT ZLEFTMAINTABLE from table @lt_accounts.
INSERT ZRIGHTMAINTABLE from table @lt_accounts2.
"iNSERT ZLEFTMAINTABLE from table @lt_accounts.

"Check result in console
out->write( sy-dbcnt ).
out->write(  'stolen code' ).
out->write( out ).


  ENDMETHOD.


  METHOD left_join.
  SELECT name,account_number
  FROM ZLEFTMAINTABLE
  LEFT JOIN ZRIGHTMAINTABLE
  ON ZLEFTMAINTABLE~account_id = ZRIGHTMAINTABLE~account_id
  INTO TABLE @DATA(Output_table).
  out = Output_table.


  ENDMETHOD.
ENDCLASS.
