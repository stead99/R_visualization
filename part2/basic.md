###基本散点图展示
####1.应用场景
eg: 直观展示两个基因表达相关性

首先我们看看数据结构，在所有的可视化的教程中我们如果将数据准备好的，那么我们利用下面的代码可以快速的做出自己想要做的图。如图2-1,数据来源于TCGA数据库，列名是样本名，行名是基因名。
![实例数据](/images/part2/data_format.png)

```R
load('./test_exp.Rdata')#rt
#rt即上图展示数据
x <- as.numeric(rt['MT-TF', ])
y <- as.numeric(rt['MT-TV', ])
plot(x, y, main = "Main title",
     xlab = "MT-TF expression", ylab = "MT-TV expression",
     pch = 19, frame = FALSE)
```

![scatter plot](/images/part2/scatter_plot1.svg)


```R
#调整字体大小,参数cex
plot(x, y, main = "Main title", cex.lab=1.5, cex.axis=1.5, cex.main=1.5,
     cex.sub=1.5,
     xlab = "MT-TF expression", ylab = "MT-TV expression",
     pch = 19, frame = FALSE)
```

![scatter plot](/images/part2/scatter_plot2.svg)

```R
#调点的颜色和大小
plot(x, y, main = "Main title", cex.lab=1.5, cex.axis=1.5, cex.main=1.5,
     cex.sub=1.5, col = "blue", cex = 2, #改变   
     xlab = "MT-TF expression", ylab = "MT-TV expression",
     pch = 19, frame = FALSE)
```

![scatter plot](/images/part2/scatter_plot3.svg)
