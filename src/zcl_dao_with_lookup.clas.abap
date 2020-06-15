CLASS zcl_dao_with_lookup DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:select_carrier_details   IMPORTING i_carrid TYPE scarr-carrid
                                     RETURNING VALUE(rt_carriers) TYPE zif_dao_query=>tt_carriers RAISING cx_static_check.

   METHODS:constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mo_dao_query TYPE REF TO zif_dao_query.
ENDCLASS.



CLASS ZCL_DAO_WITH_LOOKUP IMPLEMENTATION.


  METHOD constructor.
* dependancy here needs to be provided by the LookupFactory!
    mo_dao_query = zcl_dependancy_lookup_factory=>create_query_provider( ).

  ENDMETHOD.


  METHOD select_carrier_details.
    TRY.
        mo_dao_query->select_carrier_details( i_carrid =  i_carrid ).
      CATCH cx_static_check. " Exceptions with Static and Dynamic Check of RAISING Clause
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
