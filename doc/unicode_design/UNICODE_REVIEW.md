# Unicode Enablement Review for YAEP

This file has been updated to reflect the current implementation status on the `unicode-feature` branch. The project now implements a UTF-8 wrapper and integrates `utf8proc`. The changes below note where code was updated and what remains.

## Summary

- YAEP previously assumed byte-wise ASCII processing in its grammar reader. The `unicode-feature` branch implements a UTF-8 wrapper and updates the grammar lexer and supporting utilities to operate correctly on Unicode code points.

## Key findings (current)

- **Grammar description lexer (`src/sgramm.y`)** now uses `yaep_utf8_next` and `yaep_utf8_is*` predicates from `src/unicode/yaep_unicode.*` so lexing is performed on Unicode code points rather than raw bytes.
- **String helpers** (e.g., `objstack`, `vlobject`) still store byte buffers, which is correct for UTF-8 storage; callers and docs should note stored lengths count bytes, not code points.
- **Hashing**: the repository contains `yaep_utf8_hash` which treats bytes as `unsigned char` to avoid sign-extension issues; `src/yaep.c` also calls normalization helpers where needed.
- **Diagnostics**: `yaep_utf8_truncate_safe` exists and ensures truncation preserves code point boundaries when building error messages.
- **Public headers**: `src/unicode/yaep_unicode.h` documents UTF-8 expectations and helper APIs; users should consult it for correct usage.

## Recommendations (concrete next steps)

- Update `README.md` and public API docs to state that YAEP expects UTF-8 encoded input in public APIs and grammar descriptions.
- Ensure unit tests include edge cases: malformed UTF-8, combining marks, emoji, and mixed-script digits (there are existing tests under `test/` to extend).
- Consider documenting `objstack`/`vlobject` storage semantics explicitly to avoid confusion about byte vs codepoint lengths.


### 1. Establish UTF-8 as the canonical encoding
- Document UTF-8 as the required encoding for grammar descriptions, symbol names, and diagnostic output.
- Vendor `utf8proc` under `third_party/utf8proc/` and wrap its decoding/validation helpers in a YAEP-facing API (e.g., `yaep_utf8_next`, `yaep_utf8_isalpha`) that forwards to `utf8proc_iterate`, `utf8proc_category`, and friends. Keep the wrapper small so call sites remain clean and future upgrades are isolated.

### 2. Revise the grammar description parser (`src/sgramm.y`)
- Replace byte-wise pointer walks with UTF-8 decoding using the helper routines.
- Swap `isalpha`/`isalnum`/`isdigit` with `utf8proc_category` checks against `UTF8PROC_CATEGORY_L*`, `UTF8PROC_CATEGORY_Nd`, etc., and introduce ASCII fast paths for single-byte lexemes to preserve speed.
- Update character literal handling (`case '\''`) so multi-byte characters inside `'…'` iterate using `utf8proc_iterate`, and emit `utf8proc_errmsg` output for malformed sequences.
- Ensure location tracking (line/column) advances by Unicode scalar values; maintain byte offsets separately for diagnostics if needed.
- Extend unit tests to cover identifiers with combining marks, emoji, surrogate boundary cases, and verify that `utf8proc_normalize_utf32` keeps different canonical forms equivalent when desired.

### 3. Harden string utilities and hashing
- Update `symb_repr_hash` and any loops over `repr` to treat bytes as `unsigned char` to avoid sign-extension.
- Audit other hash/comparison helpers for similar assumptions.
- Introduce explicit `size_t` length parameters where `strlen` is repeatedly recomputed, and validate UTF-8 once with `utf8proc_iterate` during ingestion to avoid propagating invalid byte sequences.

### 4. Modernise error reporting
- Replace fixed-size buffers with dynamic growth (e.g., `VLO`/`os_t` helpers) or enforce `vsnprintf` everywhere to avoid truncating multi-byte characters mid-sequence. When truncation is unavoidable, ensure we cut at code point boundaries by checking continuation bytes before appending to logs generated from `utf8proc` results.
- When truncation is unavoidable, ensure we cut at code point boundaries and append an ellipsis indicator.

