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

  CLASS-METHODS: left_join EXPORTING out type tt_ztable , right_join EXPORTING right_out type tt_ztable , INNER_join EXPORTING INNER_out type tt_ztable.


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

 "ZTASK3_EXERCISE=>left_join( IMPORTING OUT = LT_OUT ). "Prints out left join table

 "ZTASK3_EXERCISE=>right_join( IMPORTING RIGHT_OUT = LT_OUT ).

 ZTASK3_EXERCISE=>inner_join( IMPORTING INNER_OUT = LT_OUT ).

 out->write( lt_out ).

 " Withdraw method.

    DATA(lv_target_customer_id) = '1004'.

    READ TABLE lt_accounts2 INTO DATA(ls_account_entry) WITH KEY client_id = lv_target_customer_id.

          out->write( |Account number for customer { lv_target_customer_id }: { ls_account_entry-account_number }| ).

  ENDMETHOD.

  METHOD left_join.

  SELECT name , account_number
  FROM ZCLIENTDETAILS
  LEFT JOIN ZACCOUNTDETAILS
  ON ZCLIENTDETAILS~client_id = ZACCOUNTDETAILS~client_id
  INTO TABLE @DATA(Output_table).

  out = Output_table.
  "Doesn't show values for Peter because the client ids don't match but still shows the name because name is in left table

  ENDMETHOD.

  METHOD right_join.

  SELECT name , account_number
  FROM ZCLIENTDETAILS
  RIGHT JOIN ZACCOUNTDETAILS
  ON ZCLIENTDETAILS~client_id = ZACCOUNTDETAILS~client_id
  INTO TABLE @DATA(Output_table).

  right_out = Output_table.
  "Doesn't show values for Peter because the client ids don't match but still shows the account_number because account_number is in right table

  ENDMETHOD.

  METHOD INNER_join.

  SELECT name , account_number
  FROM ZCLIENTDETAILS
  INNER JOIN ZACCOUNTDETAILS
  ON ZCLIENTDETAILS~client_id = ZACCOUNTDETAILS~client_id
  INTO TABLE @DATA(Output_table).

  Inner_out = Output_table.
  "Doesn't show values from both tables that don't match, only shows values that match.

  ENDMETHOD.



ENDCLASS.
