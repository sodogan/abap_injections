INTERFACE zif_dao_query
  PUBLIC .
  TYPES: tt_carriers TYPE SORTED TABLE OF scarr WITH UNIQUE KEY carrid .

  METHODS: select_carrier_details   IMPORTING i_carrid TYPE scarr-carrid
                                   RETURNING VALUE(rt_carriers) TYPE tt_carriers RAISING cx_static_check.

ENDINTERFACE.
