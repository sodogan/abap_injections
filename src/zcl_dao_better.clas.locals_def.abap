CLASS lcx_no_data_found DEFINITION INHERITING FROM cx_static_check FINAL.

  PUBLIC SECTION.
  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

INTERFACE lif_dao.
  METHODS: select_carrier_details   IMPORTING i_carrid TYPE scarr-carrid
                                       RETURNING VALUE(rt_carriers) TYPE zcl_dao_monolithic=>tt_carriers RAISING cx_static_check.

ENDINTERFACE.
