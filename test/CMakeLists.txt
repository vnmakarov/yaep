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

set( TEST_DATA_DIR "${CMAKE_CURRENT_SOURCE_DIR}" )

include_directories(
	${PROJECT_SOURCE_DIR}/src
	${CMAKE_CURRENT_SOURCE_DIR}
	${CMAKE_CURRENT_SOURCE_DIR}/common
)

# ANSI-C tokenizer
find_package( FLEX )
if( FLEX_FOUND )
	flex_target( flex_ansic ansic.l "${CMAKE_CURRENT_BINARY_DIR}/ansic.c" )
	add_custom_target( ansic_c DEPENDS ${FLEX_flex_ansic_OUTPUTS} ) # for direct #includes
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
