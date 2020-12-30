#' Remove Column Containing Specified Entry(s)
#'
#' Remove an entire column of a data table whose
#' entries contain a specified value.
#'
#' @param x A matrix or data frame. Any 2-dimensional object in R.
#' @param index Deprecated. If selection based on rows is desired, please
#' use [dplyr::filter()].
#' @param search Numeric or character. The exact match to be searched.
#' If contained within any column or row, it will be removed.
#' @return Same class object as `x` with possibly column(s) removed.
#' @author Stu Field
#' @examples
#' M <- matrix(1:25, ncol = 5)
#' M
#' remove_columns(M, search = 20)
#' N <- data.frame(M)
#' N[4, 4] <- "A"
#' N
#' remove_columns(N, search = c("A", 17, 23))
#' @export
remove_columns <- function(x, index = NULL, search) {
  if ( !missing(index) ) {
    usethis::ui_stop(
      "The `index =` argument is now deprecated. See ?removeColumns"
    )
  }
  .logic <- function(.x) !any(.x %in% search)
  x[, apply(x, 2, .logic)]
}

