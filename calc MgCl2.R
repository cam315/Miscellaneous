## A simple function to calculate MgCl2 concentrations in PCR
## Sizhong, 2014-3-10

magnisium <- function(volumn, finalconc,times_buffer =10, Mg_in_buffer = 15, wsolution = 25) {
    finalconc = seq(1.5,5, by = 0.25) # unit mM
    res = vector(mode = "list", length = length(volumn))
for (i in volumn) {
        res[[i]] = (finalconc*i- i/times_buffer*Mg_in_buffer)/wsolution
        names(res[[i]]) = finalconc
    }
return(res)    
}


# remove empty element 

delete.nulls <- function(x.list){ 
    x.list[unlist(lapply(x.list, length) != 0)]
}


# Usage
# volumn: parameter specifying the volumn of the PCR reaction system, e.g. 25µl,50µl;
# finalconc: the final concentration (mM) of MgCl2 you want to reach; 
# times_buffer: the Reaction Buffer solution, for example 10 × Pol Buffer B for OptiTag <br/>from roboklon (see http://www.roboklon.de/pdf/7_en.pdf for this Buffer);
# Mg_in_buffer: the Mg concentration already in buffer, e.g. 10 x Pol Buffer B <br/>(general application, up to 8-10 kb) contains 15 mM MgCl2
# wsolution: the Mg concentration of your stock solution, e.g. 25mM.

# use function

a = magnisium(c(25,50))

b = delete.nulls(a)

# merge to a final data frame

cc = do.call(rbind, b)
rownames(cc) <- paste0(totalvolumn,'µl')

write.table(cc, file='MgCl2_to_be_added.txt',quote=FALSE, sep="\t")

