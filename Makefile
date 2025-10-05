#
#   FILE NAME:   Makefile
#
#   TITLE:       Makefile for work with YAEP (Yet Another Earley Parser)
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
#   SPECIAL CONSIDERATION: Following makefile macro can be redefined
#        on make command line:
#            distdir      the subdirectory used for creation of compressed
#                         distribution tar file
#            prefix       common prefix for installation directories
#            exec_prefix  common prefix for binary installation directories
#            libdir       the directory used for installation of the library
#            includedir   the directory used for installation header files
#            INSTALL      utility used fort installing executables
#            INSTALLDATA  utility used fort installing nonexecutables
#            AWK          utility used instead of POSIX utility `awk'
#            SED          utility used instead of POSIX utility `sed'
#            ETAGS        utility used for creation of reusable packages tag
#                         table
#            CC           used C compiler
#            CFLAGS       C compiler flags
#            CXX          used C++ compiler
#            CXXFLAGS     C++ compiler flags
#            RANLIB       utility for conversion of archives to random
#                         libraries
#            AR           utility for creation of archives
#
#   MAKEFILE ENTRIES:
#            all (default)   create all object files
#            test            test YAEP
#            install         create and install the library of reusable
#                            functions, header files, and its man pages
#            uninstall       delete the installed file
#            clean           delete all object files
#            realclean       delete all which can be built up automatically
#            distclean       delete all not needed for distribution
#            TAGS            updating TAGS table for the packages sources
#            dist-copy       copying distribution files into `distdir'
#            dist            unconditional creation of compressed
#                            distribution tar file
#

SHELL=/bin/sh

# The subdirectory used for copying sources and creation of 
# compressed distribution tar file.
distdir = yaep-0.997

# Common prefix for installation directories.
# NOTE: this directory must exist when you start installation.
prefix=/usr/local

# Common prefix for binary installation directories.
# NOTE: this directory must exist when you start installation.
exec_prefix=${prefix}

# The directory for installation of the library.
libdir=${exec_prefix}/lib

# The directory for installation of header files.
includedir=${prefix}/include/yaep

# The directory for installation of documentation
docdir=${prefix}/share/doc/${PACKAGE}/yaep

# Utility for installing executables.
INSTALL=/usr/bin/install -c

# Utility for installing nonexecutables.
INSTALLDATA=${INSTALL} -m 644

# Utility used instead of POSIX utility `awk'.
AWK=mawk

# Utility used instead of POSIX utility `sed'.
SED=sed

# Utility for creation of reusable packages tag table.
ETAGS=etags

# Obligatory compiler options
OPTIONS=-Isrc -I$(srcdir)/src \
	-Isrc/unicode -I$(srcdir)/src/unicode \
	-Ithird_party/utf8proc -I$(srcdir)/third_party/utf8proc

# C compiler and its flag used for compilation of C files.
CC = gcc
CFLAGS = -g  -Ofast $(OPTIONS) -DNDEBUG 

# C++ compiler and its flag used for compilation of C++ files.
CXX = g++
CXXFLAGS = -g  -Ofast $(OPTIONS) -DNDEBUG

# Yacc
YACC=bison -y

# Utility for conversion of archives to random libraries.
RANLIB=ranlib

# Utility for creation of archives.
AR=ar

# Directory for C object files
Cdir=src/C

# Directory for C++ object files
Cxxdir=src/C++

# Directory for C test files
Ctest=test/C

# Directory for C++ object file
Cxxtest=test/C++

# Directory for doc files
Docdir=doc

# Supporting possibility build directories

srcdir = .

top_srcdir = .

