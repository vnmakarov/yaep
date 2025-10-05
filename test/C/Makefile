#
#   FILE NAME:   Makefile
#
#   TITLE:       Makefile to test YAEP (Yet Another Earley Parser) C interface
#
#   Copyright (c) 1997-2018  Vladimir Makarov <vmakarov@gcc.gnu.org>
#
#   Permission is hereby granted, free of charge, to any person obtaining a
#   copy of this software and associated documentation files (the
#   "Software"), to deal in the Software without restriction, including
#   without limitation the rights to use, copy, modify, merge, publish,
#   distribute, sublicense, and/or sell copies of the Software, and to
#   permit persons to whom the Software is furnished to do so, subject to
#   the following conditions:
#
#   The above copyright notice and this permission notice shall be included
#   in all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

CC = gcc
CFLAGS = -g  -Ofast $(OPTIONS) -DNDEBUG 

srcdir = .
top_srcdir = ../..

Clibrary = ../../src/libyaep.a
YAEP_TEST = ../../src/yaep_test

all: test01 test02 test03 test04 test05 test06 test07 test08 test09\
     test10 test11 test12 test13 test14 test15 test16 test17 test18 test19\
     test20 test21 test22 test23 test24 test25 test26 test27 test28 test29\
     test30 test31 test32 test33 test34 test35 test36 test37 test38 test39\
     test40 test41 test42 test43 test44 test45 test46 test47 test48 test49

test01:
	@ $(YAEP_TEST) 1 1 0 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@.out | tr -d '\n'`" && echo $@: ok || echo $@: FAIL
	@ $(YAEP_TEST) 0 1 0 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@a.out | tr -d '\n'`" && echo $@a: ok || echo $@a: FAIL

test02:
	@ $(YAEP_TEST) 1 1 1 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@.out | tr -d '\n'`.*collisions.*$$" && echo $@: ok || echo $@: FAIL
	@ $(YAEP_TEST) 0 1 1 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@a.out | tr -d '\n'`.*collisions.*$$" && echo $@a: ok || echo $@a: FAIL

test03:
	@ $(YAEP_TEST) 1 0 1 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@.out | tr -d '\n'`.*collisions.*$$" && echo $@: ok || echo $@: FAIL
	@ $(YAEP_TEST) 0 0 1 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@a.out | tr -d '\n'`.*collisions.*$$" && echo $@a: ok || echo $@a: FAIL
	@ $(YAEP_TEST) 0 -1 1 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@b.out | tr -d '\n'`.*collisions.*$$" && echo $@b: ok || echo $@a: FAIL

test04:
	@ $(YAEP_TEST) 1 2 1 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@.out | tr -d '\n'`.*collisions.*$$" && echo $@: ok || echo $@: FAIL
	@ $(YAEP_TEST) 0 2 0 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@a.out | tr -d '\n'`$$" && echo $@a: ok || echo $@a: FAIL
	@ $(YAEP_TEST) 0 3 0 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@b.out | tr -d '\n'`$$" && echo $@b: ok || echo $@a: FAIL

test05:
	@ $(YAEP_TEST) 1 1 2 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@.out | tr -d '\n'`.*collisions.*$$" && echo $@: ok || echo $@: FAIL
	@ $(YAEP_TEST) 0 1 2 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@a.out | tr -d '\n'`.*collisions.*$$" && echo $@a: ok || echo $@a: FAIL

test06 test07 test08 test09 test10 test11 test12 test13 test14 test15 test16 test17 test18 test19\
    test20 test21 test22 test23 test24 test25 test26 test27 test44:
	@ $(CC) $(CFLAGS) -I$(top_srcdir)/src $(srcdir)/$@.c $(Clibrary) -o $@.bin && ./$@.bin 1 0 2>&1 | cmp - $(srcdir)/../$@.out && echo $@: ok || echo $@: FAIL

test28 test29:
	@ $(CC) $(CFLAGS) -I$(top_srcdir)/src $(srcdir)/$@.c $(Clibrary) -o $@.bin
	@ ./$@.bin 1 2 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@.out | tr -d '\n'`" && echo $@a: ok || echo $@a: FAIL
	@ ./$@.bin 0 2 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@.out | tr -d '\n'`" && echo $@b: ok || echo $@b: FAIL
	@ ./$@.bin 2 2 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@.out | tr -d '\n'`" && echo $@c: ok || echo $@c: FAIL

test30 test31 test32 test33 test34 test36 test37 test38 test39 test40 test42 test43 test48 test49 :
	@ $(CC) $(CFLAGS) -I$(top_srcdir)/src $(srcdir)/$@.c $(Clibrary) -o $@.bin
	@ ./$@.bin 1 2 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@.out | tr -d '\n'`" && echo $@: ok || echo $@: FAIL

test35 :
	@ $(CC) $(CFLAGS) -I$(top_srcdir)/src $(srcdir)/$@.c $(Clibrary) -o $@.bin
	@ ./$@.bin 1 2 0 2>&1 | tr -d '\n' | grep -q "^`cat $(srcdir)/../$@.out | tr -d '\n'`" && echo $@: ok || echo $@: FAIL

../ansic.c: $(top_srcdir)/test/ansic.l
	@-flex -o $@ $<

test41: ../ansic.c
	@ if test -f ../ansic.c; then \
	   $(CC) $(CFLAGS) -I. -I.. -I$(top_srcdir)/src -I$(srcdir)/.. $(srcdir)/../ticker.c $(srcdir)/$@.c $(Clibrary) -o $@.bin; \
	   echo -n $@: Big C parsing test '-- '; ./$@.bin 1 0 < $(srcdir)/../test.i && echo $@: ok || echo $@: FAIL; \
	else \
	   echo $@: 'skipped (ansic.c is absent probably because flex is absent)'; \
	fi
	
test45 test46 test47:
	@ $(CC) $(CFLAGS) -I$(top_srcdir)/src $(srcdir)/$@.c $(Clibrary) -o $@.bin
	@ ./$@.bin 1 2 2>&1 | tr -d '\n' | grep -Eq "^`cat $(srcdir)/../$@.rout|tr -d '\n'`$$" && echo $@: ok || echo $@: FAIL

clean:
	rm -f *.bin ../ansic.c

realclean: clean

distclean: clean
