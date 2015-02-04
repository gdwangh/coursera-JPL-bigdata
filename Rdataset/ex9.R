install.packages("MASS")

# setwd("D:/workspace/The Caltech-JPL Summer School on Big Data Analytics/coursera-JPL-bigdata/Rdataset")
setwd("D:/doc/study/JPL summer school big data/coursera-JPL-bigdata/Rdataset")
cid<-read.table("Thompson_data/Citrus_Identification_Data.txt",sep=",",header = TRUE)
ciw<-read.table("Thompson_data/Citrus_Identification_Wavelengths.txt",sep=",")
cvd<-read.table("Thompson_data/Citrus_Varieties_Data.txt",sep=",",header = TRUE)
cvw<-read.table("Thompson_data/Citrus_Varieties_Wavelengths.txt",sep=",")

# Plot a few example spectra from random rows
reflectance11<-cid[1,c(4:429)]
reflectance12<-cid[22,c(4:429)]
wavelength<-ciw[,1]
y_rng<-range(reflectance11, reflectance12)
plot(wavelength, reflectance11,type="l", col="red",ylim=y_rng)
lines(wavelength, reflectance12,type="l", col="blue",ylim=y_rng)


wavelength1<-cid[,22]
wavelength2<-cid[,33]
plot(wavelength1, wavelength2)

# Perform a Principal Component Analysis (PCA).
X=cid[,c(4:429)]

library(caret)
nsv<-nearZeroVar(X)
cidPC<-preProcess(X[,-nsv],method="pca")
head(cidPC$rotation)
V<- cidPC$rotation
plot(V[,1], V[,3])

