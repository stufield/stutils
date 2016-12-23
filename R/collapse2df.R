#' 
#' Collapse Vector List to Data Frame
#' 
#' Function collapses a list of vectors, or a list of 1-row data frames, into a
#' n x m data frame, where n equals the list length and m equals the vector
#' length. All vectors must be of the same length.
#' 
#' Uses \code{\link[base]{rbind}} and \code{\link[base]{Reduce}} and to preform
#' the collapse.
#' 
#' @param x A \emph{named} list (which become the rows) containing numeric
#' vectors of the same length. Vectors can be in the form of a numeric vector
#' or a 1-row data frame.
#' @return A data frame object of the vertically collapsed vectors.
#' @note Functions similarly to \code{\link[base]{do.call}}.
#' @author Stu Field
#' @seealso \code{\link[base]{rbind}}, \code{\link[base]{Reduce}}
#' @references %% ~put references to the literature/web site here ~
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' tmp <- lapply(1:3, function(...) rnorm(4))
#' names(tmp) <- LETTERS[1:3]
#' collapse2df(tmp)
#' tmp2 <- lapply(tmp, function(x) {names(x) = letters[1:4]; x})
#' collapse2df(tmp2)
#' 
#' @export collapse2df
collapse2df <- function(x) {

   if ( is.null(names(x)) )
      stop("Must provide a named list as input argument [x]", call.=FALSE)
   nm <- names(x)
   out <- Reduce(function(...) rbind(...), x)
   rownames(out) <- nm
   if ( !inherits(out, "data.frame") )
      as.data.frame(out)
   else
      out
}
