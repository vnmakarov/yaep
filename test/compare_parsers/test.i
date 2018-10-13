typedef void *__builtin_va_list;
typedef unsigned int size_t;
typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;
typedef struct
{
  long __val[2];
} __quad_t;
typedef struct
{
  __u_long __val[2];
} __u_quad_t;
 typedef __u_quad_t __dev_t;
 typedef unsigned int __uid_t;
 typedef unsigned int __gid_t;
 typedef unsigned long int __ino_t;
 typedef __u_quad_t __ino64_t;
 typedef unsigned int __mode_t;
 typedef unsigned int __nlink_t;
 typedef long int __off_t;
 typedef __quad_t __off64_t;
 typedef int __pid_t;
 typedef struct { int __val[2]; } __fsid_t;
 typedef long int __clock_t;
 typedef unsigned long int __rlim_t;
 typedef __u_quad_t __rlim64_t;
 typedef unsigned int __id_t;
 typedef long int __time_t;
 typedef unsigned int __useconds_t;
 typedef long int __suseconds_t;

 typedef int __daddr_t;
 typedef long int __swblk_t;
 typedef int __key_t;


 typedef int __clockid_t;


 typedef int __timer_t;


 typedef long int __blksize_t;




 typedef long int __blkcnt_t;
 typedef __quad_t __blkcnt64_t;


 typedef unsigned long int __fsblkcnt_t;
 typedef __u_quad_t __fsblkcnt64_t;


 typedef unsigned long int __fsfilcnt_t;
 typedef __u_quad_t __fsfilcnt64_t;

 typedef int __ssize_t;



typedef __off64_t __loff_t;
typedef __quad_t *__qaddr_t;
typedef char *__caddr_t;


 typedef int __intptr_t;


 typedef unsigned int __socklen_t;







enum
{
  _ISupper = ((0) < 8 ? ((1 << (0)) << 8) : ((1 << (0)) >> 8)),
  _ISlower = ((1) < 8 ? ((1 << (1)) << 8) : ((1 << (1)) >> 8)),
  _ISalpha = ((2) < 8 ? ((1 << (2)) << 8) : ((1 << (2)) >> 8)),
  _ISdigit = ((3) < 8 ? ((1 << (3)) << 8) : ((1 << (3)) >> 8)),
  _ISxdigit = ((4) < 8 ? ((1 << (4)) << 8) : ((1 << (4)) >> 8)),
  _ISspace = ((5) < 8 ? ((1 << (5)) << 8) : ((1 << (5)) >> 8)),
  _ISprint = ((6) < 8 ? ((1 << (6)) << 8) : ((1 << (6)) >> 8)),
  _ISgraph = ((7) < 8 ? ((1 << (7)) << 8) : ((1 << (7)) >> 8)),
  _ISblank = ((8) < 8 ? ((1 << (8)) << 8) : ((1 << (8)) >> 8)),
  _IScntrl = ((9) < 8 ? ((1 << (9)) << 8) : ((1 << (9)) >> 8)),
  _ISpunct = ((10) < 8 ? ((1 << (10)) << 8) : ((1 << (10)) >> 8)),
  _ISalnum = ((11) < 8 ? ((1 << (11)) << 8) : ((1 << (11)) >> 8))
};
extern const unsigned short int **__ctype_b_loc (void)
     ;
extern const __int32_t **__ctype_tolower_loc (void)
     ;
extern const __int32_t **__ctype_toupper_loc (void)
     ;






extern int isalnum (int) ;
extern int isalpha (int) ;
extern int iscntrl (int) ;
extern int isdigit (int) ;
extern int islower (int) ;
extern int isgraph (int) ;
extern int isprint (int) ;
extern int ispunct (int) ;
extern int isspace (int) ;
extern int isupper (int) ;
extern int isxdigit (int) ;



extern int tolower (int __c) ;


extern int toupper (int __c) ;


extern int isascii (int __c) ;



extern int toascii (int __c) ;



extern int _toupper (int) ;
extern int _tolower (int) ;




typedef struct _IO_FILE FILE;





typedef struct _IO_FILE __FILE;
typedef long int wchar_t;
typedef unsigned int wint_t;
typedef struct
{
  int __count;
  union
  {
    wint_t __wch;
    char __wchb[4];
  } __value;
} __mbstate_t;
typedef struct
{
  __off_t __pos;
  __mbstate_t __state;
} _G_fpos_t;
typedef struct
{
  __off64_t __pos;
  __mbstate_t __state;
} _G_fpos64_t;
enum
{
  __GCONV_OK = 0,
  __GCONV_NOCONV,
  __GCONV_NODB,
  __GCONV_NOMEM,

  __GCONV_EMPTY_INPUT,
  __GCONV_FULL_OUTPUT,
  __GCONV_ILLEGAL_INPUT,
  __GCONV_INCOMPLETE_INPUT,

  __GCONV_ILLEGAL_DESCRIPTOR,
  __GCONV_INTERNAL_ERROR
};



enum
{
  __GCONV_IS_LAST = 0x0001,
  __GCONV_IGNORE_ERRORS = 0x0002
};



struct __gconv_step;
struct __gconv_step_data;
struct __gconv_loaded_object;
struct __gconv_trans_data;



typedef int (*__gconv_fct) (struct __gconv_step *, struct __gconv_step_data *,
       const unsigned char **, const unsigned char *,
       unsigned char **, size_t *, int, int);


typedef wint_t (*__gconv_btowc_fct) (struct __gconv_step *, unsigned char);


typedef int (*__gconv_init_fct) (struct __gconv_step *);
typedef void (*__gconv_end_fct) (struct __gconv_step *);



typedef int (*__gconv_trans_fct) (struct __gconv_step *,
      struct __gconv_step_data *, void *,
      const unsigned char *,
      const unsigned char **,
      const unsigned char *, unsigned char **,
      size_t *);


typedef int (*__gconv_trans_context_fct) (void *, const unsigned char *,
       const unsigned char *,
       unsigned char *, unsigned char *);


typedef int (*__gconv_trans_query_fct) (const char *, const char ***,
     size_t *);


typedef int (*__gconv_trans_init_fct) (void **, const char *);
typedef void (*__gconv_trans_end_fct) (void *);

struct __gconv_trans_data
{

  __gconv_trans_fct __trans_fct;
  __gconv_trans_context_fct __trans_context_fct;
  __gconv_trans_end_fct __trans_end_fct;
  void *__data;
  struct __gconv_trans_data *__next;
};



struct __gconv_step
{
  struct __gconv_loaded_object *__shlib_handle;
  const char *__modname;

  int __counter;

  char *__from_name;
  char *__to_name;

  __gconv_fct __fct;
  __gconv_btowc_fct __btowc_fct;
  __gconv_init_fct __init_fct;
  __gconv_end_fct __end_fct;



  int __min_needed_from;
  int __max_needed_from;
  int __min_needed_to;
  int __max_needed_to;


  int __stateful;

  void *__data;
};



struct __gconv_step_data
{
  unsigned char *__outbuf;
  unsigned char *__outbufend;



  int __flags;



  int __invocation_counter;



  int __internal_use;

  __mbstate_t *__statep;
  __mbstate_t __state;



  struct __gconv_trans_data *__trans;
};



typedef struct __gconv_info
{
  size_t __nsteps;
  struct __gconv_step *__steps;
  struct __gconv_step_data __data [1];
} *__gconv_t;


typedef union
{
  struct __gconv_info __cd;
  struct
  {
    struct __gconv_info __cd;
    struct __gconv_step_data __data;
  } __combined;
} _G_iconv_t;

typedef int _G_int16_t ;
typedef int _G_int32_t ;
typedef unsigned int _G_uint16_t ;
typedef unsigned int _G_uint32_t ;
typedef __builtin_va_list __gnuc_va_list;
struct _IO_jump_t; struct _IO_FILE;
typedef void _IO_lock_t;





struct _IO_marker {
  struct _IO_marker *_next;
  struct _IO_FILE *_sbuf;



  int _pos;
};


enum __codecvt_result
{
  __codecvt_ok,
  __codecvt_partial,
  __codecvt_error,
  __codecvt_noconv
};
struct _IO_FILE {
  int _flags;




  char* _IO_read_ptr;
  char* _IO_read_end;
  char* _IO_read_base;
  char* _IO_write_base;
  char* _IO_write_ptr;
  char* _IO_write_end;
  char* _IO_buf_base;
  char* _IO_buf_end;

  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;



  int _flags2;

  __off_t _old_offset;



  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];



  _IO_lock_t *_lock;
  __off64_t _offset;





  void *__pad1;
  void *__pad2;

  int _mode;

  char _unused2[15 * sizeof (int) - 2 * sizeof (void *)];

};


typedef struct _IO_FILE _IO_FILE;


struct _IO_FILE_plus;

extern struct _IO_FILE_plus _IO_2_1_stdin_;
extern struct _IO_FILE_plus _IO_2_1_stdout_;
extern struct _IO_FILE_plus _IO_2_1_stderr_;
typedef __ssize_t __io_read_fn (void *__cookie, char *__buf, size_t __nbytes);







typedef __ssize_t __io_write_fn (void *__cookie, const char *__buf,
     size_t __n);







typedef int __io_seek_fn (void *__cookie, __off64_t *__pos, int __w);


