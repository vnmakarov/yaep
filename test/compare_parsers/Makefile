.PHONY: clean realclean

# Clean up transient files created by running compare_parsers.sh
# This does not touch source files (like ansic.y, ansic.c if checked in) but
# removes generated parser outputs and the per-run logs/directories.
clean:
	rm -f a.out y.tab.c marpa_test.c small_test.i test_yyparse.c y.tab.h
	rm -f *.log *.out *_run*.log
	rm -rf logs logs_* logs-master logs-master-* logs_master logs_unicode logs_unicode-* logs-*

realclean: clean
