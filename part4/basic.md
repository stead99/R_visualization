###基本散点图展示
####1.应用场景
箱型图应用非常常见，比如：两组比较，多组比较，多组里面的两两比较


![scatter plot](/images/part4/data_format1.png)

####利用ggplot2创建boxplot

```R
#rt为2.1 scatter plot所展示的数据
#rt_box如上图所示

rt <- read.table(file = "/Users/stead/Documents/SourceTree/gitbook/R_visualization/data/LUAD_test.txt", header = TRUE, 
                row.names = 1, stringsAsFactors = FALSE)

#准备ggplot2所需数据格式
rt_box <- data.frame(cbind(as.numeric(rt['TP53',]), c(rep('tumor', 57), rep('normal', 57))))
colnames(rt_box) <- c('TP53', 'group')
rt_box$TP53 <- as.numeric(rt_box$TP53)
```

```R
library(ggplot2)
P <- ggplot(rt_box, aes(x = group, y = TP53)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
                outlier.size=4)
print(P)
```

![scatter plot](/images/part4/box_plot1.svg)


```R
#P 来自于上图
P + geom_jitter(shape=16, position=position_jitter(0.2))#在boxplot中加入具体表达值所在的位置点
```

![scatter plot](/images/part4/box_plot2.svg)

```R
P2 <- ggplot(rt_box, aes(x = group, y = TP53, color = group)) +
  geom_boxplot() + theme_classic() #改变下主题
print(P2)
```

![scatter plot](/images/part4/box_plot3.svg)

```R
P3 <- ggplot(rt_box, aes(x = group, y = TP53, fill = group)) +
      geom_boxplot() + theme_classic() + 
      geom_dotplot(binaxis='y', stackdir='center', position=position_dodge(1))
print(P3)
```

![scatter plot](/images/part4/box_plot4.svg)
