*"* use this source file for your ABAP unit test classes
**We can not do injection here as there is no interfaces and its FINAL so can not inherit!
**Only possible ways is back-door injection!
**How to test a Singleton class- As you see its so hard!
**You can only subclass this one and redefine the method to create a stub!
** Check out the friendships

CLASS lct_monolithic DEFINITION DEFERRED.
CLASS zcl_dao_singleton_backdoor DEFINITION LOCAL FRIENDS lct_monolithic.


CLASS lcst_dummy DEFINITION FOR TESTING.
  PUBLIC SECTION.
     INTERFACES lif_dao_access.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcst_dummy IMPLEMENTATION.

  METHOD lif_dao_access~select_carrier_details.
   rt_carriers = VALUE #( (  carrid = 'AA' carrname = 'American Airlines'  ) ).
  ENDMETHOD.

ENDCLASS.



*In the test we need to use the redefined stub!
CLASS lct_monolithic DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS .
  PUBLIC SECTION .

  PRIVATE SECTION.

    METHODS isrightdatareturned FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS lct_monolithic IMPLEMENTATION.

  METHOD isrightdatareturned.

    DATA: mo_cut TYPE REF TO zcl_dao_singleton_backdoor
          .

    mo_cut =  CAST zcl_dao_singleton_backdoor( zcl_dao_singleton_backdoor=>zif_dao_singleton~get_instance( |AA| ) ) .
*Replace the singleton with stub singleton!
    mo_cut->mo_dao_access = new lcst_dummy( ).
*When
    DATA(lt_actual) = mo_cut->select_carrier_details( 'AA').

*Then
    DATA(lt_expected) = VALUE zcl_dao_singleton_backdoor=>tt_carriers( (  carrid = 'AA' carrname = 'American Airlines'  ) ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lt_actual                              " Data object with current value
        exp                  = lt_expected                             " Data object with expected type
    ).
    cl_abap_unit_assert=>assert_table_contains( line = VALUE scarr(  carrid = 'AA' carrname = 'American Airlines'  ) table = lt_actual  ).
  ENDMETHOD.





ENDCLASS.
