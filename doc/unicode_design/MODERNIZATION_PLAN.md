# Modernization status (branch: unicode-feature)

This document records the actual implemented modernization and Unicode work present on the `unicode-feature` branch, plus recommended follow-ups. It is intentionally concise and points to concrete files that implement each item.

## Implemented (evidence)

- CMake C11 baseline: top-level `CMakeLists.txt` sets `CMAKE_C_STANDARD` to 11 by default and provides `YAEP_LEGACY_C99` to fall back to C99.
- Warning options: `YAEP_ENABLE_STRICT_WARNINGS` adds `-Wall -Wextra -Wpedantic` on non-MSVC toolchains.
- utf8proc vendored: `third_party/utf8proc/` is included via CMake (`add_subdirectory( third_party/utf8proc )`).
- Unicode wrapper: `src/unicode/yaep_unicode.h` and `src/unicode/yaep_unicode.c` implement iteration, validation, classification predicates, byte-safe hashing, safe truncation, and NFC normalization helpers (e.g., `yaep_utf8_next`, `yaep_utf8_validate`, `yaep_utf8_isalpha`, `yaep_utf8_normalize_nfc`).
- Grammar lexer updated: `src/sgramm.y` uses the unicode wrapper (`yaep_utf8_next`, `yaep_utf8_isalpha`, `yaep_utf8_isalnum`, etc.) for Unicode-aware lexing and literal handling.
- Normalization: `src/yaep.c` uses `yaep_utf8_normalize_nfc()` at symbol insertion sites so NFC-equivalent identifiers map consistently when normalization succeeds.
- Tests: UTF-8 related tests and CMake test targets exist under `test/` (see `test/C/CMakeLists.txt` for `test_utf8_*` targets and `test_hash_stability.c`).

## Remaining / recommended

- CI: add GitHub Actions (or similar) to exercise C11 builds and run the UTF-8 tests and optionally sanitizers.
- Autotools parity: if Autotools support must be retained, update Autotools to mirror CMake options, otherwise document deprecation.
- Performance profiling: run `src/compare_parsers` benchmarks to validate ASCII fast-paths and quantify any overhead introduced by Unicode handling.

## Where to inspect code (concrete refs)

- `src/unicode/yaep_unicode.h`, `src/unicode/yaep_unicode.c` — wrapper API and implementation.
- `src/sgramm.y` — grammar lexer updated to call Unicode helpers.
- `src/yaep.c` — symbol insertion and normalization usage sites.
- `CMakeLists.txt` — C11 default and `third_party/utf8proc` inclusion.
- `test/C` and `test/` — UTF-8 tests and CMake wiring.

