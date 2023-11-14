function main()
{
	local pdf="${1}"
	local tsv="${2}"
	local this_script_dir="$(dirname "${0}")"

	awk -v pdf="${pdf}" \
		-f "${this_script_dir}/generate_split_pdf_script.awk" "${tsv}" \
		> "${this_script_dir}/split_pdf.sh"

	source "${this_script_dir}/split_pdf.sh"
	split_pdf 2> /dev/null

	return 0
}

main "$@"
