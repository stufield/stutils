
#' Vector Proportions
#' 
#' Calculate the proportion of each entry in a vector
#' relative to the entire vector.
#' 
#' Often useful in calculating proportions of individuals in 
#' given stages, then calculating gene frequencies.
#' 
#' @aliases vectorProp
#' @param x Numeric vector
#' @return A vector with a value 1 -> 0 for each entry, each representing the
#' proportion of each entry to the sum of the vector.
#' @note Used in previous versions of pine12, later discarded in favor of the
#' mating function by Jesse Drendel.
#' @author Stu Field
#' @seealso \code{\link[base]{sum}}
#' @examples
#' 
#' vectorProp(1:10)
#' vectorProp(c(1,2,3,4,5,4,3,2,1))
#' 
#' @export vectorProp
vectorProp <- function(x) x / sum(x)

