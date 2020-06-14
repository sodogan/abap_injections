

class lcl_dao_access definition final.

  public section.
  INTERFACES lif_dao_access.

  protected section.

  private section.

endclass.

class lcl_dao_access implementation.

  method lif_dao_access~select_carrier_details.
   SELECT * FROM scarr
     INTO TABLE @rt_carriers
     WHERE carrid = @i_carrid
     .

  endmethod.

endclass.