typedef int __io_close_fn (void *__cookie);
extern int __underflow (_IO_FILE *) ;
extern int __uflow (_IO_FILE *) ;
extern int __overflow (_IO_FILE *, int) ;
extern wint_t __wunderflow (_IO_FILE *) ;
extern wint_t __wuflow (_IO_FILE *) ;
extern wint_t __woverflow (_IO_FILE *, wint_t) ;
extern int _IO_getc (_IO_FILE *__fp) ;
extern int _IO_putc (int __c, _IO_FILE *__fp) ;
extern int _IO_feof (_IO_FILE *__fp) ;
extern int _IO_ferror (_IO_FILE *__fp) ;

extern int _IO_peekc_locked (_IO_FILE *__fp) ;





extern void _IO_flockfile (_IO_FILE *) ;
extern void _IO_funlockfile (_IO_FILE *) ;
extern int _IO_ftrylockfile (_IO_FILE *) ;
extern int _IO_vfscanf (_IO_FILE * , const char * ,
   __gnuc_va_list, int *) ;
extern int _IO_vfprintf (_IO_FILE *, const char *,
    __gnuc_va_list) ;
extern __ssize_t _IO_padn (_IO_FILE *, int, __ssize_t) ;
extern size_t _IO_sgetn (_IO_FILE *, void *, size_t) ;

extern __off64_t _IO_seekoff (_IO_FILE *, __off64_t, int, int) ;
extern __off64_t _IO_seekpos (_IO_FILE *, __off64_t, int) ;

extern void _IO_free_backup_area (_IO_FILE *) ;


typedef _G_fpos_t fpos_t;




extern struct _IO_FILE *stdin;
extern struct _IO_FILE *stdout;
extern struct _IO_FILE *stderr;









extern int remove (const char *__filename) ;

extern int rename (const char *__old, const char *__new) ;









extern FILE *tmpfile (void);
extern char *tmpnam (char *__s) ;





extern char *tmpnam_r (char *__s) ;
extern char *tempnam (const char *__dir, const char *__pfx)
     ;








extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);

extern int fflush_unlocked (FILE *__stream);






extern FILE *fopen (const char * __filename,
      const char * __modes);




extern FILE *freopen (const char * __filename,
        const char * __modes,
        FILE * __stream);

extern FILE *fdopen (int __fd, const char *__modes) ;



extern void setbuf (FILE * __stream, char * __buf) ;



extern int setvbuf (FILE * __stream, char * __buf,
      int __modes, size_t __n) ;





extern void setbuffer (FILE * __stream, char * __buf,
         size_t __size) ;


extern void setlinebuf (FILE *__stream) ;








extern int fprintf (FILE * __stream,
      const char * __format, ...);




extern int printf (const char * __format, ...);

extern int sprintf (char * __s,
      const char * __format, ...) ;





extern int vfprintf (FILE * __s, const char * __format,
       __gnuc_va_list __arg);




extern int vprintf (const char * __format, __gnuc_va_list __arg);

extern int vsprintf (char * __s, const char * __format,
       __gnuc_va_list __arg) ;





extern int snprintf (char * __s, size_t __maxlen,
       const char * __format, ...)
     ;

extern int vsnprintf (char * __s, size_t __maxlen,
        const char * __format, __gnuc_va_list __arg)
     ;






extern int fscanf (FILE * __stream,
     const char * __format, ...);




extern int scanf (const char * __format, ...);

extern int sscanf (const char * __s,
     const char * __format, ...) ;






extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);

extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
extern int fgetc_unlocked (FILE *__stream);











extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);

extern int fputc_unlocked (int __c, FILE *__stream);







extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);






extern int getw (FILE *__stream);


extern int putw (int __w, FILE *__stream);








extern char *fgets (char * __s, int __n, FILE * __stream);






extern char *gets (char *__s);






extern int fputs (const char * __s, FILE * __stream);





extern int puts (const char *__s);






extern int ungetc (int __c, FILE *__stream);






extern size_t fread (void * __ptr, size_t __size,
       size_t __n, FILE * __stream);




extern size_t fwrite (const void * __ptr, size_t __size,
        size_t __n, FILE * __s);

extern size_t fread_unlocked (void * __ptr, size_t __size,
         size_t __n, FILE * __stream);
extern size_t fwrite_unlocked (const void * __ptr, size_t __size,
          size_t __n, FILE * __stream);








extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream);




extern void rewind (FILE *__stream);







extern int fgetpos (FILE * __stream, fpos_t * __pos);




extern int fsetpos (FILE *__stream, const fpos_t *__pos);



extern void clearerr (FILE *__stream) ;

extern int feof (FILE *__stream) ;

extern int ferror (FILE *__stream) ;




extern void clearerr_unlocked (FILE *__stream) ;
extern int feof_unlocked (FILE *__stream) ;
extern int ferror_unlocked (FILE *__stream) ;








extern void perror (const char *__s);

extern int sys_nerr;
extern const char *const sys_errlist[];
extern int fileno (FILE *__stream) ;




extern int fileno_unlocked (FILE *__stream) ;
extern FILE *popen (const char *__command, const char *__modes);





extern int pclose (FILE *__stream);





extern char *ctermid (char *__s) ;
extern void flockfile (FILE *__stream) ;



extern int ftrylockfile (FILE *__stream) ;


extern void funlockfile (FILE *__stream) ;




typedef struct
  {
    int quot;
    int rem;
  } div_t;



typedef struct
  {
    long int quot;
    long int rem;
  } ldiv_t;



extern size_t __ctype_get_mb_cur_max (void) ;




extern double atof (const char *__nptr)
     ;

extern int atoi (const char *__nptr)
     ;

extern long int atol (const char *__nptr)
     ;



extern double strtod (const char * __nptr,
        char ** __endptr) ;



extern long int strtol (const char * __nptr,
   char ** __endptr, int __base)
     ;

extern unsigned long int strtoul (const char * __nptr,
      char ** __endptr, int __base)
     ;

extern double __strtod_internal (const char * __nptr,
     char ** __endptr, int __group)
     ;
extern float __strtof_internal (const char * __nptr,
    char ** __endptr, int __group)
     ;
extern long double __strtold_internal (const char * __nptr,
           char ** __endptr,
           int __group) ;

extern long int __strtol_internal (const char * __nptr,
       char ** __endptr,
       int __base, int __group)
     ;



extern unsigned long int __strtoul_internal (const char * __nptr,
          char ** __endptr,
          int __base, int __group)
     ;
extern char *l64a (long int __n) ;


extern long int a64l (const char *__s)
     ;






typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;




typedef __loff_t loff_t;



typedef __ino_t ino_t;
typedef __dev_t dev_t;




typedef __gid_t gid_t;




typedef __mode_t mode_t;




typedef __nlink_t nlink_t;




typedef __uid_t uid_t;





typedef __off_t off_t;
typedef __pid_t pid_t;




typedef __id_t id_t;




typedef __ssize_t ssize_t;





typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;





typedef __key_t key_t;


typedef __time_t time_t;



typedef __clockid_t clockid_t;
typedef __timer_t timer_t;
typedef unsigned long int ulong;
typedef unsigned short int ushort;
typedef unsigned int uint;
typedef char int8_t;
typedef short int int16_t;
typedef int int32_t;






typedef unsigned char u_int8_t;
typedef unsigned short int u_int16_t;
typedef unsigned int u_int32_t;




typedef int register_t;
typedef int __sig_atomic_t;




typedef struct
  {
    unsigned long int __val[(1024 / (8 * sizeof (unsigned long int)))];
  } __sigset_t;
typedef __sigset_t sigset_t;
struct timespec
  {
    __time_t tv_sec;
    long int tv_nsec;
  };
struct timeval
  {
    __time_t tv_sec;
    __suseconds_t tv_usec;
  };




typedef __suseconds_t suseconds_t;





typedef long int __fd_mask;
typedef struct
  {






    __fd_mask __fds_bits[1024 / (8 * sizeof (__fd_mask))];


  } fd_set;






typedef __fd_mask fd_mask;

extern int select (int __nfds, fd_set * __readfds,
     fd_set * __writefds,
     fd_set * __exceptfds,
     struct timeval * __timeout);

typedef __blkcnt_t blkcnt_t;



typedef __fsblkcnt_t fsblkcnt_t;



typedef __fsfilcnt_t fsfilcnt_t;
struct __sched_param
  {
    int __sched_priority;
  };
struct _pthread_fastlock
{
  long int __status;
  int __spinlock;

};



typedef struct _pthread_descr_struct *_pthread_descr;





typedef struct __pthread_attr_s
{
  int __detachstate;
  int __schedpolicy;
  struct __sched_param __schedparam;
  int __inheritsched;
  int __scope;
  size_t __guardsize;
  int __stackaddr_set;
  void *__stackaddr;
  size_t __stacksize;
} pthread_attr_t;







typedef long __pthread_cond_align_t;


typedef struct
{
  struct _pthread_fastlock __c_lock;
  _pthread_descr __c_waiting;
  char __padding[48 - sizeof (struct _pthread_fastlock)
   - sizeof (_pthread_descr) - sizeof (__pthread_cond_align_t)];
  __pthread_cond_align_t __align;
} pthread_cond_t;



typedef struct
{
  int __dummy;
} pthread_condattr_t;


typedef unsigned int pthread_key_t;





