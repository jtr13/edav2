# Two continuous variables

In this chapter, we will look at techniques that explore the relationships between two continuous variables.

## Scatterplot

### Basics and implications

For the following example, we use data set `SpeedSki`. 


```r
library(GDAdata)
library(ggplot2)

ggplot(SpeedSki, aes(Year, Speed)) + 
  geom_point() +
  labs(x = "Birth year", y = "Speed achieved (km/hr)") +
  ggtitle("Skiers by birth year and speed achieved")
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-1-1.png" width="460.8" style="display: block; margin: auto;" />

In our example, we simply use `geom_point` on variables `Year` and `Speed` to create the scatterplot. we try to capture if there is a relationship between the age of a player and the speed he/she can achieve. From the graph, it seems such relationship does not exist. Overall, scatterplots are very useful in understanding the correlation (or lack thereof) between variables. The scatterplot gives a good idea of whether that relationship is positive or negative and if there’s a correlation. However, don’t mistake correlation in a scatterplot for causation!

### Overplotting

In some situations a scatter plot faces the problem of overplotting as there are so many points overlapping. Consider the following example from class. To save time, we randomly sample 20% of the data in advance.


```r
library(dplyr)
library(ggplot2movies)

sample <- slice_sample(movies,prop=0.2)

ggplot(sample,aes(x=votes,y=rating)) +
  geom_point() +
  theme_classic() +
  ggtitle("Votes vs. rating")
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-2-1.png" width="460.8" style="display: block; margin: auto;" />

To create better visuals, we can use:

* Alpha blending - `alpha=...`

* Open circles - `pch=21`

* smaller circles - `size=...` or `shape="."`


```r
library(gridExtra)

f1 <- ggplot(sample,aes(x=votes,y=rating)) +
  geom_point(alpha=0.3) +
  theme_classic() +
  ggtitle("Alpha blending")

f2 <- ggplot(sample,aes(x=votes,y=rating)) +
  geom_point(pch = 21) +
  theme_classic() +
  ggtitle("Open circle")

f3 <- ggplot(sample,aes(x=votes,y=rating)) +
  geom_point(size=0.5) +
  theme_classic() +
  ggtitle("Smaller circle")

grid.arrange(f1, f2, f3,nrow = 3)
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-3-1.png" width="672" style="display: block; margin: auto;" />

Other methods that directly deal with the data:

* Randomly sample data - as shown in the first code chunk using `sample_n`

* Subset - split data into bins using `ntile(votes, 10)`

* Remove outliers 

* Transform to log scale

### Interactive scatterplot

You can create an interactive scatterplot using `plotly`. In the following example, we take 1% of the movie data set to present a better visual. We plotted the votes vs. rating and grouped by the year they are released. In this graph:

* You can hover on to the points to see the title of the movie

* You can double click on the year legend to look at a certain year

* You can zoom into a certain part of the graph to better understand the data points.

```r
library(plotly)

sample2 <- slice_sample(movies,prop=0.01) %>%
  filter(year > 2000)

plot_ly(sample2, x = ~votes, y = ~rating,
        color = ~as.factor(year), text= ~title,
        hoverinfo = 'text') 
