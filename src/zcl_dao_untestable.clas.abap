*/*
* Untestable code-Static and final
* Static methods can not be inherited or redefined!
* No backdoor-injection is possible!
*/
CLASS zcl_dao_untestable DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.
    TYPES: tt_carriers TYPE SORTED TABLE OF scarr WITH UNIQUE KEY carrid .
    CLASS-METHODS:select_carrier_details   IMPORTING i_carrid TYPE scarr-carrid
                                     RETURNING VALUE(rt_carriers) TYPE tt_carriers RAISING cx_static_check.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_dao_untestable IMPLEMENTATION.

  METHOD select_carrier_details.
* Seam  here !
    SELECT * FROM scarr
     INTO TABLE @rt_carriers
     WHERE carrid = @i_carrid
     .

    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE lcx_no_data_found.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
