###3D PCA
####应用场景
3D PCA和2D PCA本质类似，可能看上去更酷炫些

>所有数据和2D一样

```R
#增加一个pro3
library(gmodels)
mat_a <- t(as.matrix(rt))
mat_pca <- fast.prcomp(mat_a, scale = T)  # do PCA
sum_a <- summary(mat_pca)
tmp <- sum_a$importance  # a include 4 sections which contain importance
pro1 <- as.numeric(sprintf("%.3f", tmp[2,1]))*100
pro2 <- as.numeric(sprintf("%.3f", tmp[2,2]))*100 # fetch the proportion of PC1 and PC2
pro3 <- as.numeric(sprintf("%.3f", tmp[2,3]))
pc <- as.data.frame(sum_a$x)  # convert to data.frame

#增加一个zlab
pc$group <-  c(rep('tumor', 57), rep('normal', 57))
pc$color <-  c(rep('#6D9EC1', 57), rep('#E46726', 57)) 
pc$group <- factor(pc$group, levels = unique(pc$group))

xlab <- paste("PC1(", pro1, "%)", sep = "")
ylab <- paste("PC2(", pro2, "%)", sep = "")
zlab <- paste("PC3(", pro3, "%)", sep = "")
```

>利用scatter3D作图

```R
#基本展示
scatter3D(x = pc$PC1, y = pc$PC2, z = pc$PC3,  
          xlab = xlab, ylab = ylab, zlab = zlab, colkey = FALSE)


#改变下颜色及分组
scatter3D(x = pc$PC1, y = pc$PC2, z = pc$PC3,
          xlab = xlab, ylab = ylab, zlab = zlab, 
          bty = 'g', cex = 1.5, pch  = 20,
          col = as.character(unique(pc$color)),  
          colvar = as.integer(pc$group),
          groups = pc$group, colkey = FALSE)
```
![PCA3](/images/part7/PCA3.svg)
![PCA4](/images/part7/PCA4.svg)

