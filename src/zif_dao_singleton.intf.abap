interface ZIF_DAO_SINGLETON
  public .

    CLASS-METHODS: get_instance
     IMPORTING i_carrid           TYPE scarr-carrid
    RETURNING VALUE(ro_instance) TYPE REF TO zif_dao_singleton.

endinterface.
