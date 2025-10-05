#include <iostream>
#include "yaep.h"

// Simple C++ test that parses a trivial grammar containing non-BMP codepoints
// (emoji) to ensure the lexer and unicode helpers can handle 4-byte UTF-8
// sequences without crashing. Returns 0 on success.

int main() {
    // Use the C++ wrapper API exposed by yaep.h
    yaep parser;

    // Grammar: single terminal named with emoji, intentionally small
    const char *desc = "TERM \xF0\x9F\x98\x80\n"  // U+1F600 emoji as part of TERM line
                       "A : '\xF0\x9F\x98\x80' ;\n";

    // Provide the description with non-BMP input to the parser.
    int rc = parser.parse_grammar(1, desc);
    // We don't rely on the parse result; this test ensures no crash on non-BMP input
    (void)rc;
    return 0;
}
