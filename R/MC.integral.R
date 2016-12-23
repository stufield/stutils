#' 
#' Monte-Carlo Integration
#' 
#' A function that runs a Monte-Carlo integration of any unknown function of
#' 'x' via simulation. Calculates the area under the curve by picking numerous
#' points and deciding if that point falls above or below the curve. This demo
#' shows the method of Monte-Carlo and how it can be used to estimate the
#' integral over a given interval of 'x'. Simulation mimics a random dart
#' thrown on a dartboard style algorithm.
#' 
#' Includes an iteration counter & a run time indicator.
#' 
#' @param n Number of points used in the estimation. Defaults to 10000.
#' @param interval Range of 'x' over which the function should be evaluated.
#' Endpoints.
#' @param FUN The function to integrate. Can be any function.
#' @param force Logical. Should a brute force method be used to find the maximum of 'y'.
#' This can sometimes be useful to avoid missing the global maximum via
#' optim(), but is slower since many points along the function are
#' independently evaluated.
#' @return Numeric estimation of the integral (area below the curve). A plot of
#' the function with points added randomly above & below the function.
#' @note This demo is for students to visually see how the Monte-Carlo
#' Integration works.
#' @author Stu Field, William Black IV!
#' @seealso \code{\link{optimize}}, \code{\link{MC.integral.fast}}
#' @references put references to the literature/web site here
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' mystery.fun <- function (x) {
#'   20*dnorm(x, mean=-1, sd=5) +
#'     ifelse(x > -1.1, 
#'   	 6*dgamma(x=x+1,shape=2,scale=0.5), 
#'   	 1.5*dgamma(x=-x,shape=5,scale=0.2)) + 
#'     2*dgamma(x=2.75-x, shape=3, scale=0.25)
#' }
#' 
#' \dontrun{
#' MC.integral(n=10000, interval=c(-2.98, 2.98), FUN=mystery.fun)
#' }
#' 
#' 
#' @export MC.integral
MC.integral <- function(n=10000, interval, FUN, force=FALSE) {

   time1 <- Sys.time()                    # timer 1
   l <- interval[1]
   r <- interval[2]     # left & right limits
   count <- 0                             # declare counter for hits below curve
   MaxY <- optimize(f=FUN, interval=interval, maximum=TRUE)$objective

   if ( force )
      MaxY <- max(FUN(seq(l, r, by=0.0001))) # using brute force method

   ### plot function ###
   par(bg="thistle")
   curve(FUN, from=l, to=r, ylim=c(0,MaxY), ylab="f(x)",
         xlab="", lwd=1.5, col="navy")
   abline(v=interval, lty=2, lwd=1.5)
   box()
   
   for (i in 1:n) {                       # Loop proposals ###
   	  if (i%%1000==0) cat("iteration...",i,"\n",sep="")
      x <- runif(1,l,r)                   # random x between l & r
      y <- runif(1) * MaxY                # random y between 0 & 1
      f.x <- FUN(x)                       # y at random x (point on curve)
      if (y < f.x) {
         count <- count + 1   # count if below curve
         points(x, y, cex=0.2, pch=20, col="darkgreen")
      } else {
         points(x, y, cex=0.2, pch=20, col="darkred")
      }
   }

   p.hits <- count / n                           # proportion hits
   T.area <- MaxY * (interval[2] - interval[1])  # total area (box)
   Integral <- T.area * p.hits                   # determine area under curve
   title(xlab= format(paste("Area Est. = ",Integral)), font.lab=4, cex.lab=1.5)
   runTime <- Sys.time() - time1                 # timer 2
   cat("Run Time = ",runTime,"s","\n",sep="")
   return(Integral)

}

