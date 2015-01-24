# setwd("D:/workspace/The Caltech-JPL Summer School on Big Data Analytics/Rdataset")
setwd("D:/doc/study/JPL summer school big data/Rdataset")

# data set comprised of 1258 total column CO2 concentrations.
load("XCO2.RData")
N<-length(XCO2)
B<-1000

# 1.(a)
# X^2(3) distribution means: chi-squared distribution with df=3
dchi<-matrix(rchisq(n=N*B, df=3, ncp = 0), nrow=B, ncol=N)

# theory q.95 = 7.814728
qchisq(p=0.95, df=3, ncp = 0, lower.tail = TRUE, log.p = FALSE)

q95_population<-function(data) {
  q95<-apply(X=data,MARGIN=1,FUN=function(d) { quantile(x=d, probs=0.95) })
  #(q95-mean(q95))/(max(q95-min(q95)))
  q95
}

q95_popu<-q95_population(data=dchi)

# (b)

q95_sampling<-function(data,size, repN, replace) {
  q95<-rep(NA, repN)
  
  for (i in c(1:repN)) {
    sub_df<-sample(x=data, size,replace)
    q95[i]<-quantile(x=sub_df, probs=0.95)
  }
  #(q95-mean(q95))/(max(q95)-min(q95))
  q95
}

rchi<-rchisq(n=N, df=3, ncp = 0)

q95_norb<-q95_sampling(data=rchi, size=N, repN=B, replace=TRUE)   # normal bootrap
q95_MoNb<-q95_sampling(data=rchi, size=N^(2/3), repN=B, replace=TRUE)  # M out of N bootrap
q95_subS<-q95_sampling(data=rchi, size=N^(2/3), repN=B, replace=FALSE) # subsampling

x_range<-range(q95_popu, q95_popu, q95_MoNb, q95_subS)
y_range<-range(hist(q95_popu,plot=FALSE)$counts,
               hist(q95_norb,plot=FALSE)$counts,
               hist(q95_MoNb,plot=FALSE)$counts,
               hist(q95_subS,plot=FALSE)$counts)
par(mfrow = c(2, 2))

hist(q95_popu,breaks=50, xlim = x_range,ylim=y_range)
hist(q95_norb,breaks=50, xlim = x_range,ylim=y_range)
hist(q95_MoNb,breaks=50, xlim = x_range,ylim=y_range)
hist(q95_subS,breaks=50, xlim = x_range,ylim=y_range)


# 2
# a
par(mfrow = c(1, 1))
hist(XCO2)
q95_XCO2<-quantile(x=XCO2, probs=0.95)

# b
q95_norb_XCO2<-q95_sampling(data=XCO2, size=N, repN=B, replace=TRUE)   # normal bootrap
q95_MoNb_XCO2<-q95_sampling(data=XCO2, size=N^(2/3), repN=B, replace=TRUE)  # M out of N bootrap
q95_subS_XCO2<-q95_sampling(data=XCO2, size=N^(2/3), repN=B, replace=FALSE) # subsampling

x_range<-range(q95_norb_XCO2, q95_MoNb_XCO2, q95_subS_XCO2)
y_range<-range(hist(q95_norb_XCO2,plot=FALSE)$counts,
               hist(q95_MoNb_XCO2,plot=FALSE)$counts,
               hist(q95_subS_XCO2,plot=FALSE)$counts)

par(mfrow = c(2, 2))

hist(XCO2,breaks=50)
hist(q95_norb_XCO2,breaks=50, xlim = x_range,ylim=y_range)
hist(q95_MoNb_XCO2,breaks=50, xlim = x_range,ylim=y_range)
hist(q95_subS_XCO2,breaks=50, xlim = x_range,ylim=y_range)

