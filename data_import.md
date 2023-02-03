# Data importation

Data is the core to any analysis. In this chapter, we will talk about various ways to import data into R.

## Packages with built in data set

Many of the packages in R have built in data sets. To gain access of the data, call the package and you can access them by the name of the data sets. For example, we can access the `ExerciseHours` data set from `Lock5withR`


```r
library(Lock5withR)
head(ExerciseHours)
```

```
##   Year Gender Hand Exercise TV Pulse Pierces
## 1    4      M    l       15  5    57       0
## 2    2      M    l       20 14    70       0
## 3    3      F    r        2  3    70       2
## 4    1      F    l       10  5    66       3
## 5    1      M    r        8  2    62       0
## 6    1      M    r       14 14    62       0
```

## Data from web

### Read in from URL

Some of the data you found online might be files ended with '.csv' or '.xls'. In this case, you can directly read them using the URL. For example, 


```r
X <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data",
              header = FALSE) #Read in iris data

head(X)
```

```
##    V1  V2  V3  V4          V5
## 1 5.1 3.5 1.4 0.2 Iris-setosa
## 2 4.9 3.0 1.4 0.2 Iris-setosa
## 3 4.7 3.2 1.3 0.2 Iris-setosa
## 4 4.6 3.1 1.5 0.2 Iris-setosa
## 5 5.0 3.6 1.4 0.2 Iris-setosa
## 6 5.4 3.9 1.7 0.4 Iris-setosa
```

Note that this is not a very stable way of reading data as the structure of the website might change, which will result in failure of reading the data.

### API / R API package

Some data sources provide APIs to access their data, for example CDC, Census, and Twitter. However, there is a learning curve in utilizing their APIs. [Best practices for API packages](https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html) will help you to get a head start.

The other option is to find packages that handles the API calls for you. For example:

* CDC data - package [`wonderapi`](https://github.com/socdataR/wonderapi)

* Census data - package [`censusapi`](https://cran.r-project.org/web/packages/censusapi/vignettes/getting-started.html)

* Twitter - package [`rtweet`](https://www.rdocumentation.org/packages/rtweet/versions/0.7.0)

A well-built client will save you a lot of time in retrieving data and should be your first resort.

## Web scraping

Web scraping is mostly considered as the last resort in obtaining data. As we put it in the last section, meaning that you should always explore the possibilities above before turning to web scraping. When scarping, you should 

* think and investigate legal issues

* think about ethical questions

* limit bandwidth use

* scrape only what you need

To start, you will need to know some backgrounds about the structure of a html page. In a webpage, you can always right click -> inspect to check on the structure. Also, as a sanity check, we recommend using package `robotstxt` to see if scarping is allowed on a certain webpage. You can simply feed in the URL into function `paths_allowed()`. We will use the CRAN page for package `forcats` for the scraping example.


```r
library(robotstxt)
library(rvest)
paths_allowed('https://cran.r-project.org/web/packages/forcats/index.html')
```

```
## [1] TRUE
```

### `rvest`

Package `rvest` is widely used for web scraping. In the following example, `read_html()` takes the target webpage URL and `html_table()` extracts all table element in the page.


```r
forcats_data <- read_html("https://cran.r-project.org/web/packages/forcats/index.html") 

forcats_table <- forcats_data %>% html_table()
forcats_table[[1]]
```

```
## # A tibble: 13 × 2
##    X1                X2                                                         
##    <chr>             <chr>                                                      
##  1 Version:          "1.0.0"                                                    
##  2 Depends:          "R (≥ 3.4)"                                                
##  3 Imports:          "cli (≥ 3.4.0), glue, lifecycle, magrittr, rlang (≥ 1.0.0)…
##  4 Suggests:         "covr, dplyr, ggplot2, knitr, readr, rmarkdown, testthat (…
##  5 Published:        "2023-01-29"                                               
##  6 Author:           "Hadley Wickham [aut, cre],\n  RStudio [cph, fnd]"         
##  7 Maintainer:       "Hadley Wickham  <hadley at rstudio.com>"                  
##  8 BugReports:       "https://github.com/tidyverse/forcats/issues"              
##  9 License:          "MIT + file LICENSE"                                       
## 10 URL:              "https://forcats.tidyverse.org/,\nhttps://github.com/tidyv…
## 11 NeedsCompilation: "no"                                                       
## 12 Materials:        "README NEWS"                                              
## 13 CRAN checks:      "forcats results"
```
If you want contents that are not in the table format, you can use `html_nodes()` specifying specific html structure. Namely,

* `h2` tag - `html_nodes("h2")`

* `id` attribute - `html_nodes("#XXX")`

* `class` attribute - `html_nodes(".XXX")`







