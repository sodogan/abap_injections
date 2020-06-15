CLASS zcl_dependancy_lookup_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE GLOBAL FRIENDS zcl_dependancy_injector.

  PUBLIC SECTION.
    CLASS-METHODS: create_query_provider RETURNING VALUE(ro_instance) TYPE REF TO zif_dao_query.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: mo_query_injectable TYPE REF TO zif_dao_query.
ENDCLASS.



CLASS zcl_dependancy_lookup_factory IMPLEMENTATION.
  METHOD create_query_provider.

    ro_instance = cond #( when mo_query_injectable is BOUND then mo_query_injectable
                           else NEW zcl_dao_query_managed(  )  ).

  ENDMETHOD.



ENDCLASS.
