CLASS ztask3_exercise DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

  TYPES:BEGIN OF ZTABLE,
        NAME TYPE ZCLIENTDETAILS-name,
        ACCOUNT_NUMBER TYPE ZACCOUNTDETAILS-account_number,
        END OF ZTABLE.

  data: lt_out type table of ztable.
  types: tt_ztable type table of ztable.

  interfaces if_oo_adt_classrun.
  CLASS-METHODS: left_join EXPORTING out type tt_ztable.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ztask3_exercise IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

  DATA: LT_ACCOUNTS TYPE TABLE OF ZCLIENTDETAILS , LT_ACCOUNTS2 TYPE TABLE OF ZACCOUNTDETAILS.

  LT_ACCOUNTS = VALUE #(

( client = '100' name = 'John' surname = 'Doe' client_id = '1001' )
( client = '100' name = 'Tim' surname = 'Black' client_id = '1002' )
( client = '100' name = 'Peter' surname = 'Lacey' client_id = '1003' )

).

 LT_ACCOUNTS2 = VALUE #(

( client = '100' account_number = '10101010' client_id = '1001' )
( client = '100' account_number = '20202020' client_id = '1002' )
( client = '100' account_number = '30303030' client_id = '1004' )

).

 DELETE FROM ZCLIENTDETAILS.
 out->write( |Deleted { sy-dbcnt } records from ZCLIENTDETAILS.| ).

 DELETE FROM ZACCOUNTDETAILS.
 out->write( |Deleted { sy-dbcnt } records from ZACCOUNTDETAILS.| ).

 INSERT ZCLIENTDETAILS FROM TABLE @LT_ACCOUNTS.
 out->write( |Inserted { sy-dbcnt } records into ZCLIENTDETAILS.| ).

 INSERT ZACCOUNTDETAILS FROM TABLE @LT_ACCOUNTS2.
 out->write( |Inserted { sy-dbcnt } records into ZACCOUNTDETAILS.| ).

 ZTASK3_EXERCISE=>left_join( IMPORTING OUT = LT_OUT ).

 out->write( lt_out ).


  ENDMETHOD.

  METHOD left_join.

  SELECT name , account_number
  FROM ZCLIENTDETAILS
  LEFT JOIN ZACCOUNTDETAILS
  ON ZCLIENTDETAILS~client_id = ZACCOUNTDETAILS~client_id
  INTO TABLE @DATA(Output_table).

  out = Output_table.


  ENDMETHOD.

ENDCLASS.
