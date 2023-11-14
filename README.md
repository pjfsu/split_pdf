# split_pdf
## a pdf page splitter

Command | Version
--- | ---
GNU bash | 5.2.15
mawk | 1.3.4
dirname (GNU coreutils)| 9.1
realpath (GNU coreutils) | 9.1
ls (GNU coreutils)) | 9.1
rm (GNU coreutils) | 9.1
cat (GNU coreutils) | 9.1
GNU grep | 3.8
pdfseparate | 22.12.0
pdfunite | 22.12.0
pdfinfo | 22.12.0

main.sh Arguments | Description
--- | ---
"${1}" | the PDF file to split
"${2}" | the tabs-separated value file containing the page ranges to split (defined by the user)

### Example

```console
user@debian:~/Documents/books/Bash_Reference_Manual$ ls
Bash_Reference_Manual.pdf  pages_range.tsv
user@debian:~/Documents/books/Bash_Reference_Manual$ pdfinfo Bash_Reference_Manual.pdf | grep Pages
Pages:           196
user@debian:~/Documents/books/Bash_Reference_Manual$ cat pages_range.tsv 
Out pdf name				First page	Last page
1. Introduction				7		8
2. Definitions				9		10
3. Basic Shell Features			11		53
4. Shell Builtin Commands		54		83
5. Shell Variables			84		96
6. Bash Features			97		118
7. Job Control				119		122
8. Command Line Editing			123		157
9. Using History Interactively		158		163
user@debian:~/Documents/books/Bash_Reference_Manual$ bash $HOME/Documents/scripts/split_pdf/main.sh "Bash_Reference_Manual.pdf" "pages_range.tsv"
splitting "1. Introduction.pdf" ... done
splitting "2. Definitions.pdf" ... done
splitting "3. Basic Shell Features.pdf" ... done
splitting "4. Shell Builtin Commands.pdf" ... done
splitting "5. Shell Variables.pdf" ... done
splitting "6. Bash Features.pdf" ... done
splitting "7. Job Control.pdf" ... done
splitting "8. Command Line Editing.pdf" ... done
splitting "9. Using History Interactively.pdf" ... done
removing single pages ... done
user@debian:~/Documents/books/Bash_Reference_Manual$ ls
'1. Introduction.pdf'            '7. Job Control.pdf'
'2. Definitions.pdf'             '8. Command Line Editing.pdf'
'3. Basic Shell Features.pdf'    '9. Using History Interactively.pdf'
'4. Shell Builtin Commands.pdf'   Bash_Reference_Manual.pdf
'5. Shell Variables.pdf'          pages_range.tsv
'6. Bash Features.pdf'
user@debian:~/Documents/books/Bash_Reference_Manual$ for pdf in [0-9]*.pdf; do echo "${pdf}"; pdfinfo "${pdf}" | grep Pages; done
1. Introduction.pdf
Pages:           2
2. Definitions.pdf
Pages:           2
3. Basic Shell Features.pdf
Pages:           43
4. Shell Builtin Commands.pdf
Pages:           30
5. Shell Variables.pdf
Pages:           13
6. Bash Features.pdf
Pages:           22
7. Job Control.pdf
Pages:           4
8. Command Line Editing.pdf
Pages:           35
9. Using History Interactively.pdf
Pages:           6
user@debian:~/Documents/books/Bash_Reference_Manual$ cat $HOME/Documents/scripts/split_pdf/split_pdf.sh 
split_pdf()
{
	local in_pdf_path="$(realpath "$(dirname "Bash_Reference_Manual.pdf")")"

	echo -n 'splitting "1. Introduction.pdf" ... '
	pdfseparate -f 7 -l 8 "Bash_Reference_Manual.pdf" "/tmp/%d_1._Introduction.pdf"
	pdfunite $(ls -v /tmp/[0-9]*_1._Introduction.pdf) "${in_pdf_path}/1. Introduction.pdf"
	echo 'done'

	echo -n 'splitting "2. Definitions.pdf" ... '
	pdfseparate -f 9 -l 10 "Bash_Reference_Manual.pdf" "/tmp/%d_2._Definitions.pdf"
	pdfunite $(ls -v /tmp/[0-9]*_2._Definitions.pdf) "${in_pdf_path}/2. Definitions.pdf"
	echo 'done'

	echo -n 'splitting "3. Basic Shell Features.pdf" ... '
	pdfseparate -f 11 -l 53 "Bash_Reference_Manual.pdf" "/tmp/%d_3._Basic_Shell_Features.pdf"
	pdfunite $(ls -v /tmp/[0-9]*_3._Basic_Shell_Features.pdf) "${in_pdf_path}/3. Basic Shell Features.pdf"
	echo 'done'

	echo -n 'splitting "4. Shell Builtin Commands.pdf" ... '
	pdfseparate -f 54 -l 83 "Bash_Reference_Manual.pdf" "/tmp/%d_4._Shell_Builtin_Commands.pdf"
	pdfunite $(ls -v /tmp/[0-9]*_4._Shell_Builtin_Commands.pdf) "${in_pdf_path}/4. Shell Builtin Commands.pdf"
	echo 'done'

	echo -n 'splitting "5. Shell Variables.pdf" ... '
	pdfseparate -f 84 -l 96 "Bash_Reference_Manual.pdf" "/tmp/%d_5._Shell_Variables.pdf"
	pdfunite $(ls -v /tmp/[0-9]*_5._Shell_Variables.pdf) "${in_pdf_path}/5. Shell Variables.pdf"
	echo 'done'

	echo -n 'splitting "6. Bash Features.pdf" ... '
	pdfseparate -f 97 -l 118 "Bash_Reference_Manual.pdf" "/tmp/%d_6._Bash_Features.pdf"
	pdfunite $(ls -v /tmp/[0-9]*_6._Bash_Features.pdf) "${in_pdf_path}/6. Bash Features.pdf"
	echo 'done'

	echo -n 'splitting "7. Job Control.pdf" ... '
	pdfseparate -f 119 -l 122 "Bash_Reference_Manual.pdf" "/tmp/%d_7._Job_Control.pdf"
	pdfunite $(ls -v /tmp/[0-9]*_7._Job_Control.pdf) "${in_pdf_path}/7. Job Control.pdf"
	echo 'done'

	echo -n 'splitting "8. Command Line Editing.pdf" ... '
	pdfseparate -f 123 -l 157 "Bash_Reference_Manual.pdf" "/tmp/%d_8._Command_Line_Editing.pdf"
	pdfunite $(ls -v /tmp/[0-9]*_8._Command_Line_Editing.pdf) "${in_pdf_path}/8. Command Line Editing.pdf"
	echo 'done'

	echo -n 'splitting "9. Using History Interactively.pdf" ... '
	pdfseparate -f 158 -l 163 "Bash_Reference_Manual.pdf" "/tmp/%d_9._Using_History_Interactively.pdf"
	pdfunite $(ls -v /tmp/[0-9]*_9._Using_History_Interactively.pdf) "${in_pdf_path}/9. Using History Interactively.pdf"
	echo 'done'

	echo -n 'removing single pages ... '
	rm /tmp/[0-9]*.pdf
	echo 'done'

	return 0
}
user@debian:~/Documents/books/Bash_Reference_Manual$ exit
```
