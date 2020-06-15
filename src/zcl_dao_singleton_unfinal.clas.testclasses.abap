*"* use this source file for your ABAP unit test classes
**We can not do injection here as there is no interfaces!
**Only possible ways are inheriting and redefining or back-door injection!
**How to test a Singleton class- As you see its so hard!
**You can only subclass this one and redefine the method to create a stub!
** Check out the friendships

CLASS lct_monolithic DEFINITION DEFERRED.
CLASS zcl_dao_singleton_unfinal DEFINITION LOCAL FRIENDS lct_monolithic.
*
*Subclass needs private access so needs to be friend as well!-as its not protected!
CLASS lcst_with_data DEFINITION DEFERRED.
CLASS zcl_dao_singleton_unfinal DEFINITION LOCAL FRIENDS lcst_with_data.

CLASS lcst_with_data DEFINITION FOR TESTING INHERITING FROM zcl_dao_singleton_unfinal FRIENDS lct_monolithic.
  PUBLIC SECTION.
    METHODS: select_carrier_details REDEFINITION.
ENDCLASS.

CLASS lcst_with_data IMPLEMENTATION.
  METHOD select_carrier_details.
    rt_carriers = VALUE #( ( carrid = 'AA' carrname = 'American Airlines' ) ).
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

    DATA: mo_cut TYPE REF TO zcl_dao_singleton_unfinal.
*Given
    mo_cut = NEW lcst_with_data( ).
*When
    DATA(lt_actual) = mo_cut->select_carrier_details( i_carrid = 'AA' ).

*Then
    DATA(lt_expected) = VALUE zcl_dao_singleton_unfinal=>tt_carriers( (  carrid = 'AA' carrname = 'American Airlines'  ) ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lt_actual                              " Data object with current value
        exp                  = lt_expected                             " Data object with expected type
    ).
    cl_abap_unit_assert=>assert_table_contains( line = VALUE scarr(  carrid = 'AA' carrname = 'American Airlines'  ) table = lt_actual  ).
  ENDMETHOD.

ENDCLASS.
