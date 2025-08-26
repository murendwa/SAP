CLASS ztask3_exercise DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

    TYPES:BEGIN OF ztable,
            name           TYPE zclientdetails-name,
            account_number TYPE zaccountdetails-account_number,
          END OF ztable.

    DATA: lt_out                 TYPE TABLE OF ztable,
          lt_accounts            TYPE TABLE OF zclientdetails,
          lt_accounts2           TYPE TABLE OF zaccountdetails,
          lv_money_in            TYPE char05,
          lv_Deposit_customer_id TYPE char05.


    TYPES: tt_ztable TYPE TABLE OF ztable.

    INTERFACES if_oo_adt_classrun.

    CLASS-METHODS: left_join EXPORTING out TYPE tt_ztable ,
                   right_join EXPORTING right_out TYPE tt_ztable ,
                   INNER_join EXPORTING INNER_out TYPE tt_ztable ,
                   static_method RETURNING VALUE(rv_static_method_output) TYPE int4 .

    METHODS : instance_method RETURNING VALUE(rv_instance_method_output) TYPE int4 .

    DATA: test_object TYPE REF TO ztask3_exercise.


  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZTASK3_EXERCISE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "DATA: LT_ACCOUNTS TYPE TABLE OF ZCLIENTDETAILS , LT_ACCOUNTS2 TYPE TABLE OF ZACCOUNTDETAILS.

    lt_accounts = VALUE #(

  ( client = '100' name = 'John' surname = 'Doe' client_id = '1001' )
  ( client = '100' name = 'Tim' surname = 'Black' client_id = '1002' )
  ( client = '100' name = 'Peter' surname = 'Lacey' client_id = '1003' )

  ).

    lt_accounts2 = VALUE #(

   ( client = '100' account_number = '10101010' client_id = '1001' account_balance = '100' )
   ( client = '100' account_number = '20202020' client_id = '1002' account_balance = '150'  )
   ( client = '100' account_number = '30303030' client_id = '1004' account_balance = '200' )

   ).

"    DELETE FROM zclientdetails.
 "   out->write( |Deleted { sy-dbcnt } records from ZCLIENTDETAILS.| ).

  "  DELETE FROM zaccountdetails.
  "  out->write( |Deleted { sy-dbcnt } records from ZACCOUNTDETAILS.| ).

  "  INSERT zclientdetails FROM TABLE @lt_accounts.
   " out->write( |Inserted { sy-dbcnt } records into ZCLIENTDETAILS.| ).

   " INSERT zaccountdetails FROM TABLE @lt_accounts2.
  "  out->write( |Inserted { sy-dbcnt } records into ZACCOUNTDETAILS.| )."

    "ZTASK3_EXERCISE=>left_join( IMPORTING OUT = LT_OUT ). "Prints out left join table

    "ZTASK3_EXERCISE=>right_join( IMPORTING RIGHT_OUT = LT_OUT ).

    "ZTASK3_EXERCISE=>inner_join( IMPORTING INNER_OUT = LT_OUT ).

     "out->write( lt_out ).



    " view Balance method.

     DATA(lv_target_customer_id) = '1004'.

     READ TABLE lt_accounts2 INTO DATA(ls_account_entry) WITH KEY client_id = lv_target_customer_id.

    out->write( |Account number for customer { lv_target_customer_id }: { ls_account_entry-account_number }| ).



    "Withdrawal Method

    DATA(lv_withdrawal_amount) = '20'.
    READ TABLE lt_accounts2 INTO DATA(ls_withdrawal_account) WITH KEY client_id = lv_target_customer_id.
    out->write( |Amount withdrawn is : { lv_withdrawal_amount } , remaining balance is { ls_withdrawal_account-account_balance - lv_withdrawal_amount }| ).


    "Deposit Method

    DATA(lv_Deposit_amount) = '40'.
    DATA(lv_Deposit_customer_id) = '1002'.

    READ TABLE lt_accounts2 INTO DATA(ls_Deposit_amount) WITH KEY client_id = lv_Deposit_customer_id .
    out->write( |Amount Deposited is : { lv_Deposit_amount } , updated balance is { ls_Deposit_amount-account_balance + lv_Deposit_amount }| ).

    "static method
    out->write( |static method ouput is : { ztask3_exercise=>static_method(  ) }| ).

    "instance method
    " The test_object variable must be instantiated before its methods can be called.
    CREATE OBJECT test_object.

    out->write( |instance method ouput is : { test_object->instance_method( ) }| ).

  ENDMETHOD.


  METHOD INNER_join.

    SELECT name , account_number
    FROM zclientdetails
    INNER JOIN zaccountdetails
    ON zclientdetails~client_id = zaccountdetails~client_id
    INTO TABLE @DATA(Output_table).

    Inner_out = Output_table.
    "Doesn't show values from both tables that don't match, only shows values that match.

  ENDMETHOD.


  METHOD instance_method.

  "Accessed through object

    DATA : lv_input3 TYPE int4, lv_input4 TYPE int4.

    lv_input3 = '4'.
    lv_input4 = '4'.

    rv_instance_method_output = lv_input3 + lv_input4.


  ENDMETHOD.


  METHOD left_join.

    SELECT name , account_number
    FROM zclientdetails
    LEFT JOIN zaccountdetails
    ON zclientdetails~client_id = zaccountdetails~client_id
    INTO TABLE @DATA(Output_table).

    out = Output_table.
    "Doesn't show values for Peter because the client ids don't match but still shows the name because name is in left table

  ENDMETHOD.


  METHOD right_join.

    SELECT name , account_number
    FROM zclientdetails
    RIGHT JOIN zaccountdetails
    ON zclientdetails~client_id = zaccountdetails~client_id
    INTO TABLE @DATA(Output_table).

    right_out = Output_table.
    "Doesn't show values for Peter because the client ids don't match but still shows the account_number because account_number is in right table

  ENDMETHOD.


  METHOD static_method.
    "Example of static method. Accessed using class name.

    DATA : lv_input1 TYPE int4, lv_input2 TYPE int4.

    lv_input1 = '3'.
    lv_input2 = '3'.

    rv_static_method_output = lv_input1 + lv_input2.


  ENDMETHOD.
ENDCLASS.
