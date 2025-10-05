# YAEP (Yet Another Earley Parser)
#
# Copyright (c) 1997-2018  Vladimir Makarov <vmakarov@gcc.gnu.org>
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
	${PROJECT_SOURCE_DIR}/third_party/utf8proc
	${CMAKE_CURRENT_SOURCE_DIR}/unicode
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
	unicode/yaep_unicode.c
)

add_library( yaep_static STATIC ${YAEP_LIB_SOURCES} )
add_dependencies( yaep_static sgramm_c )
target_link_libraries( yaep_static PUBLIC utf8proc )
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
	unicode/yaep_unicode.c
)

add_library( yaep++_static STATIC ${YAEPXX_LIB_SOURCES} )
add_dependencies( yaep++_static sgramm_c )
target_link_libraries( yaep++_static PUBLIC utf8proc )
set_target_properties( yaep++_static PROPERTIES OUTPUT_NAME ${YAEPXX_LIB_STATIC} )

# Install
set( YAEP_INCLUDE
	yaep.h
)
install( TARGETS yaep_static yaep++_static DESTINATION ${CMAKE_INSTALL_LIBDIR} )
install( FILES ${YAEP_INCLUDE} DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}" )

# Build test binaries from the same sources

add_executable( yaep_test ${YAEP_LIB_SOURCES} )
target_link_libraries( yaep_test PRIVATE yaep_static utf8proc )
add_executable( yaep++_test ${YAEPXX_LIB_SOURCES} )
target_link_libraries( yaep++_test PRIVATE yaep++_static utf8proc )
set_target_properties( yaep_test yaep++_test PROPERTIES COMPILE_FLAGS "-DYAEP_TEST -DYAEP_DEBUG" )
