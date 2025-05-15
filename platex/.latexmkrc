$out_dir = '../dist';
$aux_dir = '../build';

$pdf_mode = 3;

$latex = 'platex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$bibtex = 'pbibtex %O %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
