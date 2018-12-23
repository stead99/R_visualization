library(clusterProfiler)
library(pathview)


setwd('/Users/stead/Documents/SourceTree/gitbook/R_visualization/images/part10')
load('/Users/stead/Documents/SourceTree/gitbook/R_visualization/data/FC_P.Rdata')#rt_FC_P

#??????KEGG???????????????
eg = bitr(row.names(rt_FC_P), fromType="SYMBOL", toType="ENTREZID", OrgDb="org.Hs.eg.db")
gene_list <- rt_FC_P$logFC[match(eg$SYMBOL, row.names(rt_FC_P), nomatch = 0)]
names(gene_list) <- eg$ENTREZID
gene_list <- gene_list[order(gene_list, decreasing = TRUE)]
gene <- names(gene_list)[abs(gene_list) > 1]


kk <- enrichKEGG(gene = gene, organism = 'hsa', pvalueCutoff = 0.05)
head(kk)

kk2 <- gseKEGG(geneList = gene_list, organism = 'hsa', pvalueCutoff = 0.05, verbose = FALSE)
head(kk2)

pdf(filename = 'KK1.pdf', width = 8, height = 4)
barplot(kk, showCategory = 8)
dev.off()

pdf(filename = 'KK2.pdf', width = 8, height = 4)
dotplot(kk2)
dev.off()

library("pathview")
hsa04610 <- pathview(gene.data  = gene_list,
                     pathway.id = "hsa04610",
                     species = "hsa",
                     limit  = list(gene=max(abs(gene_list)), cpd=1))

#GO analysis
ggo <- groupGO(gene = gene, OrgDb = org.Hs.eg.db, ont = "CC",
               level = 3, readable = TRUE)

ego <- enrichGO(gene = gene, universe = names(gene_list), OrgDb = org.Hs.eg.db, 
                ont = "CC", pAdjustMethod = "BH", pvalueCutoff = 0.1,
                qvalueCutoff = 0.05, readable = TRUE)

pdf(file = 'GO1.pdf', width = 8, height = 4)
barplot(ego, showCategory=8)
dev.off()

pdf(file = 'GO2.pdf', width = 8, height = 4)
dotplot(ego)
dev.off()

pdf(file = 'GO3.pdf', width = 8, height = 6)
emapplot(ego)
dev.off()

pdf(file = 'GO4.pdf', width = 8, height = 6)
cnetplot(ego, categorySize = "pvalue", foldChange = gene_list)
dev.off()


