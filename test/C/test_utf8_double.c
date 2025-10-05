/* Test parsing two grammars to isolate double free bug */

#include <stdio.h>
#include <stdlib.h>
#include "yaep.h"

int main(void)
{
    struct grammar *g1, *g2;
    
    printf("Creating first grammar...\n");
    g1 = yaep_create_grammar();
    if (g1 == NULL)
    {
        fprintf(stderr, "Error: Failed to allocate first grammar\n");
        return 1;
    }
    
    const char *grammar1 = "TERM;\nα : ;\n";
    
    if (yaep_parse_grammar(g1, 0, grammar1) != 0)
    {
        fprintf(stderr, "Error: Failed to parse first grammar\n");
        fprintf(stderr, "Error message: %s\n", yaep_error_message(g1));
        yaep_free_grammar(g1);
        return 1;
    }
    
    printf("First grammar parsed successfully\n");
    printf("Freeing first grammar...\n");
    yaep_free_grammar(g1);
    printf("First grammar freed successfully\n\n");
    
    printf("Creating second grammar...\n");
    g2 = yaep_create_grammar();
    if (g2 == NULL)
    {
        fprintf(stderr, "Error: Failed to allocate second grammar\n");
        return 1;
    }
    
    const char *grammar2 = "TERM;\nS : 'a' S 'b' | ;\n";
    
    if (yaep_parse_grammar(g2, 0, grammar2) != 0)
    {
        fprintf(stderr, "Error: Failed to parse second grammar\n");
        fprintf(stderr, "Error message: %s\n", yaep_error_message(g2));
        yaep_free_grammar(g2);
        return 1;
    }
    
    printf("Second grammar parsed successfully\n");
    printf("Freeing second grammar...\n");
    yaep_free_grammar(g2);
    printf("Second grammar freed successfully\n\n");
    
    printf("SUCCESS: Both grammars parsed and freed correctly!\n");
    return 0;
}
