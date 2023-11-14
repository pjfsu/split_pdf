BEGIN{ 
	FS="\t+"
	IN_PDF=pdf
	SECTION_NAME_RE="[[:graph:]]( |[[:graph:]])*[[:graph:]]"
	FIRST_PAGE_RE="[[:digit:]]+"
	LAST_PAGE_RE="[[:digit:]]+"
	VALID_LINE_RE="^"SECTION_NAME_RE"\\t+"FIRST_PAGE_RE"\\t+"LAST_PAGE_RE"$"
	# print VALID_LINE_RE
	print "split_pdf()"
	print "{"
	print "\tlocal in_pdf_path=\"$(realpath \"$(dirname \""IN_PDF"\")\")\""
	print ""
}
NR==1{
	next
}
!match($0, VALID_LINE_RE){
	printf "\techo 'invalid line %d:\"%s\"'\n", \
	       NR, \
	       $0
	print ""
	next
}
{
	out_pdf_name=$1
	underscored_out_pdf_name=out_pdf_name
	gsub(/ /, "_", underscored_out_pdf_name)
	first_page=$2
	last_page=$3

	printf "\techo -n 'splitting \"%s.pdf\" ... '\n", \
	       out_pdf_name
	printf "\tpdfseparate -f %d -l %d \"%s\" \"%s\"\n", \
		  first_page, \
		  last_page, \
		  IN_PDF, \
		  "/tmp/%d_"underscored_out_pdf_name".pdf"
	printf "\tpdfunite %s \"%s\"\n", \
		  "$(ls -v /tmp/[0-9]*_"underscored_out_pdf_name".pdf)", \
		  "${in_pdf_path}/"out_pdf_name".pdf"
	print "\techo 'done'"
	print ""
}
END{
	print "\techo -n 'removing single pages ... '"
	print "\trm /tmp/[0-9]*.pdf"
	print "\techo 'done'"
	print ""
	print "\treturn 0"
	print "}"
}