typedef struct
{
  int __m_reserved;
  int __m_count;
  _pthread_descr __m_owner;
  int __m_kind;
  struct _pthread_fastlock __m_lock;
} pthread_mutex_t;



typedef struct
{
  int __mutexkind;
} pthread_mutexattr_t;



typedef int pthread_once_t;
typedef unsigned long int pthread_t;





extern long int random (void) ;


extern void srandom (unsigned int __seed) ;





extern char *initstate (unsigned int __seed, char *__statebuf,
   size_t __statelen) ;



extern char *setstate (char *__statebuf) ;







struct random_data
  {
    int32_t *fptr;
    int32_t *rptr;
    int32_t *state;
    int rand_type;
    int rand_deg;
    int rand_sep;
    int32_t *end_ptr;
  };

extern int random_r (struct random_data * __buf,
       int32_t * __result) ;

extern int srandom_r (unsigned int __seed, struct random_data *__buf)
     ;

extern int initstate_r (unsigned int __seed, char * __statebuf,
   size_t __statelen,
   struct random_data * __buf)
     ;

extern int setstate_r (char * __statebuf,
         struct random_data * __buf)
     ;






extern int rand (void) ;

extern void srand (unsigned int __seed) ;




extern int rand_r (unsigned int *__seed) ;







extern double drand48 (void) ;
extern double erand48 (unsigned short int __xsubi[3]) ;


extern long int lrand48 (void) ;
extern long int nrand48 (unsigned short int __xsubi[3])
     ;


extern long int mrand48 (void) ;
extern long int jrand48 (unsigned short int __xsubi[3])
     ;


extern void srand48 (long int __seedval) ;
extern unsigned short int *seed48 (unsigned short int __seed16v[3])
     ;
extern void lcong48 (unsigned short int __param[7]) ;





struct drand48_data
  {
    unsigned short int __x[3];
    unsigned short int __old_x[3];
    unsigned short int __c;
    unsigned short int __init;
    unsigned long long int __a;
  };


extern int drand48_r (struct drand48_data * __buffer,
        double * __result) ;
extern int erand48_r (unsigned short int __xsubi[3],
        struct drand48_data * __buffer,
        double * __result) ;


extern int lrand48_r (struct drand48_data * __buffer,
        long int * __result)
     ;
extern int nrand48_r (unsigned short int __xsubi[3],
        struct drand48_data * __buffer,
        long int * __result)
     ;


extern int mrand48_r (struct drand48_data * __buffer,
        long int * __result)
     ;
extern int jrand48_r (unsigned short int __xsubi[3],
        struct drand48_data * __buffer,
        long int * __result)
     ;


extern int srand48_r (long int __seedval, struct drand48_data *__buffer)
     ;

extern int seed48_r (unsigned short int __seed16v[3],
       struct drand48_data *__buffer) ;

extern int lcong48_r (unsigned short int __param[7],
        struct drand48_data *__buffer)
     ;









extern void *malloc (size_t __size) ;

extern void *calloc (size_t __nmemb, size_t __size)
     ;







extern void *realloc (void *__ptr, size_t __size) ;

extern void free (void *__ptr) ;




extern void cfree (void *__ptr) ;






extern void *alloca (size_t __size) ;












extern void *valloc (size_t __size) ;


extern void abort (void) ;



extern int atexit (void (*__func) (void)) ;





extern int on_exit (void (*__func) (int __status, void *__arg), void *__arg)
     ;






extern void exit (int __status) ;



extern char *getenv (const char *__name) ;




extern char *__secure_getenv (const char *__name) ;





extern int putenv (char *__string) ;





extern int setenv (const char *__name, const char *__value, int __replace)
     ;


extern int unsetenv (const char *__name) ;






extern int clearenv (void) ;
extern char *mktemp (char *__template) ;
extern int mkstemp (char *__template) ;
extern char *mkdtemp (char *__template) ;








extern int system (const char *__command);

extern char *realpath (const char * __name,
         char * __resolved) ;






typedef int (*__compar_fn_t) (const void *, const void *);









extern void *bsearch (const void *__key, const void *__base,
        size_t __nmemb, size_t __size, __compar_fn_t __compar)
     ;



extern void qsort (void *__base, size_t __nmemb, size_t __size,
     __compar_fn_t __compar) ;



extern int abs (int __x) ;
extern long int labs (long int __x) ;












extern div_t div (int __numer, int __denom)
     ;
extern ldiv_t ldiv (long int __numer, long int __denom)
     ;

extern char *ecvt (double __value, int __ndigit, int * __decpt,
     int * __sign) ;




extern char *fcvt (double __value, int __ndigit, int * __decpt,
     int * __sign) ;




extern char *gcvt (double __value, int __ndigit, char *__buf)
     ;




extern char *qecvt (long double __value, int __ndigit,
      int * __decpt, int * __sign)
     ;
extern char *qfcvt (long double __value, int __ndigit,
      int * __decpt, int * __sign)
     ;
extern char *qgcvt (long double __value, int __ndigit, char *__buf)
     ;




extern int ecvt_r (double __value, int __ndigit, int * __decpt,
     int * __sign, char * __buf,
     size_t __len) ;
extern int fcvt_r (double __value, int __ndigit, int * __decpt,
     int * __sign, char * __buf,
     size_t __len) ;

extern int qecvt_r (long double __value, int __ndigit,
      int * __decpt, int * __sign,
      char * __buf, size_t __len)
     ;
extern int qfcvt_r (long double __value, int __ndigit,
      int * __decpt, int * __sign,
      char * __buf, size_t __len)
     ;







extern int mblen (const char *__s, size_t __n) ;


extern int mbtowc (wchar_t * __pwc,
     const char * __s, size_t __n) ;


extern int wctomb (char *__s, wchar_t __wchar) ;



extern size_t mbstowcs (wchar_t * __pwcs,
   const char * __s, size_t __n) ;

extern size_t wcstombs (char * __s,
   const wchar_t * __pwcs, size_t __n)
     ;








extern int rpmatch (const char *__response) ;
extern int getloadavg (double __loadavg[], int __nelem)
     ;









extern void *memcpy (void * __dest,
       const void * __src, size_t __n)
     ;


extern void *memmove (void *__dest, const void *__src, size_t __n)
     ;






extern void *memccpy (void * __dest, const void * __src,
        int __c, size_t __n)
     ;





extern void *memset (void *__s, int __c, size_t __n) ;


extern int memcmp (const void *__s1, const void *__s2, size_t __n)
     ;


extern void *memchr (const void *__s, int __c, size_t __n)
      ;



extern char *strcpy (char * __dest, const char * __src)
     ;

extern char *strncpy (char * __dest,
        const char * __src, size_t __n)
     ;


extern char *strcat (char * __dest, const char * __src)
     ;

extern char *strncat (char * __dest, const char * __src,
        size_t __n) ;


extern int strcmp (const char *__s1, const char *__s2)
     ;

extern int strncmp (const char *__s1, const char *__s2, size_t __n)
     ;


extern int strcoll (const char *__s1, const char *__s2)
     ;

extern size_t strxfrm (char * __dest,
         const char * __src, size_t __n)
     ;

extern char *strdup (const char *__s)
     ;


extern char *strchr (const char *__s, int __c)
     ;

extern char *strrchr (const char *__s, int __c)
     ;




extern size_t strcspn (const char *__s, const char *__reject)
     ;


extern size_t strspn (const char *__s, const char *__accept)
     ;

extern char *strpbrk (const char *__s, const char *__accept)
     ;

extern char *strstr (const char *__haystack, const char *__needle)
     ;



extern char *strtok (char * __s, const char * __delim)
     ;




extern char *__strtok_r (char * __s,
    const char * __delim,
    char ** __save_ptr)
     ;

extern char *strtok_r (char * __s, const char * __delim,
         char ** __save_ptr)
     ;


extern size_t strlen (const char *__s)
     ;



extern char *strerror (int __errnum) ;

extern char *strerror_r (int __errnum, char *__buf, size_t __buflen)
     ;





extern void __bzero (void *__s, size_t __n) ;



extern void bcopy (const void *__src, void *__dest, size_t __n)
     ;


extern void bzero (void *__s, size_t __n) ;


extern int bcmp (const void *__s1, const void *__s2, size_t __n)
     ;


extern char *index (const char *__s, int __c)
     ;


extern char *rindex (const char *__s, int __c)
     ;



extern int ffs (int __i) ;
extern int strcasecmp (const char *__s1, const char *__s2)
     ;


extern int strncasecmp (const char *__s1, const char *__s2, size_t __n)
     ;
extern char *strsep (char ** __stringp,
       const char * __delim)
     ;

struct _position_struct
{

  const char *file_name;

  unsigned int line_number;

  unsigned int column_number;


  struct _position_struct *path;
};

typedef struct _position_struct position_t;

extern const position_t no_position;

extern position_t current_position;

extern void initiate_positions (void);

extern void finish_positions (void);

extern int position_file_inclusion_level (position_t position);

extern void start_file_position (const char *file_name);

extern void finish_file_position (void);

extern int compare_positions (position_t position_1, position_t position_2);



extern void __assert_fail (const char *__assertion, const char *__file,
      unsigned int __line, const char *__function)
     ;


extern void __assert_perror_fail (int __errnum, const char *__file,
      unsigned int __line,
      const char *__function)
     ;




extern void __assert (const char *__assertion, const char *__file, int __line)
     ;



extern void _allocation_error_function (void);

