# Add utf8proc library to YAEP build
add_library(utf8proc STATIC utf8proc.c)
target_include_directories(utf8proc PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
