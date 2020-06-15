CLASS zcl_dependancy_injector DEFINITION FOR TESTING
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  class-METHODS: inject_dao_provider IMPORTING io_dao_provider TYPE REF TO zif_dao_query.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dependancy_injector IMPLEMENTATION.
  METHOD inject_dao_provider.
   zcl_dependancy_lookup_factory=>mo_query_injectable = io_dao_provider.
  ENDMETHOD.

ENDCLASS.
