###violin plot
violin plot和boxplot功能类似，但是violin plot将点的密度横向的展示出来了，因此可以很好的看出数据在坐标轴分布的情况。

>数据适用适用上一节的数据rt_box_m

```
###类似于boxplot，使用的geom_violin来生成violin plot
PV1 <- ggplot(rt_box_m, aes(x = gene_name, y = expression)) + 
       geom_violin(trim = FALSE, aes(color = group)) + 
       scale_color_manual(values = c("blue", "red")) #改变violin颜色
print(PV1)

###感觉这样有点难看
svg(file = 'box_plot17.svg', width = 8, height = 4)
PV2 <- ggplot(rt_box_m, aes(x = gene_name, y = expression)) + 
       geom_violin(trim = FALSE, aes(color = group)) +
       geom_boxplot(width = 0.1, aes(color = group), position = position_dodge(0.9)) + #加入box
       scale_color_manual(values = c("blue", "red")) 
print(PV2)

###也可以将box变成点
PV3 <- ggplot(rt_box_m, aes(x = gene_name, y = expression)) + 
       geom_violin(trim = FALSE, aes(color = group)) +
       geom_dotplot(aes(fill = group, color = group), trim = FALSE, 
                    binaxis='y', stackdir='center', dotsize = 0.2,
                    position = position_dodge(0.9))  #加入点
print(PV3)
```

![scatter plot](/images/part4/box_plot16.svg)
![scatter plot](/images/part4/box_plot17.svg)
![scatter plot](/images/part4/box_plot18.svg)
