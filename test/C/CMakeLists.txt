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
add_test( NAME yaep-test01 COMMAND yaep_test 1 1 0 )
file( READ ${TEST_DATA_DIR}/test01.out TEST_OUTPUT )
set_tests_properties( yaep-test01 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

add_test( NAME yaep-test01a COMMAND yaep_test 0 1 0 )
file( READ ${TEST_DATA_DIR}/test01a.out TEST_OUTPUT )
set_tests_properties( yaep-test01a PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Static lookahead
add_test( NAME yaep-test02 COMMAND yaep_test 1 1 1 )
file( READ ${TEST_DATA_DIR}/test02.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test02 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

add_test( NAME yaep-test02a COMMAND yaep_test 0 1 1 )
file( READ ${TEST_DATA_DIR}/test02a.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test02a PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

# No lookahead
add_test( NAME yaep-test03 COMMAND yaep_test 1 0 1 )
file( READ ${TEST_DATA_DIR}/test03.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test03 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

add_test( NAME yaep-test03a COMMAND yaep_test 0 0 1 )
file( READ ${TEST_DATA_DIR}/test03a.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test03a PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

add_test( NAME yaep-test03b COMMAND yaep_test 0 -1 1 )
file( READ ${TEST_DATA_DIR}/test03b.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test03b PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

# Dynamic lookahead
add_test( NAME yaep-test04 COMMAND yaep_test 1 2 1 )
file( READ ${TEST_DATA_DIR}/test04.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test04 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

add_test( NAME yaep-test04a COMMAND yaep_test 0 2 0 )
file( READ ${TEST_DATA_DIR}/test04a.out TEST_OUTPUT )
set_tests_properties( yaep-test04a PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

add_test( NAME yaep-test04b COMMAND yaep_test 0 3 0 )
file( READ ${TEST_DATA_DIR}/test04b.out TEST_OUTPUT )
set_tests_properties( yaep-test04b PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Debug level 2
add_test( NAME yaep-test05 COMMAND yaep_test 1 1 2 )
file( READ ${TEST_DATA_DIR}/test05.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test05 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

add_test( NAME yaep-test05a COMMAND yaep_test 0 1 2 )
file( READ ${TEST_DATA_DIR}/test05a.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test05a PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}[^\n]*collisions[^\n]*\n$" )

# Undefined or bad grammar
add_executable( test06 test06.c )
target_link_libraries( test06 yaep_static )
add_test( NAME yaep-test06 COMMAND test06 1 0 )
file( READ ${TEST_DATA_DIR}/test06.out TEST_OUTPUT )
set_tests_properties( yaep-test06 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# UTF-8 truncation test (ensures error messages are valid UTF-8 and ellipsize)
add_executable( test_utf8_truncation test_utf8_truncation.c )
target_link_libraries( test_utf8_truncation yaep_static )
add_test( NAME yaep-test-utf8-truncation COMMAND test_utf8_truncation )

# Lexer identifier UTF-8 handling unit test
add_executable( test_utf8_identifier test_utf8_identifier.c )
target_link_libraries( test_utf8_identifier yaep_static )
add_test( NAME yaep-test-utf8-identifier COMMAND test_utf8_identifier )

# Concurrent parsing smoke test (pthread)
add_executable( test_concurrent_parse test_concurrent_parse.c )
target_link_libraries( test_concurrent_parse yaep_static pthread )
add_test( NAME yaep-test-concurrent-parse COMMAND test_concurrent_parse )
set_tests_properties( yaep-test-concurrent-parse PROPERTIES DISABLED TRUE )

# Concurrent parsing test (process-based)
add_executable( test_concurrent_parse_process test_concurrent_parse_process.c )
target_link_libraries( test_concurrent_parse_process yaep_static )
add_test( NAME yaep-test-concurrent-parse-process COMMAND test_concurrent_parse_process )

# Concurrent parsing test (pthread serialized by mutex)
add_executable( test_concurrent_parse_mutex test_concurrent_parse_mutex.c )
target_link_libraries( test_concurrent_parse_mutex yaep_static pthread )
add_test( NAME yaep-test-concurrent-parse-mutex COMMAND test_concurrent_parse_mutex )
set_tests_properties( yaep-test-concurrent-parse-mutex PROPERTIES DISABLED TRUE )

# NFC normalization canonical-equivalence test
add_executable( test_utf8_normalization test_utf8_normalization.c )
target_link_libraries( test_utf8_normalization yaep_static )
add_test( NAME yaep-test-utf8-normalization COMMAND test_utf8_normalization )

# Persistence / no-allocator normalization test
add_executable( test_utf8_persistence test_utf8_persistence.c )
target_link_libraries( test_utf8_persistence yaep_static )
add_test( NAME yaep-test-utf8-persistence COMMAND test_utf8_persistence )

# Additional small UTF-8 helper tests
add_executable( test_utf8_iterator test_utf8_iterator.c )
target_link_libraries( test_utf8_iterator yaep_static )
add_test( NAME yaep-test-utf8-iterator COMMAND test_utf8_iterator )

add_executable( test_truncate_edge test_truncate_edge.c )
target_link_libraries( test_truncate_edge yaep_static )
add_test( NAME yaep-test-truncate-edge COMMAND test_truncate_edge )

# Longer truncation stress test
add_executable( test_truncate_long test_truncate_long.c )
target_link_libraries( test_truncate_long yaep_static )
add_test( NAME yaep-test-truncate-long COMMAND test_truncate_long )

# NFC canonicalization cases
add_executable( test_nfc_cases test_nfc_cases.c )
target_link_libraries( test_nfc_cases yaep_static )
add_test( NAME yaep-test-nfc-cases COMMAND test_nfc_cases )

# Hash stability tests
add_executable( test_hash_stability test_hash_stability.c )
target_link_libraries( test_hash_stability yaep_static )
add_test( NAME yaep-test-hash-stability COMMAND test_hash_stability )

# Already defined grammar
add_executable( test07 test07.c )
target_link_libraries( test07 yaep_static )
add_test( NAME yaep-test07 COMMAND test07 1 0 )
file( READ ${TEST_DATA_DIR}/test07.out TEST_OUTPUT )
set_tests_properties( yaep-test07 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Description syntax error
add_executable( test08 test08.c )
target_link_libraries( test08 yaep_static )
add_test( NAME yaep-test08 COMMAND test08 1 0 )
file( READ ${TEST_DATA_DIR}/test08.out TEST_OUTPUT )
set_tests_properties( yaep-test08 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Error in rule lhs
add_executable( test09 test09.c )
target_link_libraries( test09 yaep_static )
add_test( NAME yaep-test09 COMMAND test09 1 0 )
file( READ ${TEST_DATA_DIR}/test09.out TEST_OUTPUT )
set_tests_properties( yaep-test09 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Different codes for one terminal
add_executable( test10 test10.c )
target_link_libraries( test10 yaep_static )
add_test( NAME yaep-test10 COMMAND test10 1 0 )
file( READ ${TEST_DATA_DIR}/test10.out TEST_OUTPUT )
set_tests_properties( yaep-test10 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Same code for different terminals
add_executable( test11 test11.c )
target_link_libraries( test11 yaep_static )
add_test( NAME yaep-test11 COMMAND test11 1 0 )
file( READ ${TEST_DATA_DIR}/test11.out TEST_OUTPUT )
set_tests_properties( yaep-test11 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# No grammar rules
add_executable( test12 test12.c )
target_link_libraries( test12 yaep_static )
add_test( NAME yaep-test12 COMMAND test12 1 0 )
file( READ ${TEST_DATA_DIR}/test12.out TEST_OUTPUT )
set_tests_properties( yaep-test12 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Terminal in lhs of rule
add_executable( test13 test13.c )
target_link_libraries( test13 yaep_static )
add_test( NAME yaep-test13 COMMAND test13 1 0 )
file( READ ${TEST_DATA_DIR}/test13.out TEST_OUTPUT )
set_tests_properties( yaep-test13 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Incorrect translation symbol number
add_executable( test14 test14.c )
target_link_libraries( test14 yaep_static )
add_test( NAME yaep-test14 COMMAND test14 1 0 )
file( READ ${TEST_DATA_DIR}/test14.out TEST_OUTPUT )
set_tests_properties( yaep-test14 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Repeated translation symbol number
add_executable( test15 test15.c )
target_link_libraries( test15 yaep_static )
add_test( NAME yaep-test15 COMMAND test15 1 0 )
file( READ ${TEST_DATA_DIR}/test15.out TEST_OUTPUT )
set_tests_properties( yaep-test15 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

add_executable( test16 test16.c )
target_link_libraries( test16 yaep_static )
add_test( NAME yaep-test16 COMMAND test16 1 0 )
file( READ ${TEST_DATA_DIR}/test16.out TEST_OUTPUT )
set_tests_properties( yaep-test16 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Nonterminal does not derive any terminal
add_executable( test17 test17.c )
target_link_libraries( test17 yaep_static )
add_test( NAME yaep-test17 COMMAND test17 1 0 )
file( READ ${TEST_DATA_DIR}/test17.out TEST_OUTPUT )
set_tests_properties( yaep-test17 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Grammar with loops
add_executable( test18 test18.c )
target_link_libraries( test18 yaep_static )
add_test( NAME yaep-test18 COMMAND test18 1 0 )
file( READ ${TEST_DATA_DIR}/test18.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test18 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Invalid token
add_executable( test19 test19.c )
target_link_libraries( test19 yaep_static )
add_test( NAME yaep-test19 COMMAND test19 1 0 )
file( READ ${TEST_DATA_DIR}/test19.out TEST_OUTPUT )
set_tests_properties( yaep-test19 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Inaccessible nonterminal
add_executable( test20 test20.c )
target_link_libraries( test20 yaep_static )
add_test( NAME yaep-test20 COMMAND test20 1 0 )
file( READ ${TEST_DATA_DIR}/test20.out TEST_OUTPUT )
set_tests_properties( yaep-test20 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Use of "error" as name
add_executable( test21 test21.c )
target_link_libraries( test21 yaep_static )
add_test( NAME yaep-test21 COMMAND test21 1 0 )
file( READ ${TEST_DATA_DIR}/test21.out TEST_OUTPUT )
set_tests_properties( yaep-test21 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Use of "$n" as name
add_executable( test22 test22.c )
target_link_libraries( test22 yaep_static )
add_test( NAME yaep-test22 COMMAND test22 1 0 )
file( READ ${TEST_DATA_DIR}/test22.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test22 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Use of "$eof" as name
add_executable( test23 test23.c )
target_link_libraries( test23 yaep_static )
add_test( NAME yaep-test23 COMMAND test23 1 0 )
file( READ ${TEST_DATA_DIR}/test23.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test23 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Repeated definition of terminal
add_executable( test24 test24.c )
target_link_libraries( test24 yaep_static )
add_test( NAME yaep-test24 COMMAND test24 1 0 )
file( READ ${TEST_DATA_DIR}/test24.out TEST_OUTPUT )
set_tests_properties( yaep-test24 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# Negative terminal code
add_executable( test25 test25.c )
target_link_libraries( test25 yaep_static )
add_test( NAME yaep-test25 COMMAND test25 1 0 )
file( READ ${TEST_DATA_DIR}/test25.out TEST_OUTPUT )
set_tests_properties( yaep-test25 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# incorrect translation
add_executable( test26 test26.c )
target_link_libraries( test26 yaep_static )
add_test( NAME yaep-test26 COMMAND test26 1 0 )
file( READ ${TEST_DATA_DIR}/test26.out TEST_OUTPUT )
set_tests_properties( yaep-test26 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# error recovery
add_executable( test27 test27.c )
target_link_libraries( test27 yaep_static )
add_test( NAME yaep-test27 COMMAND test27 1 0 )
file( READ ${TEST_DATA_DIR}/test27.out TEST_OUTPUT )
set_tests_properties( yaep-test27 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

add_executable( test28 test28.c )
target_link_libraries( test28 yaep_static )
add_test( NAME yaep-test28a COMMAND test28 1 2 )
add_test( NAME yaep-test28b COMMAND test28 0 2 )
add_test( NAME yaep-test28c COMMAND test28 2 2 )
file( READ ${TEST_DATA_DIR}/test28.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test28a yaep-test28b yaep-test28c PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test29 test29.c )
target_link_libraries( test29 yaep_static )
add_test( NAME yaep-test29a COMMAND test29 1 2 )
add_test( NAME yaep-test29b COMMAND test29 0 2 )
add_test( NAME yaep-test29c COMMAND test29 2 2 )
file( READ ${TEST_DATA_DIR}/test29.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test29a yaep-test29b yaep-test29c PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# ambiguous grammar
add_executable( test30 test30.c )
target_link_libraries( test30 yaep_static )
add_test( NAME yaep-test30 COMMAND test30 1 2 )
file( READ ${TEST_DATA_DIR}/test30.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test30 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test31 test31.c )
target_link_libraries( test31 yaep_static )
add_test( NAME yaep-test31 COMMAND test31 1 2 )
file( READ ${TEST_DATA_DIR}/test31.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test31 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# ambiguous grammar with error recovery
add_executable( test32 test32.c )
target_link_libraries( test32 yaep_static )
add_test( NAME yaep-test32 COMMAND test32 1 2 )
file( READ ${TEST_DATA_DIR}/test32.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test32 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test33 test33.c )
target_link_libraries( test33 yaep_static )
add_test( NAME yaep-test33 COMMAND test33 1 2 )
file( READ ${TEST_DATA_DIR}/test33.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test33 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test34 test34.c )
target_link_libraries( test34 yaep_static )
add_test( NAME yaep-test34 COMMAND test34 1 2 )
file( READ ${TEST_DATA_DIR}/test34.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test34 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# error without error recovery
add_executable( test35 test35.c )
target_link_libraries( test35 yaep_static )
add_test( NAME yaep-test35 COMMAND test35 1 2 0 )
file( READ ${TEST_DATA_DIR}/test35.out TEST_OUTPUT )
set_tests_properties( yaep-test35 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# error recovery with two errors
add_executable( test36 test36.c )
target_link_libraries( test36 yaep_static )
add_test( NAME yaep-test36 COMMAND test36 1 2 )
file( READ ${TEST_DATA_DIR}/test36.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test36 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test37 test37.c )
target_link_libraries( test37 yaep_static )
add_test( NAME yaep-test37 COMMAND test37 1 2 )
file( READ ${TEST_DATA_DIR}/test37.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test37 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# error recovery with two errors; another description syntax
add_executable( test38 test38.c )
target_link_libraries( test38 yaep_static )
add_test( NAME yaep-test38 COMMAND test38 1 2 )
file( READ ${TEST_DATA_DIR}/test38.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test38 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# more ambiguous grammar
add_executable( test39 test39.c )
target_link_libraries( test39 yaep_static )
add_test( NAME yaep-test39 COMMAND test39 1 2 )
file( READ ${TEST_DATA_DIR}/test39.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test39 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test40 test40.c )
target_link_libraries( test40 yaep_static )
add_test( NAME yaep-test40 COMMAND test40 1 2 )
file( READ ${TEST_DATA_DIR}/test40.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test40 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# Big ANSI-C test
find_program( SHELL bash )
if( FLEX_FOUND AND NOT ( SHELL STREQUAL "SHELL-NOTFOUND" ) )
	add_executable( test41 test41.c )
	add_dependencies( test41 ansic_c )
	target_link_libraries( test41
		yaep_static
		ticker
	)
	add_test( yaep-test41 ${SHELL} -c "${CMAKE_CURRENT_BINARY_DIR}/test41 1 0 < ${TEST_DATA_DIR}/test.i" )
endif()

# ambiguous grammar with empty nodes
add_executable( test42 test42.c )
target_link_libraries( test42 yaep_static )
add_test( NAME yaep-test42 COMMAND test42 1 2 )
file( READ ${TEST_DATA_DIR}/test42.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test42 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

add_executable( test43 test43.c )
target_link_libraries( test43 yaep_static )
add_test( NAME yaep-test43 COMMAND test43 1 2 )
file( READ ${TEST_DATA_DIR}/test43.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test43 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# negative cost
add_executable( test44 test44.c )
target_link_libraries( test44 yaep_static )
add_test( NAME yaep-test44 COMMAND test44 1 0 )
file( READ ${TEST_DATA_DIR}/test44.out TEST_OUTPUT )
set_tests_properties( yaep-test44 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# ambiguous grammar with cost and one parse tree
add_executable( test45 test45.c )
target_link_libraries( test45 yaep_static )
add_test( NAME yaep-test45 COMMAND test45 1 2 )
file( READ ${TEST_DATA_DIR}/test45.rout TEST_OUTPUT )
set_tests_properties( yaep-test45 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# ambiguous grammar with cost and several parse trees
add_executable( test46 test46.c )
target_link_libraries( test46 yaep_static )
add_test( NAME yaep-test46 COMMAND test46 1 2 )
file( READ ${TEST_DATA_DIR}/test46.rout TEST_OUTPUT )
set_tests_properties( yaep-test46 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

# ambiguous grammar with cost and one parse tree and freeing
add_executable( test47 test47.c )
target_link_libraries( test47 yaep_static )
add_test( NAME yaep-test47 COMMAND test47 1 2 )
file( READ ${TEST_DATA_DIR}/test47.rout TEST_OUTPUT )
set_tests_properties( yaep-test47 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}$" )

add_executable( test48 test48.c )
target_link_libraries( test48 yaep_static )
add_test( NAME yaep-test48 COMMAND test48 1 2 )
file( READ ${TEST_DATA_DIR}/test48.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test48 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# unambigous grammar abstract node for an empty rule
add_executable( test49 test49.c )
target_link_libraries( test49 yaep_static )
add_test( NAME yaep-test49 COMMAND test49 1 2 )
file( READ ${TEST_DATA_DIR}/test49.out TEST_OUTPUT )
rescape( TEST_OUTPUT "${TEST_OUTPUT}" )
set_tests_properties( yaep-test49 PROPERTIES PASS_REGULAR_EXPRESSION "^${TEST_OUTPUT}" )

# UTF-8 Support Test
add_executable( test_utf8 test_utf8.c )
target_link_libraries( test_utf8 yaep_static )
add_test( NAME yaep-test-utf8 COMMAND test_utf8 )
set_tests_properties( yaep-test-utf8 PROPERTIES PASS_REGULAR_EXPRESSION "All UTF-8 tests passed" )

# Simple UTF-8 debugging test
add_executable( test_utf8_simple test_utf8_simple.c )
target_link_libraries( test_utf8_simple yaep_static )
add_test( NAME yaep-test-utf8-simple COMMAND test_utf8_simple )

# Double grammar test
add_executable( test_utf8_double test_utf8_double.c )
target_link_libraries( test_utf8_double yaep_static )
add_test( NAME yaep-test-utf8-double COMMAND test_utf8_double )

# Invalid UTF-8 validation test
add_executable( test_utf8_invalid test_utf8_invalid.c )
target_link_libraries( test_utf8_invalid yaep_static )
add_test( NAME yaep-test-utf8-invalid COMMAND test_utf8_invalid )
