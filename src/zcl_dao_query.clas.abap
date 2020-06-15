CLASS zcl_dao_query DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
  INTERFACES zif_dao_query.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dao_query IMPLEMENTATION.
  METHOD zif_dao_query~select_carrier_details.
    SELECT * FROM scarr
     INTO TABLE @rt_carriers
     WHERE carrid = @i_carrid
     .
  ENDMETHOD.

ENDCLASS.
