

INTERFACE lif_dao_access.
  METHODS:select_carrier_details IMPORTING i_carrid           TYPE scarr-carrid
                                 RETURNING VALUE(rt_carriers) TYPE zcl_dao_singleton_backdoor=>tt_carriers.
ENDINTERFACE.
