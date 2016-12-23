#' 
#' Cumulative Vector Product Product
#' 
#' Returns the product of neighboring elements in 
#' the vector \code{"x"}.
#' 
#' @param x A numeric vector.
#' @return A list containing:
#' \item{Sum.vec }{A vector of length(x) - 1.}
#' \item{Sum }{Sum of the resulting vector in Sum.vec.}
#' \item{Prod.vec }{The product of all the values present 
#' the original vector \code{x}.}
#' @note Used as a mere exercise in function writing for the R tutorial.
#' @author Stu Field
#' @seealso \code{\link{vectorProp}}
#' @references %% ~put references to the literature/web site here ~
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' cum.prod(1:10)
#' 
#' @export cum.prod
cum.prod <- function(x) {
   one <- 1:(length(x) - 1)
   two <- 2:length(x)   
   list(Sum.vec=one*two, Sum=sum(one*two), Prod.vec=prod(x))
}

