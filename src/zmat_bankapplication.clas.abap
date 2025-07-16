CLASS zmat_bankapplication DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun.
  CLASS-METHODS: DEPOSIT EXPORTING
      lv_deposited_money TYPE INT4
      lv_deposit_client_id TYPE char05
      lv_deposit_account_number TYPE INT4
      lv_deposit_updated_balance TYPE INT4 .

  CLASS-DATA: lt_accounts TYPE TABLE OF ZMAT_CLIENT , lt_accounts2 TYPE TABLE OF ZMAT_ACCOUNT .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmat_bankapplication IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATA : deposit_money_in type int4 , deposit_client_id type char05 , deposit_account type int4 , deposit_balance type int4 .

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

   DELETE FROM ZMAT_CLIENT.
   DELETE FROM ZMAT_ACCOUNT.

   INSERT ZMAT_CLIENT FROM TABLE @lt_accounts.
   INSERT ZMAT_ACCOUNT FROM TABLE @lt_accounts2.


   zmat_bankapplication=>deposit( IMPORTING
      lv_deposited_money = deposit_money_in
      lv_deposit_client_id      = deposit_client_id
      lv_deposit_account_number = deposit_account
      lv_deposit_updated_balance = deposit_balance
    ).
   UPDATE ZMAT_ACCOUNT SET account_balance = @deposit_balance
   WHERE CLIENT_ID = @deposit_client_id.
   out->write( deposit_client_id ).

  ENDMETHOD.

  METHOD deposit.



  lv_deposited_money ='122'.
  lv_deposit_client_id = '1002'.
  lv_deposit_account_number = '10101010'.
  "lv_deposit_updated_balance = '1774'.


  READ TABLE lt_accounts2 INTO DATA(ls_deposit_money) WITH KEY CLIENT_ID = lv_deposit_client_id.
    lv_deposit_updated_balance = ls_deposit_money-account_balance + lv_deposited_money.

  "UPDATE ZMAT_ACCOUNT SET account_balance = @lv_deposit_updated_balance
  "WHERE client_id = @lv_deposit_client_id AND account_number = @lv_account_number.

  ENDMETHOD.

ENDCLASS.
