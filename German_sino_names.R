# Script to get commonly-used German names to Chinese via Wiki
# Sizhong Yang, July 12, 2017

library(RCurl)
library(XML)

# Function 1
Names <- function(url){
  htm <- getURLContent(url, .encoding='UTF-8')
  doc = htmlParse(htm) # 在用htmlParse解析为DOM文件
  name = xpathSApply(doc,"//div[@style='-moz-column-count: 2']//ul//li",xmlValue)
  return(name)
  Sys.sleep(time=3)
}

# Function 2, get names of multiple queires

multiNames <- function(URLpre,URLpost, ...){
  n = length(URLpost)
  result <- vector('list', length = n)
  result <- lapply(1:n, function(i) Names(url = paste0(URLpre,URLpost[i],')')))
  onevector = Reduce(c,result) # here 'c' is function of 'concatenate'
  return(onevector)
}

# How to use the function

pre = "https://zh.wikipedia.org/wiki/德语姓名列表_("

s = multiNames(pre, LETTERS[1:26])

# To write out, UTF-8 needs 'useBytes=TRUE' 
writeLines(s, con = 'German-Sino-name.txt',useBytes=TRUE)

