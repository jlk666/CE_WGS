sourmash compare -p 8 *.sig  -o CE_cmp
sed -i 's|/home/zhuosl/CE_WGS/main/Genome_contig/spades_||g' CE_cmp.labels.txt
sourmash plot --pdf --labels CE_cmp