# All hand written source files of the packages.
source = $(srcdir)/src/allocate.h $(srcdir)/src/allocate.c \
	 $(srcdir)/src/vlobject.h $(srcdir)/src/vlobject.c $(srcdir)/src/vlobject.cpp\
		 $(srcdir)/src/objstack.h $(srcdir)/src/objstack.c $(srcdir)/src/objstack.cpp\
	 $(srcdir)/src/hashtab.h $(srcdir)/src/hashtab.c $(srcdir)/src/hashtab.cpp\
		 $(srcdir)/src/yaep.h $(srcdir)/src/yaep.c $(srcdir)/src/sgramm.y\
	 $(srcdir)/src/yaep.cpp $(srcdir)/src/Makefile.in $(srcdir)/src/CMakeLists.txt \
	 $(srcdir)/src/unicode/yaep_unicode.h $(srcdir)/src/unicode/yaep_unicode.c \
	 $(srcdir)/third_party/utf8proc/utf8proc.h \
	 $(srcdir)/third_party/utf8proc/utf8proc.c \
	 $(srcdir)/third_party/utf8proc/utf8proc_data.c \
	 $(srcdir)/third_party/utf8proc/CMakeLists.txt

additional_files = README.md LICENSE install-sh Makefile.in CMakeLists.txt configure.ac configure

doc_files = CMakeLists.txt Makefile.in yaep.txt yaep.info* yaep.html yaep-*.html\
            yaep.pdf yaep.dvi yaep.ps\
            yaep++.txt yaep++.info* yaep++.html yaep++-*.html\
            yaep++.pdf yaep++.dvi yaep++.ps Internals.txt

test_files = CMakeLists.txt Makefile.in ansic.h ansic.l \
	 test01a.out test01.out test02a.out test02.out test03a.out test03b.out \
	 test03.out test04a.out test04b.out test04.out test05a.out test05.out \
	 test06.out test07.out test08.out test09.out test10.out test11.out \
	 test12.out test13.out test14.out test15.out test16.out test17.out \
	 test18.out test19.out test20.out test21.out test22.out test23.out \
	 test24.out test25.out test26.out test27.out test28.out test29.out \
	 test30.out test31.out test32.out test33.out test34.out test35.out \
	 test36.out test37.out test38.out test39.out test40.out test42.out \
	 test43.out test44.out test45.rout test46.rout test47.rout test48.out test49.out \
	 test.i \
	 ticker.h ticker.c ticker.cpp

test_c_files = Makefile.in CMakeLists.txt common.h \
	 test06.c test07.c test08.c test09.c test10.c test11.c test12.c test13.c test14.c \
	 test15.c test16.c test17.c test18.c test19.c test20.c test21.c test22.c test23.c \
	 test24.c test25.c test26.c test27.c test28.c test29.c test30.c test31.c test32.c \
	 test33.c test34.c test35.c test36.c test37.c test38.c test39.c test40.c test41.c \
	 test42.c test43.c test44.c test45.c test46.c test47.c test48.c test49.c

test_cpp_files = Makefile.in CMakeLists.txt common.h \
	 test06.cpp test07.cpp test08.cpp test09.cpp test10.cpp test11.cpp test12.cpp test13.cpp \
	 test14.cpp test15.cpp test16.cpp test17.cpp test18.cpp test19.cpp test20.cpp test21.cpp \
	 test22.cpp test23.cpp test24.cpp test25.cpp test26.cpp test27.cpp test28.cpp test29.cpp \
	 test30.cpp test31.cpp test32.cpp test33.cpp test34.cpp test35.cpp test36.cpp test37.cpp \
	 test38.cpp test39.cpp test40.cpp test41.cpp test42.cpp test43.cpp test44.cpp test45.cpp \
	 test46.cpp test47.cpp test48.cpp test49.cpp

test_compare_files = ansic.y test1.i test_common.c test.i test.y test_yaep.c test_yyparse.c \
		     whole_gcc_test.i CMakeLists.txt compare_parsers.sh.in

# Files which are not in distribution
additional_doc_files = yaep.sgml.in yaep_part.sgml.in\
                       yaep++.sgml.in yaep_part++.sgml.in 

# All C object files
Cobjects = $(Cdir)/allocate.o  $(Cdir)/vlobject.o  $(Cdir)/objstack.o $(Cdir)/hashtab.o \
	$(Cdir)/yaep_unicode.o $(Cdir)/utf8proc.o