extern void default_allocation_error_function (void);

extern void
  (*change_allocation_error_function (void (*error_function) (void))) (void);



extern void __assert_fail (const char *__assertion, const char *__file,
      unsigned int __line, const char *__function)
     ;


extern void __assert_perror_fail (int __errnum, const char *__file,
      unsigned int __line,
      const char *__function)
     ;




extern void __assert (const char *__assertion, const char *__file, int __line)
     ;



typedef struct
{

  char *vlo_start;

  char *vlo_free;


  char *vlo_boundary;
} vlo_t;
extern void _VLO_tailor_function (vlo_t *vlo);
extern void _VLO_add_string_function (vlo_t *vlo, const char *str);
extern void _VLO_expand_memory (vlo_t *vlo, size_t additional_length);

extern long int __sysconf (int);


typedef __clock_t clock_t;





struct tm
{
  int tm_sec;
  int tm_min;
  int tm_hour;
  int tm_mday;
  int tm_mon;
  int tm_year;
  int tm_wday;
  int tm_yday;
  int tm_isdst;


  long int tm_gmtoff;
  const char *tm_zone;




};








struct itimerspec
  {
    struct timespec it_interval;
    struct timespec it_value;
  };


struct sigevent;



extern clock_t clock (void) ;


extern time_t time (time_t *__timer) ;


extern double difftime (time_t __time1, time_t __time0)
     ;


extern time_t mktime (struct tm *__tp) ;





extern size_t strftime (char * __s, size_t __maxsize,
   const char * __format,
   const struct tm * __tp) ;




extern struct tm *gmtime (const time_t *__timer) ;



extern struct tm *localtime (const time_t *__timer) ;





extern struct tm *gmtime_r (const time_t * __timer,
       struct tm * __tp) ;



extern struct tm *localtime_r (const time_t * __timer,
          struct tm * __tp) ;





extern char *asctime (const struct tm *__tp) ;


extern char *ctime (const time_t *__timer) ;







extern char *asctime_r (const struct tm * __tp,
   char * __buf) ;


extern char *ctime_r (const time_t * __timer,
        char * __buf) ;




extern char *__tzname[2];
extern int __daylight;
extern long int __timezone;




extern char *tzname[2];



extern void tzset (void) ;



extern int daylight;
extern long int timezone;





extern int stime (const time_t *__when) ;
extern time_t timegm (struct tm *__tp) ;


extern time_t timelocal (struct tm *__tp) ;


extern int dysize (int __year) ;
extern int nanosleep (const struct timespec *__requested_time,
        struct timespec *__remaining);



extern int clock_getres (clockid_t __clock_id, struct timespec *__res) ;


extern int clock_gettime (clockid_t __clock_id, struct timespec *__tp) ;


extern int clock_settime (clockid_t __clock_id, const struct timespec *__tp)
     ;
extern int timer_create (clockid_t __clock_id,
    struct sigevent * __evp,
    timer_t * __timerid) ;


extern int timer_delete (timer_t __timerid) ;


extern int timer_settime (timer_t __timerid, int __flags,
     const struct itimerspec * __value,
     struct itimerspec * __ovalue) ;


extern int timer_gettime (timer_t __timerid, struct itimerspec *__value)
     ;


extern int timer_getoverrun (timer_t __timerid) ;

struct ticker
{



  clock_t modified_creation_time;


  clock_t incremented_off_time;
};



typedef struct ticker ticker_t;



extern ticker_t create_ticker (void);

extern void ticker_off (ticker_t *ticker);

extern void ticker_on (ticker_t *ticker);

extern double active_time (ticker_t ticker);

extern const char *active_time_string (ticker_t ticker);



extern void __assert_fail (const char *__assertion, const char *__file,
      unsigned int __line, const char *__function)
     ;


extern void __assert_perror_fail (int __errnum, const char *__file,
      unsigned int __line,
      const char *__function)
     ;




extern void __assert (const char *__assertion, const char *__file, int __line)
     ;



struct _os_auxiliary_struct
{
  char _os_character;
  double _os_double;
};
struct _os_segment
{
  struct _os_segment *os_previous_segment;
  char os_segment_contest [((char *) &((struct _os_auxiliary_struct *) 0)->_os_double - (char *) 0)];
};







typedef struct
{

  size_t initial_segment_length;
  struct _os_segment *os_current_segment;

  char *os_top_object_start;

  char *os_top_object_free;


  char *os_boundary;
} os_t;
extern void _OS_create_function (os_t *os, size_t initial_segment_length);
extern void _OS_delete_function (os_t *os);
extern void _OS_empty_function (os_t *os);
extern void _OS_add_string_function (os_t *os, const char *str);
extern void _OS_expand_memory (os_t *os, size_t additional_length);



extern void __assert_fail (const char *__assertion, const char *__file,
      unsigned int __line, const char *__function)
     ;


extern void __assert_perror_fail (int __errnum, const char *__file,
      unsigned int __line,
      const char *__function)
     ;




extern void __assert (const char *__assertion, const char *__file, int __line)
     ;



typedef int integer_t;

typedef int bool_t;

typedef char *string_t;



typedef unsigned int bit_string_element_t;



typedef long int token_string_t;



struct context_t
  {
    vlo_t bit_string;
  };

typedef struct context_t *context_t;





typedef enum IR_node_mode_enum
{
  IR_NM_node,
  IR_NM_identifier_or_literal,
  IR_NM_identifier,
  IR_NM_literal,
  IR_NM_string,
  IR_NM_number,
  IR_NM_code_insertion,
  IR_NM_additional_code,
  IR_NM_definition,
  IR_NM_start_definition,
  IR_NM_code,
  IR_NM_yacc_code,
  IR_NM_local_code,
  IR_NM_import_code,
  IR_NM_export_code,
  IR_NM_union_code,
  IR_NM_scanner_definition,
  IR_NM_expect_definition,
  IR_NM_symbol_definition,
  IR_NM_token_definition,
  IR_NM_left_definition,
  IR_NM_right_definition,
  IR_NM_nonassoc_definition,
  IR_NM_type_definition,
  IR_NM_symbol,
  IR_NM_rule,
  IR_NM_pattern,
  IR_NM_alternative,
  IR_NM_sequence,
  IR_NM_separator_iteration,
  IR_NM_sequence_element,
  IR_NM_control_point,
  IR_NM_default,
  IR_NM_star_iteration,
  IR_NM_plus_iteration,
  IR_NM_code_insertion_atom,
  IR_NM_unit,
  IR_NM_group,
  IR_NM_range_atom,
  IR_NM_range_no_left_bound_atom,
  IR_NM_range_no_right_bound_atom,
  IR_NM_range_no_left_right_bounds_atom,
  IR_NM_identifier_or_literal_atom,
  IR_NM_string_atom,
  IR_NM_description,
  IR_NM_denotation,
  IR_NM_single_definition,
  IR_NM_single_term_definition,
  IR_NM_literal_range_definition,
  IR_NM_single_nonterm_definition,
  IR_NM_canonical_rule,
  IR_NM_right_hand_side_element,
  IR_NM_canonical_rule_element,
  IR_NM_canonical_rule_end,
  IR_NM_LR_situation,
  IR_NM_LR_set,
  IR_NM_LR_set_look_ahead_trie_node,
  IR_NM_back_track_alternative,
  IR_NM_conflict,
  IR_NM_regular_arc,
  IR_NM_rule_list_element,
  IR_NM_LR_core,
  IR_NM_DeRemer_dependence,
  IR_NM_LR_set_dependence,
  IR_NM_shift_dependence,
  IR_NM_shift_LR_situation_dependence,
  IR_NM_dependence_list_element,
  IR_NM__root,
  IR_NM__error
} IR_node_mode_t;

extern short _IR_node_level [];

extern unsigned char _IR_SF_node [];

extern unsigned char _IR_SF_identifier_or_literal [];

extern unsigned char _IR_SF_identifier [];

extern unsigned char _IR_SF_literal [];

extern unsigned char _IR_SF_string [];

extern unsigned char _IR_SF_number [];

extern unsigned char _IR_SF_code_insertion [];

extern unsigned char _IR_SF_additional_code [];

extern unsigned char _IR_SF_definition [];

extern unsigned char _IR_SF_start_definition [];

extern unsigned char _IR_SF_code [];

extern unsigned char _IR_SF_yacc_code [];

extern unsigned char _IR_SF_local_code [];

extern unsigned char _IR_SF_import_code [];

extern unsigned char _IR_SF_export_code [];

extern unsigned char _IR_SF_union_code [];

extern unsigned char _IR_SF_scanner_definition [];

extern unsigned char _IR_SF_expect_definition [];

extern unsigned char _IR_SF_symbol_definition [];

extern unsigned char _IR_SF_token_definition [];

extern unsigned char _IR_SF_left_definition [];

extern unsigned char _IR_SF_right_definition [];

extern unsigned char _IR_SF_nonassoc_definition [];

extern unsigned char _IR_SF_type_definition [];

extern unsigned char _IR_SF_symbol [];

extern unsigned char _IR_SF_rule [];

extern unsigned char _IR_SF_pattern [];

extern unsigned char _IR_SF_alternative [];

extern unsigned char _IR_SF_sequence [];

extern unsigned char _IR_SF_separator_iteration [];

extern unsigned char _IR_SF_sequence_element [];

extern unsigned char _IR_SF_control_point [];

