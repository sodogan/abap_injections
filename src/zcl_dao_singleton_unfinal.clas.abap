*/*
* Singleton class-unfinal means can be redefined
* We can inherit and replace it with our own stub!
*/*
CLASS zcl_dao_singleton_unfinal DEFINITION
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.
    TYPES: tt_carriers TYPE SORTED TABLE OF scarr WITH UNIQUE KEY carrid .
    CLASS-METHODS: class_constructor.
    CLASS-METHODS: get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_dao_singleton_unfinal.
    METHODS:select_carrier_details   IMPORTING i_carrid TYPE scarr-carrid
                                     RETURNING VALUE(rt_carriers) TYPE tt_carriers.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: mo_self TYPE REF TO zcl_dao_singleton_unfinal.

ENDCLASS.



CLASS ZCL_DAO_SINGLETON_UNFINAL IMPLEMENTATION.


  METHOD class_constructor.
    mo_self = NEW #(  ).
  ENDMETHOD.


  METHOD get_instance.
   ro_instance = mo_self.
  ENDMETHOD.


  METHOD select_carrier_details.
* Seam  here !
    SELECT * FROM scarr
     INTO TABLE @rt_carriers
     WHERE carrid = @i_carrid
     .


  ENDMETHOD.
ENDCLASS.