Callobjects = $(Cobjects) $(Cdir)/yaep.o

# All C++ object files
Cppobjects = $(Cxxdir)/allocate.o  $(Cxxdir)/vlobject.o  $(Cxxdir)/objstack.o $(Cxxdir)/hashtab.o \
	$(Cxxdir)/yaep_unicode.o $(Cxxdir)/utf8proc.o
Cppallobjects = $(Cppobjects) $(Cxxdir)/yaep.o

# C Library
Clibrary = libyaep.a

# C++ Library
Cpplibrary = libyaep++.a

# Default entry
all: $(Cdir)  $(Cxxdir)  src/$(Clibrary)  src/$(Cpplibrary) src/yaep_test src/yaep++_test

$(Cdir):
	-mkdir -p $(Cdir)

$(Cxxdir):
	-mkdir -p $(Cxxdir)

src/$(Clibrary): $(Callobjects)
	rm -f src/$(Clibrary)
	$(AR) rc src/$(Clibrary) $(Callobjects)
	$(RANLIB) src/$(Clibrary)

$(Cxxdir)/allocate.o: $(Cxxdir) $(Cdir)/allocate.o
	cp $(Cdir)/allocate.o $(Cxxdir)

$(Cxxdir)/yaep_unicode.o: $(Cxxdir) $(Cdir)/yaep_unicode.o
	cp $(Cdir)/yaep_unicode.o $(Cxxdir)

$(Cxxdir)/utf8proc.o: $(Cxxdir) $(Cdir)/utf8proc.o
	cp $(Cdir)/utf8proc.o $(Cxxdir)

src/$(Cpplibrary): $(Cppallobjects)
	rm -f src/$(Cpplibrary)
	$(AR) rc src/$(Cpplibrary) $(Cppallobjects)
	$(RANLIB) src/$(Cpplibrary)

src/sgramm.c: $(srcdir)/src/sgramm.y
	$(YACC) $(srcdir)/src/sgramm.y
	mv y.tab.c $@

# Test the packages.
test: all test-c test-cpp test-speed

src/yaep_test: $(Cobjects)
	   $(CC) $(CFLAGS) -DYAEP_TEST -DYAEP_DEBUG $(Cobjects) $(top_srcdir)/src/yaep.c -o $@

test-c: yaep-tst
yaep-tst: src/yaep_test
	cd test/C && make

src/yaep++_test: $(Cppobjects)
	   $(CXX) $(CXXFLAGS) -DYAEP_TEST -DYAEP_DEBUG $(Cppobjects) $(top_srcdir)/src/yaep.cpp -o $@

test-cpp: yaepcpp-tst
yaepcpp-tst: src/yaep++_test
	cd test/C++ && make

test-speed:
	cd test/compare_parsers && $(SHELL) compare_parsers.sh

# Creation of installation directories and the library of reusable
# functions, header files, and their man files to target directories.
install: all
	-mkdir -p $(libdir)
	$(INSTALLDATA) src/$(Clibrary) $(libdir)/$(Clibrary)
	$(INSTALLDATA) src/$(Cpplibrary) $(libdir)/$(Cpplibrary)
	-mkdir -p $(includedir)
	$(INSTALLDATA) $(srcdir)/src/yaep.h $(includedir)/yaep.h
	-mkdir -p $(docdir)
	$(INSTALLDATA) $(srcdir)/doc/Internals.txt $(srcdir)/doc/yaep.txt\
	  $(srcdir)/doc/yaep.html  $(srcdir)/doc/yaep-*.html\
          $(srcdir)/doc/yaep.info* $(srcdir)/doc/yaep.pdf\
          $(srcdir)/doc/yaep.dvi $(srcdir)/doc/yaep.ps\
          $(srcdir)/doc/yaep++.txt $(srcdir)/doc/yaep++.html $(srcdir)/doc/yaep++-*.html\
          $(srcdir)/doc/yaep++.info* $(srcdir)/doc/yaep++.pdf\
          $(srcdir)/doc/yaep++.dvi $(srcdir)/doc/yaep++.ps\
          $(docdir)

