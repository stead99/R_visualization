###基本散点图展示
####1.应用场景
eg: 依据设定的方向展示某种特征数值的变化趋势。比如说：基因的表达随患者年龄的变化趋势，基因的表达随肿瘤大小的变化趋势等等

![scatter plot](/images/part3/data_format_cli.png)

####利用plot创建line plot

```R
#rt_cli如上图所示
x <- c(1:57) #创造一个于TP53有相同长度的数值向量
y <- rt_cli$TP53[order(rt_cli$TP53)] #将TP53的表达值从大到小排序
plot(x, y, type = "S")
```

![scatter plot](/images/part3/line_plot1.svg)


```R
#type 改变线的类型
#xlab和ylab 添加x和y的标签
#cex.lab, cex.axis改变字体大小
plot(x, y, type = "b", pch = 19, cex.lab = 2, cex.axis=2, 
     col = "red", xlab = "virtual", ylab = "TP53")
```

![scatter plot](/images/part3/line_plot2.svg)

####利用ggplot2创建line plot

```R
library(ggplot2)
data <- data.frame(cbind(x, y), stringsAsFactors = FALSE) #准备一个ggplot2所需要的数据格式
colnames(data) <- c('virtual', 'TP53')
ggplot(data = data, aes(x = virtual, y = TP53)) +
  geom_line()
```

![scatter plot](/images/part3/line_plot3.svg)

```R
#theme_classic() 主题类型
#color 改变line的颜色
ggplot(data = data, aes(x = virtual, y = TP53)) +
  geom_line(color = "blue") + theme_classic()
```

![scatter plot](/images/part3/line_plot4.svg)
