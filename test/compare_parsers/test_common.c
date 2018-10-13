struct lex {
  short code;
  short column;
  int line;
  const char *id;
  struct lex *next;
};

static os_t lexs;
static struct lex *list;
static struct lex *curr = NULL;

static int column = 0;
static int line = 1;

static hash_table_t table;

static unsigned
hash (hash_table_entry_t el)
{
  const char *id = (char *) el;
  unsigned result, i;

  for (result = i = 0;*id++ != '\0'; i++)
    result += ((unsigned char) *id << (i % CHAR_BIT));
  return result;
}

static int
eq (hash_table_entry_t el1, hash_table_entry_t el2)
{
  return strcmp ((char *) el1, (char *) el2) == 0;
}

static void initiate_typedefs( YaepAllocator * alloc ) {
  table = create_hash_table( alloc, 50000, hash, eq );
}

/* Now we ignore level */
static
void add_typedef (const char *id, int level)
{
  hash_table_entry_t *entry_ptr;

  assert (level == 0);
  entry_ptr = find_hash_table_entry (table, id, 1);
  if (*entry_ptr == NULL)
    *entry_ptr = (hash_table_entry_t) id;
  else
    assert (strcmp (id, *entry_ptr) == 0);
#ifdef DEBUG
  fprintf (stderr, "add typedef %s\n", id);
#endif
}

#ifdef __GNUC__
inline
#endif
static
int find_typedef (const char *id, int level)
{
  hash_table_entry_t *entry_ptr;

  entry_ptr = find_hash_table_entry (table, id, 0);
#ifdef DEBUG
  if (*entry_ptr != NULL)
    fprintf (stderr, "found typedef %s\n", id);
#endif
  return *entry_ptr != NULL;
}
