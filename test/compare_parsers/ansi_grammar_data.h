#ifndef YAEP_ANSI_GRAMMAR_DATA_H
#define YAEP_ANSI_GRAMMAR_DATA_H

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static inline char *
yaep_ansi_default_grammar_path(void)
{
  static char *cached = NULL;

  if (cached != NULL)
    return cached;

  const char *file = __FILE__;
  const char *last_slash = strrchr(file, '/');
#ifdef _WIN32
  const char *last_backslash = strrchr(file, '\\');
  if (last_backslash != NULL && (last_slash == NULL || last_backslash > last_slash))
    last_slash = last_backslash;
#endif

  size_t dir_len = 0;
  if (last_slash != NULL)
    dir_len = (size_t)(last_slash - file + 1);

  const char suffix[] = "ansi_grammar.txt";
  size_t total = dir_len + sizeof(suffix);

  cached = (char *) malloc(total);
  if (cached == NULL)
    {
      fprintf(stderr, "yaep: out of memory while building ANSI grammar path\n");
      exit(EXIT_FAILURE);
    }

  if (dir_len > 0)
    memcpy(cached, file, dir_len);
  memcpy(cached + dir_len, suffix, sizeof(suffix));

  return cached;
}

static inline const char *
yaep_ansi_grammar_description(void)
{
  static char *buffer = NULL;

  if (buffer != NULL)
    return buffer;

  const char *path = getenv("YAEP_ANSI_GRAMMAR_PATH");
  if (path == NULL || path[0] == '\0')
    path = yaep_ansi_default_grammar_path();

  FILE *fp = fopen(path, "rb");
  if (fp == NULL)
    {
      fprintf(stderr, "yaep: unable to open ANSI grammar file '%s': %s\n", path, strerror(errno));
      exit(EXIT_FAILURE);
    }

  if (fseek(fp, 0, SEEK_END) != 0)
    {
      fprintf(stderr, "yaep: failed to seek ANSI grammar file '%s': %s\n", path, strerror(errno));
      fclose(fp);
      exit(EXIT_FAILURE);
    }

  long size = ftell(fp);
  if (size < 0)
    {
      fprintf(stderr, "yaep: failed to determine size of ANSI grammar file '%s': %s\n", path, strerror(errno));
      fclose(fp);
      exit(EXIT_FAILURE);
    }

  if (fseek(fp, 0, SEEK_SET) != 0)
    {
      fprintf(stderr, "yaep: failed to rewind ANSI grammar file '%s': %s\n", path, strerror(errno));
      fclose(fp);
      exit(EXIT_FAILURE);
    }

  buffer = (char *) malloc((size_t) size + 1);
  if (buffer == NULL)
    {
      fprintf(stderr, "yaep: out of memory while loading ANSI grammar file '%s'\n", path);
      fclose(fp);
      exit(EXIT_FAILURE);
    }

  size_t read = fread(buffer, 1, (size_t) size, fp);
  if (read != (size_t) size)
    {
      fprintf(stderr, "yaep: short read while loading ANSI grammar file '%s': %s\n", path,
              (ferror(fp) ? strerror(errno) : "unexpected end of file"));
      fclose(fp);
      exit(EXIT_FAILURE);
    }
  buffer[read] = '\0';

  fclose(fp);
  return buffer;
}

#endif /* YAEP_ANSI_GRAMMAR_DATA_H */
