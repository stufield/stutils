% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bootstrap.R
\name{bootstrap}
\alias{bootstrap}
\title{Generic Bootstrapping Subroutine}
\usage{
bootstrap(x, boot = 1000, FUN, up = 0.975, lo = 0.025)
}
\arguments{
\item{x}{Character or Numeric. The original data to be bootstrapped.}

\item{boot}{Number of bootstraps to perform.}

\item{FUN}{Function desired for the point estimate of the original data
vector (if numeric data). Must return a scalar.}

\item{up}{Upper confidence limit.}

\item{lo}{Lower confidence limit.}
}
\value{
A list containing:
\item{BootSamples}{List of the bootstrap populations created during
the simulation.}
\item{BootEstimates}{List of the various point estimates of each of
the bootstrap samples.}
\item{CI95}{Vector of the point estimate and upper & lower CI95
produced via the bootstrap samples.}
\item{SE}{The standard error based on the original data.
Could be used to calculate CI95 via 1.96*SE if so desired.}
}
\description{
Provide a numeric or character vector and create bootstrap samples
(with estimates) of the original vector. Also calculates CI95
using \code{\link[=quantile]{quantile()}}.
}
\examples{
bootstrap(x = round(runif(25,1,100)), boot = 50, FUN = mean) # numeric
bootstrap(x = LETTERS[1:26], boot = 50)                      # character
z <- factor(sample(c("stu", "is", "cool"), 10, replace = TRUE))
# bootstrap(x = z, boot = 50)      # factor (ask to convert to character)
}
\seealso{
\code{\link[=CI95se]{CI95se()}}, \code{\link[=quantile]{quantile()}}
}
\author{
Stu Field
}
