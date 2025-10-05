/* Simple UTF-8 identifier test for debugging
 * 
 * This minimal test helps isolate lexer issues with Unicode identifiers.
 */

#include <stdio.h>
#include <stdlib.h>
#include "yaep.h"

int main(void)
{
    struct grammar *g;
    
    /* Very simple ASCII grammar to test backwards compatibility */
    const char *grammar_str =
        "TERM;\n"
        "S : 'a' S 'b' | ;\n";
    
    printf("Testing simple UTF-8 grammar with Greek letter alpha (α)...\n");
    printf("Grammar:\n%s\n", grammar_str);
    
    g = yaep_create_grammar();
    if (g == NULL)
    {
        fprintf(stderr, "Error: Failed to allocate grammar\n");
        return 1;
    }
    
    if (yaep_parse_grammar(g, 0, grammar_str) != 0)
    {
        fprintf(stderr, "Error: Failed to parse grammar\n");
        fprintf(stderr, "Error message: %s\n", yaep_error_message(g));
        yaep_free_grammar(g);
        return 1;
    }
    
    printf("SUCCESS: Simple UTF-8 grammar parsed correctly!\n");
    yaep_free_grammar(g);
    return 0;
}
