*/* Constructor injection here
*  Notice that the seam is moved to the interface
*  Allowing us to stub or use Mocking
*  Example of Constructor injection here!
*  Other ways are setter injections too
*  Setter injection allows outside others to inject too
*/*
CLASS zcl_dao_injectable DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:

     "! <p class="shorttext synchronized" lang="en"></p>
     "! Constructor injection-optional otherwise creates the default instance of the implementation
     "! @parameter if_dao_query | <p class="shorttext synchronized" lang="en"></p>
     constructor IMPORTING if_dao_query TYPE REF TO zif_dao_query OPTIONAL.

    METHODS:

            "! <p class="shorttext synchronized" lang="en"></p>
            "! Parameter injection can be done here but its the last resort!
            "! @parameter i_carrid | <p class="shorttext synchronized" lang="en"></p>
            "! @parameter rt_carriers | <p class="shorttext synchronized" lang="en"></p>
            "! @raising cx_static_check | <p class="shorttext synchronized" lang="en"></p>
            select_carrier_details   IMPORTING i_carrid TYPE scarr-carrid
                                     RETURNING VALUE(rt_carriers) TYPE zif_dao_query=>tt_carriers RAISING cx_static_check,

            "! <p class="shorttext synchronized" lang="en"></p>
            "! Setter injection goes here- also exposes outsiders to change the interface!
            "! @parameter mif_dao_query | <p class="shorttext synchronized" lang="en"></p>
            set_mif_dao_query IMPORTING mif_dao_query TYPE REF TO zif_dao_query.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mif_dao_query TYPE REF TO zif_dao_query.
ENDCLASS.



CLASS ZCL_DAO_INJECTABLE IMPLEMENTATION.


  METHOD constructor.
    mif_dao_query = COND #(  WHEN if_dao_query IS BOUND THEN if_dao_query
                                  else new zcl_dao_query(  )
     ).
  ENDMETHOD.


  METHOD select_carrier_details.
* Dependancy is replaced with the Global interface !
*    SELECT * FROM scarr
*     INTO TABLE @rt_carriers
*     WHERE carrid = @i_carrid
*     .
    rt_carriers = mif_dao_query->select_carrier_details( i_carrid = i_carrid ).
  ENDMETHOD.

  METHOD SET_MIF_DAO_QUERY.
    ME->MIF_DAO_QUERY = MIF_DAO_QUERY.
  ENDMETHOD.

ENDCLASS.
