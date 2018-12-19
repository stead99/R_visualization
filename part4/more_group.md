###多组boxplot
####1.引用场景
eg:展示多个基因在肿瘤和正常组织中的表达量

```R
#多组boxplot
#构建数据集
rt_box_m <- data.frame(cbind(c(as.numeric(rt['TP53',]), as.numeric(rt['CD274',]), as.numeric(rt['LAMA3', ])),
                             c(rep('TP53', 114), rep('CD274', 114), rep('LAMA3', 114)), 
                             rep(c(rep('tumor', 57), rep('normal', 57)), 3)), stringsAsFactors = FALSE)
colnames(rt_box_m) <- c('expression', 'gene_name', 'group')
rt_box_m$expression <- as.numeric(rt_box_m$expression)
```
>数据结构如下

![scatter plot](/images/part4/data_format2.png)

```R
library(ggpubr)

PP1 <- ggplot(rt_box_m, aes(x = gene_name, y = expression)) + 
      geom_boxplot(aes(fill = group), position = position_dodge(0.9))
print(PP1)

#利用stat_compare_means添加统计检验的pvalue
PP2 <- PP1 + stat_compare_means(aes(group = group), label = "p.format")
print(PP2)

###利用theme_classic改变主题
PP3 <- PP2 +  theme_classic()  
print(PP3)
```
![scatter plot](/images/part4/box_plot11.svg)
![scatter plot](/images/part4/box_plot12.svg)
![scatter plot](/images/part4/box_plot13.svg)

####分面展示这些结果
```R
PF1 <- ggplot(rt_box_m, aes(group, expression)) + 
       geom_boxplot(aes(color = group))+
       facet_grid(. ~ gene_name) + #改变分面展示的方向
       scale_color_manual(values = c("blue", "red")) + #修改box的颜色
       stat_compare_means(label = "p.format")
print(PF1)

PF2 <- ggplot(rt_box_m, aes(group, expression)) + 
       geom_boxplot(aes(color = group))+
       facet_grid(gene_name ~ .) +
       scale_color_manual(values = c("blue", "red")) +
       stat_compare_means(label = "p.format")
print(PF2)
```
![scatter plot](/images/part4/box_plot14.svg)
![scatter plot](/images/part4/box_plot15.svg)
