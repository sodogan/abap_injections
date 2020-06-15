*"* use this source file for your ABAP unit test classes


CLASS lcl_stub DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: zif_dao_query.
ENDCLASS.

CLASS lcl_stub IMPLEMENTATION.

  METHOD zif_dao_query~select_carrier_details.
    rt_carriers = VALUE #(  ).
  ENDMETHOD.

ENDCLASS.
************************************************************************************
CLASS lcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PUBLIC SECTION.
  PRIVATE SECTION.
    METHODS cancreate  FOR TESTING RAISING cx_static_check.

ENDCLASS.
CLASS lcl_test IMPLEMENTATION.
  METHOD cancreate.

*   inject the stub
    zcl_dependancy_injector=>inject_dao_provider( NEW lcl_stub(  ) ).


    DATA(lo_cut) = NEW zcl_dao_with_lookup(  ).

    DATA(lt_carriers) = lo_cut->select_carrier_details( i_carrid = 'AA' ).
*  CATCH cx_static_check. " Exceptions with Static and Dynamic Check of RAISING Clause

    cl_abap_unit_assert=>assert_equals( msg = 'Injection through dependancy lookup'
                                       exp = VALUE zif_dao_query=>tt_carriers( )
                                       act = lt_carriers ).

  ENDMETHOD.
ENDCLASS.
