# --------------------
# Revision Info
# --------------------
# $Id$
# $Author$
# $Date$
#################################
#         Function:   tryNULL
#################################

#' Try NULL Function
#'
#' A convenient wrapper around either \code{\link{try}} or \code{\link{tryCatch}}.
#' However, rather than of returning the an error signal/warning, \code{NULL} is
#' returned if an error is encountered. This makes it easier to test the status
#' of the returned object later in the code with \code{\link{is.null}}.
#'
#' @aliases tryNULL try.null
#' @param expr an R expression to try.
#' @param default The value to return if an error is encountered. By default,
#' and according to the function name, \code{NULL}. This option is included for
#' the rare case when something other than \code{NULL} is desired.
#' @param quiet Logical. Should the error message (if encountered) be printed
#' to the console?
#' @return Either the value of the expression in \code{expr} or, if an error is
#' encountered, the value in \code{default}.
#' @author Stu Field
#' @seealso \code{\link{try}}, \code{\link{tryCatch}}, \code{\link[plyr]{tryNULL}}
#' @references More or less stolen from the \code{plyr} package, with some modifications.
#' @examples
#'
#' tryNULL(log("a"))
#' tryNULL(log("a"), quiet = FALSE)
#' tryNULL(log("a"), default = 0)
#'
#' @export tryNULL
tryNULL <- function (expr, default = NULL, quiet = TRUE) {
  result <- default
  if ( quiet )
    tryCatch(result <- expr, error=function(e) e)
  else
    try(result <- expr)
  result
}

