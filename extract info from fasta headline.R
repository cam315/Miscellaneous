##--------------------------------------------------------------
## Extract ACC and Speices name from headline of ls_orchid.fasta 
## by using regular expression
## Sizhong, 2013-1-10, Potsdam
##--------------------------------------------------------------

# input fasta file

url <- 'https://raw.githubusercontent.com/biopython/biopython/master/Doc/examples/ls_orchid.fasta'

download.file(url,f <- tempfile())

a <- readLines(f)

#check the inputted fasta file

a[1:10] 

# you can find headline is always the 1,3,5...lines,

# fasta file headlines start with '>'

aa <- a[grep('^>',a)] 

# a function to get part for this structured data

getData <- function(line){
   gi = gsub(">gi\\|(\\d+)\\|(.*)",'\\1',line)
   emb = gsub(">gi\\|(\\d+)\\|emb\\|(.*?)\\|(.*)",'\\2',line)
   species = gsub(">(\\S+)\\s+?(.*?)\\s+?(.*)",'\\2',line)
   gene = gsub(">(\\S+)\\s+?(.*?)\\s+?(.*)",'\\3',line)
   df =  data.frame(gi,emb, species, gene)
   return(df)
}

# use the function

s = getData(aa)