#' Which Entry(s)
#' 
#' Determine which entry of a matrix matches a given value.
#' Similar functions exist for a vector, but when applied to a 
#' matrix entries are converted to a vector of the matrix columns.
#' This is not ideal. This function provides \verb{row x column}
#' addressing of the entries which agree with the `match =` argument.
#' 
#' @param x A `matrix` object to be searched.
#' @param match Index to be matched.
#' @return A matrix indicating which entries agree with `match`. Rows are
#' the number of different match(es) and column 1 is the row of a positive
#' match and column 2 is the column of the positive match.
#' @author Stu Field
#' @seealso [which()]
#' @examples
#' M <- matrix(1:25, ncol = 5)
#' M[5,1]  <- 17
#' M[4, 2] <- 17
#' whichEntry(M, 17)
#' @export whichEntry
whichEntry <- function(x, match) {
  col <- ceiling(which(x == match) / nrow(x))
  row <- which(x == match) - nrow(x) * (col - 1)
  out <- cbind(row, col)
  rownames(out) <- rep("entry", nrow(out))
  out
}