# Delete the installed files and the installation directories.
uninstall:
	rm -f $(libdir)/$(Clibrary)
	rm -f $(libdir)/$(Cpplibrary)
	-rmdir $(libdir)
	rm -f $(includedir)/yaep.h
	-rmdir $(includedir)
	rm -f $(docdir)/yaep.txt \
          $(docdir)/yaep.html\
          $(docdir)/yaep-*.html\
          $(docdir)/yaep.info*\
          $(docdir)/yaep.pdf\
          $(docdir)/yaep.dvi\
          $(docdir)/yaep.ps\
          $(docdir)/yaep++.txt\
          $(docdir)/yaep++.html\
          $(docdir)/yaep++-*.html\
          $(docdir)/yaep++.info*\
          $(docdir)/yaep++.pdf\
          $(docdir)/yaep++.dvi\
          $(docdir)/yaep++.ps
	-rmdir $(docdir)

# Delete all temporary files and the libraries.
clean:
	rm -f $(Callobjects) src/$(Clibrary) $(Cppallobjects) src/$(Cpplibrary) src/yaep_test src/yaep++_test
	cd test/C && make clean
	cd test/C++ && make clean
	rm -rf $(distdir) $(distdir).tar.gz

# Delete all which can be built up automatically.
realclean: distclean
	rm -f TAGS

# Delete all not needed for distribution.
distclean: clean
	rm -f src/sgramm.c
	rm -f $(Docdir)/yaep.sgml $(Docdir)/yaep.tex $(Docdir)/yaep.log\
              $(Docdir)/yaep.aux $(Docdir)/yaep.toc
	rm -f $(Docdir)/yaep++.sgml $(Docdir)/yaep++.tex $(Docdir)/yaep++.log\
	      $(Docdir)/yaep++.aux $(Docdir)/yaep++.toc\
              $(Docdir)/yaep.sgml $(Docdir)/yaep.tmp\
              $(Docdir)/yaep++.sgml $(Docdir)/yaep++.tmp
	cd test/C && make distclean
	cd test/C++ && make distclean

# Updating TAGS table for reusable packages sources.
TAGS : $(source)
	$(ETAGS) $(source)

# Ouput names of TAGS table for the reusable packages sources.
tagsout : $(source)
	for i in $(source);do\
	  echo `basename $$i`;\
	done

