# 安裝套件
install.packages(c("httr","jsonlite","xml2","rvest","stringr","dplyr","ggplot2"))

# 載入套件
library(httr)
library(jsonlite)
library(xml2)
library(rvest)
library(stringr)
library(dplyr)
library(ggplot2)

# 擷取網站
udn <- GET("https://udn.com/news/breaknews/1")

# 觀察網頁內容
content(udn, "text")
udn

# 讀取html內容
udn_html <- read_html(udn)
udn_html

# 抓取發文時間和觀看次數
udn_time <- html_nodes(udn_html, ".dt")
udn_time <- html_text(udn_time)
udn_time
udn_view <- html_nodes(udn_html, ".view")
udn_view <- html_text(udn_view)
udn_view

# 儲存資料
udn_df <- data.frame(
  udn_time = udn_time,
  udn_view = as.numeric(udn_view)
)
View(udn_df)

# 排序資料
udn_df_arrange <- arrange(udn_df, desc(udn_view))
View(udn_df_arrange)

# 繪製資料
ggplot(udn_df_arrange, aes(udn_time, udn_view)) + 
  geom_bar(stat = "identity") +
  theme(text = element_text(family = "STHeiti"))
