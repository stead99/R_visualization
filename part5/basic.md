###密度分布图
####应用场景
可以展示数据分布特征，比如说：我们可以看看数据样本中患者年龄分布情况，也可以分组看看不同组别患者年龄分布趋势。

![data_format](/images/part3/data_format_cli.png)

####利用ggplot2创建density plot

```R
load("./cli_test.Rdata")
#rt_cli数据形式如上图

library(ggplot2)
ggplot(rt_cli, aes(age)) +
  geom_density(color= "#E69F00", alpha=0.4)

#scale_color_manual设置线条颜色
ggplot(rt_cli, aes(age, colour = stage)) +
  geom_density() + 
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9", "#FF6666"))

#alpha 改变填充颜色深度
ggplot(rt_cli, aes(age, colour = stage, fill = stage)) +
  geom_density(alpha=0.4) + 
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9", "#FF6666"))

###计算每个stage age的均值
library(plyr)
age_mm <- ddply(rt_cli, "stage", summarise, grp.mean=mean(age))

###利用geom_vline添加均值值所在的位置
ggplot(rt_cli, aes(age, colour = stage, fill = stage)) +
  geom_density(alpha=0.4) +  
  geom_vline(data = age_mm, aes(xintercept = grp.mean, color = stage),
             linetype="dashed") + 
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9", "#FF6666")) +
  theme_classic() 
```

![scatter plot](/images/part5/density_plot1.svg)![scatter plot](/images/part5/density_plot2.svg)
![scatter plot](/images/part5/density_plot3.svg)![scatter plot](/images/part5/density_plot4.svg)
