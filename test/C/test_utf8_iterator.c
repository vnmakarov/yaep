#include <stdio.h>
#include <string.h>
#include "../../src/unicode/yaep_unicode.h"

int main(void)
{
    const char *s = "A"; /* ASCII */
    size_t len = 0;
    const char *p = s;
    yaep_codepoint_t cp = yaep_utf8_next_with_len(&p, &len);
    if (cp != 'A' || len != 1) {
        fprintf(stderr, "ASCII test failed: cp=%u len=%zu\n", (unsigned)cp, len);
        return 1;
    }

    /* U+1F600 GRINNING FACE (4 bytes) */
    const char *emoji = "\xF0\x9F\x98\x80";
    p = emoji; len = 0;
    cp = yaep_utf8_next_with_len(&p, &len);
    if (cp != 0x1F600 || len != 4) {
        fprintf(stderr, "Emoji test failed: cp=0x%X len=%zu\n", (unsigned)cp, len);
        return 2;
    }

    puts("OK");
    return 0;
}
