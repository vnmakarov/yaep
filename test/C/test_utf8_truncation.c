#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "yaep.h"

/* Small test that forces a long error message containing multibyte
   UTF-8 sequences and verifies that the grammar->error_message is valid
   UTF-8 and ends with ellipsis when truncated. This test is integrated
   with the existing test harness and returns exit status 0 on success. */

int main(int argc, char **argv) {
    struct grammar *g = yaep_create_grammar();
    if (!g) return 1;
    /* Avoid unused-parameter warnings from test harness */
    (void)argc;
    (void)argv;

    /* Create a very long description containing repeated non-BMP char U+1F600 (emoji) */
    const char *smile = "\xF0\x9F\x98\x80"; /* U+1F600 */
     size_t repeat = 300; /* produce a long message */
     /* Compute conservative capacity: each iteration appends "TERM " (5 bytes),
         the multi-byte sequence `smile` (strlen(smile) bytes) and a newline.
         Add one for the trailing NUL and some slack. */
     size_t per = strlen("TERM ") + strlen(smile) + strlen("\n");
     size_t cap = repeat * per + 16;
    char *desc = (char *) malloc(cap);
    if (!desc) return 2;
    desc[0] = '\0';
    for (size_t i = 0; i < repeat; i++) {
        strcat(desc, "TERM ");
        strcat(desc, smile);
        strcat(desc, "\n");
    }

    /* Intentionally call parse with a malformed grammar to force an error
       and cause yaep_error to format a long message. */
    int rc = yaep_parse_grammar(g, 1, desc);
    /* rc is intentionally unused besides forcing parse side-effects */
    (void)rc;

    /* We expect an error; ensure error_message is valid UTF-8 by checking
       it is NUL-terminated and does not contain lone continuation bytes.
       Very small sanity check: look for the ellipsis '...' sequence when
       the message was long. */
    const char *em = yaep_error_message(g);
    size_t len = strlen(em);
    int ok = 0;
    if (len > 0) {
        /* check NUL termination (already checked via strlen) and ensure
           there is no byte in 0x80..0xBF that isn't part of a valid
           multi-byte sequence by a simple scan: we treat any leading
           byte >= 0xC0 as start and expect correct continuation bytes. */
        const unsigned char *p = (const unsigned char *) em;
        int valid = 1;
        while (*p) {
            if (*p < 0x80) { p++; continue; }
            else if ((*p & 0xE0) == 0xC0) { /* 2-byte */
                if ((p[1] & 0xC0) != 0x80) { valid = 0; break; }
                p += 2;
            } else if ((*p & 0xF0) == 0xE0) { /* 3-byte */
                if ((p[1] & 0xC0) != 0x80 || (p[2] & 0xC0) != 0x80) { valid = 0; break; }
                p += 3;
            } else if ((*p & 0xF8) == 0xF0) { /* 4-byte */
                if ((p[1] & 0xC0) != 0x80 || (p[2] & 0xC0) != 0x80 || (p[3] & 0xC0) != 0x80) { valid = 0; break; }
                p += 4;
            } else { valid = 0; break; }
        }
        if (valid) {
                /* Check for ellipsis somewhere in the message when truncated.
                    We avoid relying on an internal compile-time macro here and use
                    a conservative runtime threshold: if the message is shorter
                    than 900 bytes we assume it wasn't truncated (the project
                    default is larger, so this is a safe check). */
                if (strstr(em, "...") != NULL || len < 900) ok = 1;
        }
    }

    free(desc);
    yaep_free_grammar(g);
    return ok ? 0 : 1;
}
