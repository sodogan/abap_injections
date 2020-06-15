*/* Constructor injection here
*  Notice that the seam is moved to the interface
*  Allowing us to stub or use Mocking
*  Example of Constructor injection here!
*  Other ways are setter injections too
*  Setter injection allows outside others to inject too
*/*
CLASS zcl_dao_singleton_injectable DEFINITION
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.
    CLASS-METHODS: get_instance  IMPORTING if_dao             TYPE REF TO zif_dao_query
                                 RETURNING VALUE(ro_instance) TYPE REF TO zcl_dao_singleton_injectable.
    METHODS:select_carrier_details   IMPORTING i_carrid TYPE scarr-carrid
                                     RETURNING VALUE(rt_carriers) TYPE zif_dao_query=>tt_carriers RAISING cx_static_check.

  PROTECTED SECTION.
  PRIVATE SECTION.
*Constructor injection goes here!
    METHODS constructor IMPORTING if_dao TYPE REF TO zif_dao_query.
    DATA: mif_dao_query TYPE REF TO zif_dao_query.
    CLASS-DATA: mo_self TYPE REF TO zcl_dao_singleton_injectable.
ENDCLASS.



CLASS zcl_dao_singleton_injectable IMPLEMENTATION.

  METHOD constructor.
    mif_dao_query = if_dao.
  ENDMETHOD.

  METHOD select_carrier_details.
* Seam  here !
*    SELECT * FROM scarr
*     INTO TABLE @rt_carriers
*     WHERE carrid = @i_carrid
*     .
    rt_carriers = mif_dao_query->select_carrier_details( i_carrid = i_carrid ).
  ENDMETHOD.
  METHOD get_instance.
    ro_instance = COND #(  WHEN mo_self IS BOUND THEN   mo_self
                                ELSE NEW zcl_dao_singleton_injectable( if_dao )
    ).
  ENDMETHOD.

ENDCLASS.
