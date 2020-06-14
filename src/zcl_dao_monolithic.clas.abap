CLASS zcl_dao_monolithic DEFINITION
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.
    TYPES: tt_carriers TYPE SORTED TABLE OF scarr WITH UNIQUE KEY carrid .
    CLASS-METHODS: class_constructor.
    CLASS-METHODS: get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_dao_monolithic.
    METHODS:select_carrier_details   IMPORTING i_carrid TYPE scarr-carrid
                                     RETURNING VALUE(rt_carriers) TYPE tt_carriers RAISING cx_static_check.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: mo_self TYPE REF TO zcl_dao_monolithic.

ENDCLASS.



CLASS zcl_dao_monolithic IMPLEMENTATION.


  METHOD class_constructor.
    mo_self = NEW #(  ).
  ENDMETHOD.


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
  METHOD get_instance.
   ro_instance = mo_self.
  ENDMETHOD.

ENDCLASS.
