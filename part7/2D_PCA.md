###主成分分析及展示
####应用
主成分分析(PCA)，个人理解是将高维数据上的点投射到新的坐标系，从而达到降维的目的，同时也可以看看哪些点的数据特征相近，比如，我们利用多个基因的表达量看看肿瘤和正常组织是否可以正常的分开

>所使用的数据依然是上一章节heatmap所用的数据

```R
rt <- read.table(file = "./LUAD_test.txt", header = TRUE, row.names = 1, stringsAsFactors = FALSE)
```

>准备PCA所需数据

```R
library(gmodels)
mat_a <- t(as.matrix(rt))
mat_pca <- fast.prcomp(mat_a, scale = T)  # do PCA
sum_a <- summary(mat_pca)
tmp <- sum_a$importance  # a include 4 sections which contain importance
pro1 <- as.numeric(sprintf("%.3f", tmp[2,1]))*100
pro2 <- as.numeric(sprintf("%.3f", tmp[2,2]))*100 # fetch the proportion of PC1 and PC2
pc <- as.data.frame(sum_a$x)  # convert to data.frame
```

>pc数据结构如下

![data format](/images/part7/data_format1.png)


```R
#准备分组和颜色参数设置
pc$group <-  c(rep('tumor', 57), rep('normal', 57))
pc$color <-  c(rep('#6D9EC1', 57), rep('#E46726', 57)) 
pc$group <- factor(pc$group, levels = unique(pc$group))

xlab <- paste("PC1(", pro1, "%)", sep = "")
ylab <- paste("PC2(", pro2, "%)", sep = "")
```

>利用ggplot展示结果

```R
library(ggplot2)
PCA1 <- ggplot(pc, aes(PC1, PC2, color = group)) +
      geom_point(size = 5) + scale_colour_manual(values = unique(pc$color)) +
      labs(x = xlab, y = ylab)
print(PCA1)

#更换个主题
PCA2 <- ggplot(pc, aes(PC1, PC2, color = group)) +
      geom_point(size = 5) + scale_colour_manual(values = unique(pc$color)) +
      labs(x = xlab, y = ylab) + theme_bw()
print(PCA2)
```

![PCA1](/images/part7/PCA1.svg)![PCA2](/images/part7/PCA2.svg)
