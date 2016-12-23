#' 
#' Monte-Carlo Integration
#' 
#' A quicker version of MC.integral(). Includes a vectorized random number
#' generation & optional plotting (which takes time). Function to determines 
#' area under curve with given interval of x.
#' 
#' This vectorized version is >100x faster than the MC.integral() when plotting
#' turned off.
#' 
#' @param n Number of points used in the estimation of area.
#' @param interval Range of 'x' over which the function should be evaluated. Endpoints.
#' @param FUN The function to integrate. Can be any function.
#' @param force Logical. Should a brute force method be used to find the maximum of 'y'.
#' This can sometimes be useful to avoid missing the global maximum via
#' optimize(), but is slower since many points along the function are
#' independently evaluated.
#' @param plot Should the simulation be plotted?
#' @return Numeric estimation of the integral (area below the curve) of the function \code{FUN}.
#' @note A faster version of MC.integral() used vectorized random No. generation
#' >100x faster than above when plotting turned off. Solving indefinite integrals with Monte-Carlo simulation
#' @author Stu Field, Bill Black
#' @seealso \code{\link{MC.integral}}, \code{\link{optimize}}
#' @references %% ~put references to the literature/web site here ~
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' mystery.fun <- function (x) {
#'   20*dnorm(x, mean=-1, sd=5) +
#'            ifelse(x > -1.1, 6*dgamma(x=x+1,shape=2,scale=0.5), 
#'            1.5*dgamma(x=-x,shape=5,scale=0.2)) + 
#'            2*dgamma(x=2.75-x, shape=3, scale=0.25)
#' }
#' 
#' \dontrun{
#' MC.integral.fast(n=10000, interval=c(-2.98, 2.98), FUN=mystery.fun, plot=FALSE)
#' # compare
#' MC.integral(n=10000, interval=c(-2.98, 2.98), FUN=mystery.fun)
#' }
#' 
#' ### Repeat in loop 1000 times
#' data(MonteCarloIntegral)
#' MCrep.v
#' 
#' # Plot histogram of estimates #
#' hist(MCrep.v, col="gray75", prob=TRUE, xlab="Area", main="", breaks=15)
#' box()
#' lines(density(MCrep.v))
#' lines(density(MCrep.v, adjust=1.75), lty="dotted", col=2)
#' Est <- density(MCrep.v)$x[which.max(density(MCrep.v)$y)]
#' abline(v=Est, col=4, lty="dotted")
#' legend("topleft", legend=format(paste("Area Est ~",round(Est,6))), 
#'        bg="gray75", cex= 0.75)
#' 
#' # check that histogram sums to 1 # 
#' H <- hist(MCrep.v, plot=FALSE)
#' print(sum((H$breaks[2]-H$breaks[1])*H$density), digits=10)
#' 
#' @export MC.integral.fast
MC.integral.fast <- function(n, interval, FUN, force=FALSE, plot=FALSE){

   time1 <- Sys.time()                    # timer 1
   l <- interval[1]; r <- interval[2]     # left & right limits
   MaxY <- optimize(f=FUN, interval=interval, maximum=TRUE)$objective

   if ( force )
      MaxY <- max(FUN(seq(l,r,by=0.0001))) # using brute force method

   x <- runif(n, l, r)                 # random x between l & r
   y <- runif(n) * MaxY                # random y between 0 & 1
   f.x <- FUN(x)                       # y at random x (point on curve)
   p.hits <- length(which(y < f.x)) / n          # proportion hits
   T.area <- MaxY * (interval[2] - interval[1])  # total area (box)
   Integral <- T.area * p.hits                   # determine area under curve

   if ( plot ) {
      par(bg="thistle")
      curve(FUN, from=l, to=r, ylim=c(0,MaxY), 
            ylab="f(x)", xlab="", lwd=1.5, col="navy")
      abline(v=interval, lty=2, lwd=1.5)
      box()
      colv <- c("darkgreen","darkred")
      points(x[which(y<f.x)], y[which(y<f.x)], cex=0.2, pch=20, col=colv[1])
      points(x[which(y > f.x)], y[which(y > f.x)], cex=0.2, pch=20, col=colv[2]) 
      title(xlab=format(paste("Area Est. = ",Integral)), font.lab=4, cex.lab=1.5)   
   }

   runTime <- Sys.time() - time1                 # timer 2
   cat("Run Time = ",runTime,"s","\n",sep="")
   return(Integral)

}

