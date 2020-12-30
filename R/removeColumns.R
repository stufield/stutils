#' Remove Column Containing Given Entry(s)
#'
#' Remove an entire column of a matrix of data frame whose
#' entries contain a given value. Created in SNP analysis data
#' and is similar to \code{\link{na.omit}} except the columns (default)
#' are removed is a match occurs in that margin.
#'
#' @aliases removeColumns rm.col
#' @param x A matrix or data frame.
#' @param index Numeric in \verb{[1,2]}. The margin to index (columns = 2; rows = 1).
#' @param search Numeric or character. The exact match to be searched.
#' If contained within any column or row, it will be removed.
#' @return Matrix or data frame with either row(s) or column(s) removed as
#' a result of matching `search`.
#' @note Used in SNP analysis to remove nucleotide positions containing a given
#' character.
#' @author Stu Field
#' @seealso \code{\link{na.omit}}
#' @examples
#' M <- matrix(1:25, ncol = 5)
#' removeColumns(M, index = 2, search = 20)
#' M <- as.data.frame(M)
#' M[4, 4] <- "A"
#' M
#' removeColumns(M, search = c("A", 17, 23))
#' @export removeColumns
removeColumns <- function(x, index = 2, search) {
  rm_logic <- apply(x, index, function(.x) any(.x %in% search))
  cat(sprintf("Removing %s: %s\n",
              ifelse(index == 1, "row(s)", "column(s)"),
              paste(which(rm_logic), collapse = " ")))

  if ( index == 1 ) {
    x[!rm_logic, , drop = FALSE]
  } else {
    x[, !rm_logic, drop = FALSE]
  }
}

