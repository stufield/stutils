#' Try Catch Returns NULL
#'
#' A convenient wrapper to capture errors in an expression
#' returning `NULL` rather than error out.
#' This simplifies error catching for downstream functionality via
#' [is.null()]. See [try()] and [tryCatch()].
#'
#' @param expr An R expression to try.
#' @param default The value to return if an error is encountered.
#' By default, and according to the function name, `NULL`.
#' This option is included for the rare case when something other
#' than `NULL` is desired.
#' @param quiet Logical. Should the error message
#' (if encountered) be printed?
#' @return Either the value of the expression in `expr` or,
#' if an error is encountered, the value in `default`.
#' @author Stu Field
#' @seealso [try()], [tryCatch()]
#' @references More or less "borrowed" from the \pkg{plyr} package.
#' @examples
#' tryNULL(log("a"))
#' tryNULL(log("a"), quiet = FALSE)
#' tryNULL(log("a"), default = 0)
#' @export
tryNULL <- function (expr, default = NULL, quiet = TRUE) {
  result <- default
  if ( quiet ) {
    tryCatch(result <- expr, error = function(e) e)
  } else {
    try(result <- expr)
  }
  result
}
