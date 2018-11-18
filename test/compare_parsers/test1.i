static void
output_msta_title (void)
{
  output_string (output_implementation_file,
                 "/* A MSTA parser generated from `");
  output_string (output_implementation_file, source_file_name);
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_string
      (output_implementation_file,
       "' */\n\n#define YYSMSTA 1 /* MSTA scanner identification. */\n\n");
  else
    output_string
      (output_implementation_file,
       "' */\n\n#define YYMSTA 1 /* MSTA parser identification. */\n\n");
}



static void
output_code (FILE *f, IR_node_t code)
{
  ((void) ((((_IR_is_type [IR_NM_code] [((code)->_IR_node_mode) /8] >> (((code)->_IR_node_mode) % 8)) & 1)) ? 0 : (__assert_fail ("((_IR_is_type [IR_NM_code] [((code)->_IR_node_mode) /8] >> (((code)->_IR_node_mode) % 8)) & 1)", "__test.c", 118, ((const char *) 0)), 0)));
  output_line (f, (((_IR_node *) (code))->_IR_S_node.position).line_number,
               (((_IR_node *) (code))->_IR_S_node.position).file_name);
  output_string (f, (((_IR_code_insertion *) ((((_IR_code *) (code))->_IR_S_code.code_itself)))->_IR_S_code_insertion.code_insertion_itself));
  output_char ('\n', f);
  output_current_line (f);
}

static void
output_start_code_insertions (void)
{
  IR_node_t current_definition;

  if ((((_IR_description *) (description))->_IR_S_description.definition_list) == ((void *)0))
    return;
  for (current_definition = (((_IR_description *) (description))->_IR_S_description.definition_list);
       current_definition != ((void *)0);
       current_definition = (((_IR_definition *) (current_definition))->_IR_S_definition.next_definition))
    if (((_IR_is_type [IR_NM_import_code] [((current_definition)->_IR_node_mode) /8] >> (((current_definition)->_IR_node_mode) % 8)) & 1))
      {
        if (define_flag)
          output_code (output_interface_file, current_definition);
        output_code (output_implementation_file, current_definition);
      }
    else if (((_IR_is_type [IR_NM_local_code] [((current_definition)->_IR_node_mode) /8] >> (((current_definition)->_IR_node_mode) % 8)) & 1)
             || ((_IR_is_type [IR_NM_yacc_code] [((current_definition)->_IR_node_mode) /8] >> (((current_definition)->_IR_node_mode) % 8)) & 1))
      output_code (output_implementation_file, current_definition);
}

static void
output_finish_code_insertions (void)
{
  IR_node_t current_definition;

  if ((((_IR_description *) (description))->_IR_S_description.definition_list) == ((void *)0))
    return;
  for (current_definition = (((_IR_description *) (description))->_IR_S_description.definition_list);
       current_definition != ((void *)0);
       current_definition = (((_IR_definition *) (current_definition))->_IR_S_definition.next_definition))
    if (((_IR_is_type [IR_NM_export_code] [((current_definition)->_IR_node_mode) /8] >> (((current_definition)->_IR_node_mode) % 8)) & 1))
      {
        if (define_flag)
          output_code (output_interface_file, current_definition);
        output_code (output_implementation_file, current_definition);
      }
}
static int max_token_value;
typedef int vector_element_t;

static int no_action_base_value;
static int final_state_number;
static vector_element_t first_pop_shift_action_value;
static vector_element_t first_reduce_value;
static vector_element_t first_look_ahead_table_value;
static int look_ahead_table_base_value;

static vector_element_t no_state_value;

static void
set_up_max_token_value (void)
{
  IR_node_t current_single_definition;
  int value;

  max_token_value = 0;
  for (current_single_definition = (((_IR_description *) (description))->_IR_S_description.single_definition_list);
       current_single_definition != ((void *)0);
       current_single_definition
       = (((_IR_single_definition *) (current_single_definition))->_IR_S_single_definition.next_single_definition))
    if (((_IR_is_type [IR_NM_single_term_definition] [((current_single_definition)->_IR_node_mode) /8] >> (((current_single_definition)->_IR_node_mode) % 8)) & 1))

      {
        if (((_IR_is_type [IR_NM_literal_range_definition] [((current_single_definition)->_IR_node_mode) /8] >> (((current_single_definition)->_IR_node_mode) % 8)) & 1))

          value = (((_IR_literal_range_definition *) (current_single_definition))->_IR_S_literal_range_definition.right_range_bound_value);
        else
          value = (((_IR_single_term_definition *) (current_single_definition))->_IR_S_single_term_definition.value);
        if (max_token_value < value)
          max_token_value = value;
      }
}

static void
enumerate_reduces (void)
{
  IR_node_t current_LR_core;
  IR_node_t current_LR_set;
  IR_node_t current_LR_situation;
  int reduces_number;

  reduces_number = 0;
  for (current_LR_core = (((_IR_description *) (description))->_IR_S_description.LR_core_list);
       current_LR_core != ((void *)0);
       current_LR_core = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.next_LR_core))
    for (current_LR_set = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.LR_set_list);
         current_LR_set != ((void *)0);
         current_LR_set = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.next_LR_set))
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag))
        for (current_LR_situation = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_situation_list);
             current_LR_situation != ((void *)0);
             current_LR_situation
               = (((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.next_LR_situation))
          if (((_IR_is_type [IR_NM_canonical_rule_end] [(((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) /8] >> ((((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) % 8)) & 1)


              && ((*(IR_node_t *) ((char *) ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)) + _IR_D_canonical_rule [((((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)))->_IR_node_mode)]))

                  != (((_IR_description *) (description))->_IR_S_description.canonical_rule_list))
              && (((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.corresponding_regular_arc) == ((void *)0)
              && ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.look_ahead_context) == ((void *)0)
                  || !it_is_zero_context ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.look_ahead_context))))

            {
              if (regular_optimization_flag)
                {
                  ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.reduce_number) = (reduces_number));
                  reduces_number++;
                }
              else
                ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.reduce_number) = ((((_IR_canonical_rule *) ((*(IR_node_t *) ((char *) ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)) + _IR_D_canonical_rule [((((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)))->_IR_node_mode)]))))->_IR_S_canonical_rule.canonical_rule_order_number)));




            }
  if (regular_optimization_flag)
    ((((_IR_description *) (description))->_IR_S_description.reduces_number) = (reduces_number));
  else
    ((((_IR_description *) (description))->_IR_S_description.reduces_number) = ((((_IR_description *) (description))->_IR_S_description.canonical_rules_number)));

}

static void
output_macro_definition (const char *comments, const char *macro_name,
                         int macro_value)
{
  output_string (output_implementation_file, comments);
  output_string (output_implementation_file, "\n#define ");
  output_string (output_implementation_file, macro_name);
  output_char (' ', output_implementation_file);
  output_decimal_number (output_implementation_file, macro_value, 0);
  output_string (output_implementation_file, "\n\n");
}

static void
set_up_final_state_number (void)
{
  IR_node_t current_LR_core;
  IR_node_t current_LR_set;

  for (current_LR_core = (((_IR_description *) (description))->_IR_S_description.LR_core_list);
       current_LR_core != ((void *)0);
       current_LR_core = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.next_LR_core))
    for (current_LR_set = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.LR_set_list);
         current_LR_set != ((void *)0);
         current_LR_set = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.next_LR_set))
      if (characteristic_symbol_of_LR_set (current_LR_set)
          == end_marker_single_definition
          && ((_IR_is_type [IR_NM_canonical_rule_end] [(((((_IR_LR_situation *) ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_situation_list)))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) /8] >> ((((((_IR_LR_situation *) ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_situation_list)))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) % 8)) & 1))


        {
          ((void) (((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag)) ? 0 : (__assert_fail ("(((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag)", "__test.c", 484, ((const char *) 0)), 0)));
          final_state_number = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_set_order_number);
          return;
        }
  ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 488, ((const char *) 0)), 0)));
}

