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

sample <- slice_sample(movies, prop = 0.2)

ggplot(sample,aes(x=votes,y=rating)) +
  geom_point() +
  ggtitle("Votes vs. rating") +
  theme_classic()
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
<div id="htmlwidget-9198441b68a8594efac1" style="width:576px;height:432px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-9198441b68a8594efac1">{"x":{"visdat":{"4e8538437a11":["function () ","plotlyVisDat"]},"cur_data":"4e8538437a11","attrs":{"4e8538437a11":{"x":{},"y":{},"text":{},"hoverinfo":"text","color":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20]}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"domain":[0,1],"automargin":true,"title":"votes"},"yaxis":{"domain":[0,1],"automargin":true,"title":"rating"},"hovermode":"closest","showlegend":true},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":[142,247,47,30,78,37,12382,57,550,281,3014,7,215,43,5,43,330,17,67,6,250,48,7,88],"y":[6,6.2,5.3,2.3,5,6,6.7,4.4,5.9,6.4,7.6,6.6,5.4,5,7,7.1,5.9,5.8,3.4,3.3,6.1,6.4,7.3,6.2],"text":["De l'amour","Very Annie Mary","Off Key","Lay It Down","Bosque animado, El","Down and Out with the Dolls","Bandits","Being Light","Ik ook van jou","Fausto 5.0","Elling","Opashkata na dyavola","Petit poucet, Le","Good Things, The","Fat Chance","Lunch","Finder's Fee","Bar imperial","Cheonsamong","Hot Tubs II: The Terror Returns","Pistol Opera","Gau lung bing sat","Tatarin","Palo, El"],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"type":"scatter","mode":"markers","name":"2001","marker":{"color":"rgba(102,194,165,1)","line":{"color":"rgba(102,194,165,1)"}},"textfont":{"color":"rgba(102,194,165,1)"},"error_y":{"color":"rgba(102,194,165,1)"},"error_x":{"color":"rgba(102,194,165,1)"},"line":{"color":"rgba(102,194,165,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[31,9,25,576,225,5,12,56,13,12,11,7,44,10,170,936,5328,14,65,6,5,7,14,7],"y":[3.7,6.8,5.2,7.5,6.7,8.4,6.2,6.3,6.5,9.1,3.9,7.3,6.5,8.1,4.6,5.6,2.8,5.5,5,8.7,7.6,6,5.7,8.1],"text":["Returning Mickey Stern","Potestad","Spin","Jibeuro","Thumbtanic","Cultivision (Collapsing Stars)","Summer Blues","Bay of Love and Sorrows, The","Veronique","Dirty Diamonds","Tribe of Joseph","Every Little Girl's Dream","Club Le Monde","Champ, The","Ginostra","Buying the Cow","Rollerball","Anansi","Vivir mata","Beatle Fan, The","Sensation","Beth","Seres humanos","Optimistic"],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"type":"scatter","mode":"markers","name":"2002","marker":{"color":"rgba(252,141,98,1)","line":{"color":"rgba(252,141,98,1)"}},"textfont":{"color":"rgba(252,141,98,1)"},"error_y":{"color":"rgba(252,141,98,1)"},"error_x":{"color":"rgba(252,141,98,1)"},"line":{"color":"rgba(252,141,98,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[287,30,21328,13,5,5,15,12,6,25,40,54,6,5,24,176],"y":[7.6,4.1,7.5,4.8,7.2,6.6,8.4,8.3,8.2,4.5,8.4,2.9,8.3,8,6.1,6.6],"text":["Homem do Ano, O","Dono, Il","Master and Commander: The Far Side of the World","Opopomoz","Abxang","Fairuz, we hielden zoveel van mekaar","Lost/Found","Nuit d'orage","Erlking, The","Champagne Society","Origines du SIDA, Les","Deadly Swarm","Nitschewo","Tahiti","Toutes ces belles promesses","Verschwende deine Jugend"],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"type":"scatter","mode":"markers","name":"2003","marker":{"color":"rgba(141,160,203,1)","line":{"color":"rgba(141,160,203,1)"}},"textfont":{"color":"rgba(141,160,203,1)"},"error_y":{"color":"rgba(141,160,203,1)"},"error_x":{"color":"rgba(141,160,203,1)"},"line":{"color":"rgba(141,160,203,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[63,2502,73,75,751,5,8,6,11,62,6,9,52,4045,125,24,6,2039,32,880,1164,45,16,96,10],"y":[3.5,6.5,3.6,5.9,7,8,8,8.5,8.8,5.9,9.8,6.9,6.6,6.8,6,9.4,7,6.7,6.6,8.4,6.5,6.8,7.4,8.5,7.1],"text":["Shiner","Ella Enchanted","Ham & Cheese","Nouvelle-France","Confidences trop intimes","Donde acaban los caminos","Trzeci","Hip Hop Homos","Night Demons","Baptists at Our Barbecue","Innocence Project, The","Beaster","Holy Lola","Polar Express, The","Strange Bedfellows","Hotel Torgo","License Exam","De-Lovely","Koi no mon","Dear Frankie","Football Factory, The","Freak Out","Manners of Dying","Grayson","Crying?"],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"type":"scatter","mode":"markers","name":"2004","marker":{"color":"rgba(231,138,195,1)","line":{"color":"rgba(231,138,195,1)"}},"textfont":{"color":"rgba(231,138,195,1)"},"error_y":{"color":"rgba(231,138,195,1)"},"error_x":{"color":"rgba(231,138,195,1)"},"line":{"color":"rgba(231,138,195,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[116,35],"y":[7.5,7.8],"text":["Kong que","Heads or Tails"],"hoverinfo":["text","text"],"type":"scatter","mode":"markers","name":"2005","marker":{"color":"rgba(166,216,84,1)","line":{"color":"rgba(166,216,84,1)"}},"textfont":{"color":"rgba(166,216,84,1)"},"error_y":{"color":"rgba(166,216,84,1)"},"error_x":{"color":"rgba(166,216,84,1)"},"line":{"color":"rgba(166,216,84,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
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

While this is quite useful for personal exploration of a dataset, it is **not** recommended for presentation purposes. Something called the [Hermann grid illusion](https://en.wikipedia.org/wiki/Grid_illusion){target="_blank"} makes this plot very difficult to examine.


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

If you look at all the previous examples, you might notice that lighter points correspond to more clustered points, which is somewhat counter-intuitive. The following example suggests an alternative approach in color scale.


```r
ggplot(SpeedSki, aes(Year, Speed)) + 
  geom_hex(bins=12) +
  scale_fill_gradient(low = "grey", high = "purple") +  
  theme_classic(18) +
  ggtitle("Alternative approach to color")
```

<img src="two_continuous_var_files/figure-html/unnamed-chunk-12-1.png" width="576" style="display: block; margin: auto;" />
