## boxplot on vectors with different length
## Sizhong, 2012-11-15


## Here is may real example of CH4 emission rates

df1 <- runif(20, min = 0, max = 5)

df2 <- runif(50, min = 10, max = 30)

df3 <- runif(25, min = 7, max = 15)


# put them in a list

z <- list(df1,df2,df3)

# Plot

boxplot(dataList,col=c('pink','bisque','steelblue'),ylab= 'Random data',cex.lab=1.2)

# add quantiles

for (i in 1:length(z)){
  text(x = i+0.5,y = round(fivenum(z[[i]]),2), cex = 0.9,
	labels = round(fivenum(z[[i]]),2),col="blue")
}



