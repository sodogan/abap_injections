
class lcx_no_data_found implementation.


endclass.

class lcl_dao definition final.

  public section.
  INTERFACES lif_dao.

  protected section.

  private section.

endclass.

class lcl_dao implementation.

  method lif_dao~select_carrier_details.
    SELECT * FROM scarr
     INTO TABLE @rt_carriers
     WHERE carrid = @i_carrid
     .

  endmethod.

endclass.
