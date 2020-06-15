CLASS zcl_dao_query_managed DEFINITION
  PUBLIC
  FINAL
  CREATE Private GLOBAL FRIENDS zcl_dependancy_lookup_factory.
  PUBLIC SECTION.
  INTERFACES zif_dao_query.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dao_query_managed IMPLEMENTATION.
  METHOD zif_dao_query~select_carrier_details.
    SELECT * FROM scarr
     INTO TABLE @rt_carriers
     WHERE carrid = @i_carrid
     .
  ENDMETHOD.

ENDCLASS.