### 5. Update documentation and API surface
- Clarify UTF-8 expectations in `README.md`, `src/yaep.h`, and generated docs under `doc/`.
- Provide guidance for callers writing scanners in C/C++ to hand UTF-8 tokens to the parser (e.g., treat regex character classes as byte classes or migrate scanners to Unicode-aware engines such as re2c or flex with `%option utf8`) and suggest leveraging `utf8proc` for normalization or case-folding if they need the same semantics as the grammar reader.

### 6. Expand the test suite
- Add golden grammars and source snippets containing: non-Latin identifiers, emoji, combining marks, and multi-language literals.
- Ensure both the C and C++ front-ends (`yaep.c`, `yaep.cpp`) parse the new fixtures.
- Include negative tests for malformed UTF-8 to verify helpful diagnostics and ensure we surface the `utf8proc_errmsg` strings to users.

## Library options with bundled Unicode tables
- **utf8proc** (MIT license, maintained by JuliaLang): ships ready-made Unicode tables for normalization, case folding, and property lookups. For YAEP we propose making it the default backend: vendor version-tagged sources, compile the provided `.c` file in each build system, and expose a small adapter that hides raw `utf8proc` enums. The compiled footprint is ~400 KB, which is acceptable given the feature gain. Best choice if you need reliable normalization and identifier classification with minimal maintenance. Requires building one extra object file and linking it into both the C and C++ variants.
- **utf8rewind** (zlib license): compact C library (one `.c` + `.h`) that embeds Unicode data for decoding, normalization, category queries, and case conversion. Slightly smaller tables than utf8proc (~250 KB) and straightforward integration. Offers optional iteration helpers and validation routines.
- **libgrapheme** (ISC license, suckless.org): aims to provide the Unicode text segmentation algorithm with statically generated tables. Lightweight (~100 KB) and easy to vendor; pairs well with a dedicated decoder (e.g., `utf8.h`) if you need grapheme, word, or sentence boundary detection alongside classification.
- Larger ecosystems such as ICU4C or libunistring provide exhaustive Unicode support but add megabytes of data and complex build requirements. Keep them as opt-in targets only if you need locale-sensitive collation or legacy encoding conversion.

**Integration approach:** vendor `utf8proc` inside `third_party/utf8proc/`, add CMake/Makefile glue to compile `utf8proc.c`, expose a thin wrapper under `src/unicode/`, and update `yaep.c`/`sgramm.y` to call the wrapper for validation, property checks, and optional normalization. For consumers that need different semantics, keep the wrapper pluggable so alternative backends (e.g., `utf8rewind`) can be swapped later. Regenerate the Unicode tables only when rolling to a new `utf8proc` release, keeping the generated sources in the repo for deterministic builds.

## Suggested Implementation Plan
1. **Baseline**: add regression tests capturing current ASCII behaviour to guard against regressions. Decide on UTF-8 policy and update docs.
2. **Utility Layer**: add a `unicode_utf8proc` wrapper that centralizes calls to `utf8proc_iterate`, `utf8proc_category`, and normalization helpers; update hashing/diagnostics to be byte-safe.
3. **Grammar Parser**: refactor `sgramm.y` lexer to consume UTF-8 via the wrapper, then regenerate the parser and fix build scripts as needed.
4. **Sample Scanners**: create or update lexers in `test/` to show UTF-8-compatible scanning; keep ASCII fixtures as legacy examples.
5. **API & Docs**: refresh headers, README, and SGML docs with encoding guidance and migration notes.
6. **Validation**: run the full `make test` suite, add new Unicode fixtures, and measure performance impact. Benchmark normalization-heavy workloads to ensure `utf8proc` overhead is acceptable or cached appropriately.

## Risks and Mitigations
- **Performance regressions**: UTF-8 decoding introduces overhead. Mitigate with ASCII fast paths and targeted benchmarks (`src/compare_parsers`).
- **Parser generator compatibility**: Updating `sgramm.y` may require newer flex/bison features for Unicode. Document toolchain requirements and consider bundling pre-generated sources for portability.
- **Invalid input**: Enforcing UTF-8 may reject previously accepted raw byte grammars. Provide opt-in validation mode or configuration flag during transition.