# Create empty subdirectory used for creation of compressed distribution
# tar file.
create-distdir:
	-mkdir $(distdir)
	rm -f -r $(distdir)/*
	mkdir $(distdir)/src
	mkdir $(distdir)/doc
	mkdir $(distdir)/test
	mkdir $(distdir)/test/C
	mkdir $(distdir)/test/C++
	mkdir $(distdir)/test/compare_parsers
	mkdir $(distdir)/third_party

# Copying distribution files into `distdir'.
dist-copy: create-distdir
	for i in $(additional_files);do cp $(srcdir)/$$i $(distdir);done
	for i in $(source);do \
		rel=$${i#$(srcdir)/}; \
		dir=`dirname $$rel`; \
		if test "$$dir" != "."; then mkdir -p "$(distdir)/$$dir"; fi; \
		cp $$i "$(distdir)/$$rel"; \
	done
	for i in $(doc_files);do cp $(srcdir)/doc/$$i $(distdir)/doc;done
	for i in $(test_files);do cp $(srcdir)/test/$$i $(distdir)/test;done
	for i in $(test_c_files);do cp $(srcdir)/test/C/$$i $(distdir)/test/C;done
	for i in $(test_cpp_files);do cp $(srcdir)/test/C++/$$i $(distdir)/test/C++;done
	for i in $(test_compare_files);do cp $(srcdir)/test/compare_parsers/$$i $(distdir)/test/compare_parsers;done
	chmod -R +w $(distdir)

# Unconditional creation of compressed distribution tar file.
dist: dist-copy
	tar cf -  $(distdir) | gzip -c >$(distdir).tar.gz

# Creation of documentation

doc: $(Docdir)/yaep.sgml $(Docdir)/yaep++.sgml\
     $(srcdir)/doc/yaep.txt $(srcdir)/doc/yaep.html\
     $(srcdir)/doc/yaep.info $(srcdir)/doc/yaep.pdf\
     $(srcdir)/doc/yaep.dvi $(srcdir)/doc/yaep.ps\
     $(srcdir)/doc/yaep++.txt $(srcdir)/doc/yaep++.html\
     $(srcdir)/doc/yaep++.info $(srcdir)/doc/yaep++.pdf\
     $(srcdir)/doc/yaep++.dvi $(srcdir)/doc/yaep++.ps

doc/yaep.sgml: $(srcdir)/doc/yaep.sgml.in $(srcdir)/doc/yaep_part.sgml.in
	$(AWK) "{if(\$$0 == \"%%%\")\
                     {while ((getline line < \"$(srcdir)/doc/yaep_part.sgml.in\") > 0)\
                        print line;close(\"$(srcdir)/doc/yaep_part.sgml.in\")}\
                 else print;}" $(srcdir)/doc/yaep.sgml.in > $@

$(srcdir)/doc/yaep.txt: $(Docdir)/yaep.sgml
	linuxdoc -B txt --papersize=letter -f $(Docdir)/yaep.sgml
	mv yaep.txt $(srcdir)
	
$(srcdir)/doc/yaep.html: $(Docdir)/yaep.sgml
	linuxdoc -B html --papersize=letter $(Docdir)/yaep.sgml
	if test -f yaep-1.html;then\
  	  for i in yaep-*.html;do\
   	    mv $$i $(srcdir)/doc/$$i;\
	  done;\
        fi
	mv yaep.html $(srcdir)/doc/yaep.html
	
$(srcdir)/doc/yaep.info: $(Docdir)/yaep.sgml
	linuxdoc -B info --papersize=letter $(Docdir)/yaep.sgml
	if test -f yaep.info;then\
	  for i in yaep.info*;do\
   	    mv $$i $(srcdir)/doc/$$i;\
	  done;\
        fi
	
$(srcdir)/doc/yaep.dvi: $(Docdir)/yaep.sgml
	linuxdoc -B latex --papersize=letter $(Docdir)/yaep.sgml
	if test ! -f yaep.dvi\
           -o -f yaep.tex -a yaep.tex -nt yaep.dvi; then\
    	        latex yaep.tex; latex yaep.tex;\
        fi
	mv yaep.dvi $(srcdir)/doc/yaep.dvi

$(srcdir)/doc/yaep.ps: $(srcdir)/doc/yaep.dvi
	dvips -o $@ $(srcdir)/doc/yaep.dvi

$(srcdir)/doc/yaep.pdf: $(srcdir)/doc/yaep.ps
	ps2pdf $(srcdir)/doc/yaep.ps $@

doc/yaep++.sgml: $(srcdir)/doc/yaep++.sgml.in $(srcdir)/doc/yaep_part++.sgml.in
	$(AWK) "{if(\$$0 == \"%%%\")\
                     {while ((getline line < \"$(srcdir)/doc/yaep_part++.sgml.in\") > 0)\
                        print line;close(\"$(srcdir)/doc/yaep_part++.sgml.in\")}\
                 else print;}" $(srcdir)/doc/yaep++.sgml.in > $@

$(srcdir)/doc/yaep++.txt: $(Docdir)/yaep++.sgml
	linuxdoc -B txt --papersize=letter -f $(Docdir)/yaep++.sgml
	mv yaep++.txt $(srcdir)

$(srcdir)/doc/yaep++.html: $(Docdir)/yaep++.sgml
	linuxdoc -B html --papersize=letter $(Docdir)/yaep++.sgml
	if test -f yaep++-1.html;then\
  	  for i in yaep++-*.html;do\
   	    mv $$i $(srcdir)/doc/$$i;\
	  done;\
        fi
	mv yaep++.html $(srcdir)/doc/yaep++.html
	
$(srcdir)/doc/yaep++.info: $(Docdir)/yaep++.sgml
	linuxdoc -B info --papersize=letter $(Docdir)/yaep++.sgml
	if test -f yaep++.info;then\
	  for i in yaep++.info*;do\
   	    mv $$i $(srcdir)/doc/$$i;\
	  done;\
        fi
	
$(srcdir)/doc/yaep++.dvi: $(Docdir)/yaep++.sgml
	linuxdoc -B latex --papersize=letter $(Docdir)/yaep++.sgml
	if test ! -f yaep++.dvi\
           -o -f yaep++.tex -a yaep++.tex -nt yaep++.dvi; then\
    	        latex yaep++.tex; latex yaep++.tex;\
        fi
	mv yaep++.dvi $(srcdir)/doc/yaep++.dvi

$(srcdir)/doc/yaep++.ps: $(srcdir)/doc/yaep++.dvi
	dvips -o $@ $(srcdir)/doc/yaep++.dvi

$(srcdir)/doc/yaep++.pdf: $(srcdir)/doc/yaep++.ps
	ps2pdf $(srcdir)/doc/yaep++.ps $@

# The following entry is only for internal usage.  It adds makefile
# dependencies for IRDT object files to the end of given file.
depend : src/sgramm.c $(Cdir) $(Cxxdir)
	@echo ++++ Adding Makefile dependencies for C ++++
	echo '# The following is generated with the aid of Makefile entry depend' >>$(srcdir)/Makefile.in
	echo '#' >>$(srcdir)/Makefile.in
	$(SED) '/^# The following is generated with the aid of Makefile entry depend/,$$d' <$(srcdir)/Makefile.in >Makefile.tmp
	echo '# The following is generated with the aid of Makefile entry depend' >>Makefile.tmp
	echo '# Do not place anything below this line' >>Makefile.tmp
	echo '#' >>Makefile.tmp
	for i in allocate.c vlobject.c objstack.c hashtab.c yaep.c;\
	do\
	   echo $(Cdir)/`gcc -MM -iquote -I$(srcdir)/src $(CFLAGS) $(srcdir)/src/$$i` | $(SED) 's/\\//g'\
                | $(SED) `echo 's%$(top_srcdir)/%$$(top_srcdir)/%g'\
                | $(SED) 's/\\./\\\\./g'` \
                | $(SED) 's% \./% %g'\
                | $(SED) 's%\$$(top_srcdir)/src/sgramm\.c%src/sgramm.c%g' \
			 >>Makefile.tmp;\
	   echo '	$$(CC) -c $$(CFLAGS) -o $$@' $(srcdir)/src/$$i \
                | $(SED) `echo 's%$(top_srcdir)/%$$(top_srcdir)/%g'\
                | $(SED) 's/\\./\\\\./g'` \
                | $(SED) 's% \./% %g' \
                | $(SED) 's%\$$(top_srcdir)/src/sgramm\.c%src/sgramm.c%g' \
                         >>Makefile.tmp;\
	done
	
	@echo ++++ Adding Makefile dependencies for C++ ++++
	for i in vlobject.cpp objstack.cpp hashtab.cpp yaep.cpp;\
	do\
	   echo $(Cxxdir)/`gcc -MM -iquote -I$(srcdir)/src $(CFLAGS) $(srcdir)/src/$$i` | $(SED) 's/\\//g'\
                | $(SED) `echo 's%$(top_srcdir)/%$$(top_srcdir)/%g'\
                | $(SED) 's/\\./\\\\./g'` \
                | $(SED) 's% \./% %g'\
                | $(SED) 's%\$$(top_srcdir)/src/sgramm\.c%src/sgramm.c%g' \
			 >>Makefile.tmp;\
	   echo '	$$(CXX) -c $$(CXXFLAGS) -o $$@' $(srcdir)/src/$$i \
                | $(SED) `echo 's%$(top_srcdir)/%$$(top_srcdir)/%g'\
                | $(SED) 's/\\./\\\\./g'` \
                | $(SED) 's% \./% %g'\
                | $(SED) 's%\$$(top_srcdir)/src/sgramm\.c%src/sgramm.c%g' \
			 >>Makefile.tmp;\
	done
	mv Makefile.tmp $(srcdir)/Makefile.in

#
# The following is generated with the aid of Makefile entry depend
# Do not place anything below this line
#
src/C/allocate.o: $(top_srcdir)/src/allocate.c  $(top_srcdir)/src/allocate.h
	$(CC) -c $(CFLAGS) -o $@ $(top_srcdir)/src/allocate.c
src/C/vlobject.o: $(top_srcdir)/src/vlobject.c  $(top_srcdir)/src/allocate.h  $(top_srcdir)/src/vlobject.h
	$(CC) -c $(CFLAGS) -o $@ $(top_srcdir)/src/vlobject.c
src/C/objstack.o: $(top_srcdir)/src/objstack.c  $(top_srcdir)/src/allocate.h  $(top_srcdir)/src/objstack.h
	$(CC) -c $(CFLAGS) -o $@ $(top_srcdir)/src/objstack.c
src/C/hashtab.o: $(top_srcdir)/src/hashtab.c  $(top_srcdir)/src/allocate.h  $(top_srcdir)/src/hashtab.h
	$(CC) -c $(CFLAGS) -o $@ $(top_srcdir)/src/hashtab.c
src/C/yaep_unicode.o: $(top_srcdir)/src/unicode/yaep_unicode.c  $(top_srcdir)/src/unicode/yaep_unicode.h  $(top_srcdir)/third_party/utf8proc/utf8proc.h
	$(CC) -c $(CFLAGS) -o $@ $(top_srcdir)/src/unicode/yaep_unicode.c
src/C/utf8proc.o: $(top_srcdir)/third_party/utf8proc/utf8proc.c  $(top_srcdir)/third_party/utf8proc/utf8proc.h  $(top_srcdir)/third_party/utf8proc/utf8proc_data.c
	$(CC) -c $(CFLAGS) -o $@ $(top_srcdir)/third_party/utf8proc/utf8proc.c
src/C/yaep.o: $(top_srcdir)/src/yaep.c  $(top_srcdir)/src/allocate.h  $(top_srcdir)/src/hashtab.h  $(top_srcdir)/src/vlobject.h  $(top_srcdir)/src/objstack.h  $(top_srcdir)/src/yaep.h src/sgramm.c
	$(CC) -c $(CFLAGS) -o $@ $(top_srcdir)/src/yaep.c
src/C++/vlobject.o: $(top_srcdir)/src/vlobject.cpp  $(top_srcdir)/src/allocate.h  $(top_srcdir)/src/vlobject.h
	$(CXX) -c $(CXXFLAGS) -o $@ $(top_srcdir)/src/vlobject.cpp
src/C++/objstack.o: $(top_srcdir)/src/objstack.cpp  $(top_srcdir)/src/allocate.h  $(top_srcdir)/src/objstack.h
	$(CXX) -c $(CXXFLAGS) -o $@ $(top_srcdir)/src/objstack.cpp
src/C++/hashtab.o: $(top_srcdir)/src/hashtab.cpp  $(top_srcdir)/src/allocate.h  $(top_srcdir)/src/hashtab.h
	$(CXX) -c $(CXXFLAGS) -o $@ $(top_srcdir)/src/hashtab.cpp
src/C++/yaep.o: $(top_srcdir)/src/yaep.cpp  $(top_srcdir)/src/yaep.c  $(top_srcdir)/src/allocate.h  $(top_srcdir)/src/hashtab.h  $(top_srcdir)/src/vlobject.h  $(top_srcdir)/src/objstack.h  $(top_srcdir)/src/yaep.h src/sgramm.c
	$(CXX) -c $(CXXFLAGS) -o $@ $(top_srcdir)/src/yaep.cpp
