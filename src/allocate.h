/*
   YAEP (Yet Another Earley Parser)

   Copyright (c) 1997-2018  Vladimir Makarov <vmakarov@gcc.gnu.org>

   Permission is hereby granted, free of charge, to any person obtaining a
   copy of this software and associated documentation files (the
   "Software"), to deal in the Software without restriction, including
   without limitation the rights to use, copy, modify, merge, publish,
   distribute, sublicense, and/or sell copies of the Software, and to
   permit persons to whom the Software is furnished to do so, subject to
   the following conditions:

   The above copyright notice and this permission notice shall be included
   in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

/**
 * @file allocate.h
 *
 * Memory allocation with error handling.
 */

#ifndef YAEP_ALLOCATE_H_
#define YAEP_ALLOCATE_H_

#ifdef __cplusplus
extern "C"
{
#endif

#include<stddef.h>

/**
 * Type for functions behaving like standard malloc().
 *
 * @sa #Yaep_calloc()
 * @sa #Yaep_realloc()
 * @sa #Yaep_free()
 */
typedef void *(*Yaep_malloc) (size_t);

/**
 * Type for functions behaving like standard calloc().
 *
 * @sa #Yaep_malloc()
 * @sa #Yaep_realloc()
 * @sa #Yaep_free()
 */
typedef void *(*Yaep_calloc) (size_t, size_t);

/**
 * Type for functions behaving like standard realloc().
 *
 * @sa #Yaep_malloc()
 * @sa #Yaep_calloc()
 * @sa #Yaep_free()
 */
typedef void *(*Yaep_realloc) (void *, size_t);

/**
 * Type for functions behaving like standard free().
 *
 * @sa #Yaep_malloc()
 * @sa #Yaep_calloc()
 * @sa #Yaep_realloc()
 */
typedef void (*Yaep_free) (void *ptr);

/**
 * Callback type for allocation errors.
 *
 * It is not necessary for callbacks of this type
 * to return to the caller.
 *
 * @param userptr Pointer provided earlier by the caller.
 *
 * @sa #yaep_alloc_geterrfunc()
 * @sa #yaep_alloc_seterr()
 */
typedef void (*Yaep_alloc_error) (void *userptr);

/**
 * YAEP allocator type.
 *
 * @sa #yaep_alloc_new()
 */
typedef struct YaepAllocator YaepAllocator;

/**
 * Default error handling function.
 *
 * This function writes an error message to @ stderr
 * and exits the program.
 *
 * @param ignored Ignored parameter.
 *
 * @sa #yaep_alloc_seterr()
 */
void yaep_alloc_defaulterrfunc (void *ignored);

/**
 * Creates a new allocator.
 *
 * The new allocator uses #yaep_alloc_defaulterrfunc()
 * and a null user pointer.
 *
 * @param mallocf Pointer to function which behaves like @c malloc().
 * 	If this is a null pointer, @c malloc() is used instead.
 * @param callocf Pointer to function which behaves like @c calloc().
 * 	If this is a null pointer, a function which behaves like @c calloc()
 * 	and is compatible with the provided @c mallocf is used instead.
 * @param reallocf Pointer to function which behaves analogously to
 * 	@c realloc() with respect to @c mallocf and @c callocf.
 * 	If this is a null pointer, and @c malloc() and @c calloc() are used
 * 	for @c mallocf and @c callocf, respectively,
 * 	then @c realloc() is used instead.
 * 	Everything else is an error.
 * @param freef Pointer to function which can free memory returned by
 * 	@c mallocf, @c callocf, and @c reallocf.
 * 	If this is a null pointer, and @c malloc(), @c calloc(), and
 * 	@c realloc() are used for @c mallocf, @c callocf, and @c reallocf,
 * 	respectively, then @c free() is used instead.
 * 	Everything else is an error.
 *
 * @return On success, a pointer to the new allocator is returned.\n
 * 	On error, a null pointer is returned.
 *
 * @sa #yaep_alloc_del()
 * @sa #yaep_alloc_seterr()
 * @sa #yaep_alloc_defaulterrfunc()
 */
YaepAllocator *yaep_alloc_new (Yaep_malloc mallocf, Yaep_calloc callocf,
			       Yaep_realloc reallocf, Yaep_free freef);

/**
 * Destroys an allocator.
 *
 * @param allocator Pointer to allocator.
 *
 * @sa #yaep_alloc_new()
 */
void yaep_alloc_del (YaepAllocator * allocator);

/**
 * Allocates memory.
 *
 * @param allocator Pointer to allocator.
 * @param size Number of bytes to allocate.
 *
 * @return On success, a pointer to the allocated memory is returned.
 * 	If @c size was zero, this may be a null pointer.\n
 * 	On error, the allocator's error function is called.
 * 	If that function returns, a null pointer is returned.
 *
 * @sa #yaep_free()
 * @sa #yaep_realloc()
 * @sa #yaep_calloc()
 * @sa #yaep_alloc_seterr()
 */
void *yaep_malloc (YaepAllocator * allocator, size_t size);

/**
 * Allocates zero-initialised memory.
 *
 * @param allocator Pointer to allocator.
 * @param nmemb Number of elements to allocate.
 * @param size Element size in bytes.
 *
 * @return On success, a pointer to <code>nmemb * size</code> bytes
 * 	of newly allocated, zero-initialised  memory is returned.
 * 	If <code>nmemb * size</code> was zero, this may be a null pointer.\n
 * 	On error, the allocator's error function is called.
 * 	If that function returns, a null pointer is returned.
 *
 * @sa #yaep_free()
 * @sa #yaep_realloc()
 * @sa #yaep_malloc()
 * @sa #yaep_alloc_seterr()
 */
void *yaep_calloc (YaepAllocator * allocator, size_t nmemb, size_t size);

/**
 * Resizes memory.
 *
 * @param allocator Pointer to allocator previously used to
 * 	allocate @c ptr.
 * @param ptr Pointer to memory previously returned by
 * 	#yaep_malloc(), #yaep_calloc(), or #yaep_realloc().
 * 	If this is a null pointer, this function behaves like #yaep_malloc().
 * @param size New memory size in bytes.
 *
 * @return On success, a pointer to @c size bytes of allocated memory
 * 	is returned, the contents of which is equal to the contents of
 * 	@c ptr immediately before the call, up to the smaller size of
 * 	both blocks.\n
 * 	On error, the allocator's error function is called.
 * 	If that function returns, a null pointer is returned.
 *
 * @sa #yaep_free()
 * @sa #yaep_malloc()
 * @sa #yaep_calloc()
 * @sa #yaep_alloc_seterr()
 */
void *yaep_realloc (YaepAllocator * allocator, void *ptr, size_t size);

/**
 * Frees previously allocated memory.
 *
 * @param allocator Pointer to allocator previously used to
 * 	allocate @c ptr.
 * @param ptr Pointer to memory to be freed.
 * 	If this is a null pointer, no operation is performed.
 *
 * @sa #yaep_malloc()
 * @sa #yaep_calloc()
 * @sa #yaep_realloc()
 */
void yaep_free (YaepAllocator * allocator, void *ptr);

/**
 * Obtains the current error function of an allocator.
 *
 * @param allocator Pointer to allocator.
 *
 * @return On success, a pointer to the error function of the
 * 	specified allocator is returned.
 * 	If no error function has ever been set for this allocator,
 * 	this is #yaep_alloc_defaulterrfunc().\n
 * 	On error, a null pointer is returned.
 *
 * @sa #yaep_alloc_getuserptr()
 * @sa #yaep_alloc_seterr()
 * @sa #yaep_alloc_defaulterrfunc()
 */
Yaep_alloc_error yaep_alloc_geterrfunc (YaepAllocator * allocator);

/**
 * Obtains the current user-provided pointer.
 *
 * @param allocator Pointer to allocator.
 *
 * @return On success, the user-provided pointer of the
 * 	specified allocator is returned.
 * 	If no pointer has ever been set for this allocator,
 * 	a pointer to the allocator itself is returned.\n
 * 	On error, a null pointer is returned.
 *
 * @sa #yaep_alloc_seterr()
 */
void *yaep_alloc_getuserptr (YaepAllocator * allocator);

/**
 * Sets the error function and user-provided pointer of an allocator.
 *
 * The error function is called by the allocator with the user-provided
 * pointer as argument whenever an allocation error occurs.
 *
 * @param allocator Pointer to allocator.
 * @param errfunc Pointer to error function.
 * 	If this is a null pointer, #yaep_alloc_defaulterrfunc() will be used.
 * @param userptr User-provided pointer.
 * 	The allocator will never attempt to dereference this pointer.
 *
 * @sa #yaep_alloc_geterrfunc()
 * @sa #yaep_alloc_getuserptr()
 */
void yaep_alloc_seterr (YaepAllocator * allocator, Yaep_alloc_error errfunc,
			void *userptr);

#ifdef __cplusplus
}
#endif

#endif
