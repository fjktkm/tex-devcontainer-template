$out_dir = '../dist';
$aux_dir = '../build';

$pdf_mode = 1;

$latex = 'pdflatex -synctex=1 -interaction=nonstopmode %O %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
