cmake_minimum_required( VERSION 3.0 )

project( yaep )
enable_testing()

set( CMAKE_C_STANDARD 90 )
set( CMAKE_CXX_STANDARD 11 )

include( GNUInstallDirs )

add_subdirectory( src )
add_subdirectory( test )
add_subdirectory( doc )
