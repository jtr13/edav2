*This is a page working in progress :)*

# Chapter 1-Learning R

## Getting started

Welcome to the world of EDAV! As you have already known, we will mainly use R through out the course. In an effort to get everyone on the same page, here is a checklist of essentials so you can get up and running. The best resources are scattered in different places online, so bear with links to various sites depending on the topic.

### Top 10 Essentials Checklist

(*r4ds* = [R for Data Science](https://r4ds.had.co.nz/) by Garrett Grolemund and Hadley Wickham, free online)

1.[Install R](https://r4ds.had.co.nz/introduction.html#r){target="_blank"} (r4ds) – You need to have this installed but you won’t open the application since you’ll be working in RStudio. If you already installed R, make sure you’re current! The latest version of R (as of 2022-01-18) is R 4.1.2 “Bird Hippie” released on 2021/11/01.

2.[Install RStudio](https://r4ds.had.co.nz/introduction.html#rstudio){target="_blank"} (r4ds) – Download the free, Desktop version for your OS. Working in this IDE will make working in R much more enjoyable. As with R, stay current. RStudio is constantly adding new features. The latest version (as of 2022-01-18) is RStudio 2021.09.2+382 (“Ghost Orchid”) release notes.

3. [Get comfortable with RStudio](https://b-rodrigues.github.io/modern_R/getting-to-know-rstudio.html){target="_blank"} -- In this chapter of Bruno Rodriguez's *Modern R with the Tidyverse*, you'll learn about panes, options, getting help, keyboard shortcuts, projects, add-ins, and packages. Be sure to try out:

    - Do some math in the console
    - Create an R Markdown file (`.Rmd`) and render it to `.html`
    - Install some packages like `tidyverse` or `MASS`  
    
    Another great option for learning the IDE: Watch [Writing Code in RStudio](https://rstudio.com/resources/webinars/programming-part-1-writing-code-in-rstudio/){target="_blank"} (*RStudio webinar*)

4. Learn ["R Nuts and Bolts"](https://bookdown.org/rdpeng/rprogdatascience/r-nuts-and-bolts.html){target="_blank"} -- Roger Peng's chapter in *R Programming* will give you a solid foundation in the basic building blocks of R. It's worth making the investing in understanding how R objects work now so they don't cause you problems later. Focus on **vectors** and especially **data frames**; matrices and lists don't come up often in data visualization.  Get familiar with R classes: **integer, numeric, character,** and **logical**. Understand how **factors** work; they are very important for graphing.

5. [Tidy up](https://r4ds.had.co.nz/introduction.html#the-tidyverse){target=_blank} (*r4ds*) -- Install the tidyverse, and get familiar with what it is. *We will discuss differences between base R and the tidyverse in class.* 

6. [Learn ggplot2 basics](https://r4ds.had.co.nz/data-visualisation.html){target="_blank"} (*r4ds*) -- In class we will study the grammar of graphics on which **ggplot2** is based, but it will help to familiarize yourself with the syntax in advance. Avail yourself of the "Data Visualization with ggplot2" cheatsheet by clicking "Help" "Cheatsheets..." within RStudio.

7. [Learn some RMarkdown](https://rmarkdown.rstudio.com/articles_intro.html){target="_blank"} -- For this class you will write assignments in R Markdown (stored as `.Rmd` files) and then render them into pdfs for submission. You can jump right in and open a new R Markdown file (*File > New File > R Markdown...*), and leave the `Default Output Format` as `HTML`. You will get a R Markdown template you can tinker with. Click the "knit" button and see what happens. For more detail, watch the RStudio webinar [Getting Started with R Markdown](https://resources.rstudio.com/the-essentials-of-data-science/getting-started-with-r-markdown-60-02) 

8. [Use RStudio projects](https://r4ds.had.co.nz/workflow-projects.html){target="_blank"} (*r4ds*) -- If you haven't already, drink the Kool-Aid. Make each problem set a separate project. You will never have to worry about `getwd()` or `setwd()` again because everything will just be in the right places.
    Or watch the webinar: ["Projects in RStudio"](https://resources.rstudio.com/wistia-rstudio-essentials-2/rstudioessentialsmanagingpart1-2){target="_blank"}

9. [Learn the basic dplyr verbs](https://r4ds.had.co.nz/transform.html){target="_blank"} for data manipulation (*r4ds*) -- Concentrate on the main verbs: **`filter()`** (rows), **`select()`** (columns), **`mutate()`**, **`arrange()`** (rows), **`group_by()`**, and **`summarize()`**. Learn the pipe **`%>%`** operator.

10. Know how to [tidy your data](https://r4ds.had.co.nz/tidy-data.html){target="_blank"} -- The **`pivot_longer()`** function from the **tidyr** package -- successor to **`gather()`** -- will help you get your data in the right form for plotting.  More on this in class. Check out these [super cool animations](https://github.com/gadenbuie/tidyexplain){target="_blank"}, which follow a data frame as it is transformed by `tidyr` functions.