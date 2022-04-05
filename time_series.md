# Time series

Time series, by definition, is a sequence of data point collected over a certain period of time. In this chapter, we will demonstrate several useful ways of plotting time-series data and how to processing ``date`` data type in R.


## Dates

Since time series analysis looks into how data is changing over time, the very first step is to transform the data into correct format.

### Basic R functions

You can convert character data to ``Date`` class with ``as.Date()``:


```r
dchar <- "2018-10-12"
ddate <- as.Date(dchar)
class(dchar)
```

```
## [1] "character"
```

```r
class(ddate)
```

```
## [1] "Date"
```
You can also specifying the format by:


```r
as.Date("Thursday, January 6, 2005", format = "%A, %B %d, %Y")
```

```
## [1] "2005-01-06"
```
Here is a list of the conversion specifications for date format from [this post](https://michaeltoth.me/the-ultimate-opinionated-guide-to-base-r-date-format-functions.html)

<center>
![](images/common_r_date_formats.png){width=75%}
</center>


## Multiple time series

For time-series dataset, line plots are mostly used with time on the x-axis. 

```r
library(dplyr)
library(readxl)
library(tidyr)
library(ggplot2)
df <- read_excel("data/historicalweeklydata.xls", 
    col_types = c("date", "numeric", "numeric", 
        "numeric"))

df <- df %>% pivot_longer(cols = -c("Week"), names_to = "TYPE") %>%
  mutate(TYPE = forcats::fct_reorder2(TYPE, Week, value))# puts legend in correct order

ggplot(df, aes(Week, value, color = TYPE)) +
  geom_line() +
  ggtitle("U.S. Mortgage Rates") +  labs (x = "", y = "percent") +
  theme_grey(16) +
  theme(legend.title = element_blank())
```

<img src="time_series_files/figure-html/unnamed-chunk-3-1.png" width="576" style="display: block; margin: auto;" />


```r
library(lubridate)
df2010 <- df %>% filter(year(Week) == 2010)
ggplot(df2010, aes(Week, value, color = TYPE)) +
  geom_line() +
  ggtitle("U.S. Mortgage Rates")
```

<img src="time_series_files/figure-html/unnamed-chunk-4-1.png" width="576" style="display: block; margin: auto;" />
