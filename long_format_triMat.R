## convert lower triangular matrix to long format data frame with 3 columns
## Sizhong Yang, 2013-3-18, Potsdam

convert <- function(triMatrix, colname=c("sp1","sp2","dist"), digs =4,...){
    # digs specifies the number of decimal places
    if(!is.matrix(triMatrix) | !is.data.frame(triMatrix)) triMatrix = as.matrix(triMatrix)
    x <- data.frame(matrix(data=NA,ncol=3,byrow=T))
    name <- rownames(triMatrix)
    #name <- gsub(" ", "",name)
    n <- length(name)
    q = 1
    for (i in(1:n)){ 
        for (j in (1:i-1)){
            spa <- name[i]  
            spb <- name[j] 
            value <- round(triMatrix[i,j], digits = digs)
            x[q,1:3] <- c(spa,spb,value)
            q = q+1
         }
       x
	colnames(x) <- colname
     }
   x <- x[x[,1] != x[,2], ] #remove self-correlated rows
   x[with(x, order(sp1, sp2)), ] # order the data frame
   invisible(x)
 }

# for very large distrance matrix, the function below is more efficient

fastConvert <- function(dist,colname=c("sp1","sp2","dist"),...){
  if(!require("reshape2")){ 
    install.packages("reshape2")
    library(reshape2)
  }  
  m <- as.matrix(dist)
  m2 <- melt(m)[melt(upper.tri(m))$value,]
  names(m2) <- colname
  invisible (m2)
}


# ----------
# Examples
# ----------

# For small distrance matrix

df = matrix(rnorm(25), 5); 
colnames(df) <- rownames(df) <- letters[1:5] 
p <- dist(df)

test = convert(p)
test

# for large distance matrix, 'fastConvert' is recommended

df = matrix(rnorm(10000), 100)
colnames(df) <- rownames(df) <- paste0('s',seq(1,100)) 
p <- dist(df)

ptm <- proc.time()
test = convert(p)
head(test)
proc.time() - ptm

ptm <- proc.time()
test = fastConvert(p)
head(test)
proc.time() - ptm

