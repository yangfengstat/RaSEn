## ---- echo = FALSE------------------------------------------------------------
library(formatR)

## ---- eval=FALSE--------------------------------------------------------------
#  install.packages("RaSEn", repos = "http://cran.us.r-project.org")

## -----------------------------------------------------------------------------
library(RaSEn)

## -----------------------------------------------------------------------------
set.seed(0, kind = "L'Ecuyer-CMRG")
train.data <- RaModel("classification", 1, n = 100, p = 50)
test.data <- RaModel("classification", 1, n = 100, p = 50)
xtrain <- train.data$x
ytrain <- train.data$y
xtest <- test.data$x
ytest <- test.data$y

## ---- tidy=TRUE, tidy.opts=list(width.cutoff=70)------------------------------
library(ggplot2)
ggplot(data = data.frame(xtrain, y = factor(ytrain)), mapping = aes(x = X1, y = X2, color = y)) + geom_point()

## ---- tidy=TRUE, tidy.opts=list(width.cutoff=80)------------------------------
ggplot(data = data.frame(xtrain, y = factor(ytrain)), mapping = aes(x = X6, y = X7, color = y)) + geom_point()

## ---- tidy=TRUE, tidy.opts=list(width.cutoff=70)------------------------------
fit.lda <- Rase(xtrain, ytrain, B1 = 100, B2 = 50, iteration = 0, base = "lda", cores = 2, criterion = "ric")
fit.qda <- Rase(xtrain, ytrain, B1 = 100, B2 = 50, iteration = 0, base = "qda", cores = 2, criterion = "ric")
fit.knn <- Rase(xtrain, ytrain, B1 = 100, B2 = 50, iteration = 0, base = "knn", cores = 2, criterion = "loo")
fit.logistic <- Rase(xtrain, ytrain, B1 = 100, B2 = 50, iteration = 0, base = "logistic", cores = 2, criterion = "ric")

## ---- tidy=TRUE, tidy.opts=list(width.cutoff=70)------------------------------
print(fit.lda)

## ---- tidy=TRUE, tidy.opts=list(width.cutoff=70)------------------------------
er.lda <- mean(predict(fit.lda, xtest) != ytest)
er.qda <- mean(predict(fit.qda, xtest) != ytest)
er.knn <- mean(predict(fit.knn, xtest) != ytest)
er.logistic <- mean(predict(fit.logistic, xtest) != ytest)
cat("LDA:", er.lda, "QDA:", er.qda, "knn:", er.knn, "logistic:", er.logistic)

## ---- tidy=TRUE, tidy.opts=list(width.cutoff=70)------------------------------
library(gridExtra)
plot_lda <- RaPlot(fit.lda)
plot_qda <- RaPlot(fit.qda)
plot_knn<- RaPlot(fit.knn)
plot_logistic <- RaPlot(fit.logistic)

grid.arrange(plot_lda, plot_qda, plot_knn, plot_logistic, ncol=2)


## ---- tidy=TRUE, tidy.opts=list(width.cutoff=70)------------------------------
fit.super <- Rase(xtrain = xtrain, ytrain = ytrain, B1 = 100, B2 = 50, base = c("knn", "lda", "logistic"), super = list(type = "separate", base.update = T), criterion = "cv", cv = 5, iteration = 0, cores = 2)
ypred <- predict(fit.super, xtest)
mean(ypred != ytest)

## ---- tidy=TRUE, tidy.opts=list(width.cutoff=70)------------------------------
fit.super$ranking.feature
fit.super$ranking.base

## -----------------------------------------------------------------------------
train.data <- RaModel("screening", 1, n = 100, p = 100)
xtrain <- train.data$x
ytrain <- train.data$y

## ---- tidy=TRUE, tidy.opts=list(width.cutoff=70)------------------------------
fit.bic <- RaScreen(xtrain, ytrain, B1 = 100, B2 = 100, model = "lm", criterion = "bic", cores = 2, iteration = 1)

## ---- tidy=TRUE, tidy.opts=list(width.cutoff=70)------------------------------
RaRank(fit.bic, selected.num = "n/logn", iteration = 0)
RaRank(fit.bic, selected.num = "n/logn", iteration = 1)

## ---- tidy=TRUE, tidy.opts=list(width.cutoff=70)------------------------------
RaRank(fit.bic, selected.num = "n-1", iteration = 1)