extern unsigned char _IR_SF_default [];

extern unsigned char _IR_SF_star_iteration [];

extern unsigned char _IR_SF_plus_iteration [];

extern unsigned char _IR_SF_code_insertion_atom [];

extern unsigned char _IR_SF_unit [];

extern unsigned char _IR_SF_group [];

extern unsigned char _IR_SF_range_atom [];

extern unsigned char _IR_SF_range_no_left_bound_atom [];

extern unsigned char _IR_SF_range_no_right_bound_atom [];

extern unsigned char _IR_SF_range_no_left_right_bounds_atom [];

extern unsigned char _IR_SF_identifier_or_literal_atom [];

extern unsigned char _IR_SF_string_atom [];

extern unsigned char _IR_SF_description [];

extern unsigned char _IR_SF_denotation [];

extern unsigned char _IR_SF_single_definition [];

extern unsigned char _IR_SF_single_term_definition [];

extern unsigned char _IR_SF_literal_range_definition [];

extern unsigned char _IR_SF_single_nonterm_definition [];

extern unsigned char _IR_SF_canonical_rule [];

extern unsigned char _IR_SF_right_hand_side_element [];

extern unsigned char _IR_SF_canonical_rule_element [];

extern unsigned char _IR_SF_canonical_rule_end [];

extern unsigned char _IR_SF_LR_situation [];

extern unsigned char _IR_SF_LR_set [];

extern unsigned char _IR_SF_LR_set_look_ahead_trie_node [];

extern unsigned char _IR_SF_back_track_alternative [];

extern unsigned char _IR_SF_conflict [];

extern unsigned char _IR_SF_regular_arc [];

extern unsigned char _IR_SF_rule_list_element [];

extern unsigned char _IR_SF_LR_core [];

extern unsigned char _IR_SF_DeRemer_dependence [];

extern unsigned char _IR_SF_LR_set_dependence [];

extern unsigned char _IR_SF_shift_dependence [];

extern unsigned char _IR_SF_shift_LR_situation_dependence [];

extern unsigned char _IR_SF_dependence_list_element [];

extern unsigned char _IR_SF__root [];

extern unsigned char _IR_SF__error [];

extern unsigned char *_IR_is_type[];

extern unsigned char _IR_D_identifier_or_literal [];

extern unsigned char _IR_D_pattern [];

extern unsigned char _IR_D_iteration_unit [];

extern unsigned char _IR_D_corresponding_single_nonterm_definition [];

extern unsigned char _IR_D_pass_number [];

extern unsigned char _IR_D_next_cp_flag [];

extern unsigned char _IR_D_canonical_rule [];

extern unsigned char _IR_D_context [];

extern unsigned char _IR_D_LR_set [];

extern unsigned char _IR_D_result_LR_set_will_be_on_the_stack [];

extern void *_IR_class_structure_array [];

typedef struct IR_node *IR_node_t;

typedef struct _IR_double_link *IR_double_link_t;

struct _IR_double_link
{
  IR_node_t field_itself;
  IR_node_t link_owner;
  void (*set_function) (IR_node_t, IR_node_t);
  IR_double_link_t previous_link;
  IR_double_link_t next_link;
};

struct _IR_S_node
{
  position_t position;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_node _IR_S_node;
} _IR_node;

struct _IR_S_identifier_or_literal
{
  struct _IR_S_node _IR_M_node;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_identifier_or_literal _IR_S_identifier_or_literal;
} _IR_identifier_or_literal;

struct _IR_S_identifier
{
  struct _IR_S_identifier_or_literal _IR_M_identifier_or_literal;
  string_t identifier_itself;
  bool_t dot_presence_flag;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_identifier _IR_S_identifier;
} _IR_identifier;

struct _IR_S_literal
{
  struct _IR_S_identifier_or_literal _IR_M_identifier_or_literal;
  string_t character_representation;
  integer_t literal_code;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_literal _IR_S_literal;
} _IR_literal;

struct _IR_S_string
{
  struct _IR_S_node _IR_M_node;
  string_t string_representation;
  string_t string_itself;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_string _IR_S_string;
} _IR_string;

struct _IR_S_number
{
  struct _IR_S_node _IR_M_node;
  integer_t number_value;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_number _IR_S_number;
} _IR_number;

struct _IR_S_code_insertion
{
  struct _IR_S_node _IR_M_node;
  string_t code_insertion_itself;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_code_insertion _IR_S_code_insertion;
} _IR_code_insertion;

struct _IR_S_additional_code
{
  struct _IR_S_node _IR_M_node;
  string_t additional_code_itself;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_additional_code _IR_S_additional_code;
} _IR_additional_code;

struct _IR_S_definition
{
  struct _IR_S_node _IR_M_node;
  IR_node_t next_definition;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_definition _IR_S_definition;
} _IR_definition;

struct _IR_S_start_definition
{
  struct _IR_S_definition _IR_M_definition;
  IR_node_t identifier;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_start_definition _IR_S_start_definition;
} _IR_start_definition;

struct _IR_S_code
{
  struct _IR_S_definition _IR_M_definition;
  IR_node_t code_itself;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_code _IR_S_code;
} _IR_code;

struct _IR_S_yacc_code
{
  struct _IR_S_code _IR_M_code;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_yacc_code _IR_S_yacc_code;
} _IR_yacc_code;

struct _IR_S_local_code
{
  struct _IR_S_code _IR_M_code;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_local_code _IR_S_local_code;
} _IR_local_code;

struct _IR_S_import_code
{
  struct _IR_S_code _IR_M_code;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_import_code _IR_S_import_code;
} _IR_import_code;

struct _IR_S_export_code
{
  struct _IR_S_code _IR_M_code;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_export_code _IR_S_export_code;
} _IR_export_code;

struct _IR_S_union_code
{
  struct _IR_S_code _IR_M_code;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_union_code _IR_S_union_code;
} _IR_union_code;

struct _IR_S_scanner_definition
{
  struct _IR_S_definition _IR_M_definition;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_scanner_definition _IR_S_scanner_definition;
} _IR_scanner_definition;

struct _IR_S_expect_definition
{
  struct _IR_S_definition _IR_M_definition;
  IR_node_t expected_number;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_expect_definition _IR_S_expect_definition;
} _IR_expect_definition;

struct _IR_S_symbol_definition
{
  struct _IR_S_definition _IR_M_definition;
  IR_node_t symbol_list;
  IR_node_t tag;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_symbol_definition _IR_S_symbol_definition;
} _IR_symbol_definition;

struct _IR_S_token_definition
{
  struct _IR_S_symbol_definition _IR_M_symbol_definition;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_token_definition _IR_S_token_definition;
} _IR_token_definition;

struct _IR_S_left_definition
{
  struct _IR_S_symbol_definition _IR_M_symbol_definition;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_left_definition _IR_S_left_definition;
} _IR_left_definition;

struct _IR_S_right_definition
{
  struct _IR_S_symbol_definition _IR_M_symbol_definition;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_right_definition _IR_S_right_definition;
} _IR_right_definition;

struct _IR_S_nonassoc_definition
{
  struct _IR_S_symbol_definition _IR_M_symbol_definition;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_nonassoc_definition _IR_S_nonassoc_definition;
} _IR_nonassoc_definition;

struct _IR_S_type_definition
{
  struct _IR_S_symbol_definition _IR_M_symbol_definition;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_type_definition _IR_S_type_definition;
} _IR_type_definition;

struct _IR_S_symbol
{
  struct _IR_S_node _IR_M_node;
  IR_node_t identifier_or_literal;
  IR_node_t number;
  IR_node_t next_symbol;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_symbol _IR_S_symbol;
} _IR_symbol;

struct _IR_S_rule
{
  struct _IR_S_node _IR_M_node;
  IR_node_t nonterm_identifier;
  IR_node_t pattern;
  IR_node_t next_rule;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_rule _IR_S_rule;
} _IR_rule;

struct _IR_S_pattern
{
  struct _IR_S_node _IR_M_node;
  IR_node_t alternatives_list;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_pattern _IR_S_pattern;
} _IR_pattern;

struct _IR_S_denotation
{
  IR_node_t corresponding_single_nonterm_definition;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_denotation _IR_S_denotation;
} _IR_denotation;

struct _IR_S_alternative
{
  struct _IR_S_node _IR_M_node;
  struct _IR_S_denotation _IR_M_denotation;
  IR_node_t next_alternative;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_alternative _IR_S_alternative;
} _IR_alternative;

struct _IR_S_sequence
{
  struct _IR_S_alternative _IR_M_alternative;
  IR_node_t sequence;
  IR_node_t precedence_identifier_or_literal;
  IR_node_t max_look_ahead_number;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_sequence _IR_S_sequence;
} _IR_sequence;

struct _IR_S_separator_iteration
{
  struct _IR_S_alternative _IR_M_alternative;
  IR_node_t iteration_sequence;
  IR_node_t iteration_precedence_identifier_or_literal;
  IR_node_t iteration_max_look_ahead_number;
  IR_node_t separator_sequence;
  IR_node_t separator_precedence_identifier_or_literal;
  IR_node_t separator_max_look_ahead_number;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_separator_iteration _IR_S_separator_iteration;
} _IR_separator_iteration;

