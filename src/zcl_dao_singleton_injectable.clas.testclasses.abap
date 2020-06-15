*"* use this source file for your ABAP unit test classes
*
* Sample of a constructor injection and how can test with stubs
*
*
**Data exists Stub that implements the same interface for select
CLASS lcst_mock_data_exists DEFINITION FOR TESTING .
  PUBLIC SECTION.
    INTERFACES zif_dao_query.
ENDCLASS.

CLASS lcst_mock_data_exists IMPLEMENTATION.
  METHOD zif_dao_query~select_carrier_details.
    rt_carriers = VALUE #( (  carrid = 'AA' carrname = 'American Airlines'  ) ).
  ENDMETHOD.
ENDCLASS.


class lcx_no_data_found DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

**Data exists Stub that implements the same interface for select
CLASS lcst_no_data_exists DEFINITION FOR TESTING .
  PUBLIC SECTION.
    INTERFACES zif_dao_query.
ENDCLASS.

CLASS lcst_no_data_exists IMPLEMENTATION.

  METHOD zif_dao_query~select_carrier_details.
    RAISE EXCEPTION TYPE lcx_no_data_found.
  ENDMETHOD.

ENDCLASS.



*In the test we need to use the redefined stub!
CLASS lct_monolithic DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS .
  PUBLIC SECTION .
  PRIVATE SECTION.
    METHODS whenthereisdatareturned FOR TESTING RAISING cx_static_check.
    METHODS whenthereisnodatareturned FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS lct_monolithic IMPLEMENTATION.


  METHOD whenthereisdatareturned.
*Given
** Constructor Injection goes here!
    DATA(mo_cut) = zcl_dao_singleton_injectable=>get_instance( if_dao = NEW lcst_mock_data_exists(  ) ).

*When
    TRY.
        DATA(lt_actual) = mo_cut->select_carrier_details( i_carrid = 'AA' ).
      CATCH cx_static_check INTO DATA(lo_exception). " Exceptions with Static and Dynamic Check of RAISING Clause
        cl_abap_unit_assert=>fail( |No data has been found:| && | { lo_exception->get_text( ) }| ).
    ENDTRY.

*Then
    DATA(lt_expected) = VALUE zif_dao_query=>tt_carriers( (  carrid = 'AA' carrname = 'American Airlines'  ) ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lt_actual                              " Data object with current value
        exp                  = lt_expected                             " Data object with expected type
    ).
*    can also verify with table contains
    cl_abap_unit_assert=>assert_table_contains( line = VALUE scarr(  carrid = 'AA' carrname = 'American Airlines'  ) table = lt_actual  ).
  ENDMETHOD.

  METHOD whenthereisnodatareturned.
*Given
** Constructor Injection goes here!
    DATA(mo_cut) = zcl_dao_singleton_injectable=>get_instance( if_dao = NEW lcst_no_data_exists(  ) ).

*When
    TRY.
        DATA(lt_actual) = mo_cut->select_carrier_details( i_carrid = 'AA' ).
      CATCH cx_static_check INTO DATA(lo_exception). " Exceptions with Static and Dynamic Check of RAISING Clause
      cl_abap_unit_assert=>assert_true(  act = xsdbool( lo_exception is bound ) ).
      RETURN.
    ENDTRY.
   cl_abap_unit_assert=>fail( |Should not reach here means Data has been found:|  ).
  ENDMETHOD.


ENDCLASS.
