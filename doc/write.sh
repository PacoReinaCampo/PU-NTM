rm -f *.pdf
rm -f *.tex

pandoc ../BOOK.md -s -o PU-NTM.pdf
pandoc ../BOOK.md -s -o PU-NTM.tex
