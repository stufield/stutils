#' 
#' Search and Replace Method Dispatch
#' @noRd
#' @export
search.replace <- function(x, s, r) UseMethod("search.replace")




#' Search & Replace
#' 
#' A global search & replace of entries within a vector, matrix, or data frame
#' 
#' @aliases search.replace search.replace.data.frame search.replace.matrix search.replace.numeric
#' @rdname search.replace
#' @param x The object to be searched, typically a matrix or data frame but
#' can be a vector of character or numeric class
#' @param s The search index
#' @param r The replace with. Must be same length as \code{s}
#' @param ... Pass throught to various S3 methods
#' @return An object of the same dimensions and class as \code{x} with the
#' \code{s} replaced with \code{r}.
#' @note %% ~~further notes~~
#' @section Warning : The lengths of \code{s} & \code{r} must be the same.
#' @author Stu Field
#' @seealso \code{\link{replace}}
#' @references %% ~put references to the literature/web site here ~
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' # matrix
#' Y <- matrix(1:25, ncol=5)
#' Y
#' search.replace(Y, s=c(8,20), r=c(99,99))
#'
#' # data.frame
#' X <- data.frame(x=c(1,2,3), y=c(2,2,4), z=c(1,2,4))
#' rownames(X) <- c("one", "two", "three")
#' X
#' search.replace(X, s=1:4, r=c("A","C","G","T"))
#'
#' # numeric
#' search.replace(1:10, s=4, r=19)
#'
#' # character
#' search.replace(head(LETTERS,10), s="G", r="Z")
#' 
#' @method search.replace default
#' @export
search.replace.default <- function(x, ...)
   stop("Could not find the appropriate S3 method definition for this object: ", class(x))



# S3 search.replace method for data.frame 

#' @rdname search.replace
#' @method search.replace data.frame
#' @export
search.replace.data.frame <- function(x, s, r) {

   if ( length(s) != length(r) )
      stop("Search & Replace Are Unequal Lengths")

   for (i in 1:length(s)) {
      cat("Replacing:", s[i], "->", r[i], "\n")
      x <- apply(x, 2, function(.c) {.c[ .c==s[i] ] <- r[i]; .c})
   }

   return(as.data.frame(x))

}




# S3 search.replace method for matrix

#' @rdname search.replace
#' @method search.replace matrix
#' @export
search.replace.matrix <- function(x, s, r) {

   if ( length(s) != length(r) )
      stop("Search & Replace Are Unequal Lengths")

   for (i in 1:length(s)) {
      cat("Replacing:", s[i], "->", r[i], "\n")
      x <- apply(x, 2, function(.c) {.c[ .c==s[i] ] <- r[i]; .c})
   }

   return(x)

}


# S3 search.replace method for numeric

#' @rdname search.replace
#' @method search.replace numeric
#' @export
search.replace.numeric <- function(x, s, r) {

   if ( length(s) != length(r) )
      stop("Search & Replace Are Unequal Lengths")

   for (i in 1:length(s)) {
      cat("Replacing:", s[i], "->", r[i], "\n")
      x[ x==s[i] ] <- r[i]
   }

   return(x)
}


# S3 search.replace method for character

#' @rdname search.replace
#' @method search.replace character
#' @export
search.replace.character <- function(...) search.replace.numeric(...)




