## convert lower triangular matrix to long format data frame with 3 columns
## Sizhong Yang, 2013-3-18, Potsdam

convert <- function(input, colname=c("sp1","sp2","dist"), digs =4,...){
    # digs specifies the number of decimal places
    if(!is.matrix(input) | !is.data.frame(input)) input = as.matrix(input)
    x <- data.frame(matrix(data=NA,ncol=3,byrow=T))
    name <- rownames(input)
    #name <- gsub(" ", "",name)
    n <- length(name)
    q = 1
    for (i in(1:n)){ 
        for (j in (1:i-1)){
            spa <- name[i]  
            spb <- name[j] 
            value <- round(input[i,j], digits = digs)
            x[q,1:3] <- c(spa,spb,value)
            q = q+1
         }
       x
	colnames(x) <- colname
     }
   x <- x[x[,1] != x[,2], ] #remove self-correlated rows
   x[with(x, order(sp1, sp2)), ] # order the data frame
 }


# use the function

df = matrix(rnorm(25), 5); 
colnames(df) <- rownames(df) <- letters[1:5] 
p <- dist(df)

convert(p)
