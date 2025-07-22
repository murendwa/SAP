CLASS zcar_instance DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun.

  METHODS:
      set_color
        IMPORTING
          iv_new_color TYPE string,
      accelerate
        IMPORTING
          iv_speed_increase TYPE int4,
      get_info
        RETURNING
          VALUE(rv_car_info) TYPE string.

  DATA: mv_color TYPE string, mv_speed TYPE int4.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcar_instance IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  DATA : lo_blue_car TYPE REF TO zcar_instance , lo_red_car TYPE REF TO zcar_instance.

  CREATE OBJECT lo_blue_car.
  CREATE OBJECT lo_red_car.

  lo_blue_car->set_color( iv_new_color = 'Blue' ).
  lo_blue_car->accelerate( iv_speed_increase = 50 ).
  out->write( lo_blue_car->get_info( ) ).

  lo_red_car->set_color( iv_new_color = 'Red' ).
  lo_red_car->accelerate( iv_speed_increase = 20 ).
  out->write( lo_red_car->get_info( ) ).


  ENDMETHOD.

  METHOD accelerate.

me->mv_speed = me->mv_speed + iv_speed_increase.
  ENDMETHOD.

  METHOD get_info.

rv_car_info = |This is a { me->mv_color } car, currently at { me->mv_speed } km/h.|.

  ENDMETHOD.

  METHOD set_color.

me->mv_color = iv_new_color.

  ENDMETHOD.

ENDCLASS.
