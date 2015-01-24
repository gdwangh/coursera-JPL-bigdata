setwd("D:/workspace/The Caltech-JPL Summer School on Big Data Analytics/Rdataset")

crts_6obj<-read.table("crts_6obj.txt",header=TRUE,sep=";")
summary(crts_6obj)

crts<-crts_6obj[,c(4:23,25)]
dim(crts)
head(crts)

LImp<-filterVarImp(crts[,-18], crts[,18])

rownames(LImp)[which.max(LImp[,"AGN"])]

sapply(names(LImp), function(nm) { 
                                  rownames(LImp)[which.max(LImp[,nm])] 
                                }
       )

sapply(names(LImp), function(nm) { 
                      rownames(LImp)[order(LImp[,nm], decreasing=TRUE)[1:topN]] 
                    }
)


library(ggplot2)
ggplot(data=crts, aes(x=std, y=linear_trend, color=object))+geom_point()
ggplot(data=crts, aes(x=std, y=pdfp, color=object))+geom_point()
ggplot(data=crts, aes(x=std, y=amplitude, color=object))+geom_point()
ggplot(data=crts, aes(x=amplitude, y=percent_amplitude, color=object))+geom_point()
ggplot(data=crts, aes(x=std, y=pdfp, color=object))+geom_point()
ggplot(data=crts, aes(x=kurtosis, y="skew, color=object))+geom_point()
