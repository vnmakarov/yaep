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

AC_ARG_ENABLE([legacy-c99],
  AS_HELP_STRING([--enable-legacy-c99],[build using -std=c99 instead of -std=c11]),
  [yaep_legacy_c99=$enableval],
  [yaep_legacy_c99=no])

AC_ARG_ENABLE([strict-warnings],
  AS_HELP_STRING([--disable-strict-warnings],[do not enable additional compiler warnings]),
  [yaep_strict_warnings=$enableval],
  [yaep_strict_warnings=yes])

yaep_candidate_standards=""
if test "x$yaep_legacy_c99" = xyes; then
  yaep_candidate_standards="c99"
else
  yaep_candidate_standards="c11 c99"
fi

yaep_selected_std=""
yaep_std_flag=""
for yaep_std in $yaep_candidate_standards; do
  case "$CC" in
    cl*|*cl.exe)
      yaep_try_flag="/std:$yaep_std"
      ;;
    *)
      yaep_try_flag="-std=$yaep_std"
      ;;
  esac
  AC_MSG_CHECKING([whether $CC accepts $yaep_try_flag])
  yaep_save_cflags="$CFLAGS"
  CFLAGS="$CFLAGS $yaep_try_flag"
  AC_COMPILE_IFELSE([AC_LANG_PROGRAM([])],
    [AC_MSG_RESULT([yes])
     yaep_selected_std="$yaep_std"
     yaep_std_flag="$yaep_try_flag"
     break],
    [AC_MSG_RESULT([no])
     CFLAGS="$yaep_save_cflags"])
done

if test "x$yaep_selected_std" = x; then
  AC_MSG_ERROR([compiler does not support the requested C standard])
fi

if test "$yaep_selected_std" = c99 && test "x$yaep_legacy_c99" != xyes; then
  AC_MSG_WARN([Falling back to C99 because the compiler lacks C11 support. Use --enable-legacy-c99 to skip the warning.])
fi

yaep_cxx_candidate_standards="c++14 c++11"
yaep_selected_cxx_std=""
AC_LANG_PUSH([C++])
for yaep_cxx_std in $yaep_cxx_candidate_standards; do
  case "$CXX" in
    cl*|*cl.exe)
      yaep_try_cxx_flag="/std:$yaep_cxx_std"
      ;;
    *)
      yaep_try_cxx_flag="-std=$yaep_cxx_std"
      ;;
  esac
  AC_MSG_CHECKING([whether $CXX accepts $yaep_try_cxx_flag])
  yaep_save_cxxflags="$CXXFLAGS"
  CXXFLAGS="$CXXFLAGS $yaep_try_cxx_flag"
  AC_COMPILE_IFELSE([AC_LANG_PROGRAM([],[])],
    [AC_MSG_RESULT([yes])
     yaep_selected_cxx_std="$yaep_cxx_std"
     break],
    [AC_MSG_RESULT([no])
     CXXFLAGS="$yaep_save_cxxflags"])
done
AC_LANG_POP([C++])

if test "x$yaep_selected_cxx_std" = x; then
  AC_MSG_ERROR([C++ compiler does not support the required standard (need at least C++11).])
fi

if test "x$yaep_strict_warnings" != xno; then
  if test "x$GCC" = xyes; then
    CFLAGS="$CFLAGS -Wall -Wextra -Wpedantic"
    CXXFLAGS="$CXXFLAGS -Wall -Wextra -Wpedantic"
  else
    case "$CC" in
      cl*|*cl.exe)
        CFLAGS="$CFLAGS /W4 /permissive-"
        CXXFLAGS="$CXXFLAGS /W4 /permissive-"
        ;;
    esac
  fi
fi

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
