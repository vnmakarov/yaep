set( TEST_DATA_DIR "${CMAKE_CURRENT_SOURCE_DIR}" )

include_directories(
	${PROJECT_SOURCE_DIR}/src
	${CMAKE_CURRENT_SOURCE_DIR}
)

# ANSI-C tokenizer
find_package( FLEX )
if( FLEX_FOUND )
	flex_target( flex_ansic ansic.l "${CMAKE_CURRENT_BINARY_DIR}/ansic.c" )
	add_custom_target( ansic_c DEPENDS ${FLEX_flex_ansic_OUTPUTS} ) # for direct #includes
	add_library( ansic_lib STATIC ${FLEX_flex_ansic_OUTPUTS} ) # for linked flex
else()
	message( WARNING "(f)lex not found; needed for all ANSI-C tests" )
endif()

# Ticker library
add_library( ticker STATIC ticker.c )
add_library( ticker++ STATIC ticker.cpp )

# Test subdirectories
add_subdirectory( C )
add_subdirectory( C++ )
add_subdirectory( compare_parsers )
