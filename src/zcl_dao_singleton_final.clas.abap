CLASS zcl_dao_singleton_final DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.
    INTERFACES zif_dao_singleton.
    TYPES: tt_carriers TYPE SORTED TABLE OF scarr WITH UNIQUE KEY carrid .
    METHODS:select_carrier_details RETURNING VALUE(rt_carriers) TYPE tt_carriers.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS: constructor  IMPORTING i_carrid TYPE scarr-carrid.
    CLASS-DATA: mo_self TYPE REF TO zif_dao_singleton.
    DATA: mo_dao_access TYPE REF TO lif_dao_access.
    DATA: mv_carrid   TYPE scarr-carrid.
ENDCLASS.



CLASS zcl_dao_singleton_final IMPLEMENTATION.


  METHOD constructor.
    me->mv_carrid = i_carrid.
    mo_dao_access = NEW lcl_dao_access(  ).
  ENDMETHOD.


  METHOD select_carrier_details.
* Moved the Seam  to the local interface so we can replace with a stub interface !
*    SELECT * FROM scarr
*     INTO TABLE @rt_carriers
*     WHERE carrid = @mv_carrid
*     .
    rt_carriers = mo_dao_access->select_carrier_details( i_carrid = mv_carrid ).

  ENDMETHOD.


  METHOD zif_dao_singleton~get_instance.
    ro_instance = COND #( WHEN NOT mo_self IS BOUND THEN NEW zcl_dao_singleton_final( i_carrid )
                         ELSE mo_self
                         ).
  ENDMETHOD.
ENDCLASS.
