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
GNU grep | 3.8
pdfseparate | 22.12.0
pdfunite | 22.12.0
pdfinfo | 22.12.0

Argument | Description
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
user@debian:~/Documents/books/Bash_Reference_Manual$ exit
```
