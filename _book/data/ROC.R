setwd('/Users/stead/Documents/SourceTree/gitbook/R_visualization/images/part8')
load('/Users/stead/Documents/SourceTree/gitbook/R_visualization/data/roc_test.Rdata') #rt

###计算给予TP53表达判断tumor和normal的特异性和灵敏性
roc_pt <- roc(rt_roc$group, rt_roc$TP53)
AUC_val <- round(as.numeric(roc_pt$auc), digits = 3)

mat_roc <- data.frame(cbind(roc_pt$specificities, roc_pt$sensitivities), stringsAsFactors = FALSE)
colnames(mat_roc) <- c('specificities', 'sensitivities')


svg(file = 'ROC1.svg', width = 4, height = 4)
ggplot(mat_roc, aes(1- specificities, sensitivities)) + geom_point() + 
geom_abline(linetype="dashed", color = "grey") + 
annotate(geom="text", x = 0.75, y = 0.25, label = paste ('AUC = ' , AUC_val, sep = "" )) + 
theme_bw()
dev.off()

svg(file = 'ROC2.svg', width = 4, height = 4)
ggplot(mat_roc, aes(1- specificities, sensitivities)) + geom_line(size = 1.5, colour = 'blue') + 
  geom_abline(linetype="dashed", color = "grey") + 
  annotate(geom="text", x = 0.75, y = 0.25, label = paste ('AUC = ' , AUC_val, sep = "" )) + 
  theme_bw()
dev.off()

