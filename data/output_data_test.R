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


###output clinical data
cancer <- 'LUAD'
rt_cli <- read.table(file = paste("/Users/stead/Desktop/PD-L1_and_TMI_type/UCSC_GDC_data/", cancer, "/phenotype/TCGA-", cancer, ".GDC_phenotype.tsv", sep = ""),
                     sep = "\t", header = TRUE, row.names = NULL, stringsAsFactors = FALSE, fill = TRUE, quote = "", na.strings = "NA")
rt_sur <- read.table(file = paste("/Users/stead/Desktop/PD-L1_and_TMI_type/UCSC_GDC_data/", cancer, "/phenotype/TCGA-", cancer, ".survival.tsv", sep = ""),
                     sep = "\t", header = TRUE, row.names = NULL, stringsAsFactors = FALSE)

###get merged exp, cli and sur
cancer_list <- GetExpSurCli(rt_sym_t_i, rt_cli, rt_sur)
rt_T_m <- cancer_list[[1]]
rt_cli_m <- cancer_list[[2]]
rt_sur_m <- cancer_list[[3]]
cancer_cli_sort <- CliSort(rt_cli_m, cancer)
rt_cli_m <- cancer_cli_sort

rt_sur_s <- rt_sur_m[, c('X_OS_IND', 'X_OS')]
colnames(rt_sur_s) <- c('OS_Time', 'OS_Status')
rt_cli_s <- rt_cli_m[, c('age_at_initial_pathologic_diagnosis', 'tumor_stage.diagnoses')]
colnames(rt_cli_s) <- c('age', 'stage')
rt_ecs <- cbind(t(rt_T_m[c(4478, 22753, 22434), ]), rt_sur_s, rt_cli_s)
setwd('/Users/stead/Documents/SourceTree/gitbook/R_visualization/data')
write.table(rt_ecs, file = 'LUAD_cli_exp.txt', row.names = TRUE, col.names = TRUE, sep = '\t')
