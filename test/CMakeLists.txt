include_directories(
	${PROJECT_SOURCE_DIR}/src
)
add_library( ticker STATIC ticker.c )
add_library( ticker++ STATIC ticker.cpp )

add_subdirectory( C )
add_subdirectory( C++ )
add_subdirectory( compare_parsers )
