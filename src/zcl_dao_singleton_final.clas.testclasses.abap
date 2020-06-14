*"* use this source file for your ABAP unit test classes
**We can not do injection here as there is no interfaces and its FINAL so can not inherit!
**Only possible ways is back-door injection!
**How to test a Singleton class- As you see its so hard!
**You can only subclass this one and redefine the method to create a stub!
** Check out the friendships

CLASS lct_monolithic DEFINITION DEFERRED.
CLASS zcl_dao_singleton_final DEFINITION LOCAL FRIENDS lct_monolithic.


CLASS lcst_dummy DEFINITION FOR TESTING.
  PUBLIC SECTION.
     INTERFACES lif_dao_access.
    METHODS constructor IMPORTING i_carrid TYPE scarr-carrid.
  PRIVATE SECTION.
    CLASS-DATA:mo_self TYPE REF TO lcst_dummy.
    DATA: mv_carrid TYPE scarr-carrid.
ENDCLASS.

CLASS lcst_dummy IMPLEMENTATION.

  METHOD constructor.
    mv_carrid =  i_carrid.
  ENDMETHOD.
  METHOD zif_dao_singleton~get_instance.
    IF NOT  mo_self IS BOUND.
      mo_self = NEW #( i_carrid ).
    ENDIF.

    ro_instance = mo_self.
  ENDMETHOD.

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

    DATA: mo_cut TYPE REF TO zcl_dao_singleton_final
          .

    mo_cut =  CAST zcl_dao_singleton_final( zcl_dao_singleton_final=>zif_dao_singleton~get_instance( |AA| ) ) .
*Replace the singleton with stub singleton!
    mo_cut->mo_self =   lcst_dummy=>zif_dao_singleton~get_instance( |AA| ) .
    mo_cut->mo_dao_access = cast lif_dao_access( mo_cut->mo_self ).
*When
    DATA(lt_actual) = mo_cut->select_carrier_details( ).

*Then
    DATA(lt_expected) = VALUE zcl_dao_singleton_final=>tt_carriers( (  carrid = 'AA' carrname = 'American Airlines'  ) ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lt_actual                              " Data object with current value
        exp                  = lt_expected                             " Data object with expected type
    ).
    cl_abap_unit_assert=>assert_table_contains( line = VALUE scarr(  carrid = 'AA' carrname = 'American Airlines'  ) table = lt_actual  ).
  ENDMETHOD.





ENDCLASS.
