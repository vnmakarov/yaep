# Generate sources from yacc first
find_package( BISON REQUIRED )
bison_target( sgramm sgramm.y ${CMAKE_CURRENT_BINARY_DIR}/sgramm.c )
if( NOT ${BISON_sgramm_DEFINED} )
	message( FATAL_ERROR "Failed to add rule for sgramm.c" )
endif()
add_custom_target( sgramm_c DEPENDS ${BISON_sgramm_OUTPUTS} ) # FIXME: yaep.c includes sgramm.c directly, so we need a custom target

# Now build libraries
include_directories(
	${CMAKE_CURRENT_BINARY_DIR}
)

# C
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
add_library( yaep_static ${YAEP_LIB_SOURCES} )
add_dependencies( yaep_static sgramm_c ) # FIXME: yaep.c includes sgramm.c directly; would be cleaner if sgramm was its own object
set_target_properties( yaep_static PROPERTIES OUTPUT_NAME ${YAEP_LIB_STATIC} )

# C++
set( YAEPXX_LIB "${PROJECT_NAME}++" )
if( UNIX )
	set( YAEPXX_LIB_STATIC ${YAEPXX_LIB} )
else()
	set( YAEPXX_LIB_STATIC "${YAEPXX_LIB}_static" )
endif()
set( YAEPXX_LIB_SOURCES
	allocate.c
	hashtab.cpp
	objstack.cpp
	vlobject.cpp
	yaep.cpp
)
add_library( yaep++_static ${YAEPXX_LIB_SOURCES} )
add_dependencies( yaep++_static sgramm_c ) # FIXME: yaep.cpp includes sgramm.c via yaep.c; would be cleaner if sgramm was its own object
set_target_properties( yaep++_static PROPERTIES OUTPUT_NAME ${YAEPXX_LIB_STATIC} )

# Install
set( YAEP_INCLUDE
	yaep.h
)
install( TARGETS yaep_static yaep++_static DESTINATION ${CMAKE_INSTALL_LIBDIR} )
install( FILES ${YAEP_INCLUDE} DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}" )
