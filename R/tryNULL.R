#' Try Catch Returns NULL
#'
#' A convenient wrapper around either [try()] or [tryCatch()].
#' However, rather than of returning the an error signal/warning,
#' `NULL` is returned if an error is encountered. 
#' This simplifies error catching for downstream functionalit via
#' [is.null()].
#'
#' @param expr An R expression to try.
#' @param default The value to return if an error is encountered.
#' By default, and according to the function name, `NULL`.
#' This option is included for the rare case when something other 
#' than `NULL` is desired.
#' @param quiet Logical. Should the error message
#' (if encountered) be printed to the console?
#' @return Either the value of the expression in `expr` or,
#' if an error is encountered, the value in `default`.
#' @author Stu Field
#' @seealso [try()], [tryCatch()]
#' @references More or less "borrowed" from the \pkg{plyr} package.
#' @examples
#' tryNULL(log("a"))
#' tryNULL(log("a"), quiet = FALSE)
#' tryNULL(log("a"), default = 0)
#' @export tryNULL
tryNULL <- function (expr, default = NULL, quiet = TRUE) {
  result <- default
  if ( quiet ) {
    tryCatch(result <- expr, error = function(e) e)
  } else {
    try(result <- expr)
  }
  result
}
