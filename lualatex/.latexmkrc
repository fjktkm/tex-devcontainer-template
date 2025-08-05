$out_dir = '../dist';
$aux_dir = '../build';

$pdf_mode = 4;

$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode %O %S';
$bibtex = 'pbibtex %O %B';
