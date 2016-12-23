#' 
#' Optimization Function
#' 
#' Given a function, determine the set of parameters that maximizes
#' (default) or minimizes it over a given interval.
#' 
#' %% ~~ If necessary, more details than the description above ~~
#' 
#' @param fn Function to be evaluated. Must return a scalar value
#' @param I Numeric. Interval over which to find the max (or min)
#' @param max Logical. If FALSE, the Min is computed
#' @param ... Arguments passed to the function
#' @return A plot containing the functional curve, max/min, y-value at Max/Min
#' @note This differs from the \code{\link{optim}} function but essentially
#' does the same. This is a brute force method.
#' @author Stu field
#' @seealso \code{\link{optimize}}, \code{\link{optim}}
#' @references %% ~put references to the literature/web site here ~
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' myfun <- function(x, a, b, t) {
#'    -t * (x-a)^2 + b
#' }
#' 
#' optimizer(fn=myfun, I=c(-10,10), max=TRUE, a=2, b=12, t=0.1)
#' optimizer(fn=myfun, I=c(-10,10), max=FALSE, a=2, b=12, t=0.1)
#' 
#' @export optimizer
optimizer <- function(fn, I, max=TRUE, ...) {

   l <- I[1]
   u <- I[2]
   scale <- 1.2
   x <- seq(l, u, by=0.01)
   eval <- fn(x, ...)
   y.value <- ifelse(max==TRUE, max(eval), min(eval))
   max.min <- ifelse(max==TRUE,
                     seq(l, u, by=0.01)[which.max(eval)],
                     seq(l, u, 0.01)[which.min(eval)])

   plot(x, eval, type="l", lwd= 2, lty= 2, xlim= c(l*scale,u*scale),
        ylim=range(eval)*scale,
        main="Optimization", ylab="fn(...)",
        xlab="independent variable")
   abline(h=y.value, col=2, lwd=1.5)
   abline(v=max.min, col=4, lwd=1.5)
   points(max.min, y.value, pch=13, col="darkorchid", cex=2)
   legend("topright", legend=c(paste("Max/Min = ",format(max.min)),
                               paste("f(max) = ",format(y.value))), 
          lty=1, col=c(4,2), bg="gray95",
          cex=0.75, inset=0.00)

   list(Max_Min=max.min, Value=y.value)
}


