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

cmake_minimum_required( VERSION 3.5 )

project( yaep )
enable_testing()

option( YAEP_LEGACY_C99 "Build YAEP with C99 instead of C11" OFF )
option( YAEP_ENABLE_STRICT_WARNINGS "Enable extra compiler warnings" ON )

if( YAEP_LEGACY_C99 )
	set( CMAKE_C_STANDARD 99 )
else()
	set( CMAKE_C_STANDARD 11 )
endif()
set( CMAKE_C_STANDARD_REQUIRED ON )
set( CMAKE_C_EXTENSIONS OFF )

set( CMAKE_CXX_STANDARD 14 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )
set( CMAKE_CXX_EXTENSIONS OFF )

if( YAEP_ENABLE_STRICT_WARNINGS )
	if( MSVC )
		add_compile_options( /W4 /permissive- )
	else()
		add_compile_options( -Wall -Wextra -Wpedantic )
	endif()
endif()

include( GNUInstallDirs )


# Add utf8proc as a third-party dependency
add_subdirectory( third_party/utf8proc )
add_subdirectory( src )
add_subdirectory( test )
add_subdirectory( doc )
