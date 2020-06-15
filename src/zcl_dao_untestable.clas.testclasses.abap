*"* use this source file for your ABAP unit test classes
**This is a monolithic class-Untestable code!
**How to test a Static class- can not inherit even!
**You can only subclass this one and redefine the method to create a stub!
** Can access the private fields with friendship but then?

CLASS lct_monolithic DEFINITION DEFERRED.
CLASS zcl_dao_untestable DEFINITION LOCAL FRIENDS lct_monolithic.



*In the test we need to use the redefined stub!
CLASS lct_monolithic DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS .
  PUBLIC SECTION .

  PRIVATE SECTION.

    METHODS howtoteststaticclass FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS lct_monolithic IMPLEMENTATION.

  METHOD howtoteststaticclass.

*    DATA: mo_cut TYPE REF TO zcl_dao_untestable.
**Given-Can not do anything with static
*    zcl_dao_untestable=>mo_self = NEW #( ).
**When
*    TRY.
*        DATA(lt_actual) = mo_cut->select_carrier_details( i_carrid = 'AA' ).
*      CATCH cx_static_check. " Exceptions with Static and Dynamic Check of RAISING Clause
*        cl_abap_unit_assert=>fail( |No data has been found!| ).
*    ENDTRY.
*
**Then
*    DATA(lt_expected) = VALUE zcl_dao_untestable=>tt_carriers( (  carrid = 'AA' carrname = 'American Airlines'  ) ).
*    cl_abap_unit_assert=>assert_equals(
*      EXPORTING
*        act                  = lt_actual                              " Data object with current value
*        exp                  = lt_expected                             " Data object with expected type
*    ).
*    cl_abap_unit_assert=>assert_table_contains( line = VALUE scarr(  carrid = 'AA' carrname = 'American Airlines'  ) table = lt_actual  ).
  ENDMETHOD.





ENDCLASS.
