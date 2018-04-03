## how to make 1×PBS or n×PBS for experiment? 
## see instruction how to make PBS at
## http://cshprotocols.cshlp.org/content/2006/1/pdb.rec8247
## Sizhong, 2013-5-10


# 1000ml 1×PBS contains:

#§	8g of NaCl
#§	0.2g of KCl
#§	1.44g of Na2HPO4
#§	0.24g of KH2PO4 


# Tiny function to calculate the amount of chemicals needed

recip <- function(vol,times=1){
  NaCl <- 8*vol/1000*times
  KCl <- 0.2*vol/1000*times
  Na2HPO4 <- 1.44*vol/1000*times
  KH2PO4 <- 0.24*vol/1000*times
  data <- data.frame(rbind(NaCl, KCl, Na2HPO4, KH2PO4))
  names(data) <- paste0(vol, 'ml')
  return(data)
}


# Example

vol <- seq(100, 1000, by = 50)

recip(vol,times=1)
recip(vol,times=10)


