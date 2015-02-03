# Exercise 1: Get Familiar with Random Forests (RF) in R

# Install the Random Forest (RF) package if necessary
install.packages("randomForest")
# load the RF package
library(randomForest)
# take a look at the iris data
head(iris)
# take a look at the class labesl
table(iris$Species)
# Define the design matrix and the classifciation target
X <-iris[, 1:4]
Y <-iris$Species
# Learn a RF model
rf <-randomForest(x=X, y=Y, ntree=200, do.trace=T)
# Print results
rf
# Plot convergence of outofbag error
plot(rf)
# investigate the vairable importance
importance(rf)
barplot(t(importance(rf)), col=4)

# Exercise 2: Random Forests for Space Exploration
# 1. Download and unzip the surface feature dataset of comet Hartley 2: http://bit.ly/1ACSlHu
setwd("D:/doc/study/JPL summer school big data/coursera-JPL-bigdata/Rdataset")

# 2. Load the data into R
dat <- dget("patchesHartley2.rdat")
str(dat)

# 3. Extract the target variable Y from the data structure
Y <- sapply(dat, function(x) x$Y)
Y <- as.factor(Y)
table(Y)

# 4. Create a design matrix X by extract features from the grayscale patches. 
# Start by using a vector of raw grayscale values. For example:
X <- matrix(nrow=length(dat), ncol=length(as.vector(dat[[1]]$gray)))

for (i in 1:length(dat)) 
{
  X[i,] <- as.vector(dat[[i]]$gray)
}

# 5. Train a random forest to differentiate true from false surface features
library(randomForest)
rf <-randomForest(x=X, y=Y)
rf
plot(rf)

# 6. Investigate the feature importance to decide which features make sense and which do not.
importance(rf)

# 7. Report the OOB error of your model on Google Hangout to compare with other students.
rf # 6.7%

# 8. Add new features to the design matrix and go back to 5
X2 <- matrix(nrow=length(dat), ncol=length(as.vector(dat[[1]]$gray))+length(as.vector(dat[[1]]$median)))

for (i in 1:length(dat)) 
{
  X2[i,] <- c(as.vector(dat[[i]]$gray), as.vector(dat[[i]]$median))
}

rf2 <-randomForest(x=X2, y=Y)
rf2 #  6.65%

X3 <- matrix(nrow=length(dat), ncol=length(as.vector(dat[[1]]$gray))+length(as.vector(dat[[1]]$rect)))

for (i in 1:length(dat)) 
{
  X3[i,] <- c(as.vector(dat[[i]]$gray), as.vector(dat[[i]]$rect))
}

rf3<-randomForest(x=X2, y=Y)
rf3  # 6.56%

# Bonus Tasks:
# 1. Plot an ROC curve based on the confidence of the classifier to see its performance.

install.packages("Epi")
library(Epi)
ROC(form=Y~X, plot="ROC")


install.packages("ROCR")
library(ROCR)


# 2. Compare the ROC curves of different models in the same plot

image(dat[[100]]$gray)
      
