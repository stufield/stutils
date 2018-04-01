# --------------------
# Revision Info
# --------------------
# $Id$
# $Author$
# $Date$
#########################
#     Function:   Mapply
#########################

#' Convenience Wrapper for mapply()
#'
#' A simple wrapper for \code{\link[base]{mapply}} that enables similar syntax
#' to the \code{\link[base]{lapply}} and \code{\link[base]{sapply}} format and
#' includes built in checks for argument formation and function arguments.
#'
#' To ensure fidelity to the original structure of the data in the output, the
#' \code{SIMPLIFY=FALSE} argument is hard coded but can be set by the user.
#'
#' From the \code{\link[base]{mapply}} description: \code{mapply()} calls
#' \code{FUN} for the values of \code{...} which are re-cycled to the
#' length of the longest, unless any have length zero. In this wrapper,
#' recycling is \emph{not} allowed, and all arguments must have equal length.
#'
#' @param ... Arguments passed to \code{\link[base]{mapply}}.
#' Typically the first argument is a named list, followed by additional
#' arguments of the same length as the first. The elements of each argument are
#' passed sequentially to the \code{FUN} argument, which is typically the final
#' argument (but does not have to be).
#' @return If \code{SIMPLIFY=FALSE}, typically a list object with each entry
#' the result of applying the function argument to each element of the
#' \code{...}. If \code{SIMPLIFY=TRUE}, an attempt is made to reduce the
#' result to a vector or matrix in a similar fashion to the \code{simplify=}
#' argument of \code{\link[base]{sapply}}.
#' @author Stu Field
#' @seealso \code{\link[base]{mapply}}, \code{\link[base]{sapply}}
#' @examples
#'
#' tmp <- list(A = 5, B = 8, C = 10)
#' f <- function(x, y, z) { print(sprintf("%s-%s", z, y)); x + y }
#' out <- Mapply(tmp, 1:length(tmp), names(tmp), f)
#' out
#'
#' @export Mapply
Mapply <- function(...) {

   args <- list(...)

   if ( is.null(names(args)) )
      names(args) <- rep("", length(args))

   if ( any(grep("SIMP", names(args), ignore.case = TRUE)) ) {
      simpl.idx <- grep("SIMP", names(args), ignore.case = TRUE)
   } else {
      args$SIMPLIFY <- FALSE
      simpl.idx     <- length(args)
   }

   fun.idx <- which(sapply(args, is.function))   # which ... is the function

   if ( length(fun.idx) != 1 )
      stop(sprintf("Multiple function [%s] arguments passed ... check syntax",
                   paste(fun.idx, collapse = ", ")), call. = FALSE)

   names(args)[ c(fun.idx, simpl.idx) ] <- c("FUN", "SIMPLIFY")
   Lvec     <- sapply(args[-c(fun.idx, simpl.idx)], length)
   fun.args <- as.list(args[[fun.idx]])
   fun.args <- fun.args[ names(fun.args) != "" ]

   if ( any(diff(Lvec) != 0) )
      stop("Check lengths of arguments ... ",
           paste(Lvec, collapse = " - "), call. = FALSE)

   if ( length(fun.args) != length(Lvec) )
      stop(sprintf("Check number of arguments in function(%s) is: %i",
                   paste(names(fun.args), collapse = ","), length(Lvec)),
           call. = FALSE)

   args <- args[ c(fun.idx, simpl.idx,
                   setdiff(seq_along(args),
                           c(fun.idx, simpl.idx))) ]    # reorder FUN first
   invisible(do.call("mapply", args))

}

