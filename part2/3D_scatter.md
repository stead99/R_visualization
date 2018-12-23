###3D 散点图展示
####1.应用场景
eg: 展示3个基因间的关系

当点的位置有多个变量决定的时候我们可以用3D散点图展示

>数据来自上一节

```R
scatterplot3d(x, y, z, pch = 16)
```

![scatter plot](/images/part2/3D_scatter_plot1.svg)

```R
#修改点的颜色，修改字体大小, 添加x, y, z lab
scatterplot3d(x, y, z, pch = 16, color = 'blue', cex.axis = 1.5, cex.lab = 1.5, 
             xlab = "MT-TF", ylab = "MT-TV", zlab = "MT-TL1")
```

![scatter plot](/images/part2/3D_scatter_plot2.svg)
