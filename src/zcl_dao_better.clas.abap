CLASS zcl_dao_better DEFINITION
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.
    TYPES: tt_carriers TYPE SORTED TABLE OF scarr WITH UNIQUE KEY carrid .
    CLASS-METHODS: class_constructor.
    CLASS-METHODS: get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_dao_better.
    METHODS:select_carrier_details   IMPORTING i_carrid TYPE scarr-carrid
                                     RETURNING VALUE(rt_carriers) TYPE tt_carriers RAISING cx_static_check.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS constructor.
    DATA: mo_dao TYPE REF TO lif_dao.
    CLASS-DATA: mo_self TYPE REF TO zcl_dao_better.
ENDCLASS.



CLASS zcl_dao_better IMPLEMENTATION.

  METHOD constructor.
    mo_dao = NEW lcl_dao(  ).
  ENDMETHOD.

  METHOD class_constructor.
    mo_self = NEW #(  ).
  ENDMETHOD.


  METHOD select_carrier_details.
* Seam  here !
*    SELECT * FROM scarr
*     INTO TABLE @rt_carriers
*     WHERE carrid = @i_carrid
*     .
    TRY.
        rt_carriers = mo_dao->select_carrier_details( i_carrid = i_carrid ).
      CATCH cx_static_check. " Exceptions with Static and Dynamic Check of RAISING Clause
    ENDTRY.



  ENDMETHOD.
  METHOD get_instance.
    ro_instance = mo_self.
  ENDMETHOD.

ENDCLASS.
