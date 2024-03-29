% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/print.RaSE.R
\name{print.RaSE}
\alias{print.RaSE}
\title{Print a fitted RaSE object.}
\usage{
\method{print}{RaSE}(x, ...)
}
\arguments{
\item{x}{fitted \code{'RaSE'} model object.}

\item{...}{additional arguments.}
}
\value{
No value is returned.
}
\description{
Similar to the usual print methods, this function summarizes results.
from a fitted \code{'RaSE'} object.
}
\examples{
set.seed(0, kind = "L'Ecuyer-CMRG")
train.data <- RaModel("classification", 1, n = 100, p = 50)
xtrain <- train.data$x
ytrain <- train.data$y

# test RaSE classifier with LDA base classifier
fit <- RaSE(xtrain, ytrain, B1 = 50, B2 = 50, iteration = 0, cutoff = TRUE,
base = 'lda', cores = 2, criterion = 'ric', ranking = TRUE)

# print the summarized results
print(fit)
}
\seealso{
\code{\link{RaSE}}.
}
