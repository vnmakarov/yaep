dnl Process this file with autoconf to produce a configure script.
AC_INIT(src/yaep.c)

dnl Checks for programs.
AC_PROG_AWK
dnl Try C++ before C because configure reports cros-compiler for CXX sometimes.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_CPP
AC_PROG_INSTALL
AC_PROG_MAKE_SET
AC_PROG_RANLIB
AC_PROG_YACC
AC_PROG_LEX
AC_PROG_SED
AC_PROG_EGREP

AC_AIX
AC_FUNC_GETMNTENT
AC_ISC_POSIX
AC_MINIX
AC_STDC_HEADERS
AC_HAVE_HEADERS(string.h)

AC_ALLOCA
AC_CONST

AC_CHECK_LIB(m, log)

dnl Checks for header files.
AC_CHECK_HEADERS(assert.h limits.h errno.h float.h time.h dlfcn.h unistd.h sys/time.h)

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_C_INLINE
AC_TYPE_SIZE_T
AC_CHECK_SIZEOF(size_t)
AC_CHECK_SIZEOF(char *)
dnl There is no clock_t `sys/types.h', or `stdlib.h' or `stddef.h' on Linux
dnl I think checking time.h will be sufficient.
dnl AC_CHECK_TYPES([clock_t], [], AC_DEFINE([clock_t], [long], []))

dnl Checks for library functions.
AC_TYPE_SIGNAL
AC_CHECK_FUNCS(setitimer sigaction sigemptyset)

AC_SUBST(YAEPLIB)
AC_SUBST(YAEPDIR)
YAEPLIB=yaep
YAEPDIR=../src

AC_SUBST(C_DEBUG_DEFINE)
if test x$yaep_debug = x; then
  C_DEBUG_DEFINE=-DNDEBUG
else
  CFLAGS=-g3
  AC_MSG_CHECKING([whether CC supports -g3])
  AC_COMPILE_IFELSE([AC_LANG_PROGRAM([])],
      [AC_MSG_RESULT([yes])]
      [g3=yes],
      [AC_MSG_RESULT([no])]
  )

  if test "$g3" = yes; then
    CFLAGS='-O0 -g3'
    CXXFLAGS='-O0 -g3'
  else
    CFLAGS='-O0 -g'
    CXXFLAGS='-O0 -g'
  fi
  C_DEBUG_DEFINE=
fi

AC_SUBST(GCC_FPIC)
AC_SUBST(LIB_SUFFIX)
AC_SUBST(MAKELIB)
AC_SUBST(AFTER_MAKELIB)

system=`uname`.`uname -r`

if test "$GCC" = yes && test x$yaep_debug = x; then
  my_save_cflags="$CFLAGS"
  CFLAGS=-Ofast
  AC_MSG_CHECKING([whether CC supports -Ofast])
  AC_COMPILE_IFELSE([AC_LANG_PROGRAM([])],
      [AC_MSG_RESULT([yes])]
      [fast=yes],
      [AC_MSG_RESULT([no])]
  )
  CFLAGS="$my_save_cflags"
  if test "$fast" = yes; then
    CFLAGS="`echo $CFLAGS|sed s/-O2//` -Ofast"
    CXXFLAGS="`echo $CXXFLAGS|sed s/-O2//` -Ofast"
  else
    CFLAGS="`echo $CFLAGS|sed s/-O2//` -O3"
    CXXFLAGS="`echo $CXXFLAGS|sed s/-O2//` -O3"
  fi

  system=`uname -m`
  case $system in
	i386*|i486*|i586*|i686*)
  	  CFLAGS="$CFLAGS -fomit-frame-pointer"
  	  CXXFLAGS="$CXXFLAGS -fomit-frame-pointer"
          ;;
	*)
	  ;;
  esac
fi

output_files="Makefile doc/Makefile src/Makefile test/Makefile test/C/Makefile test/C++/Makefile test/compare_parsers/compare_parsers.sh"

AC_OUTPUT($output_files)
