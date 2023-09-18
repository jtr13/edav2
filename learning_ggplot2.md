# (PART) R graphics {-}

# Learning ggplot2

## **Getting started**

Hopefully, most of you already have experiences in plotting basic R graphics. In this Chapter, you will be briefly introduced one of the most powerful plotting packages in R: `ggplot2` with it's basic grammar and functions. To start, install `ggplot2` in the console or in R chunk.

```
install.packages('ggplot2')
```


## **Default part: layer**

For many R beginners, the question is always like: why is ggplot? One remarkable feature of `ggplot2` is having an underlying grammar which enables you to compose graphs by combining different components. You can easily create novel graphics by adding `ggplot2` functions to meet your needs based on your data. 

By definition of the grammar of graphics, the most important features are data and mapping in the layers and that's where we are getting started.


```r
library(ggplot2)

ggplot(data = iris) +  #Data part
  geom_point(aes(Sepal.Length, Sepal.Width))  #Mapping part
```

<img src="learning_ggplot2_files/figure-html/unnamed-chunk-1-1.png" width="384" style="display: block; margin: auto;" />

The most important part of all plots is data, which includes the information you want to visualize. Based on that, the next step is to decide its mapping, which determine how the data's variable are mapped to aesthetic attributes on a graphic. Since data is independent from the other elements, you can always add several layers of data into the same ggplot while keeping the other components the same.


```r
ggplot(data = iris) +  #Data part
  geom_point(aes(Petal.Length, Petal.Width)) +  #layer 1 with mapping 
  geom_point(aes(Sepal.Length, Sepal.Width), color='red')  #layer 2 with a different mapping
```

<img src="learning_ggplot2_files/figure-html/unnamed-chunk-2-1.png" width="384" style="display: block; margin: auto;" />



## **Customized parts**

The following picture shows the order of ggplot functions:

<center>
![](images/codingOrder.png){width=60%}
</center>

