

INTERFACE lif_dao_access.
  INTERFACES zif_dao_singleton.

  METHODS:select_carrier_details IMPORTING i_carrid           TYPE scarr-carrid
                                 RETURNING VALUE(rt_carriers) TYPE zcl_dao_singleton_final=>tt_carriers.

ENDINTERFACE.
