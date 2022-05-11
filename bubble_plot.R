
### Example script generating bubble plot with ggplot2 package
### Sizhong Yang
### GreenGate Genomics
### May 11, 2022

## load packages
library(ggplot2)
library(reshape2)

##  Step1, read in data

df = read.table('example_data_fungi.tsv', header=TRUE, sep="\t") 

## Step2, convert to percentage

per = sweep(df[,-1], 2, colSums(df[,-1]),"/")*100

## Add a new column by CAZyFamily

per$CAZy = df$CAZy

per$CAZyFamily = gsub('\\d+', '', per$CAZy)

## Step3, convert to long format using melt function of package reshape2

per.m = melt(per, id.vars = c('CAZy', 'CAZyFamily'), variable.name = 'Samples', value.name = "Relabund")
dim(per.m)
head(per.m)

## Step4, check new data and manipulate features

summary(per.m$Relabund)  ## Summary information of Relative abundance

per.m$Samples = factor(per.m$Samples, levels = c("OD2","ID2","OD3","ID3","OD5","ID5"))

## Step5, Generate plot object with ggplot2

p = ggplot(data = per.m, aes(x = Samples, y = CAZy, size = Relabund, fill=CAZy)) + 
	geom_point(data=subset(per.m, Relabund>0), na.rm=TRUE,shape=21)+ 
	ggtitle(paste("Bubble plot for Fungi CAZy",Sys.time()))

print(p)

p2 = ggplot(data = per.m, aes(x = Samples, y = CAZy, size = Relabund, fill=CAZy)) + 
	geom_point(data=subset(per.m, Relabund>0), na.rm=TRUE,shape=21)+ 
	ggtitle(paste("Bubble plot for Fungi CAZy",Sys.time())) +
	xlab("") + ylab("CAZy family") + 
	theme_bw() + 
	theme(title = element_text(size = 8, face="plain"),
		axis.title = element_text(size = 20, face="bold"),
		axis.text.x = element_text(size=16,angle = 0, vjust = 0.5,hjust = 0.5,face="bold",color='black'), 
		axis.text.y = element_text(size=16,face="plain",color='black'),
		legend.title = element_text(colour="black", size=14, face="bold"),
		legend.text = element_text(size=12, face="bold")) + 
	scale_size(range = c(0.5, 20), breaks = c(0.5,1.5,10,25,50,65))+
	guides(fill = 'none') +
	guides(size=guide_legend("Relative\nAbundance\n(%)"))

print(p2)

## facet by CAZyFamily

p2 + facet_grid(CAZyFamily~., scales = 'free',space = "free") + 
	theme(strip.text = element_text(colour="black", size=16, face="bold"))

## save plot to a vector plot, here we use pdf devices

ggsave(file = "test.pdf", device = "pdf")