struct _IR_S_sequence_element
{
  struct _IR_S_node _IR_M_node;
  struct _IR_S_denotation _IR_M_denotation;
  IR_node_t next_sequence_element;
  IR_node_t sequence_element_identifier;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_sequence_element _IR_S_sequence_element;
} _IR_sequence_element;

struct _IR_S_control_point
{
  struct _IR_S_sequence_element _IR_M_sequence_element;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_control_point _IR_S_control_point;
} _IR_control_point;

struct _IR_S_default
{
  struct _IR_S_sequence_element _IR_M_sequence_element;
  IR_node_t default_pattern;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_default _IR_S_default;
} _IR_default;

struct _IR_S_star_iteration
{
  struct _IR_S_sequence_element _IR_M_sequence_element;
  IR_node_t iteration_unit;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_star_iteration _IR_S_star_iteration;
} _IR_star_iteration;

struct _IR_S_plus_iteration
{
  struct _IR_S_sequence_element _IR_M_sequence_element;
  IR_node_t iteration_unit;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_plus_iteration _IR_S_plus_iteration;
} _IR_plus_iteration;

struct _IR_S_code_insertion_atom
{
  struct _IR_S_sequence_element _IR_M_sequence_element;
  IR_node_t code_insertion;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_code_insertion_atom _IR_S_code_insertion_atom;
} _IR_code_insertion_atom;

struct _IR_S_unit
{
  struct _IR_S_sequence_element _IR_M_sequence_element;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_unit _IR_S_unit;
} _IR_unit;

struct _IR_S_group
{
  struct _IR_S_unit _IR_M_unit;
  IR_node_t pattern;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_group _IR_S_group;
} _IR_group;

struct _IR_S_range_atom
{
  struct _IR_S_unit _IR_M_unit;
  IR_node_t left_bound;
  IR_node_t right_bound;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_range_atom _IR_S_range_atom;
} _IR_range_atom;

struct _IR_S_range_no_left_bound_atom
{
  struct _IR_S_range_atom _IR_M_range_atom;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_range_no_left_bound_atom _IR_S_range_no_left_bound_atom;
} _IR_range_no_left_bound_atom;

struct _IR_S_range_no_right_bound_atom
{
  struct _IR_S_range_atom _IR_M_range_atom;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_range_no_right_bound_atom _IR_S_range_no_right_bound_atom;
} _IR_range_no_right_bound_atom;

struct _IR_S_range_no_left_right_bounds_atom
{
  struct _IR_S_range_atom _IR_M_range_atom;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_range_no_left_right_bounds_atom _IR_S_range_no_left_right_bounds_atom;
} _IR_range_no_left_right_bounds_atom;

struct _IR_S_identifier_or_literal_atom
{
  struct _IR_S_unit _IR_M_unit;
  IR_node_t identifier_or_literal;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_identifier_or_literal_atom _IR_S_identifier_or_literal_atom;
} _IR_identifier_or_literal_atom;

struct _IR_S_string_atom
{
  struct _IR_S_unit _IR_M_unit;
  IR_node_t string;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_string_atom _IR_S_string_atom;
} _IR_string_atom;

struct _IR_S_description
{
  struct _IR_S_node _IR_M_node;
  IR_node_t definition_list;
  IR_node_t rule_list;
  IR_node_t additional_code;
  IR_node_t union_code;
  IR_node_t single_definition_list;
  integer_t tokens_number;
  integer_t nonterminals_number;
  integer_t canonical_rules_number;
  integer_t duplicated_patterns_number;
  IR_node_t canonical_rule_list;
  IR_node_t axiom_identifier;
  IR_node_t axiom_definition;
  bool_t scanner_flag;
  integer_t expected_shift_reduce_conflicts_number;
  IR_node_t LR_core_list;
  integer_t splitted_LR_sets_number;
  integer_t LR_sets_number;
  integer_t pushed_LR_sets_number;
  integer_t reduces_number;
  integer_t all_number_of_regular_arcs;
  integer_t number_of_regular_arcs;
  integer_t token_equivalence_classes_number;
  integer_t duplicated_actions;
  bool_t back_tracking_exists;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_description _IR_S_description;
} _IR_description;

struct _IR_S_single_definition
{
  struct _IR_S_node _IR_M_node;
  IR_node_t type;
  bool_t accessibility_flag;
  IR_node_t single_definition_usage_list;
  IR_node_t identifier_or_literal;
  IR_node_t next_single_definition;
  IR_node_t last_symbol_LR_situation_processed;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_single_definition _IR_S_single_definition;
} _IR_single_definition;

struct _IR_S_single_term_definition
{
  struct _IR_S_single_definition _IR_M_single_definition;
  integer_t token_order_number;
  integer_t value;
  integer_t priority;
  bool_t left_assoc_flag;
  bool_t right_assoc_flag;
  bool_t nonassoc_flag;
  bool_t deletion_flag;
  IR_node_t next_equivalence_class_token;
  integer_t equivalence_class_number;
  bool_t token_was_processed_on_equivalence;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_single_term_definition _IR_S_single_term_definition;
} _IR_single_term_definition;

struct _IR_S_literal_range_definition
{
  struct _IR_S_single_term_definition _IR_M_single_term_definition;
  integer_t right_range_bound_value;
  bool_t bounds_have_explicit_values;
  IR_node_t right_range_bound_literal;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_literal_range_definition _IR_S_literal_range_definition;
} _IR_literal_range_definition;

struct _IR_S_single_nonterm_definition
{
  struct _IR_S_single_definition _IR_M_single_definition;
  integer_t nonterm_order_number;
  IR_node_t nonterm_canonical_rule_list;
  bool_t derivation_ability_flag;
  integer_t pass_number;
  IR_node_t corresponding_pattern;
  integer_t minimal_derived_string_length;
  context_t relation_FIRST;
  bool_t process_nonterminal_on_its_process_pass;
  bool_t pattern_has_been_output;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_single_nonterm_definition _IR_S_single_nonterm_definition;
} _IR_single_nonterm_definition;

struct _IR_S_canonical_rule
{
  struct _IR_S_node _IR_M_node;
  bool_t next_cp_flag;
  integer_t canonical_rule_order_number;
  IR_node_t next_nonterm_canonical_rule;
  IR_node_t precedence_single_term_definition;
  integer_t rule_priority;
  integer_t max_look_ahead_value;
  integer_t output_action_number;
  IR_node_t left_hand_side;
  IR_node_t right_hand_side;
  IR_node_t action;
  IR_node_t original_code_insertion_place;
  IR_node_t next_canonical_rule;
  IR_node_t canonical_rule_LR_situation;
  bool_t canonical_rule_action_has_been_output;
  integer_t action_code_copies_number;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_canonical_rule _IR_S_canonical_rule;
} _IR_canonical_rule;

struct _IR_S_right_hand_side_element
{
  struct _IR_S_node _IR_M_node;
  IR_node_t canonical_rule;
  IR_node_t next_right_hand_side_element;
  bool_t cp_start_flag;
  bool_t cp_flag;
  integer_t minimal_FIRST_of_rule_tail_length;
  context_t FIRST_of_rule_tail;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_right_hand_side_element _IR_S_right_hand_side_element;
} _IR_right_hand_side_element;

struct _IR_S_canonical_rule_element
{
  struct _IR_S_right_hand_side_element _IR_M_right_hand_side_element;
  bool_t next_cp_flag;
  IR_node_t element_itself;
  IR_node_t element_identifier;
  IR_node_t next_single_definition_usage;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_canonical_rule_element _IR_S_canonical_rule_element;
} _IR_canonical_rule_element;

struct _IR_S_canonical_rule_end
{
  struct _IR_S_right_hand_side_element _IR_M_right_hand_side_element;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_canonical_rule_end _IR_S_canonical_rule_end;
} _IR_canonical_rule_end;

struct _IR_S_LR_situation
{
  struct _IR_double_link goto_LR_set;
  bool_t goto_arc_has_been_removed;
  context_t look_ahead_context;
  bool_t first_symbol_LR_situation;
  IR_node_t next_symbol_LR_situation;
  bool_t important_LR_situation_flag;
  bool_t situation_in_stack_flag;
  bool_t under_control_point_flag;
  bool_t back_tracking_conflict_flag;
  IR_node_t corresponding_regular_arc;
  integer_t reduce_number;
  integer_t popped_LR_sets_number;
  integer_t popped_attributes_number;
  IR_node_t element_after_dot;
  context_t context;
  IR_node_t LR_set;
  IR_node_t next_LR_situation;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_LR_situation _IR_S_LR_situation;
} _IR_LR_situation;

struct _IR_S_LR_set
{
  IR_node_t conflicts_list;
  bool_t it_is_in_LALR_sets_stack;
  bool_t reachable_flag;
  bool_t it_is_pushed_LR_set;
  bool_t it_is_errored_LR_set;
  bool_t attribute_is_used;
  bool_t visit_flag;
  IR_node_t first_splitted_LR_set;
  IR_node_t next_splitted_LR_set;
  bool_t back_tracking_flag;
  bool_t it_is_in_reduce_action_LR_sets_stack;
  IR_node_t LR_set_look_ahead_trie;
  integer_t LR_set_order_number;
  integer_t term_arcs_number;
  integer_t nonterm_arcs_number;
  IR_node_t start_LR_set_pass;
  bool_t LR_set_has_been_output_in_comment;
  IR_node_t LR_situation_list;
  IR_node_t LR_core;
  IR_node_t next_LR_set;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_LR_set _IR_S_LR_set;
} _IR_LR_set;