For more function order suggestions and auto-correction when writing your own `ggplot2` functions, please refer to [ggformat](https://github.com/jtr13/ggformat) addin created by Joyce.


### **Geometric object, statistical transformation and position adjustment**

<center>
![](images/layers.png)
</center>

Geometric object, Statistical transformation and Position adjustment are components that can be customized in each layer.

Geometric objects `geoms` control the type of plot you create. Different types of plot have different aesthetics features. For example, a point geom has position, color, shape, and size aesthetics. You should first decide which kind of plot better explains the data before choosing `geoms` and use `help` function to check what aesthetics can be modified to achieve your desired effects.

A statistical transformation `stat` transforms the data. And Position adjustment is applied when you need to adjust the position of elements on the plot for dense data, otherwise data points might obscure one another.


```r
ggplot(data = iris) +
  geom_histogram(mapping=aes(x=Petal.Length, fill=Species), stat = 'bin',position = 'stack')
```

<img src="learning_ggplot2_files/figure-html/unnamed-chunk-3-1.png" width="460.8" style="display: block; margin: auto;" />


### **Scale**

<center>
![](images/scale.png){width=50%}
</center>

A scale controls how data is mapped to aesthetic attributes, so one scale for one layer.


```r
ggplot(data = iris) +
  geom_histogram(mapping=aes(x=Petal.Length, fill=Species), stat = 'bin',position = 'stack') +
  scale_x_continuous(limits = c(0, 10)) +
  scale_y_continuous(limits = c(0, 50))
```

<img src="learning_ggplot2_files/figure-html/unnamed-chunk-4-1.png" width="460.8" style="display: block; margin: auto;" />



### **Coordinate system**

A coordinate system `coord` maps the position of objects onto the plane of the plot, and controls how the axes and grid lines are drawn. One ggplot can only have one `coord``


```r
ggplot(data = iris) +
  geom_histogram(mapping=aes(x=Petal.Length, fill=Species), stat = 'bin',position = 'stack') +
  coord_polar()
```

<img src="learning_ggplot2_files/figure-html/unnamed-chunk-5-1.png" width="460.8" style="display: block; margin: auto;" />


### **Faceting**

Faceting can be used to split the data up into subsets of the entire dataset. 


```r
ggplot(data = iris) +
  geom_histogram(mapping=aes(x=Petal.Length), stat = 'bin') +
  facet_wrap(iris$Species)
```

<img src="learning_ggplot2_files/figure-html/unnamed-chunk-6-1.png" width="460.8" style="display: block; margin: auto;" />


### **Labels**

Labels include titles, labels for x,y axis and annotates. Good graphics also need to give clear information by using labels to tell readers' of the background knowledge of your data.


```r
ggplot(data = iris) +
  geom_histogram(mapping=aes(x=Petal.Length, fill=Species), stat = 'bin',position = 'stack') +
  ggtitle('Stacked petal length of different species') +
  xlab('Length of Petal')
```

<img src="learning_ggplot2_files/figure-html/unnamed-chunk-7-1.png" width="460.8" style="display: block; margin: auto;" />




## **Resources for ggplot2**

- For more implementations and examples, one easiest way is referring to the ggplot2 Cheatsheets provided by R. Follow the steps shown below and you can find the cheat-sheets in your RStudio. 

<center>
![](images/ggplotCheatsheet_1.png){width=75%}
</center>

The cheat-sheets clearly list the basic components of a ggplot where you can customize your unique plot by choosing different functions.

- If you are seeking for more detailed explanations and examples with real datasets, here are some useful links for you: 

1. [ggplot2: Elegant Graphics](https://ggplot2-book.org/)

2. [ggformat](https://github.com/jtr13/ggformat)

## Required aesthetic mappings


|GEOM                   |REQUIRED MAPPINGS                            |
|:----------------------|:--------------------------------------------|
|geom_abline            |NA                                           |
|geom_area              |x and y                                      |
|geom_bar               |x or y                                       |
|geom_bin_2d            |x and y                                      |
|geom_bin2d             |x and y                                      |
|geom_blank             |NA                                           |
|geom_boxplot           |x or y                                       |
|geom_col               |x and y                                      |
|geom_contour           |x, y, and z                                  |
|geom_contour_filled    |x, y, and z                                  |
|geom_count             |x and y                                      |
|geom_crossbar          |x, y, ymin, and ymax or x, y, xmin, and xmax |
|geom_curve             |x, y, xend, and yend                         |
|geom_density           |x or y                                       |
|geom_density_2d        |x and y                                      |
|geom_density_2d_filled |x and y                                      |
|geom_density2d         |x and y                                      |
|geom_density2d_filled  |x and y                                      |
|geom_dotplot           |x                                            |
|geom_errorbar          |x, ymin, and ymax or y, xmin, and xmax       |
|geom_errorbarh         |xmin, xmax, and y                            |
|geom_freqpoly          |x or y                                       |
|geom_function          |NA                                           |
|geom_hex               |x and y                                      |
|geom_histogram         |x or y                                       |
|geom_hline             |yintercept                                   |
|geom_jitter            |x and y                                      |
|geom_label             |x, y, and label                              |
|geom_line              |x and y                                      |
|geom_linerange         |x, ymin, and ymax or y, xmin, and xmax       |
|geom_map               |NA                                           |
|geom_path              |x and y                                      |
|geom_point             |x and y                                      |
|geom_pointrange        |x, y, ymin, and ymax or x, y, xmin, and xmax |
|geom_polygon           |x and y                                      |
|geom_qq                |sample                                       |
|geom_qq_line           |sample                                       |
|geom_quantile          |x and y                                      |
|geom_raster            |x and y                                      |
|geom_rect              |xmin, xmax, ymin, and ymax                   |
|geom_ribbon            |x, ymin, and ymax or y, xmin, and xmax       |
|geom_rug               |NA                                           |
|geom_segment           |x, y, xend, and yend                         |
|geom_sf                |geometry                                     |
|geom_sf_label          |geometry                                     |
|geom_sf_text           |geometry                                     |
|geom_smooth            |x and y                                      |
|geom_spoke             |x, y, angle, and radius                      |
|geom_step              |x and y                                      |
|geom_text              |x, y, and label                              |
|geom_tile              |x and y                                      |
|geom_violin            |x and y                                      |
|geom_vline             |xintercept                                   |

 
