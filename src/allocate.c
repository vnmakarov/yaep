#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include"allocate.h"

struct YaepAllocator {
	Yaep_malloc malloc;
	Yaep_calloc calloc;
	Yaep_realloc realloc;
	Yaep_free free;
	Yaep_alloc_error alloc_error;
	void * userptr;
};

void yaep_alloc_defaulterrfunc( void * ignored ) {
	( void ) ignored;

	fputs( "*** out of memory ***\n", stderr );
	exit( EXIT_FAILURE );
}

struct YaepAllocator * yaep_alloc_new( Yaep_malloc mallocf, Yaep_calloc callocf, Yaep_realloc reallocf, Yaep_free freef ) {
	struct YaepAllocator * result;

	/* Sanity checks */
	if ( mallocf == NULL ) {
		mallocf = malloc;
	}
	if ( ( callocf == NULL ) && ( mallocf == malloc ) ) {
		callocf = calloc;
	}
	if ( reallocf == NULL ) {
		if ( ( mallocf == malloc ) && ( callocf == calloc ) ) {
			reallocf = realloc;
		} else {
			return NULL;
		}
	}
	if ( freef == NULL ) {
		if ( ( mallocf == malloc ) && ( callocf == calloc ) && ( reallocf == realloc ) ) {
			freef = free;
		} else {
			return NULL;
		}
	}

	/* Allocate allocator */
	result = mallocf( sizeof( *result ) );
	if ( result == NULL ) {
		return NULL;
	}
	result->malloc = mallocf;
	result->calloc = callocf;
	result->realloc = reallocf;
	result->free = freef;
	result->alloc_error = yaep_alloc_defaulterrfunc;
	result->userptr = result;

	return result;
}

void yaep_alloc_del( struct YaepAllocator * allocator ) {
	if ( allocator != NULL ) {
		Yaep_free freef = allocator->free;
		freef( allocator );
	}
}

void * yaep_malloc( struct YaepAllocator * allocator, size_t size ) {
	void * result;

	if ( allocator == NULL ) {
		return NULL;
	}

	result = allocator->malloc( size );
	if ( ( result == NULL ) && ( size != 0 ) ) {
		allocator->alloc_error( allocator->userptr );
	}

	return result;
}

void * yaep_calloc( struct YaepAllocator * allocator, size_t nmemb, size_t size ) {
	void * result;

	if ( allocator == NULL ) {
		return NULL;
	}

	if ( allocator->calloc != NULL ) {
		result = allocator->calloc( nmemb, size );
	} else if ( ( nmemb == 0 ) || ( size == 0 ) ) {
		result = NULL;
	} else {
		size_t total = nmemb * size;
		if ( total / nmemb != size ) {
			result = NULL;
		} else {
			result = allocator->malloc( total );
			if ( result != NULL ) {
				memset( result, '\0', total );
			}
		}
	}

	if ( ( result == NULL ) && ( nmemb != 0 ) && ( size != 0 ) ) {
		allocator->alloc_error( allocator->userptr );
	}

	return result;
}

void * yaep_realloc( struct YaepAllocator * allocator, void * ptr, size_t size ) {
	void * result;

	if ( allocator == NULL ) {
		return NULL;
	}

	result = allocator->realloc( ptr, size );
	if ( ( result == NULL ) && ( size != 0 ) ) {
		allocator->alloc_error( allocator->userptr );
	}

	return result;
}

void yaep_free( struct YaepAllocator * allocator, void * ptr ) {
	if ( allocator != NULL ) {
		allocator->free( ptr );
	}
}

Yaep_alloc_error yaep_alloc_geterrfunc( YaepAllocator * allocator ) {
	if ( allocator != NULL ) {
		return allocator->alloc_error;
	} else {
		return NULL;
	}
}

void * yaep_alloc_getuserptr( YaepAllocator * allocator ) {
	if ( allocator != NULL ) {
		return allocator->userptr;
	} else {
		return NULL;
	}
}

void yaep_alloc_seterr( YaepAllocator * allocator, Yaep_alloc_error errfunc, void * userptr ) {
	if ( allocator != NULL ) {
		if ( errfunc != NULL ) {
			allocator->alloc_error = errfunc;
		} else {
			allocator->alloc_error = yaep_alloc_defaulterrfunc;
		}
		allocator->userptr = userptr;
	}
}
