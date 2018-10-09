# Generate sources from yacc first
find_package( BISON REQUIRED )
bison_target( sgramm sgramm.y ${CMAKE_CURRENT_BINARY_DIR}/sgramm.c )
if( NOT ${BISON_sgramm_DEFINED} )
	message( FATAL_ERROR "Failed to add rule for sgramm.c" )
endif()
add_custom_target( sgramm_c DEPENDS ${BISON_sgramm_OUTPUTS} ) # FIXME: yaep.c includes sgramm.c directly, so we need a custom target

# Now build library
set( YAEP_LIB ${PROJECT_NAME} )
if( UNIX )
	set( YAEP_LIB_STATIC ${YAEP_LIB} )
else()
	set( YAEP_LIB_STATIC "${YAEP_LIB}_static" )
endif()
set( YAEP_LIB_SOURCES
	allocate.c
	hashtab.c
	objstack.c
	vlobject.c
	yaep.c
)
include_directories(
	${CMAKE_CURRENT_BINARY_DIR}
)
add_library( yaep_static ${YAEP_LIB_SOURCES} )
add_dependencies( yaep_static sgramm_c ) # FIXME: yaep.c includes sgramm.c directly; would be cleaner if sgramm was its own object
set_target_properties( yaep_static PROPERTIES OUTPUT_NAME ${YAEP_LIB_STATIC} )
