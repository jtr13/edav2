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

`pivot_wider` is just the opposite of `pivot_longer`. Using `pivot_wider`, we can transform our tidy data back into the messy form as all distinct values in `Parameters` will become column names. 

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

## Basic transformation functions

For the following sections, we will use data set `biopsy` from `MASS` for demonstration purpose.


```
##        ID V1 V2 V3 V4 V5 V6 V7 V8 V9     class
## 1 1000025  5  1  1  1  2  1  3  1  1    benign
## 2 1002945  5  4  4  5  7 10  3  2  1    benign
## 3 1015425  3  1  1  1  2  2  3  1  1    benign
## 4 1016277  6  8  8  1  3  4  3  7  1    benign
## 5 1017023  4  1  1  3  2  1  3  1  1    benign
## 6 1017122  8 10 10  8  7 10  9  7  1 malignant
```

### `rename`

Upon getting the data, we noticed that the names of the columns are very vague. After reading the documentation, we wanted to change the names of the column so that the viewer gets a sense of the values they’re referring to. We use `rename` to modify the column names.


```r
biopsy_new <- rename(biopsy,
       thickness = V1,cell_size = V2,
       cell_shape = V3, marg_adhesion = V4,
       epithelial_cell_size = V5, bare_nuclei = V6,
       chromatin = V7, norm_nucleoli = V8, mitoses = V9)

head(biopsy_new)
```

```
##        ID thickness cell_size cell_shape marg_adhesion epithelial_cell_size
## 1 1000025         5         1          1             1                    2
## 2 1002945         5         4          4             5                    7
## 3 1015425         3         1          1             1                    2
## 4 1016277         6         8          8             1                    3
## 5 1017023         4         1          1             3                    2
## 6 1017122         8        10         10             8                    7
##   bare_nuclei chromatin norm_nucleoli mitoses     class
## 1           1         3             1       1    benign
## 2          10         3             2       1    benign
## 3           2         3             1       1    benign
## 4           4         3             7       1    benign
## 5           1         3             1       1    benign
## 6          10         9             7       1 malignant
```

### `select`

`select` is column-wise operation. Specifically, only the columns that are specified will be returned.

In the biopsy data, we do not require the variables “chromatin” and “mitoses”. So, let’s drop them using a minus sign:


```r
#selecting all except the columns chromatin and mitoses
biopsy_new <- biopsy_new %>% dplyr::select(-chromatin,-mitoses)

head(biopsy_new,5)
```

```
##        ID thickness cell_size cell_shape marg_adhesion epithelial_cell_size
## 1 1000025         5         1          1             1                    2
## 2 1002945         5         4          4             5                    7
## 3 1015425         3         1          1             1                    2
## 4 1016277         6         8          8             1                    3
## 5 1017023         4         1          1             3                    2
##   bare_nuclei norm_nucleoli  class
## 1           1             1 benign
## 2          10             2 benign
## 3           2             1 benign
## 4           4             7 benign
## 5           1             1 benign
```

### `mutate`

The **mutate** function computes new variables from the already existing variables and adds them to the dataset. It gives information that the data already contained but was never displayed.

The variable `bare_nucleus` contains the values  from 1.00 to 10.00. If we wish to normalize the variable, we can use the mutate function:


```r
#normalize the bare nuclei values 
maximum_bare_nuclei<-max(biopsy_new$bare_nuclei,na.rm=TRUE)
biopsy_new <- biopsy_new %>% mutate(bare_nuclei=bare_nuclei/maximum_bare_nuclei)

head(biopsy_new,5)
```

```
##        ID thickness cell_size cell_shape marg_adhesion epithelial_cell_size
## 1 1000025         5         1          1             1                    2
## 2 1002945         5         4          4             5                    7
## 3 1015425         3         1          1             1                    2
## 4 1016277         6         8          8             1                    3
## 5 1017023         4         1          1             3                    2
##   bare_nuclei norm_nucleoli  class
## 1         0.1             1 benign
## 2         1.0             2 benign
## 3         0.2             1 benign
## 4         0.4             7 benign
## 5         0.1             1 benign
```

In some situations, your new variable might involve conditions. You can consider using `case_when` combined with `mutate`.

### `select`

**Filter** is a row-wise operation. It returns a modified copy that contains only certain rows. This function filters rows based on conditions supplied in its argument. The filter function takes the data frame as the first argument. The next argument contains one or more logical tests. The rows/observations that pass these logical tests are returned in the result of the filter function.

For our example, say we only want the data of those tumor cells that have clump thickness greater than 6.


```r
biopsy_new <- biopsy_new %>% filter(thickness>5.5)

head(biopsy_new,5)
```

```
##        ID thickness cell_size cell_shape marg_adhesion epithelial_cell_size
## 1 1016277         6         8          8             1                    3
## 2 1017122         8        10         10             8                    7
## 3 1044572         8         7          5            10                    7
## 4 1047630         7         4          6             4                    6
## 5 1050670        10         7          7             6                    4
##   bare_nuclei norm_nucleoli     class
## 1         0.4             7    benign
## 2         1.0             7 malignant
## 3         0.9             5 malignant
## 4         0.1             3 malignant
## 5         1.0             1 malignant
```

If you want to filter using multiple conditions, use logical operators: &(And), |(Or).

### `arrange`

**Arrange** reorders the rows of the data based on their contents in the ascending order by default.

Say in our example, the doctors would want to view the data in the order of the cell size of the tumor.


```r
#arrange in the order of V2:cell size
head(arrange(biopsy_new,cell_size))
```

```
##        ID thickness cell_size cell_shape marg_adhesion epithelial_cell_size
## 1 1050718         6         1          1             1                    2
## 2 1204898         6         1          1             1                    2
## 3 1223967         6         1          3             1                    2
## 4  543558         6         1          3             1                    4
## 5   63375         9         1          2             6                    4
## 6  752904        10         1          1             1                    2
##   bare_nuclei norm_nucleoli     class
## 1         0.1             1    benign
## 2         0.1             1    benign
## 3         0.1             1    benign
## 4         0.5            10 malignant
## 5         1.0             7 malignant
## 6         1.0             4 malignant
```

In case you want your data in descending order, wrap your variable with `desc()`.

### `group_by` and `summarize`

The **summarize** function uses the data to create a new data frame with the summary statistics such as minimum, maximum, average, and so on. These statistical functions must be aggregate functions which take a vector of values as input and output a single value.

The **group_by** function groups the data by the values of the variables. This, along with summarize, makes observations about groups of rows of the dataset.

The doctors would want to see the maximum cell size and the thickness for each of the classes: benign and malignant. This can be done by grouping the data by class and finding the maximum of the required variables:


```r
biopsy_grouped <- group_by(biopsy_new,class)
summarize(biopsy_grouped, max(thickness), mean(cell_size), var(norm_nucleoli))
```

```
## # A tibble: 2 × 4
##   class     `max(thickness)` `mean(cell_size)` `var(norm_nucleoli)`
##   <fct>                <int>             <dbl>                <dbl>
## 1 benign                   8              2.67                 5.93
## 2 malignant               10              6.73                11.3
```
