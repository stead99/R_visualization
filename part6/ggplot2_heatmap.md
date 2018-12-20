###ggplot2 heatmap

>数据依然来自于上一节的数据

```R
library("reshape2")
library("ggplot2")

#准备ggplt2所需要的数据格式
mat_ht_gg <- melt(t(mat_ht_z))

#作图
HT1 <- ggplot(data = mat_ht_gg, aes(x = Var1, y = Var2)) + 
       geom_tile(aes(fill = value))
print(HT1)
        
#可以换一种颜色
HT2 <- HT1 + scale_fill_gradient2(low = "blue", high = "red")
print(HT2)
```
![scatter plot](/images/part6/heatmap6.svg)
![scatter plot](/images/part6/heatmap7.svg)

>如果想要获得聚类的图，需要提前对输入数据进行聚类

```R
#do cluster
library(ggplot2)
library(ggcorrplot)
library(ggdendro)

#col cluster
mat_dendro_col <- as.dendrogram(hclust(d = dist(x = t(mat_ht_z))))
mat_dendro_ord_col <- order.dendrogram(mat_dendro_col)
#row cluster
mat_dendro_row <- as.dendrogram(hclust(d = dist(x = mat_ht_z)))
mat_dendro_ord_row <- order.dendrogram(mat_dendro_row)

#Re-order heatmap columns to match dendrogram
mat_ht_gg_clu <- mat_ht_z[mat_dendro_ord_row, mat_dendro_ord_col]
mat_ht_clu <- melt(t(mat_ht_gg_clu))

HT3 <- ggplot(data = mat_ht_clu, aes(x = Var1, y = Var2)) + 
       geom_tile(aes(fill = value)) +  
        scale_fill_gradient2(low = "blue", high = "red")
print(HT3)
```

![scatter plot](/images/part6/heatmap8.svg)


>如果想要加上聚类的线可以通过ggdendrogram叠加上去

```R
library(grid)
dendro_plot_col <- ggdendrogram(data = mat_dendro_col, rotate = FALSE) +
                   theme(axis.text.x = element_text(size = 2))

dendro_plot_row <- ggdendrogram(data = mat_dendro_row, rotate = TRUE) +
                   theme(axis.text.y = element_text(size = 2))

HT4 <- ggplot(data = mat_ht_clu, aes(x = Var1, y = Var2)) +
       geom_tile(aes(fill = value)) +
       scale_fill_gradient2(low = "blue", high = "red") +
       theme(axis.text.y = element_blank(),
             axis.title.y = element_blank(),
             axis.ticks.y = element_blank(),
             axis.text.x = element_blank(),
             axis.title.x = element_blank(),
             axis.ticks.x = element_blank(),
             legend.position = "bottom")

grid.newpage()
print(HT4, vp=viewport(0.6, 0.8, x = 0.5, y = 0.3)) #x change x positiion, y change y position,
print(dendro_plot_col, vp=viewport(0.66, 0.2, x = 0.495, y = 0.78)) # 0.875change cluster plot wide
print(dendro_plot_row, vp=viewport(0.2, 0.77, x = 0.9, y = 0.335)) # 0.65change cluster plot wide
```

![scatter plot](/images/part6/heatmap9.svg)
