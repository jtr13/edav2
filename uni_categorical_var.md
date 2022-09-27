# Unidimensional categorical variables

In real-world datasets, categorical features are quite common but tricky during both the data pre-processing and visualization process. In this chapter, we will demonstrate several plotting options for the uni-dimensional categorical variables with ``ggplot``.

## Bar plot

There are two types of uni-dimensional categorical variables: nominal and ordinal. Here you will be shown how these variables should be plotted differently using bar plot under the same dataset.

### Nominal data

Nominal data is data with no fixed category order and should be sorted from highest to lowest count (left to right, or top to bottom)

By default, R always sorts levels in alphabetical order. To reorder it by a sorted value, you can try ``fct_reorder`` , ``fct_rev``, ``fct_relevel`` in the **forcats** package


```r
library(vcdExtra)
library(ggplot2)
library(forcats)
library(dplyr)

Accident %>%
  group_by(mode) %>%
  summarise(freq = sum(Freq)) %>%
  ggplot(aes(x=fct_reorder(mode,freq,.desc = TRUE),y=freq)) +
  geom_bar(stat = "identity",fill = "cornflowerblue") +
  ggtitle("Number of people with different modes in accident") +
  xlab("") +
  theme(panel.grid.major.x = element_blank())
```

<img src="uni_categorical_var_files/figure-html/unnamed-chunk-1-1.png" width="460.8" style="display: block; margin: auto;" />

… or top to bottom


```r
Accident %>%
  group_by(mode) %>%
  summarise(freq = sum(Freq)) %>%
  ggplot(aes(x=fct_rev(fct_reorder(mode,freq,.desc = TRUE)),y=freq)) +
  geom_bar(stat = "identity",fill = "cornflowerblue") +
  ggtitle("Number of people with different modes in accident") +
  coord_flip() +
  xlab("") +
  theme(panel.grid.major.x = element_blank())
```

<img src="uni_categorical_var_files/figure-html/unnamed-chunk-2-1.png" width="460.8" style="display: block; margin: auto;" />


### Ordinal data

Ordinal data is data having a fixed category order and need to sort it in logical order of the categories (left to right)


```r
Accident %>%
  group_by(age) %>%
  summarise(freq = sum(Freq)) %>%
  ggplot(aes(x=age,y=freq)) +
  geom_bar(stat = "identity",fill = "cornflowerblue") +
  ggtitle("Number of people of different ages in accident") +
  xlab("") +
  theme(panel.grid.major.x = element_blank())
```

<img src="uni_categorical_var_files/figure-html/unnamed-chunk-3-1.png" width="460.8" style="display: block; margin: auto;" />

Sort in logical order of the categories (starting at bottom OR top)


```r
Accident %>%
  group_by(age) %>%
  summarise(freq = sum(Freq)) %>%
  ggplot(aes(x=age,y=freq)) +
  geom_bar(stat = "identity",fill = "cornflowerblue") +
  ggtitle("Number of people of different ages in accident") +
  xlab("") +
  coord_flip() +
  theme(panel.grid.major.x = element_blank())
```

<img src="uni_categorical_var_files/figure-html/unnamed-chunk-4-1.png" width="460.8" style="display: block; margin: auto;" />

## Cleveland dot plot

Cleveland dot plot is a good alternative to bar plots, making plots more readable and comparable even with more data. Similarly, we also need to reorder the categorical variables just like what we've done for nominal bar plot.


```r
library(Lock5withR)
ggplot(USStates, aes(x = IQ, y = fct_reorder(State, IQ))) +
  geom_point(color = "blue") +
  ggtitle("Avg. IQ for US states") +
  ylab("") +
  theme_linedraw()
```

<img src="uni_categorical_var_files/figure-html/unnamed-chunk-5-1.png" width="432" style="display: block; margin: auto;" />

### Cleveland dot plot with multiple dots

Sort by Obese Rate


```r
library(tidyr)
USStates %>%
  select('State','Obese','HeavyDrinkers') %>%
  gather(key='type',value='percentage',Obese,HeavyDrinkers) %>%
  ggplot(aes(x=percentage, y=fct_reorder2(State,type=='Obese',percentage,.desc=FALSE), color = type)) +
  geom_point() +
  ggtitle("Obese rate & heavy drinker rate in US") +
  ylab("") +
  theme_linedraw()
```

<img src="uni_categorical_var_files/figure-html/unnamed-chunk-6-1.png" width="432" style="display: block; margin: auto;" />

### Cleveland dot plot with facets

You can split the graph into small multiples using facet_grid().


```r
ggplot(USStates, aes(x = IQ, y = reorder(State, IQ))) +
  geom_point(color = "blue") +
  facet_grid(Pres2008 ~ ., scales = "free_y", space = "free_y") +
  ggtitle('IQ of US state residents facet by Pres2008') +
  xlab("IQ") +
  ylab('') +
  theme_linedraw() +
  theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank())
```

<img src="uni_categorical_var_files/figure-html/unnamed-chunk-7-1.png" width="432" style="display: block; margin: auto;" />

### Example: How Much People in the Trump Administration Are Worth


```r
# create dot plot theme
theme_dotplot <- 
  theme_bw(16) +
  theme(axis.text.y = element_text(size = rel(.8)), axis.ticks.y = element_blank(),
        axis.title.x = element_text(), axis.text = element_text(face = "bold"),
        plot.background = element_rect(fill = "lightcyan2"),
        panel.background = element_rect(fill = "moccasin"),
        panel.grid.major.x = element_line(size = 0.5),
        panel.grid.major.y = element_line(size = 0.5, color = "lightblue"),
        panel.grid.minor.x = element_blank(),
        strip.text = element_text(size = rel(.7)), legend.position = "top")

# data source:
# NYT, How Much People in the Trump Administration Are Worth
# https://www.nytimes.com/interactive/2017/04/01/us/politics/how-much-people-in-the-trump-administration-are-worth-financial-disclosure.html
df <- read.csv("data/Assets.csv")

# change units to millions
df$Assets <- df$Assets / 1000000

# sort names by assets
df$Name <- reorder(df$Name, df$Assets)

ggplot(df, aes(x = Assets, y = Name)) +
  geom_point() +
  ggtitle("How Much People in the Trump\nAdministration Are Worth") +
  xlab("Assets in Millions $") +
  ylab("") +
  theme_dotplot
```

<img src="uni_categorical_var_files/figure-html/unnamed-chunk-8-1.png" width="672" style="display: block; margin: auto;" />

```r
  # create Panel column
df$Panel <- rep(1:4, each = 9)
df$Panel <- factor(df$Panel, levels = 1:4,
                   labels = c("$18 Million+", "$4 - 12 Million", "$1 - 3.5 Million",
                              "$66k - $604k"))

ggplot(df, aes(x = Assets, y = Name)) +
  geom_point() +
  facet_wrap(~Panel, ncol = 1, scales = "free") +
  ggtitle("How Much People in the Trump\nAdministration Are Worth") +
  xlab("Assets in Millions $") +
  ylab("") +
  theme_dotplot
```

<img src="uni_categorical_var_files/figure-html/unnamed-chunk-8-2.png" width="672" style="display: block; margin: auto;" />



