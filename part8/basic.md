###ROC曲线
####应用场景
评估某个指标预测某项事件的性能，诊断的特异性和灵敏性，比如以基因的表达预测tumor和normal的特异性和灵敏性

>使用数据格式如下图

![data format](/images/part8/data_format1.png)

```R
load('./roc_test.Rdata') #rt
###计算给予TP53表达判断tumor和normal的特异性和灵敏性
roc_pt <- roc(rt_roc$group, rt_roc$TP53)
AUC_val <- round(as.numeric(roc_pt$auc), digits = 3)#获取AUC的值

mat_roc <- data.frame(cbind(roc_pt$specificities, roc_pt$sensitivities), stringsAsFactors = FALSE)
colnames(mat_roc) <- c('specificities', 'sensitivities')
```

>作图

```R
library(ggplot2)
library(pROC)

ggplot(mat_roc, aes(1- specificities, sensitivities)) + geom_point() + 
geom_abline(linetype="dashed", color = "grey") + 
annotate(geom="text", x = 0.75, y = 0.25, label = paste ('AUC = ' , AUC_val, sep = "" )) + 
theme_bw()

#将点换成线
#geom_line()做切换
ggplot(mat_roc, aes(1- specificities, sensitivities)) + 
geom_line(size = 1.5, colour = 'blue') + 
geom_abline(linetype="dashed", color = "grey") + 
annotate(geom="text", x = 0.75, y = 0.25, label = paste ('AUC = ' , AUC_val, sep = "" )) + 
theme_bw()
```

![ROC1](/images/part8/ROC1.svg)![ROC2](/images/part8/ROC2.svg)
