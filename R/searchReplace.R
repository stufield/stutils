
#' Search & Replace
#' 
#' A global search & replace of entries within a vector, matrix, or data frame
#'
#' \bold{Warning:} The lengths of \code{s} and \code{r} \emph{must} be identical.
#' 
#' @aliases searchReplace
#' @param x The object to be searched, typically a matrix or data frame but
#' can be a vector of character or numeric class.
#' @param s The search index.
#' @param r The replace with. Must be same length as \code{s}.
#' @param ... Pass through to various S3 methods.
#' @return An object of the same dimensions and class as \code{x}, with the
#' \code{s=} matches replaced with \code{r=}.
#' @author Stu Field
#' @seealso \code{\link{replace}}
#' @examples
#' 
#' # matrix
#' Y <- matrix(1:25, ncol = 5)
#' Y
#' searchReplace(Y, s = c(8, 20), r = c(99, 99))
#'
#' # data.frame
#' X <- data.frame(x = c(1, 2, 3), y = c(2, 2, 4), z = c(1, 2, 4))
#' rownames(X) <- c("one", "two", "three")
#' X
#' searchReplace(X, s = 1:4, r = c("A", "C", "G", "T"))
#'
#' # numeric
#' searchReplace(1:10, s = 4, r = 19)
#'
#' # character
#' searchReplace(head(LETTERS, 10), s = "G", r = "Z")
#'
#' @export searchReplace
searchReplace <- function(x, s, r) UseMethod("searchReplace")


#' S3 default method searchReplace

#' @noRd
#' @method searchReplace default
#' @export
searchReplace.default <- function(x, ...)
   stop("Could not find the appropriate S3 method definition for this object: ", class(x))



#' S3 searchReplace method for data.frame 

#' @noRd
#' @method searchReplace data.frame
#' @export
searchReplace.data.frame <- function(x, s, r) {

   if ( length(s) != length(r) )
      stop("Search & Replace Are Unequal Lengths")

   for (i in 1:length(s)) {
      cat("Replacing:", s[i], "->", r[i], "\n")
      x <- apply(x, 2, function(.c) {.c[ .c==s[i] ] <- r[i]; .c})
   }

   return(as.data.frame(x))

}


#' S3 searchReplace method for matrix

#' @noRd
#' @method searchReplace matrix
#' @export
searchReplace.matrix <- function(x, s, r) {

   if ( length(s) != length(r) )
      stop("Search & Replace Are Unequal Lengths")

   for (i in 1:length(s)) {
      cat("Replacing:", s[i], "->", r[i], "\n")
      x <- apply(x, 2, function(.c) {.c[ .c==s[i] ] <- r[i]; .c})
   }

   return(x)

}


#' S3 searchReplace method for numeric

#' @noRd
#' @method searchReplace numeric
#' @export
searchReplace.numeric <- function(x, s, r) {

   if ( length(s) != length(r) )
      stop("Search & Replace Are Unequal Lengths")

   for (i in 1:length(s)) {
      cat("Replacing:", s[i], "->", r[i], "\n")
      x[ x==s[i] ] <- r[i]
   }

   return(x)
}


#' S3 searchReplace method for character

#' @noRd
#' @method searchReplace character
#' @export
searchReplace.character <- function(...) searchReplace.numeric(...)


