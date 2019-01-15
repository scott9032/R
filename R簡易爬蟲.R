# ¦w¸Ë®M¥ó
install.packages(c("httr","jsonlite","xml2","rvest","stringr","dplyr","ggplot2"))

# ¸ü¤J®M¥ó
library(httr)
library(jsonlite)
library(xml2)
library(rvest)
library(stringr)
library(dplyr)
library(ggplot2)

# Â^¨úºô¯¸
udn <- GET("https://udn.com/news/breaknews/1")

# Æ[¹îºô­¶¤º®e
content(udn, "text")
udn

# Åª¨úhtml¤º®e
udn_html <- read_html(udn)
udn_html

# §ì¨úµo¤å®É¶¡©MÆ[¬Ý¦¸¼Æ
udn_time <- html_nodes(udn_html, ".dt")
udn_time <- html_text(udn_time)
udn_time
udn_view <- html_nodes(udn_html, ".view")
udn_view <- html_text(udn_view)
udn_view

# Àx¦s¸ê®Æ
udn_df <- data.frame(
  udn_time = udn_time,
  udn_view = as.numeric(udn_view)
)
View(udn_df)

# ±Æ§Ç¸ê®Æ‡æ
udn_df_arrange <- arrange(udn_df, desc(udn_view))
View(udn_df_arrange)

# Ã¸»s¸ê®Æ
ggplot(udn_df_arrange, aes(udn_time, udn_view)) + 
  geom_bar(stat = "identity") +
  theme(text = element_text(family = "STHeiti"))
