copy <- function() {
  file <- readLines("style/joyce_temp.R")
  writeLines(file, "style/joyce.theme")
}