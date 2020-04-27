rm(list = ls())

library(tidyverse)
library(rvest)

free_books_url<-"https://towardsdatascience.com/springer-has-released-65-machine-learning-and-data-books-for-free-961f8181f189"
free_books_page <- read_html(free_books_url)

mainText <- free_books_page %>%
  html_nodes('.ih') %>%
  html_text()
mainText <- mainText[-1]

new_urls <- pdf_name <- NULL
for(i in seq_along(mainText)){
  doi <- unlist(str_split(mainText[i], pattern = regex('=')))[3]
  new_urls <- c(new_urls, paste0("https://link.springer.com/content/pdf/", "10.1007/", doi, ".pdf"))
  pdf_name <- c(pdf_name, paste0("book_doi", doi, ".pdf"))
}

for(i in seq_along(new_urls)){
  download.file(new_urls[i], pdf_name[i])
}

