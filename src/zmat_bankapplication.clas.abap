CLASS zmat_bankapplication DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun.
  CLASS-METHODS: DEPOSIT EXPORTING
      gv_deposited_money TYPE INT4
      gv_deposit_client_id TYPE char05
      gv_deposit_updated_balance TYPE INT4 .

  CLASS-METHODS: WITHDRAW EXPORTING
    gv_withdraw_money TYPE INT4
    gv_withdraw_client_id TYPE char05
    gv_withdraw_updated_balance TYPE INT4 .

  CLASS-DATA: gt_accounts TYPE TABLE OF ZMAT_CLIENT , gt_accounts2 TYPE TABLE OF ZMAT_ACCOUNT
  , gt_accounts3 TYPE TABLE OF ZCLIENTSEPT_INFO , gt_accounts4 TYPE TABLE OF ZCLIENTSEPT_DET .

    Class-METHODS:Inner_Join EXPORTING out type ANY TABLE.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZMAT_BANKAPPLICATION IMPLEMENTATION.


  METHOD deposit.

  gv_deposited_money = '300'.
  gv_deposit_client_id = '1002'.

  READ TABLE gt_accounts2 INTO DATA(ls_deposit_money) WITH KEY CLIENT_ID = gv_deposit_client_id.
    gv_deposit_updated_balance = ls_deposit_money-account_balance + gv_deposited_money.


  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

  DATA : deposit_money_in type int4 , deposit_client_id type char05 , deposit_account type int4 , deposit_balance type int4 ,
  withdraw_money_out type int4 , withdraw_client_id type char05 , withdraw_account type int4 , withdraw_balance type int4 .

    gt_accounts = VALUE #(

  ( client = '100' name = 'John' surname = 'Doe' client_id = '1001' )
  ( client = '100' name = 'Tim' surname = 'Black' client_id = '1002' )
  ( client = '100' name = 'Peter' surname = 'Lacey' client_id = '1003' )

  ).

    gt_accounts2 = VALUE #(

   ( client = '100' account_number = '10101010' client_id = '1001' account_balance = '100' )
   ( client = '100' account_number = '20202020' client_id = '1002' account_balance = '150'  )
   ( client = '100' account_number = '30303030' client_id = '1004' account_balance = '200' )

   ).

   gt_accounts3 = VALUE #(

  ( client = '100' name = 'John' surname = 'Doe' client_id = '1001' )
  ( client = '100' name = 'Tim' surname = 'Black' client_id = '1002' )
  ( client = '100' name = 'Peter' surname = 'Lacey' client_id = '1003' )

  ).

  gt_accounts4 = VALUE #(

   ( client = '100' bank_name = 'Capitec' bank_account = '100' client_id = '1001' )
   ( client = '100' bank_name = 'ABSA' bank_account = '150' client_id = '1002' )
   ( client = '100' bank_name = 'FNB' bank_account = '200' client_id = '1003' )

   ).



   DELETE FROM ZMAT_CLIENT.
   DELETE FROM ZMAT_ACCOUNT.

   DELETE FROM ZCLIENTSEPT_INFO.
   DELETE FROM ZCLIENTSEPT_DET.

   INSERT ZMAT_CLIENT FROM TABLE @gt_accounts.
   INSERT ZMAT_ACCOUNT FROM TABLE @gt_accounts2.

   INSERT ZCLIENTSEPT_INFO FROM TABLE @gt_accounts3.
   INSERT ZCLIENTSEPT_DET FROM TABLE @gt_accounts4.


   zmat_bankapplication=>deposit( IMPORTING
      gv_deposited_money = deposit_money_in
      gv_deposit_client_id      = deposit_client_id
      gv_deposit_updated_balance = deposit_balance
    ).
   UPDATE ZMAT_ACCOUNT SET account_balance = @deposit_balance
   WHERE CLIENT_ID = @deposit_client_id.
   out->write( deposit_client_id ).

   zmat_bankapplication=>withdraw( IMPORTING
   gv_withdraw_money = withdraw_money_out
   gv_withdraw_client_id = withdraw_client_id
   gv_withdraw_updated_balance = withdraw_balance
    ).
   UPDATE ZMAT_ACCOUNT SET account_balance = @withdraw_balance
   WHERE CLIENT_ID = @withdraw_client_id.
   out->write( withdraw_client_id ).


  ENDMETHOD.


  METHOD withdraw.

  gv_withdraw_money = '20'.
  gv_withdraw_client_id = '1004'.

  READ TABLE gt_accounts2 INTO DATA(ls_withdraw_money) WITH KEY CLIENT_ID = gv_withdraw_client_id.
  gv_withdraw_updated_balance = ls_withdraw_money-account_balance - gv_withdraw_money.

  ENDMETHOD.


  METHOD INNER_JOIN.

  SELECT name,bank_account
  FROM ZCLIENTSEPT_INFO
  LEFT JOIN ZCLIENTSEPT_DET
  ON ZCLIENTSEPT_INFO~client_id = ZCLIENTSEPT_DET~client_id
  INTO TABLE @DATA(Output_table).
  out = Output_table.

  ENDMETHOD.

ENDCLASS.
