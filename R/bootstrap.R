######################################

#' Generic Bootstrapping Subroutine
#' 
#' Provide a numeric or character vector and create bootstrap samples (with
#' estimates) of the original vector. Also calculates CI95 using the quantile()
#' function.
#' 
#' %% ~~ If necessary, more details than the description above ~~
#' 
#' @param x Character or Numeric. The original data to be bootstrapped.
#' @param boot Number of bootstraps to perform.
#' @param FUN Function desired for the point estimate of the original data
#' vector (if numeric data)
#' @param up Upper confidence limit
#' @param lo Lower confidence limit
#' @return A list containing:
#' \item{BootSamples }{List of the bootstrap populations created during
#' the simulation.}
#' \item{BootEstimates }{List of the various point estimates of each of 
#' the bootstrap samples.}
#' \item{CI95 }{Vector of the point estimate and upper & lower CI95 
#' produced via the bootstrap samples.}
#' \item{SE }{The standard error based on the original data.
#' Could be used to calculate CI95 via 1.96*SE if so desired.}
#' @note %% ~~further notes~~
#' @author Stu Field
#' @seealso \code{\link{CI95se}}, \code{\link{quantile}}
#' @references Colorado State University
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' bootstrap(x=round(runif(25,1,100)), boot=50, FUN=mean) # numeric
#' bootstrap(x=LETTERS[1:26], boot=50)                    # character
#' z <- factor(sample(c("stu","is","cool"), 10, replace=TRUE))
#' # bootstrap(x=z, boot=50)      # factor (ask to convert to character)
#' 
#' @importFrom stats quantile var
#' @export bootstrap
bootstrap <- function(x, boot=1000, FUN, up=0.975, lo=0.025){

   if ( is.numeric(x) || is.character(x) ) {
      if ( is.numeric(x) ) {
         est <- FUN(x)   # calculate point estimate
         bootsamples <- lapply(1:boot, function(i) sample(x, replace=TRUE))
         boot.est <- sapply(bootsamples, FUN)   # pt. estimates of bootstraps
         upper <- quantile(boot.est, probs=up)  # upper CI
         lower <- quantile(boot.est, probs=lo)  # lower CI
         se <- sqrt(var(boot.est))              # standard error of pt. estimate
         Out <- list(BootSamples=bootsamples,
                     BootEstimates=boot.est,
                     CI95=c(lower, estimate=est, upper),
                     SE=se)
     }
     if ( is.character(x) ) {
       Out <- lapply(1:boot, function(i) sample(x, replace=TRUE))
     }
   } else {
   	 input <- readline("x must be numeric or character! Coerce to character (y/n)? ")
   	 if ( grepl("y", input, ignore.case=TRUE) ) {
   	   y <- as.character(x)
   	   Out <- lapply(1:boot, function(i) sample(y, replace=TRUE))
   	 } else {
          stop("Function aborted ... please try again ...")
       }
   }
   Out
}

