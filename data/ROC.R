library(ggplot2)
library(pROC)
setwd('/Users/stead/Documents/SourceTree/gitbook/R_visualization/images/part8')
load('/Users/stead/Documents/SourceTree/gitbook/R_visualization/data/roc_test.Rdata') #rt

###????????????TP53????????????tumor???normal????????????????????????
roc_pt <- roc(rt_roc$group, rt_roc$TP53)
AUC_val <- round(as.numeric(roc_pt$auc), digits = 3)

mat_roc <- data.frame(cbind(roc_pt$specificities, roc_pt$sensitivities), stringsAsFactors = FALSE)
colnames(mat_roc) <- c('specificities', 'sensitivities')


pdf(file = 'ROC1.pdf', width = 4, height = 4)
ggplot(mat_roc, aes(1- specificities, sensitivities)) + geom_point() + 
geom_abline(linetype="dashed", color = "grey") + 
annotate(geom="text", x = 0.75, y = 0.25, label = paste ('AUC = ' , AUC_val, sep = "" )) + 
theme_bw()
dev.off()

pdf(file = 'ROC2.pdf', width = 4, height = 4)
ggplot(mat_roc, aes(1- specificities, sensitivities)) + geom_line(size = 1.5, colour = 'blue') + 
  geom_abline(linetype="dashed", color = "grey") + 
  annotate(geom="text", x = 0.75, y = 0.25, label = paste ('AUC = ' , AUC_val, sep = "" )) + 
  theme_bw()
dev.off()

