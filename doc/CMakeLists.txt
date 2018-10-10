set( DOCFILES
	Internals.txt
	yaep-1.html
	yaep.dvi
	yaep.html
	yaep.info
	yaep.pdf
	yaep.ps
	yaep.txt
	yaep++-1.html
	yaep++.dvi
	yaep++.html
	yaep++.info
	yaep++.pdf
	yaep++.ps
	yaep++.txt
)
install( FILES ${DOCFILES} DESTINATION "${CMAKE_INSTALL_DOCDIR}" )