static int
internal_trie_nodes_number (IR_node_t first_trie_node)
{
  int result;
  IR_node_t current_trie_node;

  result = 0;
  for (current_trie_node = first_trie_node;
       current_trie_node != ((void *)0);
       current_trie_node = (((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.next_brother))
    if ((((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.first_son) != ((void *)0))
      result
        += internal_trie_nodes_number ((((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.first_son)) + 1;
  return result;
}

static void
prepare_tables_output (void)
{
  IR_node_t current_LR_core;
  IR_node_t current_LR_set;

  set_up_max_token_value ();

  no_action_base_value
    = -(((_IR_description *) (description))->_IR_S_description.token_equivalence_classes_number) - 1;


  first_pop_shift_action_value = (((_IR_description *) (description))->_IR_S_description.LR_sets_number);
  first_reduce_value
    = first_pop_shift_action_value + (((_IR_description *) (description))->_IR_S_description.number_of_regular_arcs);
  enumerate_reduces ();
  first_look_ahead_table_value
    = first_reduce_value + (((_IR_description *) (description))->_IR_S_description.reduces_number);
  look_ahead_table_base_value
    = (((_IR_description *) (description))->_IR_S_description.LR_sets_number) - first_look_ahead_table_value;

  no_state_value = (((_IR_description *) (description))->_IR_S_description.LR_sets_number);
  for (current_LR_core = (((_IR_description *) (description))->_IR_S_description.LR_core_list);
       current_LR_core != ((void *)0);
       current_LR_core = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.next_LR_core))
    for (current_LR_set = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.LR_set_list);
         current_LR_set != ((void *)0);
         current_LR_set = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.next_LR_set))
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag))
        no_state_value += internal_trie_nodes_number ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_set_look_ahead_trie));

  output_macro_definition ("/* Max code of all tokens. */",
                           ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLAST_TOKEN_CODE" : "YYLAST_TOKEN_CODE"), max_token_value);
  output_macro_definition ("/* Undefined internal code for tokens. */",
                           ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSNO_TOKEN_INTERNAL_CODE" : "YYNO_TOKEN_INTERNAL_CODE"),
                           (((_IR_description *) (description))->_IR_S_description.token_equivalence_classes_number));
  output_macro_definition ("/* Code for token `error'. */",
                           ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERRCODE" : "YYERRCODE"),
                           (((_IR_single_term_definition *) (error_single_definition))->_IR_S_single_term_definition.value));
  output_macro_definition
    ("/* Token class of token `error'. */", ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERRCLASS" : "YYERRCLASS"),
     (((_IR_single_term_definition *) (error_single_definition))->_IR_S_single_term_definition.equivalence_class_number));
  output_macro_definition ("/* Base of empty action vector. */",
                           ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSNO_ACTION_BASE" : "YYNO_ACTION_BASE"), no_action_base_value);
  output_macro_definition ("/* An element of action check vector. */",
                           ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSNO_STATE" : "YYNO_STATE"), no_state_value);
  set_up_final_state_number ();
  output_macro_definition ("/* Final state of the parser. */",
                           ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSFINAL" : "YYFINAL"), final_state_number);
  output_macro_definition
    ("/* An element of action vector and default action vector. */",
     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSNO_ACTION" : "YYNO_ACTION"), 0);
  output_macro_definition
    ("/* An element of action vector (first pop-shift-action). */",
     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYS1POP_SHIFT_ACTION" : "YY1POP_SHIFT_ACTION"), first_pop_shift_action_value);
  output_macro_definition
    ("/* An element of action vector (first reduce). */",
     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYS1REDUCE" : "YY1REDUCE"), first_reduce_value);
  output_macro_definition
    ("/* Number of different reduce actions. */",
     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSNREDUCES" : "YYNREDUCES"), (((_IR_description *) (description))->_IR_S_description.reduces_number));
  output_macro_definition
    ("/* An element of action vector (the first look ahead table number). */",
     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYS1LOOK_AHEAD_TABLE_VALUE" : "YY1LOOK_AHEAD_TABLE_VALUE"), first_look_ahead_table_value);
  output_macro_definition
    ("/* Base of the look ahead tables value.  The order number of the\n   look ahead table is action look ahead table value + this value. */",

     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_TABLE_BASE" : "YYLOOK_AHEAD_TABLE_BASE"), look_ahead_table_base_value);
}

static void
output_vector_element_type (vector_element_t min_vector_element_value,
                            vector_element_t max_vector_element_value)
{
  if (min_vector_element_value >= 0 && max_vector_element_value <= (127 * 2 + 1))
    output_string (output_implementation_file, "unsigned char");
  else if (min_vector_element_value >= (-127 - 1)
           && max_vector_element_value <= 127)
    output_string (output_implementation_file, "signed char");
  else if (min_vector_element_value >= 0
           && max_vector_element_value <= (32767 * 2 + 1))
    output_string (output_implementation_file, "unsigned short");
  else if (min_vector_element_value >= (-32767 - 1)
           && max_vector_element_value <= 32767)
    output_string (output_implementation_file, "short");
  else
    {
      ((void) ((min_vector_element_value >= (-2147483647 - 1) && max_vector_element_value <= 2147483647) ? 0 : (__assert_fail ("min_vector_element_value >= (-2147483647 - 1) && max_vector_element_value <= 2147483647", "__test.c", 595, ((const char *) 0)), 0)));

      output_string (output_implementation_file, "int");
    }
}

static void
output_vector (vector_element_t *vector, int vector_length)
{
  int elements_on_line;

  elements_on_line = 1;
  if (vector_length == 0)
    {
      output_decimal_number (output_implementation_file, 0, 0);
      output_string
        (output_implementation_file,
         " /* This is dummy element because the vector is empty */");
    }
  else
    {
      do
        {
          output_decimal_number (output_implementation_file, *vector, 5);
          vector++;
          vector_length--;
          if (elements_on_line == 10)
            {
              elements_on_line = 0;
              output_string (output_implementation_file, ",\n");
            }
          else if (vector_length != 0)
            output_string (output_implementation_file, ", ");
          elements_on_line++;
        }
      while (vector_length != 0);
    }
}



static void
output_translate_vector (void)
{
  IR_node_t current_single_definition;
  int current_token_value;
  vlo_t translate_vector;
  int current_range_value;
  int left_range_value;
  int right_range_value;

  do { vlo_t *_temp_vlo = &(translate_vector); size_t temp_initial_length = (1000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 645, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(translate_vector); size_t _temp_length = ((max_token_value + 1) * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 647, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); _temp_vlo->vlo_free += _temp_length; } while (0);

  for (current_token_value = 0;
       current_token_value <= max_token_value;
       current_token_value++)

    ((vector_element_t *) ((translate_vector).vlo_start != ((void *)0) ? (void *) (translate_vector).vlo_start : (abort (), (void *) 0))) [current_token_value]
      = (((_IR_description *) (description))->_IR_S_description.token_equivalence_classes_number);
  for (current_single_definition = (((_IR_description *) (description))->_IR_S_description.single_definition_list);
       current_single_definition != ((void *)0);
       current_single_definition
       = (((_IR_single_definition *) (current_single_definition))->_IR_S_single_definition.next_single_definition))
    if (((_IR_is_type [IR_NM_single_term_definition] [((current_single_definition)->_IR_node_mode) /8] >> (((current_single_definition)->_IR_node_mode) % 8)) & 1))
      {
        left_range_value = (((_IR_single_term_definition *) (current_single_definition))->_IR_S_single_term_definition.value);
        if (((_IR_is_type [IR_NM_literal_range_definition] [((current_single_definition)->_IR_node_mode) /8] >> (((current_single_definition)->_IR_node_mode) % 8)) & 1))

          right_range_value
            = (((_IR_literal_range_definition *) (current_single_definition))->_IR_S_literal_range_definition.right_range_bound_value);
        else
          right_range_value = left_range_value;
        for (current_range_value = left_range_value;
             current_range_value <= right_range_value;
             current_range_value++)
          ((vector_element_t *) ((translate_vector).vlo_start != ((void *)0) ? (void *) (translate_vector).vlo_start : (abort (), (void *) 0)))
            [current_range_value]
              = (((_IR_single_term_definition *) (current_single_definition))->_IR_S_single_term_definition.equivalence_class_number);
      }
  output_string
    (output_implementation_file,
     "/* Vector for translating external token codes to internal codes. */\n");
  output_string (output_implementation_file, "static const ");
  output_vector_element_type (0, max_token_value + 1);
  output_char (' ', output_implementation_file);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystranslate" : "yytranslate"));
  output_string (output_implementation_file, "[] = {\n");
  output_vector ((vector_element_t *) ((translate_vector).vlo_start != ((void *)0) ? (void *) (translate_vector).vlo_start : (abort (), (void *) 0)),
                 ((translate_vector).vlo_start != ((void *)0) ? (translate_vector).vlo_free - (translate_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
  output_string (output_implementation_file, "};\n\n");
  do { vlo_t *_temp_vlo = &(translate_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 685, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
}




struct element
{
  int index;
  vector_element_t value;
};

typedef struct element element_t;

static vlo_t *current_comb_vector_ptr;
static vlo_t *current_check_vector_ptr;
static int current_undefined_base_value;
static vector_element_t current_undefined_comb_vector_element_value;
static vector_element_t current_undefined_check_vector_element_value;
static int max_added_vector_length;



static int min_current_vector_index;
static int max_current_vector_index;

static int first_possible_zero_element_index;
static int min_comb_vector_displacement;
static vector_element_t max_comb_vector_element_value;
static vector_element_t min_base_vector_element_value;
static vector_element_t max_base_vector_element_value;

static void
add_vector_element (vlo_t *vector, int index, vector_element_t element_value)
{
  element_t element;

  element.index = index;
  element.value = element_value;
  do { vlo_t *_temp_vlo = &(*vector); size_t _temp_length = (sizeof (element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 724, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); memcpy( _temp_vlo->vlo_free, ( &element) , _temp_length ); _temp_vlo->vlo_free += _temp_length; } while (0);
  if (max_comb_vector_element_value < element_value)
    max_comb_vector_element_value = element_value;
  if (min_current_vector_index > index)
    min_current_vector_index = index;
  if (max_current_vector_index < index)
    max_current_vector_index = index;
}

static int
add_vector (int vector_number, element_t *vector, int vector_length)
{
  vector_element_t *comb_vector_start;
  vector_element_t *check_vector_start;
  int comb_vector_index;
  int comb_vector_elements_number;
  int vector_index;
  int additional_elements_number;
  int i;

  if (vector_length == 0)
    comb_vector_index = current_undefined_base_value;
  else
    {
      ((void) ((current_check_vector_ptr == ((void *)0) || (((*current_comb_vector_ptr).vlo_start != ((void *)0) ? (*current_comb_vector_ptr).vlo_free - (*current_comb_vector_ptr).vlo_start : (abort (), 0)) == ((*current_check_vector_ptr).vlo_start != ((void *)0) ? (*current_check_vector_ptr).vlo_free - (*current_check_vector_ptr).vlo_start : (abort (), 0)))) ? 0 : (__assert_fail ("current_check_vector_ptr == ((void *)0) || (((*current_comb_vector_ptr).vlo_start != ((void *)0) ? (*current_comb_vector_ptr).vlo_free - (*current_comb_vector_ptr).vlo_start : (abort (), 0)) == ((*current_check_vector_ptr).vlo_start != ((void *)0) ? (*current_check_vector_ptr).vlo_free - (*current_check_vector_ptr).vlo_start : (abort (), 0)))", "__test.c", 750, ((const char *) 0)), 0)));


      comb_vector_start = ((*current_comb_vector_ptr).vlo_start != ((void *)0) ? (void *) (*current_comb_vector_ptr).vlo_start : (abort (), (void *) 0));
      comb_vector_elements_number
        = ((*current_comb_vector_ptr).vlo_start != ((void *)0) ? (*current_comb_vector_ptr).vlo_free - (*current_comb_vector_ptr).vlo_start : (abort (), 0)) / sizeof (vector_element_t);


      if (comb_vector_elements_number - 2 * max_added_vector_length <= 0)
        comb_vector_index = 0;
      else
        comb_vector_index = rand () % (comb_vector_elements_number
                                       - 2 * max_added_vector_length);

      for ( ;



           comb_vector_index < comb_vector_elements_number;
           comb_vector_index++)
        {
          for (vector_index = 0;
               vector_index < vector_length;
               vector_index++)
            if (comb_vector_start [vector [vector_index].index
                                  + comb_vector_index]
                != current_undefined_comb_vector_element_value)
              break;
          if (vector_index >= vector_length)
            break;
        }
      if (comb_vector_elements_number != 0)
        while (comb_vector_start [first_possible_zero_element_index]
               != current_undefined_comb_vector_element_value)
          first_possible_zero_element_index++;



      additional_elements_number
        = (comb_vector_index + max_current_vector_index
           + max_added_vector_length + 1 - comb_vector_elements_number);
      if (additional_elements_number < 0)
        additional_elements_number = 0;

      do { vlo_t *_temp_vlo = &(*current_comb_vector_ptr); size_t _temp_length = (additional_elements_number * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 793, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); _temp_vlo->vlo_free += _temp_length; } while (0);

      comb_vector_start = ((*current_comb_vector_ptr).vlo_start != ((void *)0) ? (void *) (*current_comb_vector_ptr).vlo_start : (abort (), (void *) 0));
      if (current_check_vector_ptr != ((void *)0))
        {
          do { vlo_t *_temp_vlo = &(*current_check_vector_ptr); size_t _temp_length = (additional_elements_number * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 798, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); _temp_vlo->vlo_free += _temp_length; } while (0);

          check_vector_start = ((*current_check_vector_ptr).vlo_start != ((void *)0) ? (void *) (*current_check_vector_ptr).vlo_start : (abort (), (void *) 0));
        }
      for (i = comb_vector_elements_number;
           i < comb_vector_elements_number + additional_elements_number;
           i++)
        comb_vector_start [i]
          = current_undefined_comb_vector_element_value;
      if (current_check_vector_ptr != ((void *)0))
        for (i = comb_vector_elements_number;
             i < comb_vector_elements_number + additional_elements_number;
             i++)
          check_vector_start [i]
            = current_undefined_check_vector_element_value;
      ((void) ((((*current_comb_vector_ptr).vlo_start != ((void *)0) ? (*current_comb_vector_ptr).vlo_free - (*current_comb_vector_ptr).vlo_start : (abort (), 0)) / sizeof (vector_element_t) >= comb_vector_index + max_added_vector_length + 1) ? 0 : (__assert_fail ("((*current_comb_vector_ptr).vlo_start != ((void *)0) ? (*current_comb_vector_ptr).vlo_free - (*current_comb_vector_ptr).vlo_start : (abort (), 0)) / sizeof (vector_element_t) >= comb_vector_index + max_added_vector_length + 1", "__test.c", 813, ((const char *) 0)), 0)));


      for (vector_index = 0; vector_index < vector_length; vector_index++)
        {




          comb_vector_start
            [comb_vector_index + vector [vector_index].index]
            = vector [vector_index].value;
          if (current_check_vector_ptr != ((void *)0))
            check_vector_start [comb_vector_index
                               + vector [vector_index].index]
              = vector_number;
        }
      if (comb_vector_index < min_comb_vector_displacement)
        min_comb_vector_displacement = comb_vector_index;
    }
  if (max_base_vector_element_value < comb_vector_index)
    max_base_vector_element_value = comb_vector_index;
  if (min_base_vector_element_value > comb_vector_index)
    min_base_vector_element_value = comb_vector_index;

  min_current_vector_index = 2147483647;
  max_current_vector_index = 0;
  return comb_vector_index;
}

static void
start_comb_vector_forming
  (vlo_t *comb_vector, vlo_t *check_vector, int undefined_base_value,
   vector_element_t undefined_comb_vector_element_value,
   vector_element_t undefined_check_vector_element_value,
   int max_vector_length)
{
  current_comb_vector_ptr = comb_vector;
  current_check_vector_ptr = check_vector;
  current_undefined_base_value = undefined_base_value;
  current_undefined_comb_vector_element_value
    = undefined_comb_vector_element_value;
  current_undefined_check_vector_element_value
    = undefined_check_vector_element_value;
  max_added_vector_length = max_vector_length;
  min_current_vector_index = 2147483647;
  max_current_vector_index = 0;
  first_possible_zero_element_index = 0;
  min_comb_vector_displacement = 0;
  max_comb_vector_element_value = 0;
  min_base_vector_element_value = 0;
  max_base_vector_element_value = 0;
}

static void
finish_comb_vector_forming (void)
{
  if (current_check_vector_ptr == ((void *)0))
    do { vlo_t *_temp_vlo = &(*current_comb_vector_ptr); size_t _temp_n = (max_added_vector_length * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 871, ((const char *) 0)), 0))); if ((size_t) ((*_temp_vlo).vlo_start != ((void *)0) ? (*_temp_vlo).vlo_free - (*_temp_vlo).vlo_start : (abort (), 0)) < _temp_n) _temp_vlo->vlo_free = _temp_vlo->vlo_start; else _temp_vlo->vlo_free -= _temp_n; } while (0);

  else
    {
      do { vlo_t *_temp_vlo = &(*current_comb_vector_ptr); size_t _temp_n = (((*current_comb_vector_ptr).vlo_start != ((void *)0) ? (*current_comb_vector_ptr).vlo_free - (*current_comb_vector_ptr).vlo_start : (abort (), 0)) - (max_base_vector_element_value + max_added_vector_length) * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 877, ((const char *) 0)), 0))); if ((size_t) ((*_temp_vlo).vlo_start != ((void *)0) ? (*_temp_vlo).vlo_free - (*_temp_vlo).vlo_start : (abort (), 0)) < _temp_n) _temp_vlo->vlo_free = _temp_vlo->vlo_start; else _temp_vlo->vlo_free -= _temp_n; } while (0);



      do { vlo_t *_temp_vlo = &(*current_check_vector_ptr); size_t _temp_n = (((*current_check_vector_ptr).vlo_start != ((void *)0) ? (*current_check_vector_ptr).vlo_free - (*current_check_vector_ptr).vlo_start : (abort (), 0)) - (max_base_vector_element_value + max_added_vector_length) * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 881, ((const char *) 0)), 0))); if ((size_t) ((*_temp_vlo).vlo_start != ((void *)0) ? (*_temp_vlo).vlo_free - (*_temp_vlo).vlo_start : (abort (), 0)) < _temp_n) _temp_vlo->vlo_free = _temp_vlo->vlo_start; else _temp_vlo->vlo_free -= _temp_n; } while (0);



    }
}

static void
add_to_LR_sets_and_trie_nodes_vector (vlo_t *vector,
                                      IR_node_t LR_set_or_trie_node)
{
  IR_node_t current_trie_node;
  IR_node_t first_trie_node;

  do { vlo_t *_temp_vlo = &(*vector); size_t _temp_length = (sizeof (IR_node_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 892, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); memcpy( _temp_vlo->vlo_free, ( &LR_set_or_trie_node ), _temp_length ); _temp_vlo->vlo_free += _temp_length; } while (0);
  if (((_IR_is_type [IR_NM_LR_set] [((LR_set_or_trie_node)->_IR_node_mode) /8] >> (((LR_set_or_trie_node)->_IR_node_mode) % 8)) & 1))
    first_trie_node = (((_IR_LR_set *) (LR_set_or_trie_node))->_IR_S_LR_set.LR_set_look_ahead_trie);
  else
    {
      ((void) ((((_IR_is_type [IR_NM_LR_set_look_ahead_trie_node] [((LR_set_or_trie_node)->_IR_node_mode) /8] >> (((LR_set_or_trie_node)->_IR_node_mode) % 8)) & 1)) ? 0 : (__assert_fail ("((_IR_is_type [IR_NM_LR_set_look_ahead_trie_node] [((LR_set_or_trie_node)->_IR_node_mode) /8] >> (((LR_set_or_trie_node)->_IR_node_mode) % 8)) & 1)", "__test.c", 898, ((const char *) 0)), 0)));

      first_trie_node = LR_set_or_trie_node;
    }
  for (current_trie_node = first_trie_node;
       current_trie_node != ((void *)0);
       current_trie_node = (((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.next_brother))
    if ((((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.first_son) != ((void *)0))
      add_to_LR_sets_and_trie_nodes_vector (vector,
                                            (((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.first_son));
}

static vector_element_t
LR_situation_vector_element (IR_node_t LR_situation)
{
  if ((((_IR_LR_situation *) (LR_situation))->_IR_S_LR_situation.corresponding_regular_arc) != ((void *)0))
    return (first_pop_shift_action_value
            + (((_IR_regular_arc *) ((((_IR_LR_situation *) (LR_situation))->_IR_S_LR_situation.corresponding_regular_arc)))->_IR_S_regular_arc.number_of_regular_arc));

  else if (((_IR_is_type [IR_NM_canonical_rule_end] [(((((_IR_LR_situation *) (LR_situation))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) /8] >> ((((((_IR_LR_situation *) (LR_situation))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) % 8)) & 1))

    return first_reduce_value + (((_IR_LR_situation *) (LR_situation))->_IR_S_LR_situation.reduce_number);
  else


    return (((_IR_LR_set *) ((((_IR_LR_situation *) (LR_situation))->_IR_S_LR_situation.goto_LR_set).field_itself))->_IR_S_LR_set.LR_set_order_number);
}



static void
output_action_table (void)
{
  vector_element_t max_default_vector_element_value;
  vector_element_t base_value;
  vector_element_t default_value;
  IR_node_t *current_LR_set_or_trie_node_ptr;
  IR_node_t trie_node_list;
  IR_node_t current_trie_node;
  IR_node_t current_LR_set;
  IR_node_t default_LR_situation;
  int action_table_number;
  IR_node_t current_LR_core;
  vlo_t LR_sets_and_trie_nodes_vector;
  vlo_t comb_vector;
  vlo_t check_vector;
  vlo_t base_vector;
  vlo_t default_vector;
  vlo_t action_vector;
  int vector_length;

  int non_empty_action_elements = 0;
  int all_action_vectors_length = 0;
  int all_based_action_vectors_length = 0;





  do { vlo_t *_temp_vlo = &(LR_sets_and_trie_nodes_vector); size_t temp_initial_length = (5000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 956, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  for (current_LR_core = (((_IR_description *) (description))->_IR_S_description.LR_core_list);
       current_LR_core != ((void *)0);
       current_LR_core = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.next_LR_core))
    for (current_LR_set = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.LR_set_list);
         current_LR_set != ((void *)0);
         current_LR_set = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.next_LR_set))
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag))
        add_to_LR_sets_and_trie_nodes_vector (&LR_sets_and_trie_nodes_vector,
                                              current_LR_set);
  action_table_number = (((_IR_description *) (description))->_IR_S_description.LR_sets_number);


  for (current_LR_set_or_trie_node_ptr
       = ((LR_sets_and_trie_nodes_vector).vlo_start != ((void *)0) ? (void *) (LR_sets_and_trie_nodes_vector).vlo_start : (abort (), (void *) 0));
       (char *) current_LR_set_or_trie_node_ptr
       <= (char *) ((LR_sets_and_trie_nodes_vector).vlo_start != ((void *)0) ? (void *) ((LR_sets_and_trie_nodes_vector).vlo_free - 1) : (abort (), (void *) 0));
       current_LR_set_or_trie_node_ptr++)
    if (((_IR_is_type [IR_NM_LR_set_look_ahead_trie_node] [((*current_LR_set_or_trie_node_ptr)->_IR_node_mode) /8] >> (((*current_LR_set_or_trie_node_ptr)->_IR_node_mode) % 8)) & 1))

      {
        ((((_IR_LR_set_look_ahead_trie_node *) (*current_LR_set_or_trie_node_ptr))->_IR_S_LR_set_look_ahead_trie_node.additional_action_table_number) = (action_table_number));

        action_table_number++;
      }

  do { vlo_t *_temp_vlo = &(comb_vector); size_t temp_initial_length = (50000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 982, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(check_vector); size_t temp_initial_length = (50000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 983, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(base_vector); size_t temp_initial_length = (5000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 984, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(default_vector); size_t temp_initial_length = (5000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 985, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(base_vector); size_t _temp_length = (((LR_sets_and_trie_nodes_vector).vlo_start != ((void *)0) ? (LR_sets_and_trie_nodes_vector).vlo_free - (LR_sets_and_trie_nodes_vector).vlo_start : (abort (), 0)) / sizeof (IR_node_t) * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 988, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); _temp_vlo->vlo_free += _temp_length; } while (0);


  do { vlo_t *_temp_vlo = &(default_vector); size_t _temp_length = (((LR_sets_and_trie_nodes_vector).vlo_start != ((void *)0) ? (LR_sets_and_trie_nodes_vector).vlo_free - (LR_sets_and_trie_nodes_vector).vlo_start : (abort (), 0)) / sizeof (IR_node_t) * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 991, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); _temp_vlo->vlo_free += _temp_length; } while (0);


  do { vlo_t *_temp_vlo = &(action_vector); size_t temp_initial_length = (2000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 992, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  start_comb_vector_forming
    (&comb_vector, &check_vector, no_action_base_value,
     0, no_state_value,
     (((_IR_description *) (description))->_IR_S_description.token_equivalence_classes_number));
  max_default_vector_element_value = 0;
  for (current_LR_set_or_trie_node_ptr
       = ((LR_sets_and_trie_nodes_vector).vlo_start != ((void *)0) ? (void *) (LR_sets_and_trie_nodes_vector).vlo_start : (abort (), (void *) 0));
       (char *) current_LR_set_or_trie_node_ptr
       <= (char *) ((LR_sets_and_trie_nodes_vector).vlo_start != ((void *)0) ? (void *) ((LR_sets_and_trie_nodes_vector).vlo_free - 1) : (abort (), (void *) 0));
       current_LR_set_or_trie_node_ptr++)
    {
      do { vlo_t *_temp_vlo = &(action_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1004, ((const char *) 0)), 0))); _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
      if (((_IR_is_type [IR_NM_LR_set] [((*current_LR_set_or_trie_node_ptr)->_IR_node_mode) /8] >> (((*current_LR_set_or_trie_node_ptr)->_IR_node_mode) % 8)) & 1))
        {
          action_table_number
            = (((_IR_LR_set *) (*current_LR_set_or_trie_node_ptr))->_IR_S_LR_set.LR_set_order_number);
          if (action_table_number == final_state_number)
            trie_node_list = ((void *)0);
          else
            trie_node_list
              = (((_IR_LR_set *) (*current_LR_set_or_trie_node_ptr))->_IR_S_LR_set.LR_set_look_ahead_trie);
        }
      else
        {
          ((void) ((((_IR_is_type [IR_NM_LR_set_look_ahead_trie_node] [((*current_LR_set_or_trie_node_ptr)->_IR_node_mode) /8] >> (((*current_LR_set_or_trie_node_ptr)->_IR_node_mode) % 8)) & 1)) ? 0 : (__assert_fail ("((_IR_is_type [IR_NM_LR_set_look_ahead_trie_node] [((*current_LR_set_or_trie_node_ptr)->_IR_node_mode) /8] >> (((*current_LR_set_or_trie_node_ptr)->_IR_node_mode) % 8)) & 1)", "__test.c", 1018, ((const char *) 0)), 0)));

          action_table_number
            = (((_IR_LR_set_look_ahead_trie_node *) (*current_LR_set_or_trie_node_ptr))->_IR_S_LR_set_look_ahead_trie_node.additional_action_table_number);

          trie_node_list = *current_LR_set_or_trie_node_ptr;
        }
      for (current_trie_node = trie_node_list;
           current_trie_node != ((void *)0)
           && ((((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.corresponding_single_term_definition)
               != ((void *)0));
           current_trie_node = (((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.next_brother))
        if ((((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.first_son) != ((void *)0))
          add_vector_element
            (&action_vector,
             (((_IR_single_term_definition *) ((((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.corresponding_single_term_definition)))->_IR_S_single_term_definition.equivalence_class_number),

             first_look_ahead_table_value
             + ((((_IR_LR_set_look_ahead_trie_node *) ((((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.first_son)))->_IR_S_LR_set_look_ahead_trie_node.additional_action_table_number))

             - (((_IR_description *) (description))->_IR_S_description.LR_sets_number));
        else
          add_vector_element
            (&action_vector,
             (((_IR_single_term_definition *) ((((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.corresponding_single_term_definition)))->_IR_S_single_term_definition.equivalence_class_number),

             LR_situation_vector_element ((((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.corresponding_LR_situation)));

      if (current_trie_node == ((void *)0))
        default_LR_situation = ((void *)0);
      else
        {
          ((void) (((((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.first_son) == ((void *)0)) ? 0 : (__assert_fail ("(((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.first_son) == ((void *)0)", "__test.c", 1049, ((const char *) 0)), 0)));
          default_LR_situation
            = (((_IR_LR_set_look_ahead_trie_node *) (current_trie_node))->_IR_S_LR_set_look_ahead_trie_node.corresponding_LR_situation);
        }
      vector_length = ((action_vector).vlo_start != ((void *)0) ? (action_vector).vlo_free - (action_vector).vlo_start : (abort (), 0)) / sizeof (element_t);

      if (debug_level >= 1)
        {
          non_empty_action_elements += vector_length;
          if (vector_length != 0)
            {
              all_action_vectors_length += max_current_vector_index + 1;
              all_based_action_vectors_length
                += max_current_vector_index - min_current_vector_index + 1;
            }
        }

      base_value
        = add_vector (action_table_number,
                      (element_t *) ((action_vector).vlo_start != ((void *)0) ? (void *) (action_vector).vlo_start : (abort (), (void *) 0)), vector_length);
      ((vector_element_t *) ((base_vector).vlo_start != ((void *)0) ? (void *) (base_vector).vlo_start : (abort (), (void *) 0))) [action_table_number]
          = base_value;
      if (default_LR_situation == ((void *)0))
        default_value = 0;
      else
        default_value = LR_situation_vector_element (default_LR_situation);
      if (max_default_vector_element_value < default_value)
        max_default_vector_element_value = default_value;
      ((vector_element_t *) ((default_vector).vlo_start != ((void *)0) ? (void *) (default_vector).vlo_start : (abort (), (void *) 0))) [action_table_number]
        = default_value;
    }

  if (debug_level >= 1)
    {
      int i;
      int comb_non_empty = 0;

      for (i = 0; i < ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t);
           i++)
        if (((vector_element_t *) ((comb_vector).vlo_start != ((void *)0) ? (void *) (comb_vector).vlo_start : (abort (), (void *) 0))) [i]
            != 0)
          comb_non_empty++;
      fprintf (stderr,
               "Size:    action vectors -- %d, action comb vector -- %ld\n",
               all_action_vectors_length,
               ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
      fprintf
        (stderr,
         "Filling: action vectors -- %d%%, action comb vector -- %ld%%\n",
         non_empty_action_elements * 100 / (1 > all_action_vectors_length ? 1 : all_action_vectors_length),
         comb_non_empty * 100 * sizeof (vector_element_t)
         / (1 > ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) ? 1 : ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0))));
      fprintf (stderr, "         based action vectors -- %d%%\n",
               non_empty_action_elements * 100
               / (1 > all_based_action_vectors_length ? 1 : all_based_action_vectors_length));
    }

  ((void) ((min_comb_vector_displacement <= 0) ? 0 : (__assert_fail ("min_comb_vector_displacement <= 0", "__test.c", 1106, ((const char *) 0)), 0)));
  finish_comb_vector_forming ();
  output_string (output_implementation_file,
                 "/* Comb vector for actions. */\n");
  output_string (output_implementation_file, "static const ");
  output_vector_element_type (0, max_comb_vector_element_value);
  output_char (' ', output_implementation_file);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysaction" : "yyaction"));
  output_string (output_implementation_file, "[] = {\n");
  output_vector ((vector_element_t *) ((comb_vector).vlo_start != ((void *)0) ? (void *) (comb_vector).vlo_start : (abort (), (void *) 0)),
                 ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
  output_string (output_implementation_file, "};\n\n");
  output_string (output_implementation_file,
                 "/* Check vector for actions. */\n");
  output_string (output_implementation_file, "static const ");
  output_vector_element_type (0, no_state_value);
  output_char (' ', output_implementation_file);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysacheck" : "yyacheck"));
  output_string (output_implementation_file, "[] = {\n");
  output_vector ((vector_element_t *) ((check_vector).vlo_start != ((void *)0) ? (void *) (check_vector).vlo_start : (abort (), (void *) 0)),
                 ((check_vector).vlo_start != ((void *)0) ? (check_vector).vlo_free - (check_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
  output_string (output_implementation_file, "};\n\n");
  output_string (output_implementation_file,
                 "/* Base vector for actions. */\n");
  output_string (output_implementation_file, "static const ");
  output_vector_element_type (min_base_vector_element_value,
                              max_base_vector_element_value);
  output_char (' ', output_implementation_file);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysabase" : "yyabase"));
  output_string (output_implementation_file, "[] = {\n");
  output_vector ((vector_element_t *) ((base_vector).vlo_start != ((void *)0) ? (void *) (base_vector).vlo_start : (abort (), (void *) 0)),
                 ((base_vector).vlo_start != ((void *)0) ? (base_vector).vlo_free - (base_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
  output_string (output_implementation_file, "};\n\n");

  output_string (output_implementation_file,
                 "/* Default vector for actions. */\n");
  output_string (output_implementation_file, "static const ");
  output_vector_element_type (0, max_default_vector_element_value);
  output_char (' ', output_implementation_file);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysadefault" : "yyadefault"));
  output_string (output_implementation_file, "[] = {\n");
  output_vector ((vector_element_t *) ((default_vector).vlo_start != ((void *)0) ? (void *) (default_vector).vlo_start : (abort (), (void *) 0)),
                 ((default_vector).vlo_start != ((void *)0) ? (default_vector).vlo_free - (default_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
  output_string (output_implementation_file, "};\n\n");
  do { vlo_t *_temp_vlo = &(LR_sets_and_trie_nodes_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1150, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
  do { vlo_t *_temp_vlo = &(action_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1151, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
  do { vlo_t *_temp_vlo = &(base_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1152, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
  do { vlo_t *_temp_vlo = &(check_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1153, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
  do { vlo_t *_temp_vlo = &(comb_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1154, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
}




static void
output_nonterminal_goto_table (void)
{
  vector_element_t base_value;
  IR_node_t current_LR_situation;
  IR_node_t current_LR_set;
  IR_node_t current_LR_core;
  vlo_t comb_vector;
  vlo_t base_vector;
  vlo_t goto_vector;
  int vector_length;

  int non_empty_goto_elements = 0;
  int all_goto_vectors_length = 0;
  int all_based_goto_vectors_length = 0;



  do { vlo_t *_temp_vlo = &(comb_vector); size_t temp_initial_length = (50000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 1178, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(base_vector); size_t temp_initial_length = (5000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 1179, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(base_vector); size_t _temp_length = ((((_IR_description *) (description))->_IR_S_description.LR_sets_number) * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1181, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); _temp_vlo->vlo_free += _temp_length; } while (0);

  do { vlo_t *_temp_vlo = &(goto_vector); size_t temp_initial_length = (2000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 1182, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  start_comb_vector_forming
    (&comb_vector, ((void *)0), 0, 0, 0,
     (((_IR_description *) (description))->_IR_S_description.nonterminals_number));
  for (current_LR_core = (((_IR_description *) (description))->_IR_S_description.LR_core_list);
       current_LR_core != ((void *)0);
       current_LR_core = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.next_LR_core))
    for (current_LR_set = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.LR_set_list);
         current_LR_set != ((void *)0);
         current_LR_set = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.next_LR_set))
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag))
        {
          do { vlo_t *_temp_vlo = &(goto_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1194, ((const char *) 0)), 0))); _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
          for (current_LR_situation = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_situation_list);
               current_LR_situation != ((void *)0);
               current_LR_situation
                 = (((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.next_LR_situation))
            if ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.first_symbol_LR_situation)
                && !((_IR_is_type [IR_NM_canonical_rule_end] [(((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) /8] >> ((((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) % 8)) & 1)


                && !(((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.goto_arc_has_been_removed)
                && ((_IR_is_type [IR_NM_single_nonterm_definition] [(((((_IR_canonical_rule_element *) ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)))->_IR_S_canonical_rule_element.element_itself))->_IR_node_mode) /8] >> ((((((_IR_canonical_rule_element *) ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)))->_IR_S_canonical_rule_element.element_itself))->_IR_node_mode) % 8)) & 1))


              add_vector_element
                (&goto_vector,
                 (((_IR_single_nonterm_definition *) ((((_IR_canonical_rule_element *) ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)))->_IR_S_canonical_rule_element.element_itself)))->_IR_S_single_nonterm_definition.nonterm_order_number),


                 (((_IR_LR_set *) ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.goto_LR_set).field_itself))->_IR_S_LR_set.LR_set_order_number));

          vector_length = ((goto_vector).vlo_start != ((void *)0) ? (goto_vector).vlo_free - (goto_vector).vlo_start : (abort (), 0)) / sizeof (element_t);

          if (debug_level >= 1)
            {
              non_empty_goto_elements += vector_length;
              if (vector_length != 0)
                {
                  all_goto_vectors_length += max_current_vector_index + 1;
                  all_based_goto_vectors_length
                    += (max_current_vector_index
                        - min_current_vector_index + 1);
                }
            }

          base_value
            = add_vector (0, (element_t *) ((goto_vector).vlo_start != ((void *)0) ? (void *) (goto_vector).vlo_start : (abort (), (void *) 0)),
                          ((goto_vector).vlo_start != ((void *)0) ? (goto_vector).vlo_free - (goto_vector).vlo_start : (abort (), 0)) / sizeof (element_t));
          ((vector_element_t *) ((base_vector).vlo_start != ((void *)0) ? (void *) (base_vector).vlo_start : (abort (), (void *) 0)))
            [(((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_set_order_number)] = base_value;
        }

  if (debug_level >= 1)
    {
      int i;
      int comb_non_empty = 0;

      for (i = 0; i < ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t);
           i++)
        if (((vector_element_t *) ((comb_vector).vlo_start != ((void *)0) ? (void *) (comb_vector).vlo_start : (abort (), (void *) 0))) [i]
            != 0)
          comb_non_empty++;
      fprintf (stderr, "Size: goto vectors -- %d, goto comb vector -- %ld\n",
               all_goto_vectors_length,
               ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
      fprintf
        (stderr,
         "Filling: goto vectors -- %d%%, goto comb vector -- %ld%%\n",
         non_empty_goto_elements * 100 / (1 > all_goto_vectors_length ? 1 : all_goto_vectors_length),
         comb_non_empty * 100 * sizeof (vector_element_t)
         / (1 > ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) ? 1 : ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0))));
      fprintf (stderr,
               "         based goto vectors -- %d%%\n",
               non_empty_goto_elements * 100
               / (1 > all_based_goto_vectors_length ? 1 : all_based_goto_vectors_length));
    }

  finish_comb_vector_forming ();
  output_string (output_implementation_file,
                 "/* Comb vector for gotos. */\n");
  output_string (output_implementation_file, "static const ");
  output_vector_element_type (0, max_comb_vector_element_value);
  output_char (' ', output_implementation_file);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysgoto" : "yygoto"));
  output_string (output_implementation_file, "[] = {\n");
  output_vector ((vector_element_t *) ((comb_vector).vlo_start != ((void *)0) ? (void *) (comb_vector).vlo_start : (abort (), (void *) 0)),
                 ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
  output_string (output_implementation_file, "};\n\n");
  output_string (output_implementation_file,
                 "/* Base vector for gotos. */\n");
  output_string (output_implementation_file, "static const ");
  output_vector_element_type (min_base_vector_element_value,
                              max_base_vector_element_value);
  output_char (' ', output_implementation_file);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysgbase" : "yygbase"));
  output_string (output_implementation_file, "[] = {\n");
  output_vector ((vector_element_t *) ((base_vector).vlo_start != ((void *)0) ? (void *) (base_vector).vlo_start : (abort (), (void *) 0)),
                 ((base_vector).vlo_start != ((void *)0) ? (base_vector).vlo_free - (base_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
  output_string (output_implementation_file, "};\n\n");
  do { vlo_t *_temp_vlo = &(goto_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1282, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
  do { vlo_t *_temp_vlo = &(base_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1283, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
  do { vlo_t *_temp_vlo = &(comb_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1284, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
}







static vlo_t nattr_pop_vector;





static IR_node_t start_LR_set_for_forming_nattr_pop_vector;

static void
form_nattr_pop_vector (IR_node_t LR_set, int nattr_pop_number)
{
  IR_node_t LR_situation_of_immediate_LR_set_predecessor;
  IR_node_t immediate_LR_set_predecessor;
  IR_double_link_t LR_situation_reference;
  int LR_set_order_number;

  if ((((_IR_LR_set *) (LR_set))->_IR_S_LR_set.start_LR_set_pass)
      == start_LR_set_for_forming_nattr_pop_vector)
    return;
  ((((_IR_LR_set *) (LR_set))->_IR_S_LR_set.start_LR_set_pass) = (start_LR_set_for_forming_nattr_pop_vector));
  if ((((_IR_LR_set *) (LR_set))->_IR_S_LR_set.attribute_is_used))
    nattr_pop_number++;
  for (LR_situation_reference = IR__first_double_link (LR_set);
       LR_situation_reference != ((void *)0);
       LR_situation_reference
         = ((LR_situation_reference)->next_link))
    {
      LR_situation_of_immediate_LR_set_predecessor
        = ((LR_situation_reference)->link_owner);
      if (((_IR_is_type [IR_NM_LR_situation] [((LR_situation_of_immediate_LR_set_predecessor)->_IR_node_mode) /8] >> (((LR_situation_of_immediate_LR_set_predecessor)->_IR_node_mode) % 8)) & 1))

        {

          ((void) (((((_IR_LR_situation *) (LR_situation_of_immediate_LR_set_predecessor))->_IR_S_LR_situation.first_symbol_LR_situation)) ? 0 : (__assert_fail ("(((_IR_LR_situation *) (LR_situation_of_immediate_LR_set_predecessor))->_IR_S_LR_situation.first_symbol_LR_situation)", "__test.c", 1327, ((const char *) 0)), 0)));

          immediate_LR_set_predecessor
     = (*(IR_node_t *) ((char *) (LR_situation_of_immediate_LR_set_predecessor) + _IR_D_LR_set [(((LR_situation_of_immediate_LR_set_predecessor))->_IR_node_mode)]));
          if ((((_IR_LR_set *) (immediate_LR_set_predecessor))->_IR_S_LR_set.reachable_flag)
       && (((_IR_LR_set *) (immediate_LR_set_predecessor))->_IR_S_LR_set.it_is_pushed_LR_set))
            {
              LR_set_order_number
  = (((_IR_LR_set *) (immediate_LR_set_predecessor))->_IR_S_LR_set.LR_set_order_number);
              add_vector_element
                (&nattr_pop_vector, LR_set_order_number, nattr_pop_number);
            }
          else
            form_nattr_pop_vector (immediate_LR_set_predecessor,
                                   nattr_pop_number);
        }
    }
}


static void
output_nattr_pop_table (void)
{
  vector_element_t base_value;
  IR_node_t current_LR_set;
  IR_node_t current_LR_core;
  vlo_t comb_vector;
  vlo_t base_vector;

  int vector_length;
  int non_empty_nattr_pop_elements = 0;
  int all_nattr_pop_vectors_length = 0;
  int all_based_nattr_pop_vectors_length = 0;



  do { vlo_t *_temp_vlo = &(comb_vector); size_t temp_initial_length = (50000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 1362, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(base_vector); size_t temp_initial_length = (5000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 1363, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(base_vector); size_t _temp_length = ((((_IR_description *) (description))->_IR_S_description.LR_sets_number) * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1365, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); _temp_vlo->vlo_free += _temp_length; } while (0);

  do { vlo_t *_temp_vlo = &(nattr_pop_vector); size_t temp_initial_length = (2000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 1366, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  start_comb_vector_forming
    (&comb_vector, ((void *)0), 0, (-1), 0,
     (((_IR_description *) (description))->_IR_S_description.LR_sets_number));
  for (current_LR_core = (((_IR_description *) (description))->_IR_S_description.LR_core_list);
       current_LR_core != ((void *)0);
       current_LR_core = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.next_LR_core))
    for (current_LR_set = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.LR_set_list);
         current_LR_set != ((void *)0);
         current_LR_set = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.next_LR_set))
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag))
        {
          do { vlo_t *_temp_vlo = &(nattr_pop_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1378, ((const char *) 0)), 0))); _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
          start_LR_set_for_forming_nattr_pop_vector = current_LR_set;
          form_nattr_pop_vector (current_LR_set, 0);

          if (debug_level >= 1)
            {
              vector_length
                = ((nattr_pop_vector).vlo_start != ((void *)0) ? (nattr_pop_vector).vlo_free - (nattr_pop_vector).vlo_start : (abort (), 0)) / sizeof (element_t);
              non_empty_nattr_pop_elements += vector_length;
              if (vector_length != 0)
                {
                  all_nattr_pop_vectors_length += max_current_vector_index + 1;
                  all_based_nattr_pop_vectors_length
                    += (max_current_vector_index
                        - min_current_vector_index + 1);
                }
            }

          base_value
            = add_vector
              (0, (element_t *) ((nattr_pop_vector).vlo_start != ((void *)0) ? (void *) (nattr_pop_vector).vlo_start : (abort (), (void *) 0)),
               ((nattr_pop_vector).vlo_start != ((void *)0) ? (nattr_pop_vector).vlo_free - (nattr_pop_vector).vlo_start : (abort (), 0)) / sizeof (element_t));
          ((vector_element_t *) ((base_vector).vlo_start != ((void *)0) ? (void *) (base_vector).vlo_start : (abort (), (void *) 0)))
            [(((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_set_order_number)] = base_value;
        }

  if (debug_level >= 1)
    {
      int i;
      int comb_non_empty = 0;

      for (i = 0; i < ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t);
           i++)
        if (((vector_element_t *) ((comb_vector).vlo_start != ((void *)0) ? (void *) (comb_vector).vlo_start : (abort (), (void *) 0))) [i]
            != (-1))
          comb_non_empty++;
      fprintf
        (stderr,
         "Size:    npop attr vectors -- %d, npop attr comb vector -- %ld\n",
         all_nattr_pop_vectors_length,
         ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
      fprintf
        (stderr,
         "Filling: npop attr vectors -- %d%%, npop attr comb vector -- %ld%%\n",
         non_empty_nattr_pop_elements * 100
         / (1 > all_nattr_pop_vectors_length ? 1 : all_nattr_pop_vectors_length),
         comb_non_empty * 100 * sizeof (vector_element_t)
         / (1 > ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) ? 1 : ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0))));
      fprintf (stderr, "         based vectors -- %d%%\n",
               non_empty_nattr_pop_elements * 100
               / (1 > all_based_nattr_pop_vectors_length ? 1 : all_based_nattr_pop_vectors_length));
    }

  finish_comb_vector_forming ();
  output_string
    (output_implementation_file,
     "/* Comb vector for popping attributes during error recovery. */\n");
  output_string (output_implementation_file, "static const ");
  output_vector_element_type ((-1),
                              max_comb_vector_element_value);
  output_char (' ', output_implementation_file);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysnattr_pop" : "yynattr_pop"));
  output_string (output_implementation_file, "[] = {\n");
  output_vector ((vector_element_t *) ((comb_vector).vlo_start != ((void *)0) ? (void *) (comb_vector).vlo_start : (abort (), (void *) 0)),
                 ((comb_vector).vlo_start != ((void *)0) ? (comb_vector).vlo_free - (comb_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
  output_string (output_implementation_file, "};\n\n");
  output_string
    (output_implementation_file,
     "/* Base vector for popping attributes during error recovery. */\n");
  output_string (output_implementation_file, "static const ");
  output_vector_element_type (min_base_vector_element_value,
                              max_base_vector_element_value);
  output_char (' ', output_implementation_file);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysnapop_base" : "yynapop_base"));
  output_string (output_implementation_file, "[] = {\n");
  output_vector ((vector_element_t *) ((base_vector).vlo_start != ((void *)0) ? (void *) (base_vector).vlo_start : (abort (), (void *) 0)),
                 ((base_vector).vlo_start != ((void *)0) ? (base_vector).vlo_free - (base_vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
  output_string (output_implementation_file, "};\n\n");
  do { vlo_t *_temp_vlo = &(nattr_pop_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1456, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
  do { vlo_t *_temp_vlo = &(base_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1457, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
  do { vlo_t *_temp_vlo = &(comb_vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1458, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
}

static void
output_pushed_states_table (void)
{
  IR_node_t current_LR_set;
  IR_node_t current_LR_core;
  vlo_t vector;
  int vector_index;

  do { vlo_t *_temp_vlo = &(vector); size_t temp_initial_length = (5000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 1469, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(vector); size_t _temp_length = ((((_IR_description *) (description))->_IR_S_description.LR_sets_number) * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1471, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); _temp_vlo->vlo_free += _temp_length; } while (0);

  for (vector_index = 0;
       vector_index < (((_IR_description *) (description))->_IR_S_description.LR_sets_number);
       vector_index++)
    ((vector_element_t *) ((vector).vlo_start != ((void *)0) ? (void *) (vector).vlo_start : (abort (), (void *) 0))) [vector_index] = 0;
  for (current_LR_core = (((_IR_description *) (description))->_IR_S_description.LR_core_list);
       current_LR_core != ((void *)0);
       current_LR_core = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.next_LR_core))
    for (current_LR_set = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.LR_set_list);
         current_LR_set != ((void *)0);
         current_LR_set = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.next_LR_set))
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag)
          && (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.it_is_pushed_LR_set))
        ((vector_element_t *) ((vector).vlo_start != ((void *)0) ? (void *) (vector).vlo_start : (abort (), (void *) 0)))
          [(((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_set_order_number)] = 1;
  output_string (output_implementation_file,
                 "/* Flags of pushed LR-sets. */\n");
  output_string (output_implementation_file, "static const ");
  output_vector_element_type (0, 1);
  output_char (' ', output_implementation_file);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyspushed" : "yypushed"));
  output_string (output_implementation_file, "[] = {\n");
  output_vector ((vector_element_t *) ((vector).vlo_start != ((void *)0) ? (void *) (vector).vlo_start : (abort (), (void *) 0)),
                 ((vector).vlo_start != ((void *)0) ? (vector).vlo_free - (vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
  output_string (output_implementation_file, "};\n\n");
  do { vlo_t *_temp_vlo = &(vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1496, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
}

static void
output_errored_states_table (void)
{
  IR_node_t current_LR_set;
  IR_node_t current_LR_core;
  vlo_t vector;
  int vector_index;

  do { vlo_t *_temp_vlo = &(vector); size_t temp_initial_length = (5000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 1507, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(vector); size_t _temp_length = ((((_IR_description *) (description))->_IR_S_description.LR_sets_number) * sizeof (vector_element_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1509, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); _temp_vlo->vlo_free += _temp_length; } while (0);

  for (vector_index = 0;
       vector_index < (((_IR_description *) (description))->_IR_S_description.LR_sets_number);
       vector_index++)
    ((vector_element_t *) ((vector).vlo_start != ((void *)0) ? (void *) (vector).vlo_start : (abort (), (void *) 0))) [vector_index] = 0;
  for (current_LR_core = (((_IR_description *) (description))->_IR_S_description.LR_core_list);
       current_LR_core != ((void *)0);
       current_LR_core = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.next_LR_core))
    for (current_LR_set = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.LR_set_list);
         current_LR_set != ((void *)0);
         current_LR_set = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.next_LR_set))
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag)
          && (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.it_is_errored_LR_set))
        ((vector_element_t *) ((vector).vlo_start != ((void *)0) ? (void *) (vector).vlo_start : (abort (), (void *) 0)))
          [(((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_set_order_number)] = 1;
  output_string (output_implementation_file,
                 "/* Flags of errored LR-sets. */\n");
  output_string (output_implementation_file, "static const ");
  output_vector_element_type (0, 1);
  output_char (' ', output_implementation_file);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserrored" : "yyerrored"));
  output_string (output_implementation_file, "[] = {\n");
  output_vector ((vector_element_t *) ((vector).vlo_start != ((void *)0) ? (void *) (vector).vlo_start : (abort (), (void *) 0)),
                 ((vector).vlo_start != ((void *)0) ? (vector).vlo_free - (vector).vlo_start : (abort (), 0)) / sizeof (vector_element_t));
  output_string (output_implementation_file, "};\n\n");
  do { vlo_t *_temp_vlo = &(vector); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1534, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
}

static int
output_token_representation (FILE *f, IR_node_t single_term_definition,
                             int literal_code)
{
  int left_range_value;
  int right_range_value;
  char representation [20];
  char *str;

  ((void) ((((_IR_is_type [IR_NM_single_term_definition] [((single_term_definition)->_IR_node_mode) /8] >> (((single_term_definition)->_IR_node_mode) % 8)) & 1)) ? 0 : (__assert_fail ("((_IR_is_type [IR_NM_single_term_definition] [((single_term_definition)->_IR_node_mode) /8] >> (((single_term_definition)->_IR_node_mode) % 8)) & 1)", "__test.c", 1547, ((const char *) 0)), 0)));

  left_range_value = (((_IR_single_term_definition *) (single_term_definition))->_IR_S_single_term_definition.value);
  if (((_IR_is_type [IR_NM_literal_range_definition] [((single_term_definition)->_IR_node_mode) /8] >> (((single_term_definition)->_IR_node_mode) % 8)) & 1))

    {
      ((void) ((left_range_value <= literal_code && ((((_IR_literal_range_definition *) (single_term_definition))->_IR_S_literal_range_definition.right_range_bound_value) >= literal_code)) ? 0 : (__assert_fail ("left_range_value <= literal_code && ((((_IR_literal_range_definition *) (single_term_definition))->_IR_S_literal_range_definition.right_range_bound_value) >= literal_code)", "__test.c", 1555, ((const char *) 0)), 0)));



      if (literal_code == left_range_value)
        return
          output_identifier_or_literal
            (f, (*(IR_node_t *) ((char *) (single_term_definition) + _IR_D_identifier_or_literal [(((single_term_definition))->_IR_node_mode)])), 1);
      else if (literal_code == right_range_value)
        return
          output_identifier_or_literal
            (f, (((_IR_literal_range_definition *) (single_term_definition))->_IR_S_literal_range_definition.right_range_bound_literal), 1);
      else
        {
          ((void) ((literal_code >= 0 && literal_code <= (127 * 2 + 1)) ? 0 : (__assert_fail ("literal_code >= 0 && literal_code <= (127 * 2 + 1)", "__test.c", 1566, ((const char *) 0)), 0)));
          if (((*__ctype_b_loc ())[(int) ((literal_code))] & (unsigned short int) _ISprint) && literal_code != '\\'
              && literal_code != '"')
            {
              representation[0] = '\'';
              representation[1] = literal_code;
              representation[2] = '\'';
              representation[3] = '\0';
              str = representation;
            }
          else
            {
              if (literal_code == '\n')
                str = "'\\\\n'";
              else if (literal_code == '\t')
                str = "'\\\\t'";
              else if (literal_code == '\v')
                str = "'\\\\v'";
              else if (literal_code == '\b')
                str = "'\\\\b'";
              else if (literal_code == '\r')
                str = "'\\\\r'";
              else if (literal_code == '\f')
                str = "'\\\\f'";
              else if (literal_code == '\\')
                str = "'\\\\\\\\'";
              else if (literal_code == '"')
                str = "'\\\"'";
              else
                {
                  sprintf (representation, "'\\\\%o'", literal_code);
                  str = representation;
                }
            }
          output_string (f, str);
          return strlen (str);
        }
    }
  else
    {
      ((void) ((left_range_value == literal_code) ? 0 : (__assert_fail ("left_range_value == literal_code", "__test.c", 1606, ((const char *) 0)), 0)));
      return
        output_identifier_or_literal
          (f, (*(IR_node_t *) ((char *) (single_term_definition) + _IR_D_identifier_or_literal [(((single_term_definition))->_IR_node_mode)])), 1);
    }
}





static void
output_token_name_table (void)
{
  IR_node_t current_single_definition;
  int current_token_value;
  int current_column;
  int current_range_value;
  int left_range_value;
  int right_range_value;
  vlo_t single_term_definition_ptrs;

  output_string (output_implementation_file, "#if ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (output_implementation_file, " != 0\n");
  output_string (output_implementation_file, "const char *");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystname" : "yytname"));
  output_string (output_implementation_file, " [] =\n{");
  do { vlo_t *_temp_vlo = &(single_term_definition_ptrs); size_t temp_initial_length = (2000); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 1634, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(single_term_definition_ptrs); size_t _temp_length = ((max_token_value + 1) * sizeof (IR_node_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1636, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); _temp_vlo->vlo_free += _temp_length; } while (0);

  for (current_token_value = 0;
       current_token_value <= max_token_value;
       current_token_value++)
    ((IR_node_t *) ((single_term_definition_ptrs).vlo_start != ((void *)0) ? (void *) (single_term_definition_ptrs).vlo_start : (abort (), (void *) 0)))
      [current_token_value] = ((void *)0);
  for (current_single_definition = (((_IR_description *) (description))->_IR_S_description.single_definition_list);
       current_single_definition != ((void *)0);
       current_single_definition
       = (((_IR_single_definition *) (current_single_definition))->_IR_S_single_definition.next_single_definition))
    if (((_IR_is_type [IR_NM_single_term_definition] [((current_single_definition)->_IR_node_mode) /8] >> (((current_single_definition)->_IR_node_mode) % 8)) & 1))

      {
        left_range_value = (((_IR_single_term_definition *) (current_single_definition))->_IR_S_single_term_definition.value);
        if (((_IR_is_type [IR_NM_literal_range_definition] [((current_single_definition)->_IR_node_mode) /8] >> (((current_single_definition)->_IR_node_mode) % 8)) & 1))

          right_range_value
            = (((_IR_literal_range_definition *) (current_single_definition))->_IR_S_literal_range_definition.right_range_bound_value);
        else
          right_range_value = left_range_value;
        for (current_range_value = left_range_value;
             current_range_value <= right_range_value;
             current_range_value++)
          ((IR_node_t *) ((single_term_definition_ptrs).vlo_start != ((void *)0) ? (void *) (single_term_definition_ptrs).vlo_start : (abort (), (void *) 0)))
            [current_range_value] = current_single_definition;
      }
  output_string (output_implementation_file, "  ");
  current_column = 3;
  for (current_token_value = 0;
       current_token_value <= max_token_value;
       current_token_value++)
    {
      if (((IR_node_t *) ((single_term_definition_ptrs).vlo_start != ((void *)0) ? (void *) (single_term_definition_ptrs).vlo_start : (abort (), (void *) 0)))
          [current_token_value] == ((void *)0))
        {

          output_string (output_implementation_file, "0");
          current_column++;
        }
      else
        {
          output_char ('\"', output_implementation_file);
          if (((IR_node_t *) ((single_term_definition_ptrs).vlo_start != ((void *)0) ? (void *) (single_term_definition_ptrs).vlo_start : (abort (), (void *) 0)))
              [current_token_value] == end_marker_single_definition)
            {
              output_string (output_implementation_file, "end-of-file");
              current_column += strlen ("end-of-file");
            }
          else
            current_column
              += output_token_representation
                (output_implementation_file,
                 ((IR_node_t *) ((single_term_definition_ptrs).vlo_start != ((void *)0) ? (void *) (single_term_definition_ptrs).vlo_start : (abort (), (void *) 0)))
                 [current_token_value], current_token_value);
          output_char ('\"', output_implementation_file);
          current_column += 2;
        }
      if (current_token_value != max_token_value)
        {
          output_string (output_implementation_file, ", ");
          current_column += 2;
        }
      if (current_column > 60)
        {
          output_string (output_implementation_file, "\n  ");
          current_column = 3;
        }
    }
  do { vlo_t *_temp_vlo = &(single_term_definition_ptrs); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 1704, ((const char *) 0)), 0))); do { void *_memory = (void *) (_temp_vlo->vlo_start); if (_memory != ((void *)0)) free (_memory); } while (0); _temp_vlo->vlo_start = ((void *)0); } while (0);
  output_string (output_implementation_file, "\n};\n");
  output_string (output_implementation_file, "#endif\n\n");
}

static void
output_parser_tables (void)
{

  ticker_t temp_ticker;



  temp_ticker = create_ticker ();

  output_translate_vector ();

  if (time_flag)
    fprintf (stderr, "      translate vector creation & output -- %ssec\n",
             active_time_string (temp_ticker));
  temp_ticker = create_ticker ();

  output_action_table ();

  if (time_flag)
    fprintf (stderr, "      action table creation & output -- %ssec\n",
             active_time_string (temp_ticker));
  temp_ticker = create_ticker ();

  output_nonterminal_goto_table ();

  if (time_flag)
    fprintf (stderr,
             "      nonterminal goto table creation & output -- %ssec\n",
             active_time_string (temp_ticker));

  if (regular_optimization_flag)
    {

      temp_ticker = create_ticker ();

      output_pushed_states_table ();

      if (time_flag)
        fprintf
          (stderr,
           "      pushed states flag table creation & output -- %ssec\n",
           active_time_string (temp_ticker));
      temp_ticker = create_ticker ();

      if (msta_error_recovery == 2)
 {
   output_errored_states_table ();

   if (time_flag)
     fprintf
       (stderr,
        "      errored states flag table creation & output -- %ssec\n",
        active_time_string (temp_ticker));
   temp_ticker = create_ticker ();


 }
      output_nattr_pop_table ();

      if (time_flag)
        fprintf
          (stderr,
           "      popped attributes number table creation & output -- %ssec\n",
           active_time_string (temp_ticker));

    }

  temp_ticker = create_ticker ();

  output_token_name_table ();

  if (time_flag)
    fprintf (stderr, "      token name table creation & output -- %ssec\n",
             active_time_string (temp_ticker));

}

static void
output_include_directives (void)
{
  output_string (output_implementation_file, "#include <stdio.h>\n");
  output_string (output_implementation_file, "#include <stdlib.h>\n\n");
  if (msta_error_recovery == 2)
    {
      output_string (output_implementation_file, "#include <limits.h>\n\n");
      output_string (output_implementation_file, "#ifndef INT_MAX\n");
      output_string (output_implementation_file,
       "#define INT_MAX 2147483647\n");
      output_string (output_implementation_file, "#endif\n\n");
    }
}

static void
output_yyparse_function_name (FILE *f)
{
  output_string (f, sym_prefix);
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_string (f, "lex");
  else
    output_string (f, "parse");
}

static void
output_yylex_function_name (FILE *f)
{
  output_string (f, sym_prefix);
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "slex" : "lex"));
}

static void
output_yyparser_class_name (FILE *f)
{
  output_string (f, sym_prefix);
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_string (f, "scanner");
  else
    output_string (f, "parser");
}

static void
output_yylex_start_function_name (FILE *f)
{
  if (cpp_flag)
    output_yyparser_class_name (f);
  else
    {
      output_string (f, sym_prefix);
      output_string (f, "lex_start");
    }
}

static void
output_yylex_finish_function_name (FILE *f)
{
  if (cpp_flag)
    output_yyparser_class_name (f);
  else
    {
      output_string (f, sym_prefix);
      output_string (f, "lex_finish");
    }
}

static void
output_yyerror_function_name (FILE *f)
{
  output_string (f, sym_prefix);
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_string (f, "serror");
  else
    output_string (f, "error");
}

static void
output_yylval_variable_name (FILE *f)
{
  output_string (f, sym_prefix);
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_string (f, "slval");
  else
    output_string (f, "lval");
}

static void
output_yychar_variable_name (FILE *f)
{
  output_string (f, sym_prefix);
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_string (f, "schar");
  else
    output_string (f, "char");
}

static void
output_yydebug_variable_name (FILE *f)
{
  output_string (f, sym_prefix);
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_string (f, "sdebug");
  else
    output_string (f, "debug");
}

static void
output_yystype_definition (FILE *f)
{
  if ((((_IR_description *) (description))->_IR_S_description.union_code) == ((void *)0))
    {
      output_string (f, "#ifndef  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
      output_string (f, "\n#define  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
      output_string (f, "  int\n#endif\n\n");
    }
  else
    {
      output_string (f, "typedef union {");
      output_line (f,
                   (((_IR_node *) ((((_IR_description *) (description))->_IR_S_description.union_code)))->_IR_S_node.position).line_number,
                   (((_IR_node *) ((((_IR_description *) (description))->_IR_S_description.union_code)))->_IR_S_node.position).file_name);
      output_string (f,
                     (((_IR_code_insertion *) ((((_IR_code *) ((((_IR_description *) (description))->_IR_S_description.union_code)))->_IR_S_code.code_itself)))->_IR_S_code_insertion.code_insertion_itself));

      output_string (f, "}  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
      output_string (f, ";\n\n");
      output_current_line (f);
    }
}

static void
output_token_definitions (FILE *f)
{
  IR_node_t current_single_definition;
  int first_enumeration_flag;

  first_enumeration_flag = 1;
  for (current_single_definition = (((_IR_description *) (description))->_IR_S_description.single_definition_list);
       current_single_definition != ((void *)0);
       current_single_definition
       = (((_IR_single_definition *) (current_single_definition))->_IR_S_single_definition.next_single_definition))
    if (((_IR_is_type [IR_NM_single_term_definition] [((current_single_definition)->_IR_node_mode) /8] >> (((current_single_definition)->_IR_node_mode) % 8)) & 1)
        && ((_IR_is_type [IR_NM_identifier] [(((*(IR_node_t *) ((char *) (current_single_definition) + _IR_D_identifier_or_literal [(((current_single_definition))->_IR_node_mode)])))->_IR_node_mode) /8] >> ((((*(IR_node_t *) ((char *) (current_single_definition) + _IR_D_identifier_or_literal [(((current_single_definition))->_IR_node_mode)])))->_IR_node_mode) % 8)) & 1)

        && current_single_definition != end_marker_single_definition
        && current_single_definition != error_single_definition)
      {
        if (enum_flag)
          {
            if (first_enumeration_flag)
              {
                output_string (f, "enum\n");
                output_string (f, "{\n");
                first_enumeration_flag = 0;
              }
            else
              output_string (f, ",\n");
            output_string (f, "  ");
            output_string (f,
                           (((_IR_identifier *) ((*(IR_node_t *) ((char *) (current_single_definition) + _IR_D_identifier_or_literal [(((current_single_definition))->_IR_node_mode)]))))->_IR_S_identifier.identifier_itself));

            output_string (f, " = ");
            output_decimal_number (f, (((_IR_single_term_definition *) (current_single_definition))->_IR_S_single_term_definition.value), 0);
          }
        else
          {
            output_string (f, "#define ");
            output_string (f,
                           (((_IR_identifier *) ((*(IR_node_t *) ((char *) (current_single_definition) + _IR_D_identifier_or_literal [(((current_single_definition))->_IR_node_mode)]))))->_IR_S_identifier.identifier_itself));

            output_char (' ', f);
            output_decimal_number (f, (((_IR_single_term_definition *) (current_single_definition))->_IR_S_single_term_definition.value), 0);
            output_char ('\n', f);
          }
      }
  if (!first_enumeration_flag)
    {
      output_string (f, "\n};\n");
    }
  output_char ('\n', f);
}

static void
output_yylval_definition (FILE *f)
{
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
  output_string (f, "  ");
  output_yylval_variable_name (f);
  output_string (f, ";\n\n");
}

static void
output_yychar_definition (FILE *f)
{
  output_string (f, "int ");
  output_yychar_variable_name (f);
  output_string (f, ";\n\n");
}

static void
output_yydebug_definition (FILE *f)
{
  output_string (f, "int ");
  output_yydebug_variable_name (f);
  output_string (f, ";\n\n");
}

static void
output_yyparse_title (FILE *f, int inside_class)
{
  ((void) ((cpp_flag || !inside_class) ? 0 : (__assert_fail ("cpp_flag || !inside_class", "__test.c", 2000, ((const char *) 0)), 0)));
  output_string (f, "int ");
  if (!inside_class && cpp_flag)
    {
      output_yyparser_class_name (f);
      output_string (f, "::");
    }
  output_yyparse_function_name (f);
  if (cpp_flag)
    output_string (f, " (void)");
  else
    output_string (f, " ()");
}
static void
output_inside_outside_definitions (FILE *f, int inside_flag)
{

  output_string (f, (inside_flag ? "  int *" : "static int *"));
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
  output_string (f, ";\n");

  output_string (f, (inside_flag ? "  " : "static "));
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
  output_string (f, " *");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
  output_string (f, ";\n");
  if (real_look_ahead_number == 2
      && msta_error_recovery == 0)
    {

      output_string (f, (inside_flag ? "  int " : "static int "));
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, ";\n");

      output_string (f, (inside_flag ? "  " : "static "));
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
      output_string (f, " ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"));
      output_string (f, ";\n");
    }
  else if (real_look_ahead_number > 2
    || msta_error_recovery != 0)
    {

      output_string (f, (inside_flag ? "  int *" : "static int *"));
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, ";\n");

      output_string (f, (inside_flag ? "  int *" : "static int *"));
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, ";\n");

      output_string (f, (inside_flag ? "  " : "static "));
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
      output_string (f, " *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"));
      output_string (f, ";\n");
    }
  if (msta_error_recovery == 2)
    {

      output_string (f, (inside_flag ? "  int *" : "static int *"));
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate_token_nums" : "yystate_token_nums"));
      output_string (f, ";\n");

      output_string (f, (inside_flag ? "  int *" : "static int *"));
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_state_token_nums" : "yysaved_state_token_nums"));
      output_string (f, ";\n");

      output_string (f, (inside_flag ? "  int *" : "static int *"));
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_states" : "yysaved_states"));
      output_string (f, ";\n");

      output_string (f, (inside_flag ? "  " : "static "));
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
      output_string (f, " *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_attributes" : "yysaved_attributes"));
      output_string (f, ";\n");
    }

  output_string (f, (inside_flag ? "  int " : "static int "));
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysnerrs" : "yynerrs"));
  output_string (f, ";      /* fixed syntactic errors number */\n");
}

static void
output_state_or_attribute_stack_expansion_function_title (FILE *f,
         int state_flag,
         int in_class_flag)
{
  ((void) ((!in_class_flag || cpp_flag) ? 0 : (__assert_fail ("!in_class_flag || cpp_flag", "__test.c", 2118, ((const char *) 0)), 0)));
  if (!cpp_flag)
    output_string (f, "static ");
  output_string (f, "int ");
  if (cpp_flag && !in_class_flag)
    {
      output_yyparser_class_name (f);
      output_string (f, "::");
    }
  output_string (f, (state_flag
       ? ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysexpand_states_stack" : "yyexpand_states_stack")
       : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysexpand_attributes_stack" : "yyexpand_attributes_stack")));
  output_string (f, " (");
  output_string (f, (state_flag ? "int" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE")));
  output_string (f, " **start, ");
  if (state_flag && msta_error_recovery == 2)
    output_string (f, "int **state_tokens, ");
  output_string (f, (state_flag ? "int" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE")));
  output_string (f, " **end, ");
  output_string (f, (state_flag ? "int" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE")));
  output_string (f, " **top)");
}

static void
output_saved_state_or_attribute_buffer_expansion_function_title
  (FILE *f, int state_flag, int in_class_flag)
{
  ((void) ((msta_error_recovery == 2) ? 0 : (__assert_fail ("msta_error_recovery == 2", "__test.c", 2145, ((const char *) 0)), 0)));
  ((void) ((!in_class_flag || cpp_flag) ? 0 : (__assert_fail ("!in_class_flag || cpp_flag", "__test.c", 2146, ((const char *) 0)), 0)));
  if (!cpp_flag)
    output_string (f, "static ");
  output_string (f, "int ");
  if (cpp_flag && !in_class_flag)
    {
      output_yyparser_class_name (f);
      output_string (f, "::");
    }
  output_string (f, (state_flag
       ? ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysexpand_saved_states_buffer" : "yyexpand_saved_states_buffer")
       : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysexpand_saved_attributes_buffer" : "yyexpand_saved_attributes_buffer")));
  output_string (f, " (");
  output_string (f, (state_flag ? "int" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE")));
  output_string (f, " **start, ");
  if (state_flag)
    output_string (f, "int **token_nums_start, ");
  output_string (f, (state_flag ? "int" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE")));
  output_string (f, " **end, int length)");
}

static void
output_token_buffer_increase_function_title (FILE *f, int in_class_flag)
{
  ((void) ((msta_error_recovery == 2) ? 0 : (__assert_fail ("msta_error_recovery == 2", "__test.c", 2170, ((const char *) 0)), 0)));
  ((void) ((!in_class_flag || cpp_flag) ? 0 : (__assert_fail ("!in_class_flag || cpp_flag", "__test.c", 2171, ((const char *) 0)), 0)));
  if (!cpp_flag)
    output_string (f, "static ");
  output_string (f, "int ");
  if (cpp_flag && !in_class_flag)
    {
      output_yyparser_class_name (f);
      output_string (f, "::");
    }
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysincrease_saved_tokens_buffer" : "yyincrease_saved_tokens_buffer"));
  output_string (f, " (int **start, ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
  output_string (f, " **attr_start, int **end, int **curr)");
}

static void
output_class_start (FILE *f)
{
  ((void) ((cpp_flag) ? 0 : (__assert_fail ("cpp_flag", "__test.c", 2189, ((const char *) 0)), 0)));
  output_string (f, "class ");
  output_yyparser_class_name (f);
  output_string (f, "{\n");
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_inside_outside_definitions (f, 1);
  if (expand_flag)
    {
      output_string (f, "  ");
      output_state_or_attribute_stack_expansion_function_title (f, 1, 1);
      output_string (f, ";\n  ");
      output_state_or_attribute_stack_expansion_function_title (f,
        0, 1);
      output_string (f, ";\n");
    }
  if (msta_error_recovery == 2)
    {
      output_string (f, "  ");
      output_saved_state_or_attribute_buffer_expansion_function_title
 (f, 1, 1);
      output_string (f, ";\n  ");
      output_saved_state_or_attribute_buffer_expansion_function_title
 (f, 0, 1);
      output_string (f, ";\n");
      output_token_buffer_increase_function_title (f, 1);
      output_string (f, ";\n");
    }
  output_string (f, "\npublic:\n");
}

static void output_yylex_start_title (FILE *f, int inside_class);

static void
output_class_finish (FILE *f)
{
  ((void) ((cpp_flag) ? 0 : (__assert_fail ("cpp_flag", "__test.c", 2224, ((const char *) 0)), 0)));
  output_string (f, "  virtual int ");
  output_yylex_function_name (f);
  output_string (f, " (void) = 0;\n");
  output_string (f, "  virtual void ");
  output_yyerror_function_name (f);
  output_string (f, " (const char *message) = 0;\n");
  output_string (f, "  ");
  output_yyparse_title (f, 1);
  output_string (f, ";\n");

  output_string (f, "  ");
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    {
      output_yylex_start_title (f, 1);
      output_string (f, ";\n");
    }
  else
    {
      output_yyparser_class_name (f);
      output_string (f, " (void) {}\n");
    }

  output_string (f, "  virtual ~");
  output_yyparser_class_name (f);
  output_string (f, " (void)");
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_string (f, ";\n");
  else
    output_string (f, "  {}\n");
  output_string (f, "};\n\n");
}

static void
output_external_definitions (void)
{

  output_yystype_definition (output_implementation_file);
  if (define_flag)
    output_yystype_definition (output_interface_file);
  output_token_definitions (output_implementation_file);
  if (define_flag)
    output_token_definitions (output_interface_file);
  if (cpp_flag)
    {
      output_class_start (output_implementation_file);
      if (define_flag)
        output_class_start (output_interface_file);
    }

  if (cpp_flag)
    output_string (output_implementation_file, "  ");
  output_yylval_definition (output_implementation_file);
  if (define_flag)
    {

      if (cpp_flag)
        output_string (output_interface_file, "  ");
      else
        output_string (output_interface_file, "extern ");
      output_yylval_definition (output_interface_file);
    }

  if (cpp_flag)
    output_string (output_implementation_file, "  ");
  output_yychar_definition (output_implementation_file);
  if (define_flag)
    {
      if (cpp_flag)
        output_string (output_interface_file, "  ");
      else
        output_string (output_interface_file, "extern ");
      output_yychar_definition (output_interface_file);
    }

  if (cpp_flag)
    output_string (output_implementation_file, "  ");
  output_yydebug_definition (output_implementation_file);
  if (define_flag)
    {
      if (cpp_flag)
        output_string (output_interface_file, "  ");
      else
        output_string (output_interface_file, "extern ");
      output_yydebug_definition (output_interface_file);
    }
  if (cpp_flag)
    {
      output_class_finish (output_implementation_file);
      if (define_flag)
        output_class_finish (output_interface_file);
    }
}

static void
output_yylex_start_title (FILE *f, int inside_class)
{
  ((void) ((cpp_flag || !inside_class) ? 0 : (__assert_fail ("cpp_flag || !inside_class", "__test.c", 2321, ((const char *) 0)), 0)));
  if (!cpp_flag)
    output_string (f, "void ");
  if (!inside_class && cpp_flag)
    {
      output_yyparser_class_name (f);
      output_string (f, "::");
    }
  output_yylex_start_function_name (f);
  if (cpp_flag)
    output_string (f, " (int &");
  else
    output_string (f, " (int *");
  output_string (f, "error_flag");
  output_string (f, ")");
}

static void
output_yylex_finish_title (FILE *f, int inside_class)
{
  ((void) ((cpp_flag || !inside_class) ? 0 : (__assert_fail ("cpp_flag || !inside_class", "__test.c", 2341, ((const char *) 0)), 0)));
  if (!cpp_flag)
    output_string (f, "void ");
  if (!inside_class && cpp_flag)
    {
      output_yyparser_class_name (f);
      output_string (f, "::");
    }
  if (cpp_flag)
    output_string (f, "~");
  output_yylex_finish_function_name (f);
  output_string (f, " (void)");
}
static void
output_look_ahead_arrays_length (FILE *f)
{
  ((void) ((real_look_ahead_number > 2 || (((_IR_description *) (description))->_IR_S_description.back_tracking_exists) || msta_error_recovery != 0) ? 0 : (__assert_fail ("real_look_ahead_number > 2 || (((_IR_description *) (description))->_IR_S_description.back_tracking_exists) || msta_error_recovery != 0", "__test.c", 2465, ((const char *) 0)), 0)));

  output_string (f, "(");
  output_decimal_number
    (f, real_look_ahead_number - (msta_error_recovery == 0
      ? 1 : 0), 0);
  if (msta_error_recovery == 2)
    output_string (f, " + 100");
  else if (msta_error_recovery == 1)
    {
      output_string (f, " + ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_MAX_LOOK_AHEAD_CHARS" : "YYERR_MAX_LOOK_AHEAD_CHARS"));
      output_string (f, " + ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
    }
  output_string (f, ")");
}


static void
output_definitions_outside_yyparse (void)
{

  output_string (output_implementation_file, "#ifndef  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSALLOC" : "YYALLOC"));
  if (expand_flag)
    output_string
      (output_implementation_file,
       "\n/* Initial state & attribute stacks size (in elems). */");
  output_string (output_implementation_file, "\n#define  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSALLOC" : "YYALLOC"));
  if (cpp_flag)
    output_string (output_implementation_file, "(size)  ::malloc (size)\n");
  else
    output_string (output_implementation_file, "(size)  malloc (size)\n");
  output_string (output_implementation_file, "#endif\n\n");

  output_string (output_implementation_file, "#ifndef  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSREALLOC" : "YYREALLOC"));
  if (expand_flag)
    output_string
      (output_implementation_file,
       "\n/* Initial state & attribute stacks size (in elems). */");
  output_string (output_implementation_file, "\n#define  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSREALLOC" : "YYREALLOC"));
  if (cpp_flag)
    output_string (output_implementation_file,
     "(ptr, size) ::realloc (ptr, size)\n");
  else
    output_string (output_implementation_file,
     "(ptr, size)  realloc (ptr, size)\n");
  output_string (output_implementation_file, "#endif\n\n");

  output_string (output_implementation_file, "#ifndef  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSFREE" : "YYFREE"));
  if (expand_flag)
    output_string
      (output_implementation_file,
       "\n/* Initial state & attribute stacks size (in elems). */");
  output_string (output_implementation_file, "\n#define  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSFREE" : "YYFREE"));
  if (cpp_flag)
    output_string (output_implementation_file, "(ptr)  ::free (ptr)\n");
  else
    output_string (output_implementation_file, "(ptr)  free (ptr)\n");
  output_string (output_implementation_file, "#endif\n\n");

  output_string (output_implementation_file, "#ifndef  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"));
  if (expand_flag)
    output_string
      (output_implementation_file,
       "\n/* Initial state & attribute stacks size (in elems). */");
  output_string (output_implementation_file, "\n#define  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"));
  output_string (output_implementation_file, "  500\n");
  output_string (output_implementation_file, "#endif\n\n");

  output_string (output_implementation_file, "#if  ");
  output_string (output_implementation_file,
                 ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"));
  output_string (output_implementation_file, " <= 0\n#undef  ");
  output_string (output_implementation_file,
                 ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"));
  output_string (output_implementation_file, "\n#define  ");
  output_string (output_implementation_file,
                 ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"));
  output_string (output_implementation_file, "  50\n");
  output_string (output_implementation_file, "#endif\n\n");
  if (expand_flag)
    {

      output_string (output_implementation_file, "#ifndef  ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_STACK_SIZE" : "YYMAX_STACK_SIZE"));
      output_string
 (output_implementation_file,
  "\n/* Max. state & attribute stacks size (in elems). */\n");
      output_string (output_implementation_file, "#define  ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_STACK_SIZE" : "YYMAX_STACK_SIZE"));
      output_string (output_implementation_file, "  5000\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#if  ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_STACK_SIZE" : "YYMAX_STACK_SIZE"));
      output_string (output_implementation_file, " <= 0\n#undef  ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_STACK_SIZE" : "YYMAX_STACK_SIZE"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_STACK_SIZE" : "YYMAX_STACK_SIZE"));
      output_string (output_implementation_file, "  100\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#ifndef  ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_EXPAND_SIZE" : "YYMAX_STACK_EXPAND_SIZE"));
      output_string
 (output_implementation_file,
  "\n/* Expansion step of state & attr. stacks size (in elems). */\n");
      output_string (output_implementation_file, "#define  ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_EXPAND_SIZE" : "YYMAX_STACK_EXPAND_SIZE"));
      output_string (output_implementation_file, "  500\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#if  ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_EXPAND_SIZE" : "YYMAX_STACK_EXPAND_SIZE"));
      output_string (output_implementation_file, " <= 0\n#undef  ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_EXPAND_SIZE" : "YYMAX_STACK_EXPAND_SIZE"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_EXPAND_SIZE" : "YYMAX_STACK_EXPAND_SIZE"));
      output_string (output_implementation_file, "  10\n");
      output_string (output_implementation_file, "#endif\n\n");
    }

  output_string (output_implementation_file, "#ifndef  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERROR_MESSAGE" : "YYERROR_MESSAGE"));
  output_string (output_implementation_file, "\n#define  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERROR_MESSAGE" : "YYERROR_MESSAGE"));
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_string (output_implementation_file, " \"lexical error\"\n");
  else
    output_string (output_implementation_file, " \"syntax error\"\n");
  output_string (output_implementation_file, "#endif\n\n");

  output_string (output_implementation_file, "#define ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
  output_string (output_implementation_file, "  (-2)");
  output_string (output_implementation_file, "\n\n");

  output_string (output_implementation_file, "#define ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEOF" : "YYEOF"));
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_string (output_implementation_file, "  -1");
  else
    output_string (output_implementation_file, "  0");
  output_string (output_implementation_file, "\n\n");

  output_string (output_implementation_file, "#define ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysclearin" : "yyclearin"));
  output_string (output_implementation_file, " do {if (");
  output_yychar_variable_name (output_implementation_file);
  output_string (output_implementation_file, " != ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
  output_string (output_implementation_file, ") ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysprev_char" : "yyprev_char"));
  output_string (output_implementation_file, " = ");
  output_yychar_variable_name (output_implementation_file);
  output_string (output_implementation_file, "; ");
  output_yychar_variable_name (output_implementation_file);
  output_string (output_implementation_file, " = ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
  output_string (output_implementation_file, ";} while (0)\n\n");
  if (msta_error_recovery == 1)
    {

      output_string (output_implementation_file, "#define ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysdeeper_error_try" : "yydeeper_error_try"));
      output_string (output_implementation_file, "  (");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_new_try" : "yyerr_new_try"));
      output_string (output_implementation_file, " = 1)\n\n");
    }


  output_string (output_implementation_file, "#define ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT"));
  output_string (output_implementation_file, " goto ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysabort" : "yyabort"));
  output_string (output_implementation_file, "\n\n");

  output_string (output_implementation_file, "#define ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSACCEPT" : "YYACCEPT"));
  output_string (output_implementation_file, " goto ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysaccept" : "yyaccept"));
  output_string (output_implementation_file, "\n\n");

  output_string (output_implementation_file, "#ifndef  ");
  output_string (output_implementation_file,
                 ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
  output_string (output_implementation_file, "\n#define  ");
  output_string (output_implementation_file,
                 ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
  output_string (output_implementation_file, "  3\n");
  output_string (output_implementation_file, "#endif\n\n");

  output_string (output_implementation_file, "#if  ");
  output_string (output_implementation_file,
                 ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
  output_string (output_implementation_file, " <= 0\n#undef  ");
  output_string (output_implementation_file,
                 ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
  output_string (output_implementation_file, "\n#define  ");
  output_string (output_implementation_file,
                 ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
  output_string (output_implementation_file, "  1\n");
  output_string (output_implementation_file, "#endif\n\n");
  if (msta_error_recovery == 1)
    {

      output_string (output_implementation_file, "#ifndef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_MAX_LOOK_AHEAD_CHARS" : "YYERR_MAX_LOOK_AHEAD_CHARS"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_MAX_LOOK_AHEAD_CHARS" : "YYERR_MAX_LOOK_AHEAD_CHARS"));
      output_string (output_implementation_file, "  7\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#if  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_MAX_LOOK_AHEAD_CHARS" : "YYERR_MAX_LOOK_AHEAD_CHARS"));
      output_string (output_implementation_file, " <= 0\n#undef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_MAX_LOOK_AHEAD_CHARS" : "YYERR_MAX_LOOK_AHEAD_CHARS"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_MAX_LOOK_AHEAD_CHARS" : "YYERR_MAX_LOOK_AHEAD_CHARS"));
      output_string (output_implementation_file, "  1\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#ifndef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_LOOK_AHEAD_INCREMENT" : "YYERR_LOOK_AHEAD_INCREMENT"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_LOOK_AHEAD_INCREMENT" : "YYERR_LOOK_AHEAD_INCREMENT"));
      output_string (output_implementation_file, "  3\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#if  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_LOOK_AHEAD_INCREMENT" : "YYERR_LOOK_AHEAD_INCREMENT"));
      output_string (output_implementation_file, " < 0\n#undef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_LOOK_AHEAD_INCREMENT" : "YYERR_LOOK_AHEAD_INCREMENT"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_LOOK_AHEAD_INCREMENT" : "YYERR_LOOK_AHEAD_INCREMENT"));
      output_string (output_implementation_file, "  0\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#ifndef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_POPPED_ERROR_STATES" : "YYERR_POPPED_ERROR_STATES"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_POPPED_ERROR_STATES" : "YYERR_POPPED_ERROR_STATES"));
      output_string (output_implementation_file, "  2\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#if  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_POPPED_ERROR_STATES" : "YYERR_POPPED_ERROR_STATES"));
      output_string (output_implementation_file, " < 0\n#undef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_POPPED_ERROR_STATES" : "YYERR_POPPED_ERROR_STATES"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_POPPED_ERROR_STATES" : "YYERR_POPPED_ERROR_STATES"));
      output_string (output_implementation_file, "  0\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#ifndef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_DISCARDED_CHARS" : "YYERR_DISCARDED_CHARS"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_DISCARDED_CHARS" : "YYERR_DISCARDED_CHARS"));
      output_string (output_implementation_file, "  3\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#if  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_DISCARDED_CHARS" : "YYERR_DISCARDED_CHARS"));
      output_string (output_implementation_file, " < 0\n#undef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_DISCARDED_CHARS" : "YYERR_DISCARDED_CHARS"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_DISCARDED_CHARS" : "YYERR_DISCARDED_CHARS"));
      output_string (output_implementation_file, "  0\n");
      output_string (output_implementation_file, "#endif\n\n");
    }
  if (real_look_ahead_number > 2 || (((_IR_description *) (description))->_IR_S_description.back_tracking_exists)
      || msta_error_recovery != 0)
    {

      output_string (output_implementation_file, "#ifndef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, "  ");
      output_look_ahead_arrays_length (output_implementation_file);
      output_string (output_implementation_file, "\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#if  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, " < ");
      output_look_ahead_arrays_length (output_implementation_file);
      output_string (output_implementation_file, "\n#undef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, "  ");
      output_look_ahead_arrays_length (output_implementation_file);
      output_string (output_implementation_file, "\n#endif\n");
    }
  if (msta_error_recovery == 2)
    {
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSUNDEFINED_RECOVERY_COST" : "YYUNDEFINED_RECOVERY_COST"));
      output_string (output_implementation_file, "  INT_MAX\n\n");
    }
  if ((((_IR_description *) (description))->_IR_S_description.back_tracking_exists))
    {

      output_string (output_implementation_file, "#ifndef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_LOOK_AHEAD_SIZE" : "YYMAX_LOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_LOOK_AHEAD_SIZE" : "YYMAX_LOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, "  (50*");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, ")\n#endif\n\n");

      output_string (output_implementation_file, "#if  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_LOOK_AHEAD_SIZE" : "YYMAX_LOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, " < ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, "\n#undef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_LOOK_AHEAD_SIZE" : "YYMAX_LOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_LOOK_AHEAD_SIZE" : "YYMAX_LOOK_AHEAD_SIZE"));
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, "\n");
      output_string (output_implementation_file, "#endif\n\n");

      output_string (output_implementation_file, "#ifndef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_EXPAND_SIZE" : "YYLOOK_AHEAD_EXPAND_SIZE"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_EXPAND_SIZE" : "YYLOOK_AHEAD_EXPAND_SIZE"));
      output_string (output_implementation_file, "  (5*");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, ")\n#endif\n\n");

      output_string (output_implementation_file, "#if  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_EXPAND_SIZE" : "YYLOOK_AHEAD_EXPAND_SIZE"));
      output_string (output_implementation_file, " <= 0\n#undef  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_EXPAND_SIZE" : "YYLOOK_AHEAD_EXPAND_SIZE"));
      output_string (output_implementation_file, "\n#define  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_EXPAND_SIZE" : "YYLOOK_AHEAD_EXPAND_SIZE"));
      output_string (output_implementation_file, "  1\n#endif\n\n");
    }

  output_string (output_implementation_file, "#define ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERROR" : "YYERROR"));
  output_string (output_implementation_file, "  goto ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserrlab" : "yyerrlab"));
  output_string (output_implementation_file, "\n\n");

  output_string (output_implementation_file, "#define ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserrok" : "yyerrok"));
  output_string (output_implementation_file, "  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
  output_string (output_implementation_file, " = (-1)\n\n");

  output_string (output_implementation_file, "#define ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSRECOVERING" : "YYRECOVERING"));
  output_string (output_implementation_file, "()  (");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
  output_string (output_implementation_file, " > 0)\n\n");



  output_string (output_implementation_file, "#define ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSTOKEN_NAME" : "YYTOKEN_NAME"));
  output_string (output_implementation_file,
                 "(code)\\\n  ((code) < 0 || (code) > ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLAST_TOKEN_CODE" : "YYLAST_TOKEN_CODE"));
  output_string (output_implementation_file, " || ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystname" : "yytname"));
  output_string (output_implementation_file, " [code] == 0");
  output_string (output_implementation_file, "\\\n");
  output_string (output_implementation_file, "   ? \"illegal-code\" : ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystname" : "yytname"));
  output_string (output_implementation_file, " [code])\n\n");
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag) && !cpp_flag)
    {
      output_inside_outside_definitions (output_implementation_file, 0);
      output_string (output_implementation_file, "\n");
    }
}

static void
output_state_or_attribute_stack_expansion_function (int state_flag)
{
  FILE *f = output_implementation_file;

  output_state_or_attribute_stack_expansion_function_title (f,
           state_flag, 0);
  output_string (f, "\n{\n");
  output_string (f, "  int size = *end - *start + 1;\n");
  output_string (f, "  int new_size = size + ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_EXPAND_SIZE" : "YYMAX_STACK_EXPAND_SIZE"));
  output_string (f, ";\n  ");
  output_string (f, (state_flag ? "int" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE")));
  output_string (f, " *new_start;\n");
  if (state_flag && msta_error_recovery == 2)
    output_string (f, "  int *new_state_tokens;\n");
  output_string (f, "\n#if ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (f, " != 0\n");
  output_string (f, "  if (");
  output_yydebug_variable_name (f);
  output_string (f, ")\n    fprintf (stderr, \"Expanding ");
  output_string (f, (state_flag ? "states": "attributes"));
  output_string
    (f, " stack (old size - %d, new size - %d)\\n\", size, new_size);\n");
  output_string (f, "#endif\n");
  output_string (f, "  if (new_size > ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_STACK_SIZE" : "YYMAX_STACK_SIZE"));
  output_string (f, ")\n");
  output_string (f, "    {\n");
  output_string (f, "      ");
  output_yyerror_function_name (f);
  output_string (f, (state_flag ? " (\"states": " (\"attributes"));
  output_string (f, " stack is overfull\");\n");
  output_string (f, "      return 1;\n");
  output_string (f, "    }\n");
  output_string (f, "  new_start = (");
  output_string (f, (state_flag ? "int" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE")));
  output_string (f, "*) ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSREALLOC" : "YYREALLOC"));
  output_string (f, " (*start, new_size * sizeof (");
  output_string (f, (state_flag ? "int" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE")));
  output_string (f, "));\n");
  output_string (f, "  if (new_start == NULL)\n");
  output_string (f, "    {\n");
  output_string (f, "      ");
  output_yyerror_function_name (f);
  output_string (f, " (\"no memory for ");
  output_string (f, (state_flag ? "states": "attributes"));
  output_string (f, " stack expansion\");\n");
  output_string (f, "      return 1;\n");
  output_string (f, "    }\n");
  if (state_flag && msta_error_recovery == 2)
    {
      output_string (f, "  new_state_tokens = (int *) ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSREALLOC" : "YYREALLOC"));
      output_string (f, " (*state_tokens, new_size * sizeof (");
      output_string (f, "int));\n");
      output_string (f, "  if (new_state_tokens == NULL)\n");
      output_string (f, "    {\n");
      output_string (f, "      ");
      output_yyerror_function_name (f);
      output_string (f, " (\"no memory for expansion of numbers of tokens ");
      output_string (f, "corresponding to states\");\n");
      output_string (f, "      return 1;\n");
      output_string (f, "    }\n");
      output_string (f, "  *state_tokens = new_state_tokens;\n");
    }
  output_string (f, "  *end = new_start + (new_size - 1);\n");
  output_string (f, "  *top = *top + (new_start - *start);\n");
  output_string (f, "  *start = new_start;\n");
  output_string (f, "  return 0;\n");
  output_string (f, "}\n\n");
}

static void
output_saved_state_or_attribute_buffer_expansion_function (int state_flag)
{
  FILE *f = output_implementation_file;

  ((void) ((msta_error_recovery == 2) ? 0 : (__assert_fail ("msta_error_recovery == 2", "__test.c", 2980, ((const char *) 0)), 0)));
  output_saved_state_or_attribute_buffer_expansion_function_title
    (f, state_flag, 0);
  output_string (f, "\n{\n");
  output_string (f, "  int size = *end - *start + 1;\n  ");
  output_string (f, (state_flag ? "int" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE")));
  output_string (f, " *new_start;\n");
  if (state_flag)
    output_string (f, "  int *new_token_nums_start;\n");
  output_string (f, "\n  if (size >= length)\n    return 0;");
  output_string (f, "\n#if ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (f, " != 0\n");
  output_string (f, "  if (");
  output_yydebug_variable_name (f);
  output_string (f, ")\n    fprintf (stderr, \"Expanding saved ");
  output_string (f, (state_flag ? "states": "attributes"));
  output_string
    (f, " buffer (old size - %d, new size - %d)\\n\", size, length);\n");
  output_string (f, "#endif\n");
  output_string (f, "  if (length > ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSMAX_STACK_SIZE" : "YYMAX_STACK_SIZE"));
  output_string (f, ")\n");
  output_string (f, "    {\n");
  output_string (f, "      ");
  output_yyerror_function_name (f);
  output_string (f, " (\"saved ");
  output_string (f, (state_flag ? "states": "attributes"));
  output_string (f, " buffer is overfull\");\n");
  output_string (f, "      return 1;\n");
  output_string (f, "    }\n");
  output_string (f, "  new_start = (");
  output_string (f, (state_flag ? "int" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE")));
  output_string (f, " *) ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSREALLOC" : "YYREALLOC"));
  output_string (f, " (*start, length * sizeof (");
  output_string (f, (state_flag ? "int" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE")));
  output_string (f, "));\n");
  output_string (f, "  if (new_start == NULL)\n");
  output_string (f, "    {\n");
  output_string (f, "      ");
  output_yyerror_function_name (f);
  output_string (f, " (\"no memory for saved ");
  output_string (f, (state_flag ? "states": "attributes"));
  output_string (f, " buffer expansion\");\n");
  output_string (f, "      return 1;\n");
  output_string (f, "    }\n");
  if (state_flag)
    {
      output_string (f, "  new_token_nums_start = (int *) ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSREALLOC" : "YYREALLOC"));
      output_string (f, " (*token_nums_start, length * sizeof (int));\n");
      output_string (f, "  if (new_token_nums_start == NULL)\n");
      output_string (f, "    {\n");
      output_string (f, "      ");
      output_yyerror_function_name (f);
      output_string (f, " (\"no memory for saved state token numbers");
      output_string (f, " buffer expansion\");\n");
      output_string (f, "      return 1;\n");
      output_string (f, "    }\n");
      output_string (f, "  *token_nums_start = new_token_nums_start;\n");
    }
  output_string (f, "  *end = new_start + (length - 1);\n");
  output_string (f, "  *start = new_start;\n");
  output_string (f, "  return 0;\n");
  output_string (f, "}\n\n");
}

static void
output_token_buffer_increase_function (void)
{
  FILE *f = output_implementation_file;

  output_token_buffer_increase_function_title (f, 0);
  output_string (f, "\n{\n");
  output_string (f, "  int size = *end - *start + 1;\n");
  output_string (f, "  int new_size = 2 * size;\n");
  output_string (f, "  int *new_start, i;\n  ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
  output_string (f, " *new_attr_start;\n");
  output_string (f, "\n#if ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (f, " != 0\n");
  output_string (f, "  if (");
  output_yydebug_variable_name (f);
  output_string (f, ")\n    fprintf (stderr, \"Increasing token buffer ");
  output_string
    (f, " (old size - %d, new size - %d)\\n\", size, new_size);\n");
  output_string (f, "#endif\n");
  output_string (f, "  new_start = (int *) ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSREALLOC" : "YYREALLOC"));
  output_string (f, " (*start, new_size * sizeof (int));\n");
  output_string (f, "  if (new_start == NULL)\n");
  output_string (f, "    {\n");
  output_string (f, "      ");
  output_yyerror_function_name (f);
  output_string (f, " (\"no memory for increasing token buffer\");\n");
  output_string (f, "      return 1;\n");
  output_string (f, "    }\n");
  output_string (f, "  new_attr_start = (");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
  output_string (f, " *) ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSREALLOC" : "YYREALLOC"));
  output_string (f, " (*attr_start, new_size * sizeof (");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
  output_string (f, "));\n");
  output_string (f, "  if (new_attr_start == NULL)\n");
  output_string (f, "    {\n");
  output_string (f, "      ");
  output_yyerror_function_name (f);
  output_string
    (f, " (\"no memory for increasing token attribute buffer\");\n");
  output_string (f, "      return 1;\n");
  output_string (f, "    }\n");
  output_string (f, "  *curr = *curr + (new_start - *start);\n");
  output_string (f, "  for (i = new_start + size - 1 - *curr; i >= 0; i--)\n");
  output_string (f, "    {\n");
  output_string (f, "      (*curr) [i + new_size - size] = (*curr) [i];\n");
  output_string
    (f, "      new_attr_start [i + *curr - new_start + new_size - size]\n");
  output_string (f, "        = new_attr_start [i + *curr - new_start];\n");
  output_string (f, "     }\n");
  output_string (f, "  for (i = new_size - size - 1; i >= 0; i--)\n");
  output_string (f, "    (*curr) [i] = YYEMPTY;\n");
  output_string (f, "  *end = new_start + (new_size - 1);\n");
  output_string (f, "  *start = new_start;\n");
  output_string (f, "  *attr_start = new_attr_start;\n");
  output_string (f, "  return 0;\n");
  output_string (f, "}\n\n");
}

static void
output_action_char (char ch)
{
  output_char (ch, output_implementation_file);
}




static IR_node_t output_action_reduce_LR_situation;

static void
output_action_attribute (IR_node_t canonical_rule,
                         position_t attribute_position,
                         const char *tag_name, const char *attribute_name)
{
  int attribute_number;
  int current_attribute_number;
  IR_node_t bound_right_hand_side_element;
  IR_node_t current_right_hand_side_element;
  IR_node_t original_canonical_rule;
  IR_node_t single_definition;

  ((void) (((*(IR_node_t *) ((char *) ((((_IR_LR_situation *) (output_action_reduce_LR_situation))->_IR_S_LR_situation.element_after_dot)) + _IR_D_canonical_rule [((((((_IR_LR_situation *) (output_action_reduce_LR_situation))->_IR_S_LR_situation.element_after_dot)))->_IR_node_mode)])) == canonical_rule) ? 0 : (__assert_fail ("(*(IR_node_t *) ((char *) ((((_IR_LR_situation *) (output_action_reduce_LR_situation))->_IR_S_LR_situation.element_after_dot)) + _IR_D_canonical_rule [((((((_IR_LR_situation *) (output_action_reduce_LR_situation))->_IR_S_LR_situation.element_after_dot)))->_IR_node_mode)])) == canonical_rule", "__test.c", 3136, ((const char *) 0)), 0)));


  if (strcmp (attribute_name, "$") == 0)
    {
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysval" : "yyval"));
      single_definition = (((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.left_hand_side);
    }
  else
    {
      bound_right_hand_side_element
        = (((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.original_code_insertion_place);
      if (bound_right_hand_side_element != ((void *)0))
        original_canonical_rule
          = (*(IR_node_t *) ((char *) (bound_right_hand_side_element) + _IR_D_canonical_rule [(((bound_right_hand_side_element))->_IR_node_mode)]));
      else
        original_canonical_rule = canonical_rule;
      if (((*__ctype_b_loc ())[(int) ((*attribute_name))] & (unsigned short int) _ISdigit) || *attribute_name == '-')
        attribute_number = atoi (attribute_name);
      else
        attribute_number
          = attribute_name_to_attribute_number
            (attribute_name, original_canonical_rule,
             bound_right_hand_side_element);
      if (attribute_number <= 0)
        single_definition = ((void *)0);
      else
        {
          for (current_attribute_number = attribute_number,
               current_right_hand_side_element
               = (((_IR_canonical_rule *) (original_canonical_rule))->_IR_S_canonical_rule.right_hand_side);
               current_right_hand_side_element != bound_right_hand_side_element
               && current_attribute_number != 1;
               current_right_hand_side_element
               = (((_IR_right_hand_side_element *) (current_right_hand_side_element))->_IR_S_right_hand_side_element.next_right_hand_side_element))

            current_attribute_number--;
          ((void) ((current_right_hand_side_element != bound_right_hand_side_element) ? 0 : (__assert_fail ("current_right_hand_side_element != bound_right_hand_side_element", "__test.c", 3172, ((const char *) 0)), 0)));

          single_definition
            = (((_IR_canonical_rule_element *) (current_right_hand_side_element))->_IR_S_canonical_rule_element.element_itself);
        }
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
      output_string (output_implementation_file, " [");
      output_decimal_number
        (output_implementation_file,
         - (pushed_LR_sets_or_attributes_number_on_path
            ((*(IR_node_t *) ((char *) (output_action_reduce_LR_situation) + _IR_D_LR_set [(((output_action_reduce_LR_situation))->_IR_node_mode)])),
             canonical_rule_right_hand_side_prefix_length
             (original_canonical_rule, bound_right_hand_side_element)
             - attribute_number, 1)), 0);
      output_char (']', output_implementation_file);
    }
  if (tag_name != ((void *)0) && *tag_name != '\0')
    {
      output_char ('.', output_implementation_file);
      output_string (output_implementation_file, tag_name);
    }
  else if (single_definition != ((void *)0) && (((_IR_single_definition *) (single_definition))->_IR_S_single_definition.type) != ((void *)0))
    {
      output_char ('.', output_implementation_file);
      output_identifier_or_literal (output_implementation_file,
                                    (((_IR_single_definition *) (single_definition))->_IR_S_single_definition.type), 0);
    }
}



static void
output_attributes_stack_check (int number, const char *indent)
{
  if (number <= 0)
    return;






  output_string (output_implementation_file, indent);
  output_string (output_implementation_file, "if (");
  output_string (output_implementation_file,
                 ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
  output_string (output_implementation_file, " >= ");
  output_string (output_implementation_file,
                 ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_end" : "yyattributes_end"));
  if (number != 1)
    {
      output_string (output_implementation_file, " - ");
      output_decimal_number (output_implementation_file, number - 1, 0);
    }
  if (expand_flag)
    {
      output_string (output_implementation_file, "\n    ");
      output_string (output_implementation_file, indent);
      output_string (output_implementation_file, "&& ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysexpand_attributes_stack" : "yyexpand_attributes_stack"));
      output_string (output_implementation_file, "(&");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
      output_string (output_implementation_file, ", &");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_end" : "yyattributes_end"));
      output_string (output_implementation_file, ", &");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
      output_string (output_implementation_file, ")");
    }
  output_string (output_implementation_file, ")\n");
  output_string (output_implementation_file, indent);
  output_string (output_implementation_file, "  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT"));
  output_string (output_implementation_file, ";\n");
}

static void
output_states_stack_check (int number, const char *indent)
{
  if (number <= 0)
    return;
  output_string (output_implementation_file, indent);
  output_string (output_implementation_file, "if (");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
  output_string (output_implementation_file, " >= ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_end" : "yystates_end"));
  if (number != 1)
    {
      output_string (output_implementation_file, " - ");
      output_decimal_number (output_implementation_file, number - 1, 0);
    }
  if (expand_flag)
    {
      output_string (output_implementation_file, "\n    ");
      output_string (output_implementation_file, indent);
      output_string (output_implementation_file, "&& ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysexpand_states_stack" : "yyexpand_states_stack"));
      output_string (output_implementation_file, "(&");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      if (msta_error_recovery == 2)
 {
   output_string (output_implementation_file, ", &");
   output_string (output_implementation_file,
    ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate_token_nums" : "yystate_token_nums"));
 }
      output_string (output_implementation_file, ", &");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_end" : "yystates_end"));
      output_string (output_implementation_file, ", &");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (output_implementation_file, ")");
    }
  output_string (output_implementation_file, ")\n");
  output_string (output_implementation_file, indent);
  output_string (output_implementation_file, "  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT"));
  output_string (output_implementation_file, ";\n");
}

static void
output_state_pushing (int check_states_stack, const char *indent)
{
  FILE *f = output_implementation_file;

  if (check_states_stack)
    output_states_stack_check (1, indent);

  output_string (f, indent);
  output_string (f, "(*++");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
  output_string (f, ") = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, ";\n");
}

static void
output_attribute_pushing (int check_attributes_stack,
                          int terminal_flag, const char *indent)
{
  if (check_attributes_stack)
    output_attributes_stack_check (1, indent);



  output_string (output_implementation_file, indent);
  output_string (output_implementation_file, "(*++");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
  output_string (output_implementation_file, ") = ");
  if (terminal_flag)
    output_yylval_variable_name (output_implementation_file);
  else
    output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysval" : "yyval"));
  output_string (output_implementation_file, ";\n");
}

static void
output_pushing (IR_node_t LR_set, int check_states_stack,
                int check_attributes_stack, int terminal_flag)
{
  if ((((_IR_LR_set *) (LR_set))->_IR_S_LR_set.it_is_pushed_LR_set))
    output_state_pushing (check_states_stack, "          ");
  if ((((_IR_LR_set *) (LR_set))->_IR_S_LR_set.attribute_is_used))
    output_attribute_pushing (check_attributes_stack, terminal_flag,
         "          ");
}

static void
output_attributes_stack_top_decrement (int number)
{



  if (number == 0)
    return;
  output_string (output_implementation_file, "          ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
  if (number == 1)
    output_string (output_implementation_file, "--");
  else
    {
      output_string (output_implementation_file, " -= ");
      output_decimal_number (output_implementation_file, number, 0);
    }
  output_string (output_implementation_file, ";\n");
}

static void
output_states_stack_top_decrement (int number)
{



  if (number == 0)
    return;
  output_string (output_implementation_file, "          ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
  if (number == 1)
    output_string (output_implementation_file, "--;\n");
  else
    {
      ((void) ((number > 0) ? 0 : (__assert_fail ("number > 0", "__test.c", 3398, ((const char *) 0)), 0)));
      output_string (output_implementation_file, " -= ");
      output_decimal_number (output_implementation_file, number, 0);
      output_string (output_implementation_file, ";\n");
    }
}







static IR_node_t current_pop_shift_action_LR_set;
static int current_pop_shift_action_rule_length;

static void
output_pop_shift_action_attribute (IR_node_t canonical_rule,
                                   position_t attribute_position,
                                   const char *tag_name,
                                   const char *attribute_name)
{
  int attribute_number;
  int current_attribute_number;
  IR_node_t current_right_hand_side_element;
  IR_node_t bound_right_hand_side_element;
  IR_node_t original_canonical_rule;
  IR_node_t single_definition;
  int rule_length;
  int stack_displacement;

  if (strcmp (attribute_name, "$") == 0)
    {
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysval" : "yyval"));
      single_definition = (((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.left_hand_side);
    }
  else
    {
      bound_right_hand_side_element
        = (((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.original_code_insertion_place);
      if (bound_right_hand_side_element != ((void *)0))
        {
          original_canonical_rule
            = (*(IR_node_t *) ((char *) (bound_right_hand_side_element) + _IR_D_canonical_rule [(((bound_right_hand_side_element))->_IR_node_mode)]));
          current_pop_shift_action_rule_length
            = canonical_rule_right_hand_side_prefix_length
              (original_canonical_rule, bound_right_hand_side_element);
        }
      else
        original_canonical_rule = canonical_rule;
      rule_length = (canonical_rule_right_hand_side_prefix_length
                     (original_canonical_rule, ((void *)0)));
      if (((*__ctype_b_loc ())[(int) ((*attribute_name))] & (unsigned short int) _ISdigit) || *attribute_name == '-')
        attribute_number = atoi (attribute_name);
      else
        attribute_number
          = attribute_name_to_attribute_number
            (attribute_name, original_canonical_rule,
             bound_right_hand_side_element);
      if (attribute_number <= 0)
        single_definition = ((void *)0);
      else
        {
          for (current_attribute_number = attribute_number,
               current_right_hand_side_element
               = (((_IR_canonical_rule *) (original_canonical_rule))->_IR_S_canonical_rule.right_hand_side);
               current_right_hand_side_element != bound_right_hand_side_element
               && current_attribute_number != 1;
               current_right_hand_side_element
               = (((_IR_right_hand_side_element *) (current_right_hand_side_element))->_IR_S_right_hand_side_element.next_right_hand_side_element))

            current_attribute_number--;
          ((void) ((current_right_hand_side_element != bound_right_hand_side_element) ? 0 : (__assert_fail ("current_right_hand_side_element != bound_right_hand_side_element", "__test.c", 3471, ((const char *) 0)), 0)));

          single_definition
            = (((_IR_canonical_rule_element *) (current_right_hand_side_element))->_IR_S_canonical_rule_element.element_itself);
        }
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
      output_string (output_implementation_file, " [");
      stack_displacement
        = 1 - (pushed_LR_sets_or_attributes_number_on_path
               (current_pop_shift_action_LR_set,
                current_pop_shift_action_rule_length - attribute_number + 1,
                1));
      ((void) ((stack_displacement <= 0) ? 0 : (__assert_fail ("stack_displacement <= 0", "__test.c", 3483, ((const char *) 0)), 0)));
      output_decimal_number
        (output_implementation_file, stack_displacement, 0);
      output_string (output_implementation_file, "]");
    }
  if (tag_name != ((void *)0) && *tag_name != '\0')
    {
      output_char ('.', output_implementation_file);
      output_string (output_implementation_file, tag_name);
    }
  else if (single_definition != ((void *)0) && (((_IR_single_definition *) (single_definition))->_IR_S_single_definition.type) != ((void *)0))
    {
      output_char ('.', output_implementation_file);
      output_identifier_or_literal (output_implementation_file,
                                    (((_IR_single_definition *) (single_definition))->_IR_S_single_definition.type), 0);
    }
}

static void
output_yyerr_status_decrement (const char *indent)
{

  output_string (output_implementation_file, indent);
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
  output_string (output_implementation_file, "--;\n");
}

static void
output_shift_pop_actions (IR_node_t regular_arc)
{
  IR_node_t current_LR_set;
  IR_node_t current_rule_list_element;
  IR_node_t canonical_rule;
  IR_node_t current_regular_arc;
  int rule_length;
  int states_stack_decrement;
  int max_states_stack_increment;
  int states_stack_displacement;
  int max_states_stack_displacement;
  int attributes_stack_decrement;
  int max_attributes_stack_increment;
  int attributes_stack_displacement;
  int max_attributes_stack_displacement;


  output_string (output_implementation_file, "        case ");
  output_decimal_number
    (output_implementation_file,
     first_pop_shift_action_value + (((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.number_of_regular_arc),
     0);
  output_string (output_implementation_file, ":\n");
  current_LR_set = (*(IR_node_t *) ((char *) ((((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.from_LR_situation)) + _IR_D_LR_set [((((((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.from_LR_situation)))->_IR_node_mode)]));
  output_string (output_implementation_file, "          /* ");
  if ((((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.terminal_marking_arc) != ((void *)0))
    {
      output_single_definition (output_implementation_file,
                                (((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.terminal_marking_arc));
      output_string (output_implementation_file, ":\n");
    }
  else
    output_string (output_implementation_file, "\n");
  output_LR_set_situations (output_implementation_file, current_LR_set,
                            "             ");
  for (current_regular_arc
         = (((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.next_equivalent_regular_arc);
       current_regular_arc != regular_arc;
       current_regular_arc
         = (((_IR_regular_arc *) (current_regular_arc))->_IR_S_regular_arc.next_equivalent_regular_arc))
    ((((_IR_LR_set *) ((*(IR_node_t *) ((char *) ((((_IR_regular_arc *) (current_regular_arc))->_IR_S_regular_arc.from_LR_situation)) + _IR_D_LR_set [((((((_IR_regular_arc *) (current_regular_arc))->_IR_S_regular_arc.from_LR_situation)))->_IR_node_mode)]))))->_IR_S_LR_set.LR_set_has_been_output_in_comment) = (0));

  for (current_regular_arc
         = (((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.next_equivalent_regular_arc);
       current_regular_arc != regular_arc;
       current_regular_arc
         = (((_IR_regular_arc *) (current_regular_arc))->_IR_S_regular_arc.next_equivalent_regular_arc))
    if (!(((_IR_LR_set *) ((*(IR_node_t *) ((char *) ((((_IR_regular_arc *) (current_regular_arc))->_IR_S_regular_arc.from_LR_situation)) + _IR_D_LR_set [((((((_IR_regular_arc *) (current_regular_arc))->_IR_S_regular_arc.from_LR_situation)))->_IR_node_mode)]))))->_IR_S_LR_set.LR_set_has_been_output_in_comment))

      {
        output_string (output_implementation_file, "             or\n");
        output_LR_set_situations (output_implementation_file,
                                  (*(IR_node_t *) ((char *) ((((_IR_regular_arc *) (current_regular_arc))->_IR_S_regular_arc.from_LR_situation)) + _IR_D_LR_set [((((((_IR_regular_arc *) (current_regular_arc))->_IR_S_regular_arc.from_LR_situation)))->_IR_node_mode)])),

                                  "             ");
        ((((_IR_LR_set *) ((*(IR_node_t *) ((char *) ((((_IR_regular_arc *) (current_regular_arc))->_IR_S_regular_arc.from_LR_situation)) + _IR_D_LR_set [((((((_IR_regular_arc *) (current_regular_arc))->_IR_S_regular_arc.from_LR_situation)))->_IR_node_mode)]))))->_IR_S_LR_set.LR_set_has_been_output_in_comment) = (1));

      }
  output_string (output_implementation_file, "           */\n");
  max_attributes_stack_increment
    = (((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.max_attributes_stack_increment);
  max_states_stack_increment = (((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.max_states_stack_increment);
  output_states_stack_check (max_states_stack_increment, "          ");
  output_attributes_stack_check (max_attributes_stack_increment, "          ");
  states_stack_displacement = 0;
  max_states_stack_displacement = 0;
  attributes_stack_displacement = 0;
  max_attributes_stack_displacement = 0;
  if ((((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.terminal_marking_arc) != ((void *)0))
    {
      current_LR_set = (((_IR_LR_situation *) ((((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.from_LR_situation)))->_IR_S_LR_situation.goto_LR_set).field_itself;
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.attribute_is_used))
        {



   if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.attribute_is_used))
     output_attribute_pushing (0, 1, "          ");
          attributes_stack_displacement++;
          max_attributes_stack_displacement++;
        }





      output_string (output_implementation_file, "          ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysprev_char" : "yyprev_char"));
      output_string (output_implementation_file, " = ");
      output_yychar_variable_name (output_implementation_file);
      output_string (output_implementation_file, ";\n");
      output_string (output_implementation_file, "          ");
      output_yychar_variable_name (output_implementation_file);
      output_string (output_implementation_file, " = ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (output_implementation_file, ";\n");
      output_yyerr_status_decrement ("          ");
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.it_is_pushed_LR_set)
          && (*(bool_t *) ((char *) (regular_arc) + _IR_D_result_LR_set_will_be_on_the_stack [(((regular_arc))->_IR_node_mode)])))
        {




          output_string (output_implementation_file, "          (*++");
          output_string (output_implementation_file,
                         ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
          output_string (output_implementation_file, ") = ");
          if (!(((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag))
            output_string (output_implementation_file,
                           ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSFINAL" : "YYFINAL"));
          else
            output_decimal_number (output_implementation_file,
                                   (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_set_order_number), 0);
          output_string (output_implementation_file, ";\n");
          states_stack_displacement++;
          max_states_stack_displacement++;
        }
    }
  ((void) (((((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.first_rule_list_element) != ((void *)0)) ? 0 : (__assert_fail ("(((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.first_rule_list_element) != ((void *)0)", "__test.c", 3630, ((const char *) 0)), 0)));
  for (current_rule_list_element = (((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.first_rule_list_element);
       current_rule_list_element != ((void *)0);
       current_rule_list_element
         = (((_IR_rule_list_element *) (current_rule_list_element))->_IR_S_rule_list_element.next_rule_list_element))
    {
      canonical_rule = (*(IR_node_t *) ((char *) (current_rule_list_element) + _IR_D_canonical_rule [(((current_rule_list_element))->_IR_node_mode)]));
      rule_length
        = canonical_rule_right_hand_side_prefix_length (canonical_rule, ((void *)0));
      if ((((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.action) != ((void *)0))
        {
   if (msta_error_recovery == 2)
     {
       output_string (output_implementation_file, "\n          if (");
       output_string (output_implementation_file,
        ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
       output_string (output_implementation_file, " < 0)");
     }
          output_line (output_implementation_file,
                       (((_IR_node *) ((((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.action)))->_IR_S_node.position).line_number,
                       (((_IR_node *) ((((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.action)))->_IR_S_node.position).file_name);
          output_char ('{', output_implementation_file);
          current_pop_shift_action_LR_set = current_LR_set;
          current_pop_shift_action_rule_length = rule_length;
          process_canonical_rule_action (canonical_rule, output_action_char,
                                         output_pop_shift_action_attribute);
          output_string (output_implementation_file, "}\n");
          output_current_line (output_implementation_file);
        }
      states_stack_decrement
        = pushed_LR_sets_or_attributes_number_on_path (current_LR_set,
                                                       rule_length, 0);
      states_stack_displacement -= states_stack_decrement;
      output_states_stack_top_decrement (states_stack_decrement);
      attributes_stack_decrement
        = pushed_LR_sets_or_attributes_number_on_path (current_LR_set,
                                                       rule_length, 1);
      attributes_stack_displacement -= attributes_stack_decrement;
      output_attributes_stack_top_decrement (attributes_stack_decrement);
      current_LR_set = get_the_single_LR_set_predecessor (current_LR_set,
                                                          rule_length);
      current_LR_set
        = goto_by_nonterminal (current_LR_set,
                               (((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.left_hand_side));
      if ((((_IR_rule_list_element *) (current_rule_list_element))->_IR_S_rule_list_element.next_rule_list_element) == ((void *)0))
        {




          output_string (output_implementation_file, "          ");
          output_string (output_implementation_file,
                         ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
          output_string (output_implementation_file, " = ");
          ((void) (((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag)) ? 0 : (__assert_fail ("(((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag)", "__test.c", 3684, ((const char *) 0)), 0)));
          output_decimal_number (output_implementation_file,
                                 (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_set_order_number),
                                 0);
          output_string (output_implementation_file, ";\n");
        }
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.it_is_pushed_LR_set)
          && (*(bool_t *) ((char *) (current_rule_list_element) + _IR_D_result_LR_set_will_be_on_the_stack [(((current_rule_list_element))->_IR_node_mode)])))
        {






          output_string (output_implementation_file, "          (*++");
          output_string (output_implementation_file,
                         ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
          output_string (output_implementation_file, ") = ");
          if ((((_IR_rule_list_element *) (current_rule_list_element))->_IR_S_rule_list_element.next_rule_list_element) == ((void *)0))
            output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
          else
            {
              if (!(((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag))
                output_string (output_implementation_file,
                               ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSFINAL" : "YYFINAL"));
              else
                output_decimal_number (output_implementation_file,
                                       (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_set_order_number),
                                       0);
            }
          output_string (output_implementation_file, ";\n");
          states_stack_displacement++;
          if (max_states_stack_displacement < states_stack_displacement)
            max_states_stack_displacement = states_stack_displacement;
        }
      if ((((_IR_rule_list_element *) (current_rule_list_element))->_IR_S_rule_list_element.lhs_nonterm_attribute_is_used))
        {
          ((void) (((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.attribute_is_used)) ? 0 : (__assert_fail ("(((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.attribute_is_used)", "__test.c", 3722, ((const char *) 0)), 0)));
   if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.attribute_is_used))
     output_attribute_pushing (0, 0, "          ");
          attributes_stack_displacement++;
          if (max_attributes_stack_displacement
              < attributes_stack_displacement)
            max_attributes_stack_displacement = attributes_stack_displacement;
        }
    }
  ((void) ((max_states_stack_increment == max_states_stack_displacement) ? 0 : (__assert_fail ("max_states_stack_increment == max_states_stack_displacement", "__test.c", 3731, ((const char *) 0)), 0)));
  ((void) ((max_attributes_stack_increment == max_attributes_stack_displacement) ? 0 : (__assert_fail ("max_attributes_stack_increment == max_attributes_stack_displacement", "__test.c", 3732, ((const char *) 0)), 0)));
  ((void) ((current_LR_set == (((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.to_LR_set).field_itself) ? 0 : (__assert_fail ("current_LR_set == (((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.to_LR_set).field_itself", "__test.c", 3733, ((const char *) 0)), 0)));
  output_string (output_implementation_file, "          break;\n");
}




static IR_node_t a_LR_set_predecessor;




static int
fix_a_LR_set_predecessor (IR_node_t LR_set)
{
  a_LR_set_predecessor = LR_set;
  return 1;
}






static IR_node_t
get_a_LR_set_predecessor (IR_node_t LR_set, int path_length)
{
  ((void) ((path_length >= 0) ? 0 : (__assert_fail ("path_length >= 0", "__test.c", 3760, ((const char *) 0)), 0)));
  a_LR_set_predecessor = ((void *)0);
  traverse_all_LR_set_predecessors (LR_set, path_length,
                                    fix_a_LR_set_predecessor);
  ((void) ((a_LR_set_predecessor != ((void *)0)) ? 0 : (__assert_fail ("a_LR_set_predecessor != ((void *)0)", "__test.c", 3764, ((const char *) 0)), 0)));
  return a_LR_set_predecessor;
}

static IR_node_t
get_a_target (IR_node_t start_LR_set, IR_node_t canonical_rule)
{
  return
    goto_by_nonterminal
    (get_a_LR_set_predecessor
     (start_LR_set,
      canonical_rule_right_hand_side_prefix_length (canonical_rule, ((void *)0))),
     (((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.left_hand_side));
}
static void
output_debug_print_about_saving_token (FILE *f, const char *indent)
{
  output_string (f, "#if ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (f, " != 0\n");
  output_string (f, indent);
  output_string (f, "if (");
  output_yydebug_variable_name (f);
  output_string (f, ")\n");
  output_string (f, indent);
  output_string (f, "  fprintf (stderr,\n");
  output_string (f, indent);
  output_string (f, "           \"Error recovery saving token %d (%s)\\n\",\n");
  output_string (f, indent);
  output_string (f, "           ");
  output_yychar_variable_name (f);
  output_string (f, ", ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSTOKEN_NAME" : "YYTOKEN_NAME"));
  output_string (f, " (");
  output_yychar_variable_name (f);
  output_string (f, "));\n#endif\n");
}
static void
output_check_yyfirst_char_ptr (FILE *f, const char *indent, int flag_1)
{
  ((void) ((msta_error_recovery != 2 || !flag_1) ? 0 : (__assert_fail ("msta_error_recovery != 2 || !flag_1", "__test.c", 3824, ((const char *) 0)), 0)));
  output_string (f, indent);
  output_string (f, "if (");
  output_string (f, (flag_1
       ? ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1")
       : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr")));
  if (msta_error_recovery == 2)
    {
      output_string (f, " > ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char_end" : "yylook_ahead_char_end"));
    }
  else
    {
      output_string (f, " >= ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, " + ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
    }
  output_string (f, ")\n");
  output_string (f, indent);
  output_string (f, "  ");
  output_string (f, (flag_1
       ? ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1")
       : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr")));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
  output_string (f, ";\n");
}
static void
output_look_ahead_read_without_saving (FILE *f, const char *indent)
{
  output_string (f, indent);
  output_yylval_variable_name (f);
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
  output_string (f, " - ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
  output_string (f, "];\n");
  output_string (f, indent);
  output_yychar_variable_name (f);
  output_string (f, " = ");
  output_string (f, "*");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
  output_string (f, ";\n");
  output_string (f, indent);
  output_string (f, "*");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
  output_string (f, "++ = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
  output_string (f, ";\n");
  output_check_yyfirst_char_ptr (f, indent, 0);
}

static void
output_saving_token (FILE *f, const char *indent)
{







  output_string (f, indent);
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
  output_string (f, " - ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
  output_string (f, "] = ");
  output_yylval_variable_name (f);
  output_string (f, ";\n");
  output_string (f, indent);
  output_string (f, "*");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
  output_string (f, "++ = ");
  output_yychar_variable_name (f);
  output_string (f, ";\n");
  output_check_yyfirst_char_ptr (f, indent, 0);
}

static void
output_increase_tokens_buffer (FILE *f, const char *indent)
{
  output_string (f, indent);
  output_string (f, "if (*");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
  output_string (f, " != ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
  output_string (f, "\n");
  output_string (f, indent);
  output_string (f, "    && ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysincrease_saved_tokens_buffer" : "yyincrease_saved_tokens_buffer"));
  output_string (f, " (&");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
  output_string (f, ",\n");
  output_string (f, indent);
  output_string (f, "                                       &");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"));
  output_string (f, ",\n");
  output_string (f, indent);
  output_string (f, "                                       &");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char_end" : "yylook_ahead_char_end"));
  output_string (f, ",\n");
  output_string (f, indent);
  output_string (f, "                                       &");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
  output_string (f, "))\n  ");
  output_string (f, indent);
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT"));
  output_string (f, ";\n");
}

static void
output_restoring_minimal_recovery_state (int best_p, int input_p,
      const char *indent)
{
  FILE *f = output_implementation_file;
  output_string (f, "#if ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (f, " != 0\n");
  output_string (f, indent);
  output_string (f, "if (");
  output_yydebug_variable_name (f);
  output_string (f, ")\n");
  output_string (f, indent);
  if (best_p)
    output_string (f, "  fprintf (stderr, \"Error recovery end - restoring %d states and %d attributes, discard %d tokens\\n\",\n");
  else
    output_string (f, "  fprintf (stderr, \"Error recovery - restoring %d states and %d attributes\\n\",\n");
  output_string (f, indent);
  output_string (f, "           ");
  output_string (f, (best_p
       ? ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_state_num" : "yybest_error_state_num")
       : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_state_num" : "yyerror_state_num")));
  output_string (f, ", ");
  output_string (f, (best_p
       ? ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_attribute_num" : "yybest_error_attribute_num")
       : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_attribute_num" : "yyerror_attribute_num")));
  if (best_p)
    {
      output_string (f, ",\n");
      output_string (f, indent);
      output_string (f, "           ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_token_ignored_num" : "yybest_token_ignored_num"));
    }
  output_string (f, ");\n#endif\n");
  output_string (f, indent);
  output_string (f, "/* It corresponds .error */\n");
  output_string (f, indent);
  output_string (f, "memcpy (");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
  output_string (f, ", ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_states" : "yysaved_states"));
  output_string (f, ",\n");
  output_string (f, indent);
  output_string (f, "        ");
  output_string (f, (best_p
       ? ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_state_num" : "yybest_error_state_num")
       : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_state_num" : "yyerror_state_num")));
  output_string (f, " * sizeof (int));\n");
  output_string (f, indent);
  output_string (f, "memcpy (");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate_token_nums" : "yystate_token_nums"));
  output_string (f, ", ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_state_token_nums" : "yysaved_state_token_nums"));
  output_string (f, ",\n");
  output_string (f, indent);
  output_string (f, "        ");
  output_string (f, (best_p
       ? ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_state_num" : "yybest_error_state_num")
       : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_state_num" : "yyerror_state_num")));
  output_string (f, " * sizeof (int));\n");
  output_string (f, indent);
  output_string (f, "memcpy (");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
  output_string (f, ", ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_attributes" : "yysaved_attributes"));
  output_string (f, ",\n");
  output_string (f, indent);
  output_string (f, "        ");
  output_string (f, (best_p
       ? ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_attribute_num" : "yybest_error_attribute_num")
       : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_attribute_num" : "yyerror_attribute_num")));
  output_string (f, " * sizeof (yylval));\n");
  output_string (f, indent);
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
  output_string (f, " + ");
  output_string (f, (best_p
       ? ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_state_num" : "yybest_error_state_num")
       : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_state_num" : "yyerror_state_num")));
  output_string (f, " - 1;\n");
  output_string (f, indent);
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
  output_string (f, " + ");
  output_string (f, (best_p
       ? ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_attribute_num" : "yybest_error_attribute_num")
       : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_attribute_num" : "yyerror_attribute_num")));
  output_string (f, " - 1;\n");
  if (input_p)
    {
      output_string (f, indent);
      output_string (f, "/* Restore input */\n");
      output_string (f, indent);
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
      output_string (f, ";\n");
      output_string (f, indent);
      output_string (f, "for (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar_ptr" : "yychar_ptr"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " - 1;;)\n");
      output_string (f, indent);
      output_string (f, "  {\n");
      output_string (f, indent);
      output_string (f, "    if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar_ptr" : "yychar_ptr"));
      output_string (f, " < ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, ")\n");
      output_string (f, indent);
      output_string (f, "      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar_ptr" : "yychar_ptr"));
      output_string (f, " += ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char_end" : "yylook_ahead_char_end"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, " + 1;\n");
      output_string (f, indent);
      output_string (f, "    if (*");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar_ptr" : "yychar_ptr"));
      output_string (f, " == ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ")\n");
      output_string (f, indent);
      output_string (f, "      break;\n");
      output_string (f, indent);
      output_string (f, "    ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
      output_string (f, "--;\n");
      output_string (f, indent);
      output_string (f, "    ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar_ptr" : "yychar_ptr"));
      output_string (f, ";\n");
      output_string (f, indent);
      output_string (f, "    ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar_ptr" : "yychar_ptr"));
      output_string (f, "--;\n");
      output_string (f, indent);
      output_string (f, "  }\n");
    }
}

static void
output_switch (void)
{
  IR_node_t current_LR_core;
  IR_node_t current_LR_set;
  IR_double_link_t LR_set_reference;
  IR_node_t owner;
  IR_node_t current_LR_situation;
  IR_node_t regular_arc;
  IR_node_t canonical_rule;
  IR_node_t LR_set_target;
  IR_node_t last_LR_set;
  int rule_length;
  int popped_states_number;
  int popped_attributes_number;
  int push_state_flag;
  int push_attribute_flag;
  int first_shift_flag;
  int first_reduce_flag;
  int first_regular_arc_flag;
  int i;
  vlo_t reduce_LR_situations_vector;
  FILE *f = output_implementation_file;

  output_string (f, "      switch (");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, ")\n");
  output_string (f, "        {\n");
  output_string (f, "        case ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSNO_ACTION" : "YYNO_ACTION"));
  output_string (f, ":\n");
  output_string
    (f, "          /* Here error processing and error recovery. */\n");
  output_string (f, "          if (");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
  output_string (f, " <= 0)\n            {\n");
  output_string (f, "              ");
  output_yyerror_function_name (f);
  output_string (f, " (");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERROR_MESSAGE" : "YYERROR_MESSAGE"));
  output_string (f, ");\n");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserrlab" : "yyerrlab"));
  output_string (f, ":\n              ++");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysnerrs" : "yynerrs"));
  output_string (f, ";\n");
  if (msta_error_recovery == 2)
    {
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, "--;\n              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " < ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, ")\n                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " += ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char_end" : "yylook_ahead_char_end"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, " + 1;\n");
      output_saving_token (f, "              ");
      output_increase_tokens_buffer (f, "              ");
      output_debug_print_about_saving_token (f, "              ");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_recovery_cost" : "yybest_recovery_cost"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSUNDEFINED_RECOVERY_COST" : "YYUNDEFINED_RECOVERY_COST"));
      output_string (f, ";\n              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysexpand_saved_states_buffer" : "yyexpand_saved_states_buffer"));
      output_string (f, "(&");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_states" : "yysaved_states"));
      output_string (f, ",\n                                               &");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_state_token_nums" : "yysaved_state_token_nums"));
      output_string (f, ",\n                                               &");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_states_end" : "yysaved_states_end"));
      output_string (f, ",\n                                               ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, " + 1))\n");
      output_string (f, "                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT"));
      output_string (f, ";\n              memcpy (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_states" : "yysaved_states"));
      output_string (f, ", ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, ",\n                      (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, " + 1) * sizeof (int));\n");
      output_string (f, "              memcpy (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_state_token_nums" : "yysaved_state_token_nums"));
      output_string (f, ", ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate_token_nums" : "yystate_token_nums"));
      output_string (f, ",\n                      (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, " + 1) * sizeof (int));\n");
      output_string (f, "              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysexpand_saved_attributes_buffer" : "yyexpand_saved_attributes_buffer"));
      output_string (f, "(&");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_attributes" : "yysaved_attributes"));
      output_string (f, ",\n");
      output_string
 (f, "                                                   &");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_attributes_end" : "yysaved_attributes_end"));
      output_string
 (f, ",\n                                                   ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
      output_string
 (f, "\n                                                   - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
      output_string (f, " + 1))\n");
      output_string (f, "                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT"));
      output_string (f, ";\n");
      output_string (f, "              memcpy (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_attributes" : "yysaved_attributes"));
      output_string (f, ", ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
      output_string (f, ",\n                      (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
      output_string (f, " + 1) * sizeof (yylval));\n");
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "              if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n");
      output_string
 (f, "                fprintf (stderr, \"Error recovery - saving %d states and %d attributes\\n\",\n");
      output_string (f, "                         ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, " + 1,\n");
      output_string (f, "                         ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
      output_string (f, " + 1);\n#endif\n");
    }
  if (regular_optimization_flag)
    {
      output_string (f, "              if (!");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyspushed" : "yypushed"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, "])\n");
      output_string (f, "                {\n");
      output_state_pushing (expand_flag, "                  ");
      output_string (f, "                }\n");
    }
  if (msta_error_recovery == 1)
    {
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_states_bound" : "yyerr_states_bound"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, " + 1;\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_new_try" : "yyerr_new_try"));
      output_string (f, " = 0;\n");

      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_LOOK_AHEAD_INCREMENT" : "YYERR_LOOK_AHEAD_INCREMENT"));
      output_string (f, ";\n");
      output_string (f, "              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
      output_string (f, " > ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_MAX_LOOK_AHEAD_CHARS" : "YYERR_MAX_LOOK_AHEAD_CHARS"));
      output_string (f, ")\n");
      output_string (f, "                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_MAX_LOOK_AHEAD_CHARS" : "YYERR_MAX_LOOK_AHEAD_CHARS"));
      output_string (f, ";\n");
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "              if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n");
      output_string (f, "                fprintf (stderr,\n");
      output_string (f, "                         \"Start error recovery, look ahead %d tokens\\n\",\n");
      output_string (f, "                         ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
      output_string (f, ");\n#endif\n");

      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_popped_error_states" : "yyerr_popped_error_states"));
      output_string (f, " = 0;\n");
      output_string (f, "              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " == ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, ")\n");
      output_string (f, "                {\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (f, " - 1] = ");
      output_yychar_variable_name (f);
      output_string (f, ";\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (f, " - 1] = ");
      output_yylval_variable_name (f);
      output_string (f, ";\n");
      output_string (f, "                }\n");
      output_string (f, "              else\n");
      output_string (f, "                {\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " [-1] = ");
      output_yychar_variable_name (f);
      output_string (f, ";\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, " - 1] = ");
      output_yylval_variable_name (f);
      output_string (f, ";\n");
      output_string (f, "                }\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " - 2;\n");
      output_string (f, "              for (;;)\n");
      output_string (f, "                {\n");
      output_string (f, "                  if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " < ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, ")\n");
      output_string (f, "                    ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " += ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (f, ";\n");
      output_string (f, "                  if (*");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " == ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ")\n");
      output_string (f, "                    break;\n");
      output_string (f, "                  *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, "-- = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ";\n");
      output_string (f, "                }\n");
      output_debug_print_about_saving_token (f, "              ");
    }
  if (msta_error_recovery != 2)
    output_string (f, "            }\n");
  if (msta_error_recovery != 2)
    {
      output_string (f, "          if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
      output_string (f, " < ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
      if (msta_error_recovery == 1)
 {
   output_string (f, " || ");
   output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
   output_string (f, " <= 0");
 }
      output_string (f, ")\n");
      output_string (f, "            {\n");
    }
  if (msta_error_recovery == 1)
    {
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_popped_error_states" : "yyerr_popped_error_states"));
      output_string (f, "++;\n");
      output_string (f, "              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
      output_string (f, " < ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_popped_error_states" : "yyerr_popped_error_states"));
      output_string (f, " * ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_LOOK_AHEAD_INCREMENT" : "YYERR_LOOK_AHEAD_INCREMENT"));
      output_string (f, ")\n");
      output_string (f, "                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_popped_error_states" : "yyerr_popped_error_states"));
      output_string (f, " * ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_LOOK_AHEAD_INCREMENT" : "YYERR_LOOK_AHEAD_INCREMENT"));
      output_string (f, ";\n");
      output_string (f, "              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
      output_string (f, " > ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_MAX_LOOK_AHEAD_CHARS" : "YYERR_MAX_LOOK_AHEAD_CHARS"));
      output_string (f, ")\n");
      output_string (f, "                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_MAX_LOOK_AHEAD_CHARS" : "YYERR_MAX_LOOK_AHEAD_CHARS"));
      output_string (f, ";\n");
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "              if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n");
      output_string (f, "                fprintf (stderr,\n");
      output_string (f, "                         \"Continue error recovery, look ahead %d tokens\\n\",\n");
      output_string (f, "                         ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
      output_string (f, ");\n#endif\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp1" : "yytemp1"));
      output_string (f, " = 0;\n");
      output_string (f, "              for (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, "; *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " != ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ";)\n");
      output_string (f, "                {\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp1" : "yytemp1"));
      output_string (f, "++;\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, "++;\n");
      output_check_yyfirst_char_ptr (f, "                  ", 1);
      output_string (f, "                }\n");

      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp2" : "yytemp2"));
      output_string (f, " = 0;\n");
      output_string (f, "              for (;;)\n");
      output_string (f, "                {\n");
      output_string (f, "                  if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " == ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, ")\n");
      output_string (f, "                    ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, " + ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (f, " - 1;\n");
      output_string (f, "                  else\n");
      output_string (f, "                    ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " - 1;\n");
      output_string (f, "                  if (*");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " == ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ")\n");
      output_string (f, "                    break;\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, ";\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp2" : "yytemp2"));
      output_string (f, "++;\n");
      output_string (f, "                }\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp1" : "yytemp1"));
      output_string (f, " += ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp2" : "yytemp2"));
      output_string (f, " - 1;\n");
      output_string (f, "              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp1" : "yytemp1"));
      output_string (f, " < 0)\n");
      output_string (f, "                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT"));
      output_string (f, ";\n");
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "              if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n");
      output_string (f, "                fprintf (stderr,\n");
      output_string (f, "                         \"Restore %d tokens saved during error recovery\\n\",\n");
      output_string (f, "                         ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp2" : "yytemp2"));
      output_string (f, ");\n#endif\n");
      output_look_ahead_read_without_saving (f, "              ");
      output_string (f, "              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_popped_error_states" : "yyerr_popped_error_states"));
      output_string (f, " >= ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_POPPED_ERROR_STATES" : "YYERR_POPPED_ERROR_STATES"));
      output_string (f, ")\n");
      output_string (f, "                {\n");
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "                  if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n");
      output_string (f, "                    fprintf (stderr, \"%d error states has been popped -- real discarding tokens\\n\",\n");
      output_string (f, "                             ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_POPPED_ERROR_STATES" : "YYERR_POPPED_ERROR_STATES"));
      output_string (f, ");\n");
      output_string (f, "#endif\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_popped_error_states" : "yyerr_popped_error_states"));
      output_string (f, " = 0;\n");
      output_string (f, "                  if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp1" : "yytemp1"));
      output_string (f, " < ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_DISCARDED_CHARS" : "YYERR_DISCARDED_CHARS"));
      output_string (f, ")\n");
      output_string (f, "                    {\n");
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "                      if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n");
      output_string
        (f, "                        fprintf (stderr, \"Discard %d already read tokens\\n\",\n");
      output_string (f, "                                 ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp1" : "yytemp1"));
      output_string (f, " + 1);\n");
      output_string (f, "#endif\n");
      output_string (f, "                      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp1" : "yytemp1"));
      output_string (f, " -= ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_DISCARDED_CHARS" : "YYERR_DISCARDED_CHARS"));
      output_string (f, ";\n");
      output_string (f, "                      while (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp1" : "yytemp1"));
      output_string (f, " < 0)\n");
      output_string (f, "                        {\n");
      output_string (f, "                          ");
      output_yychar_variable_name (f);
      output_string (f, " = ");
      output_yylex_function_name (f);
      output_string (f, " ();\n");
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "                          if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n");
      output_string
        (f, "                            fprintf (stderr, \"Read token %d (%s)\\n\",\n");
      output_string (f, "                                     ");
      output_yychar_variable_name (f);
      output_string (f, ", ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSTOKEN_NAME" : "YYTOKEN_NAME"));
      output_string (f, " (");
      output_yychar_variable_name (f);
      output_string (f, "));\n");
      output_string (f, "#endif\n");
      output_string (f, "                          ");
      output_string (f, "if (");
      output_yychar_variable_name (f);
      if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
        output_string (f, " < 0)\n");
      else
        output_string (f, " <= 0)\n");
      output_string (f, "                          ");
      output_string (f, "  break;\n");
      output_string (f, "                          ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp1" : "yytemp1"));
      output_string (f, "++;\n");
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "                          if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp1" : "yytemp1"));
      output_string (f, " < 0 && ");
      output_yydebug_variable_name (f);
      output_string (f, ")\n");
      output_string
        (f, "                            fprintf (stderr, \"Discard token %d (%s)\\n\",\n");
      output_string (f, "                                     ");
      output_yychar_variable_name (f);
      output_string (f, ", ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSTOKEN_NAME" : "YYTOKEN_NAME"));
      output_string (f, " (");
      output_yychar_variable_name (f);
      output_string (f, "));\n");
      output_string (f, "#endif\n");
      output_string (f, "                        }\n");
      output_string (f, "                      for (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, "; *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " != ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ";)\n");
      output_string (f, "                        {\n");
      output_string (f, "                           *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, "++ = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ";\n");
      output_check_yyfirst_char_ptr (f, "                           ", 1);
      output_string (f, "                        }\n");
      output_string (f, "                    }\n");
      output_string (f, "                  else if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_DISCARDED_CHARS" : "YYERR_DISCARDED_CHARS"));
      output_string (f, " > 0)\n");
      output_string (f, "                    {\n");
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "                      if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n");
      output_string
        (f, "                        fprintf (stderr, \"Discard %d already read tokens\\n\",\n");
      output_string
        (f, "                                 ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_DISCARDED_CHARS" : "YYERR_DISCARDED_CHARS"));
      output_string (f, ");\n");
      output_string (f, "#endif\n");
      output_string (f, "                      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " + ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_DISCARDED_CHARS" : "YYERR_DISCARDED_CHARS"));
      output_string (f, " - 1;\n");
      output_check_yyfirst_char_ptr (f, "                      ", 1);
      output_string (f, "                      while (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " != ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, ")\n");
      output_string (f, "                        {\n");
      output_string (f, "                           *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, "++ = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ";\n");
      output_check_yyfirst_char_ptr (f, "                          ", 0);
      output_string (f, "                        }\n");
      output_look_ahead_read_without_saving (f, "                      ");
      output_string (f, "                    }\n");
      output_string (f, "                }\n");
    }
  output_string (f, "              ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysabase" : "yyabase"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, "];\n");
  if (msta_error_recovery == 2)
    {
      output_string (f, "            ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysnext_error" : "yynext_error"));
      output_string (f, ":\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystoken_ignored_num" : "yytoken_ignored_num"));
      output_string (f, " = 0;\n");
    }
  output_string (f, "              ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
  output_string (f, ";\n");
  output_string (f, "              for (;;)\n");
  output_string (f, "                {\n");
  output_string (f, "                  if (");
  if (msta_error_recovery == 1)
    {
      output_string (f, "(");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, " < ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_states_bound" : "yyerr_states_bound"));
      output_string (f, " || !");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_new_try" : "yyerr_new_try"));
      output_string (f, ")\n                      && ");
    }
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " != ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSNO_ACTION_BASE" : "YYNO_ACTION_BASE"));
  output_string (f, "\n");
  output_string (f, "                      && ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysacheck" : "yyacheck"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " + ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERRCLASS" : "YYERRCLASS"));
  output_string (f, "] == ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, "\n");
  output_string (f, "                      && ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysaction" : "yyaction"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " + ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERRCLASS" : "YYERRCLASS"));
  output_string (f, "] < ");
  output_decimal_number (f, first_pop_shift_action_value, 0);
  output_string (f, "/* after the last shift */)\n");
  output_string (f, "                    {\n");
  output_string (f, "                      /* shift on error */\n");
  output_string (f, "#if ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (f, " != 0\n");
  output_string (f, "                      if (");
  output_yydebug_variable_name (f);
  output_string (f, ")\n");
  output_string (f, "                        fprintf (stderr,\n");
  output_string (f, "                                 \"state %d, ");
  output_string (f, "error shifting to state %d\\n\",\n");
  output_string (f, "                                 ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, ", ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysaction" : "yyaction"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " + ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERRCLASS" : "YYERRCLASS"));
  output_string (f, "]);\n#endif\n");
  output_string (f, "                      ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysaction" : "yyaction"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " + ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERRCLASS" : "YYERRCLASS"));
  output_string (f, "];\n");
  if (msta_error_recovery == 2)
    {
      output_string (f, "                      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_state_num" : "yyerror_state_num"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, " + 1;\n");
      output_string (f, "                      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_attribute_num" : "yyerror_attribute_num"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
      output_string (f, " + 1;\n");
      output_string (f, "                      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_state" : "yyerror_state"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, ";\n");
      output_string (f, "                      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_token_num" : "yyerror_token_num"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate_token_nums" : "yystate_token_nums"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, "];\n");
      output_string (f, "                      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_attribute" : "yyerror_attribute"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysval" : "yyval"));
      output_string (f, ";\n");
    }
  if (regular_optimization_flag)
    {
      output_string (f, "                      if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyspushed" : "yypushed"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, "])\n");
      output_string (f, "                        {\n");
    }
  if (regular_optimization_flag)
    output_state_pushing (1, "                         ");
  else
    output_state_pushing (1, "                     ");
  if (regular_optimization_flag)
    output_attribute_pushing (1, 0, "                         ");
  else
    output_attribute_pushing (1, 0, "                     ");
  if (regular_optimization_flag)
    output_string (f, "                        }\n");
  if (msta_error_recovery == 1)
    {
      output_string (f, "                      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_states_bound" : "yyerr_states_bound"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, ";\n");
    }
  output_string (f, "                      break;\n");
  output_string (f, "                    }\n");
  output_string (f, "                  if (");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
  output_string (f, " <= ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
  output_string (f, ")\n");
  output_string (f, "                    ");
  output_string (f, (msta_error_recovery == 2
       ? "break" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT")));
  output_string (f, ";\n");
  output_string (f, "                  ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, " = *--");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
  output_string (f, ";\n");
  output_string (f, "                  ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysabase" : "yyabase"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, "];\n");
  output_string (f, "                  ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
  if (!regular_optimization_flag)
    output_string (f, "--;\n");
  else
    {
      output_string (f, "\n                    -= ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysnattr_pop" : "yynattr_pop"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysnapop_base" : "yynapop_base"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " [1]]\n");
      output_string (f, "                                    + *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, "];\n");
    }
  output_string (f, "                }\n");
  if (msta_error_recovery == 2)
    {
      output_string (f, "              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " <= ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, "\n                  && ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_recovery_cost" : "yybest_recovery_cost"));
      output_string (f, " == ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSUNDEFINED_RECOVERY_COST" : "YYUNDEFINED_RECOVERY_COST"));
      output_string (f, ")\n");
      output_string
 (f, "                /* No more error states and no recovery. */");
      output_string (f, "\n                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT"));
      output_string (f, ";\n              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " <= ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, "\n                  || ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_token_num" : "yyerror_token_num"));
      output_string (f, " >= ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_recovery_cost" : "yybest_recovery_cost"));
      output_string (f, ")\n                goto ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysrecovery_finish" : "yyrecovery_finish"));
      output_string (f, ";\n");
      output_string (f, "            }\n");
      output_string (f, "          else if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
      output_string (f, " < ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
      output_string (f, ")\n");
      output_string (f, "            {\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystoken_ignored_num" : "yytoken_ignored_num"));
      output_string (f, " += ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
      output_string (f, ";\n              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
      output_string (f, ";\n");
      output_restoring_minimal_recovery_state (0, 0, "              ");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_state" : "yyerror_state"));
      output_string (f, ";\n              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysval" : "yyval"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_attribute" : "yyerror_attribute"));
      output_string (f, ";\n");
      output_string (f, "              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyspushed" : "yypushed"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, "])\n");
      output_string (f, "                {\n");
      output_string (f, "                  /* We don't need to check stack ends */\n");
      output_state_pushing (0, "                  ");
      output_string (f, "                  (*++");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
      output_string (f, ") = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysval" : "yyval"));
      output_string (f, ";\n");
      output_string (f, "                }\n");
    }
  output_string (f, "            }\n");
  output_string (f, "          else\n");
  output_string (f, "            {\n");
  output_string (f, "              if (");
  output_yychar_variable_name (f);
  output_string (f, " == ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEOF" : "YYEOF"));
  output_string (f, ")\n");
  output_string (f, "                ");
  if (msta_error_recovery != 2)
    output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT"));
  else
    {
      output_string (f, "goto ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysrestore_and_try_next_error" : "yyrestore_and_try_next_error"));
      output_string (f, ";\n              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystoken_ignored_num" : "yytoken_ignored_num"));
      output_string (f, "++");
    }
  output_string (f, ";\n");
  output_string (f, "#if ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (f, " != 0\n");
  output_string (f, "              if (");
  output_yydebug_variable_name (f);
  output_string (f, ")\n");
  output_string (f, "                 fprintf\n");
  output_string (f, "                   (stderr,\n");
  output_string (f, "                    \"state %d, error recovery discards");
  output_string (f, " token %d (%s)\\n\",\n");
  output_string (f, "                    ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, ", ");
  output_yychar_variable_name (f);
  output_string (f, ", ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSTOKEN_NAME" : "YYTOKEN_NAME"));
  output_string (f, " (");
  output_yychar_variable_name (f);
  output_string (f, "));\n#endif\n");
  if (msta_error_recovery == 1)
    {
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
      output_string (f, "--;\n");
    }
  if (msta_error_recovery != 2)
    {
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysprev_char" : "yyprev_char"));
      output_string (f, " = ");
      output_yychar_variable_name (f);
      output_string (f, ";\n");
    }
  output_string (f, "              ");
  output_yychar_variable_name (f);
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
  output_string (f, ";\n");
  output_string (f, "            }\n");
  output_string (f, "          break;\n");
  output_string (f, "        case ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSFINAL" : "YYFINAL"));
  output_string (f, ":\n");
  if (msta_error_recovery == 2)
    {
      output_string (f, "          if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
      output_string (f, " >= 0)\n            {\n              ");
      output_yychar_variable_name (f);
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ";\n              goto ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_recovery_try_end" : "yyerr_recovery_try_end"));
      output_string (f, ";\n            }\n");
    }
  output_string (f, "          ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSACCEPT" : "YYACCEPT"));
  output_string (f, ";\n");
  output_string (f, "          break;\n");
  first_shift_flag = 1;
  for (push_attribute_flag = 0; push_attribute_flag < 2; push_attribute_flag++)
    for (push_state_flag = 0; push_state_flag < 2; push_state_flag++)
      {
        last_LR_set = ((void *)0);
        for (current_LR_core = (((_IR_description *) (description))->_IR_S_description.LR_core_list);
             current_LR_core != ((void *)0);
             current_LR_core = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.next_LR_core))
          for (current_LR_set = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.LR_set_list);
               current_LR_set != ((void *)0);
               current_LR_set = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.next_LR_set))
            if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag)
                && (((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.it_is_pushed_LR_set)
                     && push_state_flag)
                    || (!(((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.it_is_pushed_LR_set)
                        && !push_state_flag))
                && (((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.attribute_is_used)
                     && push_attribute_flag)
                    || (!(((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.attribute_is_used)
                        && !push_attribute_flag))
                && (characteristic_symbol_of_LR_set (current_LR_set)
                    != end_marker_single_definition
                    || !((_IR_is_type [IR_NM_canonical_rule_end] [(((((_IR_LR_situation *) ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_situation_list)))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) /8] >> ((((((_IR_LR_situation *) ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_situation_list)))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) % 8)) & 1)))


              {
                for (LR_set_reference = IR__first_double_link (current_LR_set);
                     LR_set_reference != ((void *)0);
                     LR_set_reference
                       = ((LR_set_reference)->next_link))
                  {
                    owner = ((LR_set_reference)->link_owner);
                    if (((_IR_is_type [IR_NM_LR_situation] [((owner)->_IR_node_mode) /8] >> (((owner)->_IR_node_mode) % 8)) & 1))
                      {
                        if (!(((_IR_LR_situation *) (owner))->_IR_S_LR_situation.goto_arc_has_been_removed)
                            && ((_IR_is_type [IR_NM_single_term_definition] [(((((_IR_canonical_rule_element *) ((((_IR_LR_situation *) (owner))->_IR_S_LR_situation.element_after_dot)))->_IR_S_canonical_rule_element.element_itself))->_IR_node_mode) /8] >> ((((((_IR_canonical_rule_element *) ((((_IR_LR_situation *) (owner))->_IR_S_LR_situation.element_after_dot)))->_IR_S_canonical_rule_element.element_itself))->_IR_node_mode) % 8)) & 1))


                          break;
                      }
                  }
                if (LR_set_reference != ((void *)0))
                  {
                    if (first_shift_flag)
                      {

                        output_string (f, "        /* shifts */\n");
                        first_shift_flag = 0;
                      }


                    output_string (f, "        case ");
                    output_decimal_number
                      (f, (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_set_order_number), 0);
                    output_string (f, ":\n");
                    last_LR_set = current_LR_set;
                  }
              }
        if (last_LR_set != ((void *)0))
          {







            output_string (f, "#if ");
            output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
            output_string (f, " != 0\n");
            output_string (f, "          ");
            output_string (f, "if (");
            output_yydebug_variable_name (f);
            output_string (f, ")\n");
            output_string (f, "          ");
            output_string
              (f, "  fprintf (stderr, \"Shifting token %d (%s)\\n\", ");
            output_yychar_variable_name (f);
            output_string (f, ",\n");
            output_string (f, "                     ");
            output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystname" : "yytname"));
            output_string (f, "[");
            output_yychar_variable_name (f);
            output_string (f, "]);\n");
            output_string (f, "#endif\n\n");
            output_string (f, "          ");
            output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
            output_string (f, " = ");
            output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
            output_string (f, ";\n");
            output_yyerr_status_decrement ("          ");
            output_pushing (last_LR_set,
                            1, regular_optimization_flag || expand_flag,
       1);




     output_string (f, "          ");
     output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysprev_char" : "yyprev_char"));
     output_string (f, " = ");
     output_yychar_variable_name (f);
     output_string (f, ";\n");
            output_string (f, "          ");
            output_yychar_variable_name (f);
            output_string (f, " = ");
            output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
            output_string (f, ";\n");
            output_string (f, "          break;\n");
          }
      }

  do { vlo_t *_temp_vlo = &(reduce_LR_situations_vector); size_t temp_initial_length = (0); temp_initial_length = (temp_initial_length != 0 ? temp_initial_length : 512); do { void *_memory; _memory = malloc (temp_initial_length); if (_memory == ((void *)0)) { _allocation_error_function (); ((void) ((0) ? 0 : (__assert_fail ("0", "__test.c", 5538, ((const char *) 0)), 0))); } (_temp_vlo->vlo_start) = _memory; } while (0); _temp_vlo->vlo_boundary = _temp_vlo->vlo_start + temp_initial_length; _temp_vlo->vlo_free = _temp_vlo->vlo_start; } while (0);
  do { vlo_t *_temp_vlo = &(reduce_LR_situations_vector); size_t _temp_length = ((((_IR_description *) (description))->_IR_S_description.reduces_number) * sizeof (IR_node_t)); ((void) ((_temp_vlo->vlo_start != ((void *)0)) ? 0 : (__assert_fail ("_temp_vlo->vlo_start != ((void *)0)", "__test.c", 5540, ((const char *) 0)), 0))); if (_temp_vlo->vlo_free + _temp_length > _temp_vlo->vlo_boundary) _VLO_expand_memory (_temp_vlo, _temp_length); _temp_vlo->vlo_free += _temp_length; } while (0);

  for (i = 0; i < (((_IR_description *) (description))->_IR_S_description.reduces_number); i++)
    ((IR_node_t *) ((reduce_LR_situations_vector).vlo_start != ((void *)0) ? (void *) (reduce_LR_situations_vector).vlo_start : (abort (), (void *) 0))) [i] = ((void *)0);
  for (current_LR_core = (((_IR_description *) (description))->_IR_S_description.LR_core_list);
       current_LR_core != ((void *)0);
       current_LR_core = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.next_LR_core))
    for (current_LR_set = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.LR_set_list);
         current_LR_set != ((void *)0);
         current_LR_set = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.next_LR_set))
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag))
        for (current_LR_situation = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_situation_list);
             current_LR_situation != ((void *)0);
             current_LR_situation
               = (((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.next_LR_situation))
          if (((_IR_is_type [IR_NM_canonical_rule_end] [(((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) /8] >> ((((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot))->_IR_node_mode) % 8)) & 1)


              && ((*(IR_node_t *) ((char *) ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)) + _IR_D_canonical_rule [((((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)))->_IR_node_mode)]))

                  != (((_IR_description *) (description))->_IR_S_description.canonical_rule_list))
              && (((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.corresponding_regular_arc) == ((void *)0)
              && ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.look_ahead_context) == ((void *)0)
                  || !it_is_zero_context ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.look_ahead_context))))

            ((IR_node_t *) ((reduce_LR_situations_vector).vlo_start != ((void *)0) ? (void *) (reduce_LR_situations_vector).vlo_start : (abort (), (void *) 0)))
              [(((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.reduce_number)] = current_LR_situation;
  first_reduce_flag = 1;
  for (i = 0; i < (((_IR_description *) (description))->_IR_S_description.reduces_number); i++)
    {
      current_LR_situation
        = ((IR_node_t *) ((reduce_LR_situations_vector).vlo_start != ((void *)0) ? (void *) (reduce_LR_situations_vector).vlo_start : (abort (), (void *) 0))) [i];
      if (current_LR_situation != ((void *)0))
        {
          if (first_reduce_flag)
            {

              output_string (f, "        /* reduces */\n");
              first_reduce_flag = 0;
            }

          canonical_rule = (*(IR_node_t *) ((char *) ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)) + _IR_D_canonical_rule [((((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)))->_IR_node_mode)]));

          output_string (f, "        case ");
          output_decimal_number
            (f, first_reduce_value + (((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.reduce_number),
             0);
          output_string (f, ":\n");

          output_string (f, "          /* ");
          output_LR_situation (f, current_LR_situation,
                               "             ", 0);
          output_string (f, " */\n");
          if ((((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.action) != ((void *)0))
            {
       if (msta_error_recovery == 2)
  {
    output_string (output_implementation_file,
     "\n          if (");
    output_string (output_implementation_file,
     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
    output_string (output_implementation_file, " < 0)");
  }
              output_line
                (f, (((_IR_node *) ((((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.action)))->_IR_S_node.position).line_number,
                 (((_IR_node *) ((((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.action)))->_IR_S_node.position).file_name);
              output_char ('{', f);
              output_action_reduce_LR_situation = current_LR_situation;
              process_canonical_rule_action
                ((*(IR_node_t *) ((char *) ((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)) + _IR_D_canonical_rule [((((((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.element_after_dot)))->_IR_node_mode)])),

                 output_action_char, output_action_attribute);
              output_string (f, "}\n");
              output_current_line (f);
            }
          rule_length
            = canonical_rule_right_hand_side_prefix_length
              (canonical_rule, ((void *)0));
          popped_states_number
            = pushed_LR_sets_or_attributes_number_on_path
              ((*(IR_node_t *) ((char *) (current_LR_situation) + _IR_D_LR_set [(((current_LR_situation))->_IR_node_mode)])), rule_length, 0);

          output_states_stack_top_decrement (popped_states_number);
          popped_attributes_number
            = pushed_LR_sets_or_attributes_number_on_path
              ((*(IR_node_t *) ((char *) (current_LR_situation) + _IR_D_LR_set [(((current_LR_situation))->_IR_node_mode)])), rule_length, 1);
          output_attributes_stack_top_decrement (popped_attributes_number);

          output_string (f, "          ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
          output_string (f, " = ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysgoto" : "yygoto"));
          output_string (f, " [");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysgbase" : "yygbase"));
          output_string (f, " [*");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
          output_string (f, "] + ");
          output_decimal_number (f, (((_IR_single_nonterm_definition *) ((((_IR_canonical_rule *) (canonical_rule))->_IR_S_canonical_rule.left_hand_side)))->_IR_S_single_nonterm_definition.nonterm_order_number),

                                 0);
          output_string (f, "];\n");
          LR_set_target = get_a_target ((*(IR_node_t *) ((char *) (current_LR_situation) + _IR_D_LR_set [(((current_LR_situation))->_IR_node_mode)])),
                                        canonical_rule);
          output_pushing
            (LR_set_target, popped_states_number < 1,
             popped_attributes_number < 1
      && (regular_optimization_flag || expand_flag),
      0);
          output_string (f, "          break;\n");
        }
    }

  first_regular_arc_flag = 1;
  for (current_LR_core = (((_IR_description *) (description))->_IR_S_description.LR_core_list);
       current_LR_core != ((void *)0);
       current_LR_core = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.next_LR_core))
    for (current_LR_set = (((_IR_LR_core *) (current_LR_core))->_IR_S_LR_core.LR_set_list);
         current_LR_set != ((void *)0);
         current_LR_set = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.next_LR_set))
      if ((((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.reachable_flag))
        for (current_LR_situation = (((_IR_LR_set *) (current_LR_set))->_IR_S_LR_set.LR_situation_list);
             current_LR_situation != ((void *)0);
             current_LR_situation
               = (((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.next_LR_situation))
          {
            regular_arc = (((_IR_LR_situation *) (current_LR_situation))->_IR_S_LR_situation.corresponding_regular_arc);
            if (regular_arc != ((void *)0)
                && (((_IR_regular_arc *) (regular_arc))->_IR_S_regular_arc.first_equivalent_regular_arc_flag))
              {
                if (first_regular_arc_flag)
                  {

                    output_string (f, "        /* regular arcs */\n");
                    first_regular_arc_flag = 0;
                  }
                output_shift_pop_actions (regular_arc);
              }
          }
  output_string (f, "        default:\n          abort ();\n");
  output_string (f, "        }\n");
}

static void
output_definition_yytemp_variable (void)
{

  output_string (output_implementation_file, "  int ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (output_implementation_file, ";\n");
}

static void
output_definition_inside_yyparse (void)
{

  output_string (output_implementation_file, "  int ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (output_implementation_file, ";\n");
  if (!(((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_inside_outside_definitions (output_implementation_file, 1);
  if ((real_look_ahead_number > 2
       && msta_error_recovery == 0)
      || msta_error_recovery == 1)
    {

      output_string (output_implementation_file, "  int *");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (output_implementation_file, ";\n");
    }

  output_string (output_implementation_file, "  int ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysprev_char" : "yyprev_char"));
  output_string (output_implementation_file, ";\n");

  output_string (output_implementation_file, "  int ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar1" : "yychar1"));
  output_string (output_implementation_file, ";\n");
  output_definition_yytemp_variable ();
  if (msta_error_recovery == 1)
    {

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp1" : "yytemp1"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp2" : "yytemp2"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_new_try" : "yyerr_new_try"));
      output_string (output_implementation_file, ";\n");
    }
  if (real_look_ahead_number >= 2)
    {

      output_string (output_implementation_file, "  ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
      output_string (output_implementation_file, " ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_lval" : "yysaved_lval"));
      output_string (output_implementation_file, ";\n");
    }

  output_string (output_implementation_file, "  long int ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
  output_string
    (output_implementation_file,
     ";  /* tokens number to shift before error messages enabled */\n");

  output_string (output_implementation_file, "  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
  output_string (output_implementation_file, " ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysval" : "yyval"));
  output_string (output_implementation_file, ";\n");

  output_string (output_implementation_file, "  int *");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_end" : "yystates_end"));
  output_string (output_implementation_file, ";\n");

  output_string (output_implementation_file, "  int *");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
  output_string (output_implementation_file, ";\n");
  if (msta_error_recovery == 1)
    {

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_states_bound" : "yyerr_states_bound"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_look_ahead_chars" : "yyerr_look_ahead_chars"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_popped_error_states" : "yyerr_popped_error_states"));
      output_string (output_implementation_file, ";\n");

    }

  output_string (output_implementation_file, "  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
  output_string (output_implementation_file, " *");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_end" : "yyattributes_end"));
  output_string (output_implementation_file, ";\n");

  output_string (output_implementation_file, "  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
  output_string (output_implementation_file, " *");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
  output_string (output_implementation_file, ";\n");
  if (msta_error_recovery == 2)
    {

      output_string (output_implementation_file, "  int *");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_states_end" : "yysaved_states_end"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
      output_string (output_implementation_file, " *");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_attributes_end" : "yysaved_attributes_end"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int *");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char_end" : "yylook_ahead_char_end"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int *");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar_ptr" : "yychar_ptr"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_state" : "yyerror_state"));
      output_string (output_implementation_file, ", ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_state" : "yybest_error_state"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"));
      output_string (output_implementation_file, " ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_attribute" : "yyerror_attribute"));
      output_string (output_implementation_file, ", ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_attribute" : "yybest_error_attribute"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysrecovery_cost" : "yyrecovery_cost"));
      output_string (output_implementation_file, ", ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_recovery_cost" : "yybest_recovery_cost"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_state_num" : "yyerror_state_num"));
      output_string (output_implementation_file, ", ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_state_num" : "yybest_error_state_num"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_attribute_num" : "yyerror_attribute_num"));
      output_string (output_implementation_file, ", ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_attribute_num" : "yybest_error_attribute_num"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystoken_ignored_num" : "yytoken_ignored_num"));
      output_string (output_implementation_file, ", ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_token_ignored_num" : "yybest_token_ignored_num"));
      output_string (output_implementation_file, ";\n");

      output_string (output_implementation_file, "  int ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
      output_string (output_implementation_file, ", ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_token_num" : "yyerror_token_num"));
      output_string (output_implementation_file, ";\n");
    }
  output_char ('\n', output_implementation_file);
}

static void
output_code_before_switch (void)
{
  int i;
  FILE *f = output_implementation_file;






  output_string (f, "#if ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (f, " != 0\n");
  output_string (f, "      if (");
  output_yydebug_variable_name (f);
  output_string (f, ")\n        fprintf (stderr, \"Entering state %d\\n\", ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, ");\n#endif\n");
  if (msta_error_recovery == 2)
    {
      output_string (f, "      if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserrored" : "yyerrored"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, "])\n        ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate_token_nums" : "yystate_token_nums"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
      output_string (f, "] = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
      output_string (f, ";\n");
      output_string (f, "      if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
      output_string (f, " == 0\n");
      output_string (f, "          || (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
      output_string (f, " > 0 && (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_recovery_cost" : "yybest_recovery_cost"));
      output_string (f, "\n");
      output_string (f, "                                   <= ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_token_num" : "yyerror_token_num"));
      output_string (f, ")))\n");
      output_string (f, "        {\n        ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_recovery_try_end" : "yyerr_recovery_try_end"));
      output_string (f, ":\n          /* end of recovery try */\n");
      output_string (f, "          if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_recovery_cost" : "yybest_recovery_cost"));
      output_string (f, " > ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_token_num" : "yyerror_token_num"));
      output_string (f, ")\n");
      output_string (f, "            {\n");
      output_string (f, "              /* So far it is the best */\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_state" : "yybest_error_state"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_state" : "yyerror_state"));
      output_string (f, ";\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_attribute" : "yybest_error_attribute"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_attribute" : "yyerror_attribute"));
      output_string (f, ";\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_recovery_cost" : "yybest_recovery_cost"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_token_num" : "yyerror_token_num"));
      output_string (f, ";\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_state_num" : "yybest_error_state_num"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_state_num" : "yyerror_state_num"));
      output_string (f, ";\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_attribute_num" : "yybest_error_attribute_num"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserror_attribute_num" : "yyerror_attribute_num"));
      output_string (f, ";\n");
      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_token_ignored_num" : "yybest_token_ignored_num"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystoken_ignored_num" : "yytoken_ignored_num"));
      output_string (f, ";\n");
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n              ");
      output_string (f, "if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n                ");
      output_string (f, "fprintf (stderr, \"Error recovery - the best recovery found with %d cost and %d rejected tokens\\n\",\n");
      output_string (f, "                         ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_recovery_cost" : "yybest_recovery_cost"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_MATCHES" : "YYERR_RECOVERY_MATCHES"));
      output_string (f, " + ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
      output_string (f, ", ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystoken_ignored_num" : "yytoken_ignored_num"));
      output_string (f, ");\n#endif\n            }\n        ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysrestore_and_try_next_error" : "yyrestore_and_try_next_error"));
      output_string (f, ":\n");
      output_restoring_minimal_recovery_state (0, 1, "          ");
      output_string (f, "\n          ");
      output_yychar_variable_name (f);
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ";\n#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "          if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n            fprintf (stderr, \"Error recovery - restoring %d saved tokens\\n\",\n");
      output_string (f, "                     ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
      output_string (f, ");\n#endif\n");
      output_string (f, "          ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSNO_ACTION_BASE" : "YYNO_ACTION_BASE"));
      output_string (f, ";\n");
      output_string (f, "          goto ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysnext_error" : "yynext_error"));
      output_string (f,";\n");
      output_string (f, "        }\n");
    }

  output_string (f, "      ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysabase" : "yyabase"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, "];\n");




  output_string (f, "      if (");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " == ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSNO_ACTION_BASE" : "YYNO_ACTION_BASE"));
  output_string (f, ")\n");
  output_string (f, "        ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysadefault" : "yyadefault"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, "];\n");






  output_string (f, "      else\n        {\n");
  output_string (f, "          if (");
  output_yychar_variable_name (f);
  output_string (f, " == ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
  output_string (f, ")\n            {\n");
  if (msta_error_recovery == 1)
    {






      output_string (f, "#ifdef ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_END" : "YYERR_RECOVERY_END"));
      output_string (f, "\n              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
      output_string (f, " == 0)\n");
      output_string (f, "                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_END" : "YYERR_RECOVERY_END"));
      output_string (f, " ();\n");
      output_string (f, "#endif\n\n");
    }
  if (real_look_ahead_number >= 2
      || msta_error_recovery != 0)
    {


      output_string (f, "              if (");
      if (real_look_ahead_number > 2
   || msta_error_recovery != 0)
 {
   output_string (f, "*");
   output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
 }
      else
 output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, " == ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ")\n                {\n");
    }


  if (real_look_ahead_number >= 2
      || msta_error_recovery != 0)
    output_string (f, "    ");
  output_string (f, "              ");
  output_yychar_variable_name (f);
  output_string (f, " = ");
  output_yylex_function_name (f);
  output_string (f, " ();\n");





  output_string (f, "#if ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (f, " != 0\n");
  if (real_look_ahead_number >= 2
      || msta_error_recovery != 0)
    output_string (f, "    ");
  output_string (f, "              if (");
  output_yydebug_variable_name (f);
  output_string (f, ")\n");
  if (real_look_ahead_number >= 2
      || msta_error_recovery != 0)
    output_string (f, "    ");
  output_string
    (f, "                fprintf (stderr, \"Reading a token %d (%s)\\n\",\n");
  if (real_look_ahead_number >= 2
      || msta_error_recovery != 0)
     output_string (f, "    ");
  output_string (f, "                         ");
  output_yychar_variable_name (f);
  output_string (f, ", ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSTOKEN_NAME" : "YYTOKEN_NAME"));
  output_string (f, " (");
  output_yychar_variable_name (f);
  output_string (f, "));\n");
  output_string (f, "#endif\n");
  if (msta_error_recovery != 0)
    {
      output_string (f, "                  if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
      output_string (f, " > 0)\n");
      output_string (f, "                    {\n");
      output_saving_token (f, "                      ");
    }
  if (msta_error_recovery == 1)
    {




      output_string (f, "                      *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ";\n");
    }
  else if (msta_error_recovery == 2)
    output_increase_tokens_buffer (f, "                      ");
  if (msta_error_recovery != 0)
    {
      output_debug_print_about_saving_token (f, "                      ");
      output_string (f, "                    }\n");
    }
  if (real_look_ahead_number >= 2
      || msta_error_recovery != 0)
    {

      output_string (f, "                }\n");
      output_string (f, "              else\n");
      output_string (f, "                {\n");

      output_string (f, "                  ");
      output_yychar_variable_name (f);
      output_string (f, " = ");
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
 output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      else
 {
   output_string (f, "*");
   output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
 }
      output_string (f, ";\n");


      output_string (f, "                  ");
      output_yylval_variable_name (f);
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"));
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
        output_string (f, ";\n");
      else
 {
   output_string (f, " [");
   output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
   output_string (f, " - ");
   output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
   output_string (f, "];\n");
 }
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
        {

          output_string (f, "                  ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
          output_string (f, " = ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
          output_string (f, ";\n");
        }
      else
        {
   output_string (f, "                  if (");
   output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
   if (msta_error_recovery == 1)
     output_string (f, " <= 0)\n");
   else
     output_string (f, " < 0)\n");
   output_string (f, "                    *");
   output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
          output_string (f, "++ = ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
          output_string (f, ";\n");
          output_string (f, "                  else\n");
          output_string (f, "                    {\n");
   output_string (f, "                      ");
   output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
          output_string (f, "++;\n");
   output_debug_print_about_saving_token (f, "                      ");
          output_string (f, "                    }\n");
   output_check_yyfirst_char_ptr (f, "                  ", 0);
        }
      output_string (f, "                }\n");
    }
  if (msta_error_recovery == 2)
    {

      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
      output_string (f, "++;\n");
    }
  output_string (f, "            }\n");
  output_string (f, "#if ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (f, " != 0\n");
  output_string (f, "          if (");
  output_yydebug_variable_name (f);
  output_string (f, ")\n");
  output_string (f, "            {\n");
  output_string (f, "              ");
  output_string (f, "fprintf (stderr, \"Now input is at %d (%s)\",\n");
  output_string (f, "                       ");
  output_yychar_variable_name (f);
  output_string (f, ", ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSTOKEN_NAME" : "YYTOKEN_NAME"));
  output_string (f, " (");
  output_yychar_variable_name (f);
  output_string (f, "));\n");
  if ((real_look_ahead_number > 2
       && msta_error_recovery == 0)
      || msta_error_recovery == 1)
    {
      output_string (f, "              for (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, "; *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, " != ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ";)\n");
      output_string (f, "                {\n");
      output_string (f, "                  fprintf (stderr, \" %d (%s)\", *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, ",\n");
      output_string (f, "                           ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSTOKEN_NAME" : "YYTOKEN_NAME"));
      output_string (f, " (*");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, "));\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
      output_string (f, "++;\n");
      output_check_yyfirst_char_ptr (f, "                  ", 1);
      output_string (f, "                }\n");
    }
  else if (real_look_ahead_number == 2)
    {
      output_string (f, "              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, " != ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ")\n");
      output_string (f, "                fprintf (stderr, \" %d (%s)\", ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, ",\n");
      output_string (f, "                         ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSTOKEN_NAME" : "YYTOKEN_NAME"));
      output_string (f, " (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, "));\n");
    }
  output_string (f, "              fprintf (stderr, \"\\n\");\n");
  output_string (f, "            }\n");
  output_string (f, "#endif\n");
  output_string (f, "          if (");
  output_yychar_variable_name (f);
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_string (f, " < 0)\n            {\n");
  else
    output_string (f, " <= 0)\n            {\n");
  output_string (f, "              ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar1" : "yychar1"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystranslate" : "yytranslate"));
  output_string (f, " [0];\n");
  output_string (f, "              ");
  output_yychar_variable_name (f);
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEOF" : "YYEOF"));
  output_string (f,
   ";  /* To prevent repeated reading EOF */\n            }\n");




  output_string (f, "          else if (");
  output_yychar_variable_name (f);
  output_string (f, " > ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLAST_TOKEN_CODE" : "YYLAST_TOKEN_CODE"));
  output_string (f, ")\n            ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT"));
  output_string (f, ";\n");




  output_string (f, "          else\n");
  output_string (f, "            ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar1" : "yychar1"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystranslate" : "yytranslate"));
  output_string (f, " [");
  output_yychar_variable_name (f);
  output_string (f, "];\n");







  output_string (f, "          ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " += ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar1" : "yychar1"));
  output_string (f, ";\n");
  output_string (f, "          if (");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysacheck" : "yyacheck"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, "] != ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, ")\n");
  output_string (f, "            ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysadefault" : "yyadefault"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, "];\n");
  output_string (f, "          else\n");
  output_string (f, "            ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysaction" : "yyaction"));
  output_string (f, " [");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
  output_string (f, "];\n");
  output_string (f, "        }\n");
  if (real_look_ahead_number >= 2)
    {
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
        {

          output_string (f, "      if (");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
          output_string (f, " >= ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYS1LOOK_AHEAD_TABLE_VALUE" : "YY1LOOK_AHEAD_TABLE_VALUE"));
          output_string (f, ")\n");
        }
      else
        {




          output_string (f, "      ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
          output_string (f, " = ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
          output_string (f, ";\n");
          output_string (f, "      while (");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
          output_string (f, " >= ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYS1LOOK_AHEAD_TABLE_VALUE" : "YY1LOOK_AHEAD_TABLE_VALUE"));
          output_string (f, ")\n");
        }
      output_string (f, "        {\n");




      output_string (f, "          ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " + ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_TABLE_BASE" : "YYLOOK_AHEAD_TABLE_BASE"));
      output_string (f, ";\n");
      output_string (f, "          ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysabase" : "yyabase"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, "];\n");




      output_string (f, "          if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " == ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSNO_ACTION_BASE" : "YYNO_ACTION_BASE"));
      output_string (f, ")\n");
      output_string (f, "            ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysadefault" : "yyadefault"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, "];\n");




      output_string (f,
                     "          else\n            {\n");
      output_string (f, "              if (");
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
        output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      else
        {
          output_char ('*', f);
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
        }
      output_string (f, " == ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ")\n                {\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_lval" : "yysaved_lval"));
      output_string (f, " = ");
      output_yylval_variable_name (f);
      output_string (f, ";\n");
      output_string (f, "                  ");
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
        output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      else
        {
          output_char ('*', f);
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
        }
      output_string (f, " = ");
      output_yylex_function_name (f);
      output_string (f, " ();\n");
      if ((real_look_ahead_number > 2
    && msta_error_recovery == 0)
   || msta_error_recovery == 1)
 {
   output_string (f, "                  if (");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
   output_string (f, " >= ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
   output_string (f, " + (");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
   output_string (f, " - 1))\n");
   output_string (f, "                    *");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
   output_string (f, " = ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
   output_string (f, ";\n");
   output_string (f, "                  else\n");
   output_string (f, "                    *");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
   output_string (f, " = ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
   output_string (f, ";\n");
 }
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "                  if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n");
      output_string (f, "                    ");
      output_string (f,
       "fprintf (stderr, \"Reading a look ahead token %d (%s)\\n\",\n");
      output_string (f, "                             ");
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
        output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      else
        {
          output_char ('*', f);
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
        }
      output_string (f, ", ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSTOKEN_NAME" : "YYTOKEN_NAME"));
      output_string (f, " (");
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
        output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      else
        {
          output_char ('*', f);
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
        }
      output_string (f, "));\n");
      output_string (f, "#endif\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"));
      if ((real_look_ahead_number > 2
    && msta_error_recovery == 0)
   || msta_error_recovery == 1)
        {
          output_string (f, " [");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
          output_string (f, " - ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
          output_string (f, "]");
        }
      output_string (f, " = ");
      output_yylval_variable_name (f);
      output_string (f, ";\n");
      output_string (f, "                  ");
      output_yylval_variable_name (f);
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_lval" : "yysaved_lval"));
      output_string (f, ";\n");
      output_string (f, "                }\n");
      output_string (f, "              if (");
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
        output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      else
        {
          output_char ('*', f);
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
        }
      if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
        output_string (f, " < 0)\n");
      else
        output_string (f, " <= 0)\n");
      output_string (f, "                {\n");
      output_string (f, "                  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar1" : "yychar1"));
      output_string (f, " = 0;\n");
      output_string (f, "                  ");
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
        output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      else
        {
          output_char ('*', f);
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
        }
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEOF" : "YYEOF"));
      output_string (f, "; /* To prevent repeated reading EOF */\n");
      output_string (f, "                }\n");







      output_string (f, "              else if (");
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
        output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      else
        {
          output_char ('*', f);
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
        }
      output_string (f, " > ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLAST_TOKEN_CODE" : "YYLAST_TOKEN_CODE"));
      output_string (f, ")\n");
      output_string (f, "                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT"));
      output_string (f, ";\n");







      output_string (f, "              else\n");
      output_string (f, "                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar1" : "yychar1"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystranslate" : "yytranslate"));
      output_string (f, " [");
      if (real_look_ahead_number == 2
   && msta_error_recovery == 0)
        output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      else
        {
          output_char ('*', f);
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
        }
      output_string (f, "];\n");







      output_string (f, "              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " += ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar1" : "yychar1"));
      output_string (f, ";\n");
      output_string (f, "              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysacheck" : "yyacheck"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, "] != ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, ")\n");
      output_string (f, "                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysadefault" : "yyadefault"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, "];\n");
      output_string (f, "              else\n");
      output_string (f, "                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysaction" : "yyaction"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, "];\n");
      if ((real_look_ahead_number > 2
    && msta_error_recovery == 0)
   || msta_error_recovery == 1)
        {




          output_string (f, "              ");
          output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr_1" : "yyfirst_char_ptr_1"));
          output_string (f, "++;\n");
   output_check_yyfirst_char_ptr (f, "              ", 1);
        }
      output_string (f, "            }\n");
      output_string (f, "        }\n");
    }
}

static void
output_initiation_code (void)
{

  output_string (output_implementation_file, "  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysnerrs" : "yynerrs"));
  output_string (output_implementation_file, " = 0;\n");

  output_string (output_implementation_file, "  ");
  output_yychar_variable_name (output_implementation_file);
  output_string (output_implementation_file, " = ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
  output_string (output_implementation_file, ";\n");
  if (real_look_ahead_number == 2
      && msta_error_recovery == 0)
    {

      output_string (output_implementation_file, "  ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (output_implementation_file, " = ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (output_implementation_file, ";\n");
    }
  else if (real_look_ahead_number > 2
    || msta_error_recovery != 0)
    {

      output_string (output_implementation_file, "  ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (output_implementation_file, " = ");
      output_string (output_implementation_file,
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (output_implementation_file, ";\n");


      output_string (output_implementation_file, "  for (");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (output_implementation_file, " = 0; ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (output_implementation_file, " < ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (output_implementation_file, "; ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (output_implementation_file, "++)\n");
      output_string (output_implementation_file, "    ");
      output_string (output_implementation_file,
                     ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (output_implementation_file, " [");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (output_implementation_file, "] = ");
      output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (output_implementation_file, ";\n");
      if (msta_error_recovery == 2)
 {

   output_string (output_implementation_file, "  ");
   output_string (output_implementation_file,
    ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
   output_string (output_implementation_file, " = 0;\n");
 }
    }
}

static void
output_scanner_array_allocation (const char *array_name, const char *size,
     const char *type, const char *error_flag_name,
     int error_flag_dereference)
{
  output_string (output_implementation_file, "  ");
  output_string (output_implementation_file, array_name);
  output_string (output_implementation_file, " = (");
  output_string (output_implementation_file, type);
  output_string (output_implementation_file, " *) ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSALLOC" : "YYALLOC"));
  output_string (output_implementation_file, " (");
  output_string (output_implementation_file, size);
  output_string (output_implementation_file, " * sizeof (");
  output_string (output_implementation_file, type);
  output_string (output_implementation_file, "));\n");
  output_string (output_implementation_file, "  if (");
  output_string (output_implementation_file, array_name);
  output_string (output_implementation_file, " == NULL)\n");
  output_string (output_implementation_file, "    {\n");
  output_string (output_implementation_file, "      ");
  if (error_flag_dereference)
    output_string (output_implementation_file, "*");
  output_string (output_implementation_file, error_flag_name);
  output_string (output_implementation_file, " = 1;\n");
  output_string (output_implementation_file, "      return;\n");
  output_string (output_implementation_file, "    }\n");

}

static void
output_scanner_array_variables_allocation (void)
{
  output_scanner_array_allocation (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"),
       ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"),
       "int",
       "error_flag",
       !cpp_flag);
  output_scanner_array_allocation
    (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"),
     "error_flag", !cpp_flag);
  if (real_look_ahead_number > 2 || msta_error_recovery != 0)
    {
      output_scanner_array_allocation
 (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"),
  "int", "error_flag", !cpp_flag);
      output_scanner_array_allocation
 (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"),
  ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"), "error_flag", !cpp_flag);
      if (msta_error_recovery == 2)
 {
   output_scanner_array_allocation
     (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate_token_nums" : "yystate_token_nums"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"),
      "int", "error_flag", !cpp_flag);
   output_scanner_array_allocation
     (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_state_token_nums" : "yysaved_state_token_nums"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"),
      "int", "error_flag", !cpp_flag);
   output_scanner_array_allocation
     (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_states" : "yysaved_states"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"),
      "int", "error_flag", !cpp_flag);
   output_scanner_array_allocation
     (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_attributes" : "yysaved_attributes"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"),
      ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"), "error_flag",
      !cpp_flag);
 }
    }
}

static void
output_parser_array_allocation (const char *array_name, const char *size,
    const char *type, const char *message)
{
  output_string (output_implementation_file, "  ");
  output_string (output_implementation_file, array_name);
  output_string (output_implementation_file, " = (");
  output_string (output_implementation_file, type);
  output_string (output_implementation_file, " *) ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSALLOC" : "YYALLOC"));
  output_string (output_implementation_file, " (");
  output_string (output_implementation_file, size);
  output_string (output_implementation_file, " * sizeof (");
  output_string (output_implementation_file, type);
  output_string (output_implementation_file, "));\n");
  output_string (output_implementation_file, "  if (");
  output_string (output_implementation_file, array_name);
  output_string (output_implementation_file, " == NULL)\n");
  output_string (output_implementation_file, "    {\n");
  output_string (output_implementation_file, "      ");
  output_yyerror_function_name (output_implementation_file);
  output_string (output_implementation_file, " (\"");
  output_string (output_implementation_file, message);
  output_string (output_implementation_file, "\");\n");
  output_string (output_implementation_file, "      ");
  output_string (output_implementation_file,
   ((((_IR_description *) (description))->_IR_S_description.scanner_flag) && !cpp_flag
    ? "return 1" : ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSABORT" : "YYABORT")));
  output_string (output_implementation_file, ";\n");
  output_string (output_implementation_file, "    }\n");

}

static void
output_parser_array_variables_allocation (void)
{
  output_parser_array_allocation (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"),
      ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"),
      "int", "no memory for states stack");
  output_parser_array_allocation (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"),
      ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"),
      "no memory for attributes stack");
  if (real_look_ahead_number > 2
      || msta_error_recovery != 0)
    {
      output_parser_array_allocation
 (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"),
  "int", (msta_error_recovery == 2
   ? "no memory for saved look ahead tokens"
   : "no memory for look ahead tokens"));
      output_parser_array_allocation
 (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"),
  ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"),
  (msta_error_recovery == 2
   ? "no memory for saved look ahead token attributes"
   : "no memory for look ahead token attributes"));
      if (msta_error_recovery == 2)
 {
   output_parser_array_allocation
     (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate_token_nums" : "yystate_token_nums"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"),
      "int", "no memory for numbers of tokens corresponding to states");
   output_parser_array_allocation
     (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_state_token_nums" : "yysaved_state_token_nums"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"),
      "int",
      "no memory for saved numbers of tokens corresponding to states");
   output_parser_array_allocation
     (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_states" : "yysaved_states"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"),
      "int", "no memory for saved states buffer");
   output_parser_array_allocation
     (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_attributes" : "yysaved_attributes"), ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"),
      ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTYPE" : "YYSTYPE"), "no memory for saved attributes buffer");
 }
    }
}

static void
output_free_array (const char *free_array)
{



  output_string (output_implementation_file, "  if (");
  output_string (output_implementation_file, free_array);
  output_string (output_implementation_file, " != NULL)\n");
  output_string (output_implementation_file, "    ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSFREE" : "YYFREE"));
  output_string (output_implementation_file, " (");
  output_string (output_implementation_file, free_array);
  output_string (output_implementation_file, ");\n");
}

static void
output_free_arrays (void)
{
  output_free_array (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
  output_free_array (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
  if (real_look_ahead_number > 2
      || msta_error_recovery != 0)
    {
      output_free_array (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_free_array (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"));
      if (msta_error_recovery == 2)
 {
   output_free_array (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate_token_nums" : "yystate_token_nums"));
   output_free_array (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_state_token_nums" : "yysaved_state_token_nums"));
   output_free_array (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_states" : "yysaved_states"));
   output_free_array (((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_attributes" : "yysaved_attributes"));
 }
    }
}

static void
output_parser_itself (void)
{
  FILE *f = output_implementation_file;

  output_definitions_outside_yyparse ();
  if (expand_flag)
    {
      output_state_or_attribute_stack_expansion_function (1);
      output_state_or_attribute_stack_expansion_function (0);
    }
  if (msta_error_recovery == 2)
    {
      output_saved_state_or_attribute_buffer_expansion_function (1);
      output_saved_state_or_attribute_buffer_expansion_function (0);
      output_token_buffer_increase_function ();
    }
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    {
      output_yylex_start_title (f, 0);
      output_string (f, "\n{\n");
      output_definition_yytemp_variable ();
      output_string (f, "\n");
      output_scanner_array_variables_allocation ();
      output_initiation_code ();
      output_string (f, "  ");
      if (!cpp_flag)
 output_string (f, "*");
      output_string (f, "error_flag");
      output_string (f, " = 0;\n");
      output_string (f, "  return;\n");
      output_string (f, "}\n\n");
    }
  if ((((_IR_description *) (description))->_IR_S_description.scanner_flag))
    {
      output_yylex_finish_title (f, 0);
      output_string (f, "\n{\n");
      output_free_arrays ();
      output_string (f, "}\n\n");
    }
  output_yyparse_title (f, 0);
  output_string (f, "\n{\n");
  output_definition_inside_yyparse ();





  output_string (f, "#if ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (f, " != 0\n");
  output_string (f, "  if (");
  output_yydebug_variable_name (f);
  output_string (f, ")\n    fprintf (stderr, \"Starting parse\\n\");\n");
  output_string (f, "#endif\n");

  if (!(((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_parser_array_variables_allocation ();




  output_string (f, "  ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_end" : "yystates_end"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
  output_string (f, " + ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"));
  output_string (f, " - 1;\n");
  output_string (f, "  ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates" : "yystates"));
  output_string (f, " - 1;\n");




  output_string (f, "  ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_end" : "yyattributes_end"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
  output_string (f, " + ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"));
  output_string (f, " - 1;\n");
  output_string (f, "  ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
  output_string (f, " = ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes" : "yyattributes"));
  output_string (f, " - 1;\n");
  if (msta_error_recovery == 2)
    {

      output_string (f, "  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_states_end" : "yysaved_states_end"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_states" : "yysaved_states"));
      output_string (f, " + ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"));
      output_string (f, " - 1;\n");

      output_string (f, "  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_attributes_end" : "yysaved_attributes_end"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyssaved_attributes" : "yysaved_attributes"));
      output_string (f, " + ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSSTACK_SIZE" : "YYSTACK_SIZE"));
      output_string (f, " - 1;\n");

      output_string (f, "  ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char_end" : "yylook_ahead_char_end"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, " + ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSLOOK_AHEAD_SIZE" : "YYLOOK_AHEAD_SIZE"));
      output_string (f, " - 1;\n");
    }
  if (!(((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_initiation_code ();

  output_string (f, "  ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
  output_string (f, " = 0; /* Start state */\n");
  if ((((_IR_LR_set *) ((((_IR_LR_core *) ((((_IR_description *) (description))->_IR_S_description.LR_core_list)))->_IR_S_LR_core.LR_set_list)))->_IR_S_LR_set.it_is_pushed_LR_set))
    {

      output_string (f, "  (*++");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstates_top" : "yystates_top"));
      output_string (f, ") = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, ";\n");
    }
  if ((((_IR_LR_set *) ((((_IR_LR_core *) ((((_IR_description *) (description))->_IR_S_description.LR_core_list)))->_IR_S_LR_core.LR_set_list)))->_IR_S_LR_set.attribute_is_used))
    {

      output_string (f, "  ++");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
      output_string (f, ";\n");
    }

  output_string (f, "  ");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
  output_string (f, " = (-1);\n");

  output_string (f, "  for (;;)\n    {\n");
  output_code_before_switch ();

  output_switch ();
  if (msta_error_recovery == 2)
    {
      output_string (f, "      continue;\n");
      output_string (f, "    ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysrecovery_finish" : "yyrecovery_finish"));
      output_string (f, ":\n");
      output_string (f, "      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyserr_status" : "yyerr_status"));
      output_string (f, " = -1;\n");
      output_restoring_minimal_recovery_state (1, 1, "      ");
      output_string (f, "      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_token_ignored_num" : "yybest_token_ignored_num"));
      output_string (f, "++;\n");
      output_string (f, "      /* Shift yybest_token_ignored_num: */\n");
      output_string (f, "      while (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_token_ignored_num" : "yybest_token_ignored_num"));
      output_string (f, "-- != 0)\n");
      output_string (f, "        {\n          if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_token_ignored_num" : "yybest_token_ignored_num"));
      output_string (f, " == 1)\n            ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysprev_char" : "yyprev_char"));
      output_string (f, " = *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, ";\n          else if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_token_ignored_num" : "yybest_token_ignored_num"));
      output_string (f, " == 0)\n            {\n              ");
      output_yychar_variable_name (f);
      output_string (f, " = *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, ";\n              ");
      output_yylval_variable_name (f);
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_attribute" : "yylook_ahead_attribute"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, "];\n            }\n          *");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, "++ = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ";\n");
      output_string (f, "          if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " > ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char_end" : "yylook_ahead_char_end"));
      output_string (f, ")\n");
      output_string (f, "            ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, ";\n");
      output_string (f, "          ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyscurr_token_num" : "yycurr_token_num"));
      output_string (f, "++;\n");
      output_string (f, "        }\n");
      output_string (f, "#if ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
      output_string (f, " != 0\n");
      output_string (f, "      if (");
      output_yydebug_variable_name (f);
      output_string (f, ")\n        {\n          ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar1" : "yychar1"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " = 0;\n          while (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, "] != ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSEMPTY" : "YYEMPTY"));
      output_string (f, ")\n            {\n              ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, "++; ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar1" : "yychar1"));
      output_string (f, "++;\n              if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, " + ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " > ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char_end" : "yylook_ahead_char_end"));
      output_string (f, ")\n                ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yystemp" : "yytemp"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyslook_ahead_char" : "yylook_ahead_char"));
      output_string (f, " - ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysfirst_char_ptr" : "yyfirst_char_ptr"));
      output_string (f, ";\n            }\n");
      output_string (f, "          fprintf (stderr,\n");
      output_string (f, "                   \"Error recovery end - restore %d saved input tokens\\n\",\n");
      output_string (f, "                   ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyschar1" : "yychar1"));
      output_string (f, " + 1);\n        }\n#endif\n");
      output_string (f, "      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, " = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_state" : "yybest_error_state"));
      output_string (f, ";\n");
      output_string (f, "      if (");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yyspushed" : "yypushed"));
      output_string (f, " [");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysstate" : "yystate"));
      output_string (f, "])\n");
      output_string (f, "        {\n");
      output_string (f, "          /* We don't need to check stack ends */\n");
      output_state_pushing (0, "          ");
      output_string (f, "          (*++");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysattributes_top" : "yyattributes_top"));
      output_string (f, ") = ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysbest_error_attribute" : "yybest_error_attribute"));
      output_string (f, ";\n");
      output_string (f, "        }\n");
      output_string (f, "#ifdef ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_END" : "YYERR_RECOVERY_END"));
      output_string (f, "\n      ");
      output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSERR_RECOVERY_END" : "YYERR_RECOVERY_END"));
      output_string (f, " ();\n#endif\n");
    }
  output_string (f, "    }\n\n");

  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysaccept" : "yyaccept"));
  output_string (f, ":\n");
  if (!(((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_free_arrays ();
  output_string (f, "  return 0;\n\n");
  output_string (f, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "yysabort" : "yyabort"));
  output_string (f, ":\n");
  if (!(((_IR_description *) (description))->_IR_S_description.scanner_flag))
    output_free_arrays ();
  output_string (f, "  return ");
  output_string (f, (((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "-1" : "1");
  output_string (f, ";\n\n");
  output_string (f, "}\n\n");
}

static void
output_additional_code (void)
{
  IR_node_t additional_code;

  additional_code = (((_IR_description *) (description))->_IR_S_description.additional_code);
  if (additional_code == ((void *)0))
    return;
  ((void) ((((_IR_is_type [IR_NM_additional_code] [((additional_code)->_IR_node_mode) /8] >> (((additional_code)->_IR_node_mode) % 8)) & 1)) ? 0 : (__assert_fail ("((_IR_is_type [IR_NM_additional_code] [((additional_code)->_IR_node_mode) /8] >> (((additional_code)->_IR_node_mode) % 8)) & 1)", "__test.c", 7459, ((const char *) 0)), 0)));
  output_char ('\n', output_implementation_file);
  output_line (output_implementation_file,
               (((_IR_node *) (additional_code))->_IR_S_node.position).line_number,
               (((_IR_node *) (additional_code))->_IR_S_node.position).file_name);
  output_string (output_implementation_file,
                 (((_IR_additional_code *) (additional_code))->_IR_S_additional_code.additional_code_itself));
  output_char ('\n', output_implementation_file);
  output_current_line (output_implementation_file);
}

void
output_parser (void)
{
  ticker_t all_output_parser_ticker;
  ticker_t tables_ticker;

  all_output_parser_ticker = create_ticker ();
  output_msta_title ();
  output_start_code_insertions ();
  output_external_definitions ();
  output_finish_code_insertions ();

  output_string (output_implementation_file, "#ifndef  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (output_implementation_file, "\n#define  ");
  output_string (output_implementation_file, ((((_IR_description *) (description))->_IR_S_description.scanner_flag) ? "YYSDEBUG" : "YYDEBUG"));
  output_string (output_implementation_file, (trace_flag ? " 1\n" : " 0\n"));
  output_string (output_implementation_file, "#endif\n\n");
  prepare_tables_output ();
  tables_ticker = create_ticker ();
  output_parser_tables ();
  if (time_flag)
    fprintf (stderr, "    creation, compacting, output of tables -- %ssec\n",
             active_time_string (tables_ticker));
  output_include_directives ();
  output_parser_itself ();
  output_additional_code ();
  if (time_flag)
    fprintf (stderr, "  all parser output -- %ssec\n",
             active_time_string (all_output_parser_ticker));
}
