CLASS zcl_fill_accounts_mat DEFINITION

PUBLIC

FINAL

CREATE PUBLIC .

PUBLIC SECTION.

    TYPES:BEGIN OF ztable,
        name type ZBANKDETAILS-NAME, " <--- Change made here
        city type ZACCOUNTS_000-CITY, " <--- Change made here
    end of ZTABLE.

data: lt_out type table of ztable.
types: tt_ztable type table of ztable.


interfaces if_oo_adt_classrun.

CLASS-METHODS:Left_join exporting out type tt_ztable .



PROTECTED SECTION.

PRIVATE SECTION.

ENDCLASS.





CLASS zcl_fill_accounts_mat IMPLEMENTATION.




METHOD if_oo_adt_classrun~main.



DATA: lt_accounts type table of ZACCOUNTS_000.

DATA: lt_accounts2 TYPE TABLE OF ZBANKDETAILS.





" Read current timestamp for last changed date

GET TIME STAMP FIELD DATA(zv_tsl).



" Fill internal table for ZBANKDETAILS

lt_accounts2 = VALUE #(

( client = '100' account_number = '00000001' bank_customer_id = '100001' currency = 'EUR' account_category = '01' lastchangedat = zv_tsl name = 'Murendwa' surname = 'Mat')

( client = '100' account_number = '00000002' bank_customer_id = '200002' currency = 'EUR' account_category = '02' lastchangedat = zv_tsl name = 'peter' surname = 'doe')

( client = '100' account_number = '00000003' bank_customer_id = '200003' currency = 'EUR' account_category = '02' lastchangedat = zv_tsl name = 'john' surname = 'one')

).





" Fill internal table for ZACCOUNTS_000

lt_accounts = VALUE #(



( client = '100' account_number = '00000001' bank_customer_id = '100001' city = 'Gaertringen' balance = '200.00 ' currency = 'EUR' account_category = '01' lastchangedat = zv_tsl )

( client = '100' account_number = '00000002' bank_customer_id = '200002' city = 'Schwetzingen' balance = '500.00 ' currency = 'EUR' account_category = '02' lastchangedat = zv_tsl )

( client = '100' account_number = '00000003' bank_customer_id = '200003' city = 'Nuernberg' balance = '150.00 ' currency = 'EUR' account_category = '02' lastchangedat = zv_tsl )

).







" Delete existing entries from both tables to ensure a clean insert

DELETE FROM ZACCOUNTS_000.

out->write( |Deleted { sy-dbcnt } records from ZACCOUNTS_000.| ).



DELETE FROM ZBANKDETAILS.

out->write( |Deleted { sy-dbcnt } records from ZBANKDETAILS.| ).



" Insert new entries into ZACCOUNTS_000

INSERT ZACCOUNTS_000 from table @lt_accounts.

out->write( |Inserted { sy-dbcnt } records into ZACCOUNTS_000.| ).



" Insert new entries into ZBANKDETAILS

INSERT ZBANKDETAILS from table @lt_accounts2.

out->write( |Inserted { sy-dbcnt } records into ZBANKDETAILS.| ).



" Final confirmation message

out->write( 'DONE!' ).



zcl_fill_accounts_mat=>left_join( IMPORTING out = lt_out ).


out->write( lt_out ).




ENDMETHOD.



METHOD left_join.


SELECT city,name

FROM ZACCOUNTS_000

LEFT JOIN ZBANKDETAILS

ON ZACCOUNTS_000~bank_customer_id = ZBANKDETAILS~bank_customer_id

INTO TABLE @DATA(Output_table).

out = Output_table.


ENDMETHOD.



ENDCLASS.
