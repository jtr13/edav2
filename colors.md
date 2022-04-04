# Colors

When evaluating the power and efficiency of a plot, color is always a key factor that sometimes speaks a language even louder than words. So in this chapter, you will be introduced with several widely-applied color schemes and get to know how to use proper colors to make better plots based on different features of your data.


## RColorBrewer

``RColorBrewer`` is an R package having built-in sensible color schemes ready-to-use for figures. Colors are grouped into three types: sequential, diverging, and qualitative.

>Sequential – Light colours for low data, dark for high data
>
>Diverging –  Light colours for mid-range data, low and high use dark colours
>
>Qualitative(for categorical data) – Colours designed to give maximum visual difference between categories
>


```r
library(RColorBrewer)
display.brewer.all() 
```

<img src="colors_files/figure-html/unnamed-chunk-1-1.png" width="576" style="display: block; margin: auto;" />

Here is an example of plotting categorical data using ``Dark2`` pallete under qualitative group of RColorBrewer:


```r
library(ggplot2)
ggplot(iris, aes(Petal.Length, Sepal.Length, colour = Species)) +
  geom_point() +
  scale_colour_brewer(palette = "Dark2")
```

<img src="colors_files/figure-html/unnamed-chunk-2-1.png" width="384" style="display: block; margin: auto;" />
