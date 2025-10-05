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

include_directories(
	${PROJECT_SOURCE_DIR}/src
	${PROJECT_SOURCE_DIR}/test
	${CMAKE_CURRENT_BINARY_DIR}
	${CMAKE_BINARY_DIR}/test
)

# Helpers
macro( rescape output input )
	set( tmp "${input}" )
	string( REPLACE "$" "\\$" tmp "${tmp}" )
	string( REPLACE "." "\\." tmp "${tmp}" )
	string( REPLACE "+" "\\+" tmp "${tmp}" )
	string( REPLACE "(" "\\(" tmp "${tmp}" )
	string( REPLACE ")" "\\)" tmp "${tmp}" )
	set( "${output}" "${tmp}" )
endmacro()

# No statistics
add_test( NAME yaep++-test01 COMMAND yaep++_test 1 1 0 )
file( READ ${TEST_DATA_DIR}/test01.out TEST_OUTPUT )
set_tests_properties( yaep++-test01 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

add_test( NAME yaep++-test01a COMMAND yaep++_test 0 1 0 )
file( READ ${TEST_DATA_DIR}/test01a.out TEST_OUTPUT )
set_tests_properties( yaep++-test01a PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Static lookahead
add_test( NAME yaep++-test02 COMMAND yaep++_test 1 1 1 )
file( READ ${TEST_DATA_DIR}/test02.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test02 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

add_test( NAME yaep++-test02a COMMAND yaep++_test 0 1 1 )
file( READ ${TEST_DATA_DIR}/test02a.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test02a PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

# No lookahead
add_test( NAME yaep++-test03 COMMAND yaep++_test 1 0 1 )
file( READ ${TEST_DATA_DIR}/test03.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test03 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

add_test( NAME yaep++-test03a COMMAND yaep++_test 0 0 1 )
file( READ ${TEST_DATA_DIR}/test03a.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test03a PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

add_test( NAME yaep++-test03b COMMAND yaep++_test 0 -1 1 )
file( READ ${TEST_DATA_DIR}/test03b.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test03b PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

# Dynamic lookahead
add_test( NAME yaep++-test04 COMMAND yaep++_test 1 2 1 )
file( READ ${TEST_DATA_DIR}/test04.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test04 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

add_test( NAME yaep++-test04a COMMAND yaep++_test 0 2 0 )
file( READ ${TEST_DATA_DIR}/test04a.out TEST_OUTPUT )
set_tests_properties( yaep++-test04a PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

add_test( NAME yaep++-test04b COMMAND yaep++_test 0 3 0 )
file( READ ${TEST_DATA_DIR}/test04b.out TEST_OUTPUT )
set_tests_properties( yaep++-test04b PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Debug level 2
add_test( NAME yaep++-test05 COMMAND yaep++_test 1 1 2 )
file( READ ${TEST_DATA_DIR}/test05.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test05 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

add_test( NAME yaep++-test05a COMMAND yaep++_test 0 1 2 )
file( READ ${TEST_DATA_DIR}/test05a.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test05a PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

# Undefined or bad grammar
add_executable( test++06 test06.cpp )
target_link_libraries( test++06 yaep++_static )
add_test( NAME yaep++-test06 COMMAND test++06 1 0 )
file( READ ${TEST_DATA_DIR}/test06.out TEST_OUTPUT )
set_tests_properties( yaep++-test06 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Already defined grammar
add_executable( test++07 test07.cpp )
target_link_libraries( test++07 yaep++_static )
add_test( NAME yaep++-test07 COMMAND test++07 1 0 )
file( READ ${TEST_DATA_DIR}/test07.out TEST_OUTPUT )
set_tests_properties( yaep++-test07 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Description syntax error
add_executable( test++08 test08.cpp )
target_link_libraries( test++08 yaep++_static )
add_test( NAME yaep++-test08 COMMAND test++08 1 0 )
file( READ ${TEST_DATA_DIR}/test08.out TEST_OUTPUT )
set_tests_properties( yaep++-test08 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Error in rule lhs
add_executable( test++09 test09.cpp )
target_link_libraries( test++09 yaep++_static )
add_test( NAME yaep++-test09 COMMAND test++09 1 0 )
file( READ ${TEST_DATA_DIR}/test09.out TEST_OUTPUT )
set_tests_properties( yaep++-test09 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Different codes for one terminal
add_executable( test++10 test10.cpp )
target_link_libraries( test++10 yaep++_static )
add_test( NAME yaep++-test10 COMMAND test++10 1 0 )
file( READ ${TEST_DATA_DIR}/test10.out TEST_OUTPUT )
set_tests_properties( yaep++-test10 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Same code for different terminals
add_executable( test++11 test11.cpp )
target_link_libraries( test++11 yaep++_static )
add_test( NAME yaep++-test11 COMMAND test++11 1 0 )
file( READ ${TEST_DATA_DIR}/test11.out TEST_OUTPUT )
set_tests_properties( yaep++-test11 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# No grammar rules
add_executable( test++12 test12.cpp )
target_link_libraries( test++12 yaep++_static )
add_test( NAME yaep++-test12 COMMAND test++12 1 0 )
file( READ ${TEST_DATA_DIR}/test12.out TEST_OUTPUT )
set_tests_properties( yaep++-test12 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Terminal in lhs of rule
add_executable( test++13 test13.cpp )
target_link_libraries( test++13 yaep++_static )
add_test( NAME yaep++-test13 COMMAND test++13 1 0 )
file( READ ${TEST_DATA_DIR}/test13.out TEST_OUTPUT )
set_tests_properties( yaep++-test13 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Incorrect translation symbol number
add_executable( test++14 test14.cpp )
target_link_libraries( test++14 yaep++_static )
add_test( NAME yaep++-test14 COMMAND test++14 1 0 )
file( READ ${TEST_DATA_DIR}/test14.out TEST_OUTPUT )
set_tests_properties( yaep++-test14 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Repeated translation symbol number
add_executable( test++15 test15.cpp )
target_link_libraries( test++15 yaep++_static )
add_test( NAME yaep++-test15 COMMAND test++15 1 0 )
file( READ ${TEST_DATA_DIR}/test15.out TEST_OUTPUT )
set_tests_properties( yaep++-test15 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

add_executable( test++16 test16.cpp )
target_link_libraries( test++16 yaep++_static )
add_test( NAME yaep++-test16 COMMAND test++16 1 0 )
file( READ ${TEST_DATA_DIR}/test16.out TEST_OUTPUT )
set_tests_properties( yaep++-test16 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Nonterminal does not derive any terminal
add_executable( test++17 test17.cpp )
target_link_libraries( test++17 yaep++_static )
add_test( NAME yaep++-test17 COMMAND test++17 1 0 )
file( READ ${TEST_DATA_DIR}/test17.out TEST_OUTPUT )
set_tests_properties( yaep++-test17 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Grammar with loops
add_executable( test++18 test18.cpp )
target_link_libraries( test++18 yaep++_static )
add_test( NAME yaep++-test18 COMMAND test++18 1 0 )
file( READ ${TEST_DATA_DIR}/test18.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test18 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Invalid token
add_executable( test++19 test19.cpp )
target_link_libraries( test++19 yaep++_static )
add_test( NAME yaep++-test19 COMMAND test++19 1 0 )
file( READ ${TEST_DATA_DIR}/test19.out TEST_OUTPUT )
set_tests_properties( yaep++-test19 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Inaccessible nonterminal
add_executable( test++20 test20.cpp )
target_link_libraries( test++20 yaep++_static )
add_test( NAME yaep++-test20 COMMAND test++20 1 0 )
file( READ ${TEST_DATA_DIR}/test20.out TEST_OUTPUT )
set_tests_properties( yaep++-test20 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Use of "error" as name
add_executable( test++21 test21.cpp )
target_link_libraries( test++21 yaep++_static )
add_test( NAME yaep++-test21 COMMAND test++21 1 0 )
file( READ ${TEST_DATA_DIR}/test21.out TEST_OUTPUT )
set_tests_properties( yaep++-test21 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Use of "$n" as name
add_executable( test++22 test22.cpp )
target_link_libraries( test++22 yaep++_static )
add_test( NAME yaep++-test22 COMMAND test++22 1 0 )
file( READ ${TEST_DATA_DIR}/test22.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test22 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Use of "$eof" as name
add_executable( test++23 test23.cpp )
target_link_libraries( test++23 yaep++_static )
add_test( NAME yaep++-test23 COMMAND test++23 1 0 )
file( READ ${TEST_DATA_DIR}/test23.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test23 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Repeated definition of terminal
add_executable( test++24 test24.cpp )
target_link_libraries( test++24 yaep++_static )
add_test( NAME yaep++-test24 COMMAND test++24 1 0 )
file( READ ${TEST_DATA_DIR}/test24.out TEST_OUTPUT )
set_tests_properties( yaep++-test24 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Negative terminal code
add_executable( test++25 test25.cpp )
target_link_libraries( test++25 yaep++_static )
add_test( NAME yaep++-test25 COMMAND test++25 1 0 )
file( READ ${TEST_DATA_DIR}/test25.out TEST_OUTPUT )
set_tests_properties( yaep++-test25 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# incorrect translation
add_executable( test++26 test26.cpp )
target_link_libraries( test++26 yaep++_static )
add_test( NAME yaep++-test26 COMMAND test++26 1 0 )
file( READ ${TEST_DATA_DIR}/test26.out TEST_OUTPUT )
set_tests_properties( yaep++-test26 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# error recovery
add_executable( test++27 test27.cpp )
target_link_libraries( test++27 yaep++_static )
add_test( NAME yaep++-test27 COMMAND test++27 1 0 )
file( READ ${TEST_DATA_DIR}/test27.out TEST_OUTPUT )
set_tests_properties( yaep++-test27 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

add_executable( test++28 test28.cpp )
target_link_libraries( test++28 yaep++_static )
add_test( NAME yaep++-test28a COMMAND test++28 1 2 )
add_test( NAME yaep++-test28b COMMAND test++28 0 2 )
add_test( NAME yaep++-test28c COMMAND test++28 2 2 )
file( READ ${TEST_DATA_DIR}/test28.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test28a yaep++-test28b yaep++-test28c PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test++29 test29.cpp )
target_link_libraries( test++29 yaep++_static )
add_test( NAME yaep++-test29a COMMAND test++29 1 2 )
add_test( NAME yaep++-test29b COMMAND test++29 0 2 )
add_test( NAME yaep++-test29c COMMAND test++29 2 2 )
file( READ ${TEST_DATA_DIR}/test29.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test29a yaep++-test29b yaep++-test29c PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# ambiguous grammar
add_executable( test++30 test30.cpp )
target_link_libraries( test++30 yaep++_static )
add_test( NAME yaep++-test30 COMMAND test++30 1 2 )
file( READ ${TEST_DATA_DIR}/test30.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test30 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test++31 test31.cpp )
target_link_libraries( test++31 yaep++_static )
add_test( NAME yaep++-test31 COMMAND test++31 1 2 )
file( READ ${TEST_DATA_DIR}/test31.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test31 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# ambiguous grammar with error recovery
add_executable( test++32 test32.cpp )
target_link_libraries( test++32 yaep++_static )
add_test( NAME yaep++-test32 COMMAND test++32 1 2 )
file( READ ${TEST_DATA_DIR}/test32.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test32 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test++33 test33.cpp )
target_link_libraries( test++33 yaep++_static )
add_test( NAME yaep++-test33 COMMAND test++33 1 2 )
file( READ ${TEST_DATA_DIR}/test33.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test33 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test++34 test34.cpp )
target_link_libraries( test++34 yaep++_static )
add_test( NAME yaep++-test34 COMMAND test++34 1 2 )
file( READ ${TEST_DATA_DIR}/test34.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test34 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# error without error recovery
add_executable( test++35 test35.cpp )
target_link_libraries( test++35 yaep++_static )
add_test( NAME yaep++-test35 COMMAND test++35 1 2 0 )
file( READ ${TEST_DATA_DIR}/test35.out TEST_OUTPUT )
set_tests_properties( yaep++-test35 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# error recovery with two errors
add_executable( test++36 test36.cpp )
target_link_libraries( test++36 yaep++_static )
add_test( NAME yaep++-test36 COMMAND test++36 1 2 )
file( READ ${TEST_DATA_DIR}/test36.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test36 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test++37 test37.cpp )
target_link_libraries( test++37 yaep++_static )
add_test( NAME yaep++-test37 COMMAND test++37 1 2 )
file( READ ${TEST_DATA_DIR}/test37.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test37 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# error recovery with two errors; another description syntax
add_executable( test++38 test38.cpp )
target_link_libraries( test++38 yaep++_static )
add_test( NAME yaep++-test38 COMMAND test++38 1 2 )
file( READ ${TEST_DATA_DIR}/test38.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test38 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# more ambiguous grammar
add_executable( test++39 test39.cpp )
target_link_libraries( test++39 yaep++_static )
add_test( NAME yaep++-test39 COMMAND test++39 1 2 )
file( READ ${TEST_DATA_DIR}/test39.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test39 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test++40 test40.cpp )
target_link_libraries( test++40 yaep++_static )
add_test( NAME yaep++-test40 COMMAND test++40 1 2 )
file( READ ${TEST_DATA_DIR}/test40.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test40 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# Big ANSI-C test
find_program( SHELL bash )
if( FLEX_FOUND AND NOT ( SHELL STREQUAL "SHELL-NOTFOUND" ) )
	add_executable( test++41
		test41.cpp
	)
	add_dependencies( test++41 ansic_c )
	target_link_libraries( test++41
		yaep++_static
		ticker++
	)
	add_test( yaep++-test41 ${SHELL} -c "${CMAKE_CURRENT_BINARY_DIR}/test++41 1 0 < ${TEST_DATA_DIR}/test.i" )
endif()

# ambiguous grammar with empty nodes
add_executable( test++42 test42.cpp )
target_link_libraries( test++42 yaep++_static )
add_test( NAME yaep++-test42 COMMAND test++42 1 2 )
file( READ ${TEST_DATA_DIR}/test42.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test42 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test++43 test43.cpp )
target_link_libraries( test++43 yaep++_static )
add_test( NAME yaep++-test43 COMMAND test++43 1 2 )
file( READ ${TEST_DATA_DIR}/test43.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test43 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# negative cost
add_executable( test++44 test44.cpp )
target_link_libraries( test++44 yaep++_static )
add_test( NAME yaep++-test44 COMMAND test++44 1 0 )
file( READ ${TEST_DATA_DIR}/test44.out TEST_OUTPUT )
set_tests_properties( yaep++-test44 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# ambiguous grammar with cost and one parse tree
add_executable( test++45 test45.cpp )
target_link_libraries( test++45 yaep++_static )
add_test( NAME yaep++-test45 COMMAND test++45 1 2 )
file( READ ${TEST_DATA_DIR}/test45.rout TEST_OUTPUT )
set_tests_properties( yaep++-test45 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# ambiguous grammar with cost and several parse trees
add_executable( test++46 test46.cpp )
target_link_libraries( test++46 yaep++_static )
add_test( NAME yaep++-test46 COMMAND test++46 1 2 )
file( READ ${TEST_DATA_DIR}/test46.rout TEST_OUTPUT )
set_tests_properties( yaep++-test46 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# ambiguous grammar with cost and one parse tree and freeing
add_executable( test++47 test47.cpp )
target_link_libraries( test++47 yaep++_static )
add_test( NAME yaep++-test47 COMMAND test++47 1 2 )
file( READ ${TEST_DATA_DIR}/test47.rout TEST_OUTPUT )
set_tests_properties( yaep++-test47 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

add_executable( test++48 test48.cpp )
target_link_libraries( test++48 yaep++_static )
add_test( NAME yaep++-test48 COMMAND test++48 1 2 )
file( READ ${TEST_DATA_DIR}/test48.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test48 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# unambigous grammar abstract node for an empty rule
add_executable( test++49 test49.cpp )
target_link_libraries( test++49 yaep++_static )
add_test( NAME yaep++-test49 COMMAND test++49 1 2 )
file( READ ${TEST_DATA_DIR}/test49.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep++-test49 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# UTF-8 Support Test
add_executable( test++_utf8 test_utf8.cpp )
target_link_libraries( test++_utf8 yaep++_static )
add_test( NAME yaep++-test-utf8 COMMAND test++_utf8 )
set_tests_properties( yaep++-test-utf8 PROPERTIES PASS_REGULAR_EXPRESSION "All UTF-8 tests passed" )

# Invalid UTF-8 validation test
add_executable( test++_utf8_invalid test_utf8_invalid.cpp )
target_link_libraries( test++_utf8_invalid yaep++_static )
add_test( NAME yaep++-test-utf8-invalid COMMAND test++_utf8_invalid )

# Non-BMP UTF-8 handling (C++ test)
add_executable( test++_utf8_nonbmp test_utf8_nonbmp.cpp )
target_link_libraries( test++_utf8_nonbmp yaep++_static )
add_test( NAME yaep++-test-utf8-nonbmp COMMAND test++_utf8_nonbmp )
