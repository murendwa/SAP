CLASS lhc_zcds_sep_client DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zcds_sep_client RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zcds_sep_client RESULT result.

    METHODS Update_Bank FOR MODIFY
      IMPORTING keys FOR ACTION zcds_sep_client~Update_Bank RESULT result.

ENDCLASS.

CLASS lhc_zcds_sep_client IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD update_bank.

  MODIFY ENTITY zcds_sep_client
  UPDATE FIELDS ( Booking_Status )
  WITH VALUE #( FOR KEY IN keys ( %TKY = KEY-%tky Booking_Status = 'B' ) ).

  READ ENTITY zcds_sep_client
  ALL FIELDS
  WITH CORRESPONDING #( keys )
  RESULT DATA(Bookings).

 result = VALUE #( for zcds_sep_client in Bookings ( %TKY = zcds_sep_client-%tky %param = zcds_sep_client ) ).

ENDMETHOD.

ENDCLASS.