struct _IR_S_LR_set_look_ahead_trie_node
{
  IR_node_t first_back_track_alternative;
  IR_node_t last_back_track_alternative;
  integer_t additional_action_table_number;
  IR_node_t corresponding_single_term_definition;
  IR_node_t corresponding_LR_situation;
  IR_node_t first_son;
  IR_node_t next_brother;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_LR_set_look_ahead_trie_node _IR_S_LR_set_look_ahead_trie_node;
} _IR_LR_set_look_ahead_trie_node;

struct _IR_S_back_track_alternative
{
  IR_node_t corresponding_LR_set_look_ahead_trie_node;
  IR_node_t next_back_track_alternative;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_back_track_alternative _IR_S_back_track_alternative;
} _IR_back_track_alternative;

struct _IR_S_conflict
{
  IR_node_t used_LR_situation;
  IR_node_t unused_LR_situation;
  token_string_t token_string;
  IR_node_t next_conflict;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_conflict _IR_S_conflict;
} _IR_conflict;

struct _IR_S_regular_arc
{
  IR_node_t first_rule_list_element;
  IR_node_t last_rule_list_element;
  integer_t regular_arc_popped_LR_sets_number;
  integer_t regular_arc_popped_attributes_number;
  integer_t max_states_stack_increment;
  integer_t max_attributes_stack_increment;
  bool_t first_equivalent_regular_arc_flag;
  IR_node_t next_equivalent_regular_arc;
  integer_t number_of_regular_arc;
  bool_t result_LR_set_will_be_on_the_stack;
  IR_node_t from_LR_situation;
  struct _IR_double_link to_LR_set;
  IR_node_t terminal_marking_arc;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_regular_arc _IR_S_regular_arc;
} _IR_regular_arc;

struct _IR_S_rule_list_element
{
  integer_t right_hand_side_used_attributes_number;
  bool_t lhs_nonterm_attribute_is_used;
  bool_t result_LR_set_will_be_on_the_stack;
  IR_node_t canonical_rule;
  IR_node_t next_rule_list_element;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_rule_list_element _IR_S_rule_list_element;
} _IR_rule_list_element;

struct _IR_S_LR_core
{
  bool_t first_pass_flag;
  bool_t second_pass_flag;
  IR_node_t LR_set_list;
  IR_node_t next_LR_core;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_LR_core _IR_S_LR_core;
} _IR_LR_core;

struct _IR_S_DeRemer_dependence
{
  context_t context;
  IR_node_t dependencies;
  bool_t context_has_been_evaluated;
  integer_t pass_number;
  integer_t unique_number;
  integer_t look_ahead;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_DeRemer_dependence _IR_S_DeRemer_dependence;
} _IR_DeRemer_dependence;

struct _IR_S_LR_set_dependence
{
  struct _IR_S_DeRemer_dependence _IR_M_DeRemer_dependence;
  IR_node_t LR_set;
  integer_t back_distance;
  IR_node_t nonterm;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_LR_set_dependence _IR_S_LR_set_dependence;
} _IR_LR_set_dependence;

struct _IR_S_shift_dependence
{
  struct _IR_S_DeRemer_dependence _IR_M_DeRemer_dependence;
  IR_node_t token;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_shift_dependence _IR_S_shift_dependence;
} _IR_shift_dependence;

struct _IR_S_shift_LR_situation_dependence
{
  struct _IR_S_shift_dependence _IR_M_shift_dependence;
  IR_node_t shift_LR_situation;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_shift_LR_situation_dependence _IR_S_shift_LR_situation_dependence;
} _IR_shift_LR_situation_dependence;

struct _IR_S_dependence_list_element
{
  IR_node_t dependence;
  IR_node_t next_dependence_list_element;
};

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
  struct _IR_S_dependence_list_element _IR_S_dependence_list_element;
} _IR_dependence_list_element;

typedef struct IR_node
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
} _IR__root;

typedef struct
{
  IR_node_mode_t _IR_node_mode;
  IR_double_link_t _IR_first_link;
} _IR__error;



extern char *IR_node_name[];

extern unsigned char IR_node_size[];







extern void _IR_set_double_field_value
  (IR_double_link_t link, IR_node_t value, int disp, int flag);

extern IR_double_link_t IR__first_double_link (IR_node_t node);
extern void IR__set_double_link (IR_double_link_t link, IR_node_t value);

extern void IR_F_set_goto_LR_set (IR_node_t _node, IR_node_t _value);

extern void IR_F_set_to_LR_set (IR_node_t _node, IR_node_t _value);
extern IR_node_t IR_create_node (IR_node_mode_t node_mode);

extern IR_node_t IR_new_identifier
(position_t position,
 string_t identifier_itself,
 bool_t dot_presence_flag);

extern IR_node_t IR_new_literal
(position_t position,
 string_t character_representation,
 integer_t literal_code);

extern IR_node_t IR_new_string
(position_t position,
 string_t string_representation,
 string_t string_itself);

extern IR_node_t IR_new_number
(position_t position,
 integer_t number_value);

extern IR_node_t IR_new_code_insertion
(position_t position,
 string_t code_insertion_itself);

extern IR_node_t IR_new_additional_code
(position_t position,
 string_t additional_code_itself);

extern IR_node_t IR_new_start_definition
(position_t position,
 IR_node_t next_definition,
 IR_node_t identifier);

extern IR_node_t IR_new_yacc_code
(position_t position,
 IR_node_t next_definition,
 IR_node_t code_itself);

extern IR_node_t IR_new_local_code
(position_t position,
 IR_node_t next_definition,
 IR_node_t code_itself);

extern IR_node_t IR_new_import_code
(position_t position,
 IR_node_t next_definition,
 IR_node_t code_itself);

extern IR_node_t IR_new_export_code
(position_t position,
 IR_node_t next_definition,
 IR_node_t code_itself);

extern IR_node_t IR_new_union_code
(position_t position,
 IR_node_t next_definition,
 IR_node_t code_itself);

extern IR_node_t IR_new_scanner_definition
(position_t position,
 IR_node_t next_definition);

extern IR_node_t IR_new_expect_definition
(position_t position,
 IR_node_t next_definition,
 IR_node_t expected_number);

extern IR_node_t IR_new_token_definition
(position_t position,
 IR_node_t next_definition,
 IR_node_t symbol_list,
 IR_node_t tag);

extern IR_node_t IR_new_left_definition
(position_t position,
 IR_node_t next_definition,
 IR_node_t symbol_list,
 IR_node_t tag);

extern IR_node_t IR_new_right_definition
(position_t position,
 IR_node_t next_definition,
 IR_node_t symbol_list,
 IR_node_t tag);

extern IR_node_t IR_new_nonassoc_definition
(position_t position,
 IR_node_t next_definition,
 IR_node_t symbol_list,
 IR_node_t tag);

extern IR_node_t IR_new_type_definition
(position_t position,
 IR_node_t next_definition,
 IR_node_t symbol_list,
 IR_node_t tag);

extern IR_node_t IR_new_symbol
(position_t position,
 IR_node_t identifier_or_literal,
 IR_node_t number,
 IR_node_t next_symbol);

extern IR_node_t IR_new_rule
(position_t position,
 IR_node_t nonterm_identifier,
 IR_node_t pattern,
 IR_node_t next_rule);

extern IR_node_t IR_new_pattern
(position_t position,
 IR_node_t alternatives_list);

extern IR_node_t IR_new_sequence
(position_t position,
 IR_node_t next_alternative,
 IR_node_t sequence,
 IR_node_t precedence_identifier_or_literal,
 IR_node_t max_look_ahead_number);

extern IR_node_t IR_new_separator_iteration
(position_t position,
 IR_node_t next_alternative,
 IR_node_t iteration_sequence,
 IR_node_t iteration_precedence_identifier_or_literal,
 IR_node_t iteration_max_look_ahead_number,
 IR_node_t separator_sequence,
 IR_node_t separator_precedence_identifier_or_literal,
 IR_node_t separator_max_look_ahead_number);

extern IR_node_t IR_new_control_point
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier);

extern IR_node_t IR_new_default
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier,
 IR_node_t default_pattern);

extern IR_node_t IR_new_star_iteration
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier,
 IR_node_t iteration_unit);

extern IR_node_t IR_new_plus_iteration
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier,
 IR_node_t iteration_unit);

extern IR_node_t IR_new_code_insertion_atom
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier,
 IR_node_t code_insertion);

extern IR_node_t IR_new_group
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier,
 IR_node_t pattern);

extern IR_node_t IR_new_range_atom
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier,
 IR_node_t left_bound,
 IR_node_t right_bound);

extern IR_node_t IR_new_range_no_left_bound_atom
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier,
 IR_node_t left_bound,
 IR_node_t right_bound);

extern IR_node_t IR_new_range_no_right_bound_atom
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier,
 IR_node_t left_bound,
 IR_node_t right_bound);

extern IR_node_t IR_new_range_no_left_right_bounds_atom
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier,
 IR_node_t left_bound,
 IR_node_t right_bound);

extern IR_node_t IR_new_identifier_or_literal_atom
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier,
 IR_node_t identifier_or_literal);

extern IR_node_t IR_new_string_atom
(position_t position,
 IR_node_t next_sequence_element,
 IR_node_t sequence_element_identifier,
 IR_node_t string);

