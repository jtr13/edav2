# Data transformation

Plotting a graph is easy. You just need to find the right library with the right function. However, it is sometimes not so easy to get your data into the form desired to generate a graph. In this chapter, we will cover some basic techniques in tidying data with `ggplot2`.

## What is tidy data?

Here's the definition of Tidy Data given by Hadley Wickham:

>A dataset is messy or tidy depending on how rows, columns and tables are matched up with observations, variables and types. In tidy data:
>
>* Each variable forms a column.
>
>* Each observation forms a row.
>
>* Each observational unit forms a value in the table.
>
*See [r4ds on tidy data](https://r4ds.had.co.nz/tidy-data.html){target="_blank"} for more info.*

**What are the advantages of tidy data?**

* Uniformity : It is easier to learn the tools that work with the data because they have a consistent way of storing data.

* Most built-in R functions work with vectors of values. Thus, having variables as columns/vectors allows R’s vectorized nature to shine.

**Take a look at the following data and can you tell whether this data is messy or not?**

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

* In this data set,all the variables are parameters of cars. This means that they are not different variables, but are values of a common variable.

To transform the data, we use `pivot_longer`.

## `pivot_longer`


```r
mtcars %>%  
  rownames_to_column("carname") %>%
  pivot_longer(cols = !carname, names_to = "Parameters",values_to = "value") %>%
  head()
```

```
## # A tibble: 6 × 3
##   carname   Parameters  value
##   <chr>     <chr>       <dbl>
## 1 Mazda RX4 mpg         21   
## 2 Mazda RX4 cyl          6   
## 3 Mazda RX4 disp       160   
## 4 Mazda RX4 hp         110   
## 5 Mazda RX4 drat         3.9 
## 6 Mazda RX4 wt           2.62
```
Follow the simple two steps:

* Identify the column you want to keep as is. In this case, we want all variables to match car names.

* **Additionally**, notice that in the original data set, `carname` acts as the index of the data set. You would want to convert the index to a column using `rownames_to_column`.

* Create meaningful names for the two new columns. In our case, straightforwardly, column names go into `parameters` and corresponding values go into `value`.


## `pivot_wider`

`pivot_wider` is just the opposite of `pivot_longer`. Using `pivot_wider`, we can just transform our tidy data back into the messy form as all distinct value in `Parameters` will become column names. 

`pivot_wider` is often used in the case such that one observation being recorded over multiple rows. Consider the following example:


```
## # A tibble: 4 × 3
##   Country Type  Number
##   <chr>   <chr>  <dbl>
## 1 USA     Case       4
## 2 USA     Death      3
## 3 Canada  Case       2
## 4 Canada  Death      1
```


```r
example %>% pivot_wider(names_from = Type, values_from = Number)
```

```
## # A tibble: 2 × 3
##   Country  Case Death
##   <chr>   <dbl> <dbl>
## 1 USA         4     3
## 2 Canada      2     1
```

It would make much more sense if `Case` and `Death` are separate features.

The main focus of this chapter is `pivot_longer` and `pivot_wider`. However, other fundamental functions in `dplyr` are also very important in manipulating your data set. In the following section, we will give an overview of the basics.

## Basic `dplyr` functions

