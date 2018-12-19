library(maftools)
library(reshape2)
library(ggplot2)

setwd('/Users/stead/Desktop/RUNX3')
script_dir='/Users/stead/Documents/SourceTree/R/common_used_codes/'
source(paste(script_dir, 'tcga_tools/get_exp_sur_cli_merge_data.R', sep = ""))
source(paste(script_dir, 'tcga_tools/get_tcga_sample_type.R', sep = ""))
source(paste(script_dir, 'smart_tools/EA2SM.R', sep = ""))

rt <- read.table(file = '/Users/stead/Desktop/PD-L1_and_TMI_type/UCSC_GDC_data/LUAD/RNA_seq/TCGA-LUAD.htseq_fpkm.tsv', header = TRUE, row.names = 1, 
                 stringsAsFactors = FALSE, sep = '\t')
rt_sym <- EA2SM(rt, in_type = 'ensembl_gene_id', out_type = 'hgnc_symbol', dup_type = 'mean')
rt_sym_t <- split_tcga_tn(rt_sym, sam_type = "tumor") 
rt_sym_n <- split_tcga_tn(rt_sym, sam_type = "normal") 
sam_tn <- intersect(colnames(rt_sym_t), colnames(rt_sym_n))

rt_sym_t_i <- rt_sym_t[, match(sam_tn, colnames(rt_sym_t), nomatch = 0)]
colnames(rt_sym_t_i) <- paste(colnames(rt_sym_t_i), 'tumor', sep = "_")
rt_sym_n_i <- rt_sym_n[, match(sam_tn, colnames(rt_sym_n), nomatch = 0)]
colnames(rt_sym_n_i) <- paste(colnames(rt_sym_n_i), 'normal', sep = "_")

rt_sym <- data.frame(cbind(rt_sym_t_i, rt_sym_n_i), stringsAsFactors = FALSE)

rt_sym_d <- data.frame(rt_sym[apply(rt_sym, 1, function(x){median(x) > 0}), ], stringsAsFactors = FALSE)[1:10000, ]
setwd('/Users/stead/Documents/SourceTree/gitbook/R_visualization/data')
write.table(rt_sym_d, file = 'LUAD_test.txt', row.names = TRUE, col.names = TRUE, sep = '\t')