extern IR_node_t IR_new_description
(position_t position,
 IR_node_t definition_list,
 IR_node_t rule_list,
 IR_node_t additional_code);

extern IR_node_t IR_new_single_term_definition
(position_t position,
 IR_node_t identifier_or_literal,
 IR_node_t next_single_definition);

extern IR_node_t IR_new_literal_range_definition
(position_t position,
 IR_node_t identifier_or_literal,
 IR_node_t next_single_definition,
 IR_node_t right_range_bound_literal);

extern IR_node_t IR_new_single_nonterm_definition
(position_t position,
 IR_node_t identifier_or_literal,
 IR_node_t next_single_definition,
 IR_node_t corresponding_pattern);

extern IR_node_t IR_new_canonical_rule
(position_t position,
 IR_node_t left_hand_side,
 IR_node_t right_hand_side,
 IR_node_t action,
 IR_node_t original_code_insertion_place,
 IR_node_t next_canonical_rule);

extern IR_node_t IR_new_canonical_rule_element
(position_t position,
 IR_node_t canonical_rule,
 IR_node_t next_right_hand_side_element,
 IR_node_t element_itself,
 IR_node_t element_identifier,
 IR_node_t next_single_definition_usage);

extern IR_node_t IR_new_canonical_rule_end
(position_t position,
 IR_node_t canonical_rule,
 IR_node_t next_right_hand_side_element);

extern IR_node_t IR_new_LR_situation
(IR_node_t element_after_dot,
 context_t context,
 IR_node_t LR_set,
 IR_node_t next_LR_situation);

extern IR_node_t IR_new_LR_set
(IR_node_t LR_situation_list,
 IR_node_t LR_core,
 IR_node_t next_LR_set);

extern IR_node_t IR_new_LR_set_look_ahead_trie_node
(IR_node_t corresponding_single_term_definition,
 IR_node_t corresponding_LR_situation,
 IR_node_t first_son,
 IR_node_t next_brother);

extern IR_node_t IR_new_back_track_alternative
(IR_node_t corresponding_LR_set_look_ahead_trie_node,
 IR_node_t next_back_track_alternative);

extern IR_node_t IR_new_conflict
(IR_node_t used_LR_situation,
 IR_node_t unused_LR_situation,
 token_string_t token_string,
 IR_node_t next_conflict);

extern IR_node_t IR_new_regular_arc
(IR_node_t from_LR_situation,
 IR_node_t to_LR_set,
 IR_node_t terminal_marking_arc);

extern IR_node_t IR_new_rule_list_element
(IR_node_t canonical_rule,
 IR_node_t next_rule_list_element);

extern IR_node_t IR_new_LR_core
(IR_node_t LR_set_list,
 IR_node_t next_LR_core);

extern IR_node_t IR_new_LR_set_dependence
(integer_t look_ahead,
 IR_node_t LR_set,
 integer_t back_distance,
 IR_node_t nonterm);

extern IR_node_t IR_new_shift_dependence
(integer_t look_ahead,
 IR_node_t token);

extern IR_node_t IR_new_shift_LR_situation_dependence
(integer_t look_ahead,
 IR_node_t token,
 IR_node_t shift_LR_situation);

extern IR_node_t IR_new_dependence_list_element
(IR_node_t dependence,
 IR_node_t next_dependence_list_element);

extern IR_node_t IR_copy_node (IR_node_t node);

extern void IR_start (void);

extern void IR_stop (void);
extern os_t irp;

void process_canonical_rule_action
      (IR_node_t canonical_rule, void (*process_char) (char ch),
       void (*process_attribute) (IR_node_t canonical_rule,
                                  position_t attribute_position,
                                  const char *tag_name,
                                  const char *attribute_name));
extern int define_flag;
extern int line_flag;
extern int trace_flag;
extern int verbose_flag;
extern const char *file_prefix;
extern const char *sym_prefix;
extern int w_flag;
extern int cpp_flag;
extern int enum_flag;
extern int error_reduce_flag;
extern int error_conflict_flag;
extern int pattern_equiv_flag;
extern int full_lr_set_flag;
extern int lr_situation_context_flag;
extern int removed_lr_sets_flag;
extern int look_ahead_number;
extern int lr_flag;
extern int lalr_optimization_flag;
extern int regular_optimization_flag;
extern int split_lr_sets_flag;
extern int split_lr_sets_flag_is_defined;
extern int msta_error_recovery;
extern int yacc_input_flag;
extern int strict_flag;
extern int yacc_file_names_flag;
extern int expand_flag;
extern int time_flag;

extern int debug_level;

extern const char *output_files_name;
extern const char *source_file_name;

extern FILE *output_description_file;
extern char *output_description_file_name;

extern FILE *output_interface_file;
extern char *output_interface_file_name;

extern FILE *output_implementation_file;
extern char *output_implementation_file_name;

extern FILE *output_description_file;
extern char *output_description_file_name;

extern IR_node_t description;

extern IR_node_t error_single_definition;

extern int max_look_ahead_number;
extern IR_node_t end_marker_single_definition;
extern int real_look_ahead_number;

int canonical_rule_right_hand_side_prefix_length
           (IR_node_t canonical_rule, IR_node_t bound_right_hand_side_element);
void traverse_all_LR_set_predecessor_paths
                       (IR_node_t LR_set, int path_length,
                        int (*applied_function) (IR_node_t LR_set),
                        int start_length_for_function);
void initiate_traverse_cache (void);
void traverse_all_LR_set_predecessors
                       (IR_node_t LR_set, int path_length,
                        int (*applied_function) (IR_node_t LR_set));
void traverse_cache_off (void);
void traverse_cache_on (void);
void finish_traverse_cache (void);
void reverse_traverse_all_LR_set_predecessor_paths
                       (IR_node_t LR_set, int path_length,
                        void (*applied_function) (IR_node_t LR_set),
                        int start_length_for_function);
IR_node_t characteristic_symbol_of_LR_set (IR_node_t LR_set);
void initiate_goto_set_cache (void);
IR_node_t find_goto_LR_situation (IR_node_t LR_set,
                                  IR_node_t single_definition);
IR_node_t goto_by_nonterminal (IR_node_t LR_set, IR_node_t single_definition);
void finish_goto_set_cache (void);
void LR_set_conflicts_number (IR_node_t LR_set,
                              int *shift_reduce_conflicts_number,
                              int *reduce_reduce_conflicts_number);
int attribute_name_to_attribute_number
                             (const char *attribute_name,
                              IR_node_t canonical_rule,
                              IR_node_t bound_right_hand_side_element);
IR_node_t get_the_single_LR_set_predecessor (IR_node_t LR_set,
                                             int path_length);
int pushed_LR_sets_or_attributes_number_on_path (IR_node_t LR_set, int length,
                                                 int attribute_flag);
void output_string (FILE *f, const char *string);
void output_char (int ch, FILE *f);
void output_decimal_number (FILE *f, int number, int minimum_width);
void initiate_output (void);
int identifier_or_literal_representation (IR_node_t identifier_or_literal,
                                          int in_string_flag,
                                          vlo_t *representation);
int output_identifier_or_literal (FILE *f, IR_node_t identifier_or_literal,
                                  int in_string_flag);
void single_definition_representation (IR_node_t single_definition,
                                       vlo_t *representation);
void output_single_definition (FILE *f, IR_node_t single_definition);
void output_line (FILE *f, int line_number, const char *file_name);
void output_current_line (FILE *f);
token_string_t get_new_token_string (IR_node_t *tokens, int tokens_number);
IR_node_t get_n_th_token (token_string_t token_string, int n);
int token_string_comparison (token_string_t token_string_1,
                             token_string_t token_string_2);
int token_string_length (token_string_t token_string);
token_string_t token_string_shortening
                     (token_string_t token_string,
                      int maximum_result_token_string_length);
void output_token_string (token_string_t token_string, FILE *f);

extern context_t null_context_in_table;

context_t get_null_context (void);
void free_context (context_t context);
int it_is_in_context (int order_number, context_t context);
void set_context_element_value (context_t context,
                                token_string_t element_number,
                                int element_value);
void context_copy (context_t to, context_t from);
void zero_context (context_t context);
int context_size (context_t context);
int it_is_zero_context (context_t context);
int context_in (context_t context_1, context_t context_2);
void context_or (context_t context_1, context_t context_2);
void context_and (context_t context_1, context_t context_2);
void context_or_of_and (context_t or_context,
                        context_t and_context_1, context_t and_context_2);
void context_subtraction (context_t context_1, context_t context_2);
void context_concat (context_t context_1, context_t context_2,
                     int maximum_result_token_string_length);
void process_context_token_strings
                    (context_t context,
                     void (*applied_function) (token_string_t token_string));
context_t context_shortening (context_t context,
                              int maximum_result_token_string_length);
unsigned context_hash_value (context_t context);
int context_eq (context_t context_1, context_t context_2);
context_t insert_or_free_context (context_t context_outside_table);
void output_context (FILE *f, context_t context);
void initiate_contexts (void);
void finish_contexts (void);
void output_parser (void);



extern void __assert_fail (const char *__assertion, const char *__file,
      unsigned int __line, const char *__function)
     ;


extern void __assert_perror_fail (int __errnum, const char *__file,
      unsigned int __line,
      const char *__function)
     ;




extern void __assert (const char *__assertion, const char *__file, int __line)
     ;
