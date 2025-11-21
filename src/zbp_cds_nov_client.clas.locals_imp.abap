CLASS lhc_zcds_Nov_client DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS Update_Bank FOR MODIFY
      IMPORTING keys FOR ACTION zcds_Nov_client~Update_Bank RESULT result.

ENDCLASS.

CLASS lhc_zcds_Nov_client IMPLEMENTATION.



  METHOD Update_Bank.

  MODIFY ENTITY zcds_Nov_client
  UPDATE FIELDS ( type )
  WITH VALUE #( FOR KEY IN keys ( %TKY = KEY-%tky type = 'B' ) ).

  READ ENTITY zcds_Nov_client
  ALL FIELDS
  WITH CORRESPONDING #( keys )
  RESULT DATA(Bookings).

 result = VALUE #( for zcds_Nov_client in Bookings ( %TKY = zcds_Nov_client-%tky %param = zcds_Nov_client ) ).



  ENDMETHOD.

ENDCLASS.