```

```{=html}
<div id="htmlwidget-e07f4bb0900e2a87307f" style="width:576px;height:432px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-e07f4bb0900e2a87307f">{"x":{"visdat":{"36fb2a02531c":["function () ","plotlyVisDat"]},"cur_data":"36fb2a02531c","attrs":{"36fb2a02531c":{"x":{},"y":{},"text":{},"hoverinfo":"text","color":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20]}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"domain":[0,1],"automargin":true,"title":"votes"},"yaxis":{"domain":[0,1],"automargin":true,"title":"rating"},"hovermode":"closest","showlegend":true},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":[14,5241,189,27,8,7,75,12,149,7,1832,36,42,39,5],"y":[6,7.4,6.1,6.7,7.2,5.7,6.9,7.5,6.1,7.1,6.3,2.7,6.7,2.7,8.3],"text":["Spirit of America, The","Monsoon Wedding","Onmyoji","Gina, an Actress, Age 29","Hood","Alias: Slayer","Reise nach Kafiristan, Die","Sweetnightgoodheart","My Kingdom","Death Affair, The","Charlotte Gray","Platinum Blonde","Gulp","Happiness Is a Warm Gun","Fountain, The"],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"type":"scatter","mode":"markers","name":"2001","marker":{"color":"rgba(102,194,165,1)","line":{"color":"rgba(102,194,165,1)"}},"textfont":{"color":"rgba(102,194,165,1)"},"error_y":{"color":"rgba(102,194,165,1)"},"error_x":{"color":"rgba(102,194,165,1)"},"line":{"color":"rgba(102,194,165,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[104,609,5,41,14,5871,50,11,761,11,9,31,7,25964,25,246,3724,98,17,409,25,87],"y":[5.3,6.2,5,5.1,7.3,5.1,6.6,7.7,6.2,7.9,8.1,7.4,5.2,8.7,8.9,6.7,6.6,6.6,2.7,6.7,6.5,5.1],"text":["Merci Docteur Rey","Doctor Sleep","Tracks","Haider lebt - 1. April 2021","Media Whore","Kung Pow: Enter the Fist","I Don't Know Jack","Seasons Alter, The","Dirty Deeds","Fans and Freaks: The Culture of Comics and Conventions","Seasons...","West of Here","King's Beard, The","Cidade de Deus","Enraged New World, An","Casomai","Treasure Planet","Bella Bettien","Savage Roses","Interview with the Assassin","Enfin pris?","Frau die an Dr. Fabian zweifelte, Die"],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"type":"scatter","mode":"markers","name":"2002","marker":{"color":"rgba(252,141,98,1)","line":{"color":"rgba(252,141,98,1)"}},"textfont":{"color":"rgba(252,141,98,1)"},"error_y":{"color":"rgba(252,141,98,1)"},"error_x":{"color":"rgba(252,141,98,1)"},"line":{"color":"rgba(252,141,98,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[204,14,35,45,6,8,58,30,10,91,5,29,11109,57,19,16,21,16,17,82],"y":[6.8,6.5,7.9,5.7,5.6,6.1,4.2,4.9,8,6,7,7.5,6.1,7.5,3.3,8,4.5,6.7,6.2,2.7],"text":["Mudge Boy, The","Confection","When Zachary Beaver Came to Town","Hamenos ta pairnei ola, O","Rascagnes","Nudity Required","Bloom","Mes enfants ne sont pas comme les autres","Hang Time","Klasse von '99 - Schule war gestern, Leben ist jetzt, Die","Lastikman","Speedo","Freddy Vs. Jason","Wheel of Time","Mind's I, A","Insoliti sospetti","Sister Blue","In Satmar Custody","Art History","Bells of Innocence"],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"type":"scatter","mode":"markers","name":"2003","marker":{"color":"rgba(141,160,203,1)","line":{"color":"rgba(141,160,203,1)"}},"textfont":{"color":"rgba(141,160,203,1)"},"error_y":{"color":"rgba(141,160,203,1)"},"error_x":{"color":"rgba(141,160,203,1)"},"line":{"color":"rgba(141,160,203,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[59,76,82,5,6,117,19,19,26,5,11,153,10,31,6,12],"y":[8.1,6.4,3.5,4.9,7.8,6.6,6.7,4.5,6.5,8.6,6.3,7,5.5,6.7,3,6.4],"text":["Nina","Duga mracna noc","Out of Bounds","Sugar Orange","Inamorata","Genesis","Waiting for the Clouds","C'est pas moi, c'est l'autre","Vento di terra","Axis of Evil: Perforated Praeter Naturam","Cielo gira, El","Chiavi di casa, Le","How to Live with a Vegan Without Killing Them","Hole in One, A","Vampire Lesbian Kickboxers","Circuit marine"],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"type":"scatter","mode":"markers","name":"2004","marker":{"color":"rgba(231,138,195,1)","line":{"color":"rgba(231,138,195,1)"}},"textfont":{"color":"rgba(231,138,195,1)"},"error_y":{"color":"rgba(231,138,195,1)"},"error_x":{"color":"rgba(231,138,195,1)"},"line":{"color":"rgba(231,138,195,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[6,43,18,11,5],"y":[7,7.4,2.6,5.2,9.4],"text":["See This Movie","Straight Into Darkness","Pobeg","5th World","Spandex: A Father's Tale"],"hoverinfo":["text","text","text","text","text"],"type":"scatter","mode":"markers","name":"2005","marker":{"color":"rgba(166,216,84,1)","line":{"color":"rgba(166,216,84,1)"}},"textfont":{"color":"rgba(166,216,84,1)"},"error_y":{"color":"rgba(166,216,84,1)"},"error_x":{"color":"rgba(166,216,84,1)"},"line":{"color":"rgba(166,216,84,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```
### Modifications

#### Contour lines

Contour lines give a sense of the density of the data at a glance.

For these contour maps, we will use the `SpeedSki` dataset.

Contour lines can be added to the plot using geom_density_2d() and contour lines work best when combined with other layers


```r
ggplot(SpeedSki, aes(Year, Speed)) + 
  geom_density_2d(bins=5) +
  geom_point() +
  ggtitle("Scatter plot with contour line")
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-5-1.png" width="460.8" style="display: block; margin: auto;" />

You can use `bins` to control the number of contour bins.

#### Scatterplot matrices

If you want to compare multiple parameters to each other, consider using a scatterplot matrix. This will allow you to show many comparisons in a compact and efficient manner.

For these scatterplot matrices, we use the `movies` dataset from the `ggplot2movies` package.

As a default, the base R plot() function will create a scatterplot matrix when given multiple variables:


```r
sample3 <- slice_sample(movies,prop=0.01) #sample data

splomvar <- sample3 %>% 
  dplyr::select(length, budget, votes, rating, year)

plot(splomvar)
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-6-1.png" width="672" style="display: block; margin: auto;" />

While this is quite useful for personal exploration of a datset, it is **not** recommended for presentation purposes. Something called the [Hermann grid illusion](https://en.wikipedia.org/wiki/Grid_illusion){target="_blank"} makes this plot very difficult to examine.


## Heatmaps

### Basics and implications 

In the following example, we still use the `SpeedSki` data set.


```r
ggplot(SpeedSki, aes(Year, Speed)) + 
  geom_bin2d() 
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-7-1.png" width="460.8" style="display: block; margin: auto;" />

To create a heatmap, simply substitute `geom_point()` with `geom_bin2d()`. Generally, heat maps are like a combination of scatterplots and histograms: they allow you to compare different parameters while also seeing their relative distributions.

### Modifications

For the following section, we introduce some variations on heatmaps.

#### Change number of bins / binwidth

By default, `geom_bin2d()` use 30 bins. Similar to a histogram, we can change the number of bins or binwidth.


```r
ggplot(SpeedSki, aes(Year, Speed)) + 
  geom_bin2d(binwidth = c(5,5)) +
  ggtitle("Changing binwidth")
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-8-1.png" width="384" style="display: block; margin: auto;" />

Notice we are specifying the binwidth for both x and y axis.

#### Combine with a scatterplot


```r
ggplot(SpeedSki, aes(Year, Speed)) +
  geom_bin2d(binwidth = c(10, 10), alpha = .4) + 
  geom_point(size = 2) +
  ggtitle("Combined with scatterplot")
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-9-1.png" width="384" style="display: block; margin: auto;" />

#### Change color scale

You can change the continuous scale of color 


```r
ggplot(SpeedSki, aes(Year, Speed)) + 
  geom_bin2d() +
  ggtitle("Changing color scale") + 
  scale_fill_viridis_c()
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-10-1.png" width="384" style="display: block; margin: auto;" />

#### Hex heatmap

One alternative is a hex heatmap. You can create the graph using `geom_hex`


```r
ggplot(SpeedSki, aes(Year, Speed)) + 
  geom_hex(binswidth = c(10,10)) +
  ggtitle("Hex heatmap")
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-11-1.png" width="384" style="display: block; margin: auto;" />

#### Alternative approach to color

If you look at all the previous examples, you might notice that lighter points corresponds to more clustered points, which is somewhat counter-intuitive. The following exmaple suggest an alternative approach in color scale.


```r
ggplot(SpeedSki, aes(Year, Speed)) + 
  geom_hex(bins=12) +
  scale_fill_gradient(low = "grey", high = "purple") +  
  theme_classic(18) +
  ggtitle("Alternative approach to color")
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-12-1.png" width="576" style="display: block; margin: auto;" />
