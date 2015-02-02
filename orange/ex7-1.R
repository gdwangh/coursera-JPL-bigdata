setwd("D:/doc/study/JPL summer school big data/coursera-JPL-bigdata/orange")

dat<-read.table("iris.tab", sep="\t", 
                col.names=c("sepal_length","sepal_width","petal_length","petal_width","iris"),
                skip=3)

table(dat$iris)

pairs(dat[,-5], col=dat$iris)
