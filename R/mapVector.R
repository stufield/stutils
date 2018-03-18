# --------------------
# Revision Info
# --------------------
# $Id$
# $Author$
# $Date$
###########################
#     Function: mapVector
###########################

#' Map Vector
#'
#' Map a factor or character vector (1-to-1 or many-2-one) to another new vector.
#'
#' If \code{v} is a factor, the returned vector is also a factor (and the levels
#' of the returned value are determined by the \code{to.vec} argument), otherwise
#' class of the returned vector is determined by the \code{to.vec} argument. If
#' the class of the returned vector changes, a warning is flagged.
#'
#' factor -> factor
#' character -> factor, numeric, or integer
#'
#' @aliases mapVector map.vector
#' @rdname mapVector
#' @param v The source vector to perform the mapping. Must be a character or
#' factor vector, or be able to be converted to one. In general, the returned
#' value is of the same class (character/factor) as the input vector.
#' @param from.list A list of the associated levels to map in the order thay
#' will be mapped to in \code{to.vec}. Alternatively, a character vector of the
#' same length as \code{to.vec} of only 1-to-1 mapping is desired.
#' @param to.vec The new mapping in the same order as they appear in
#' \code{from.list}.
#' @param nomatch Value that unmapped values in the source vector should take.
#' By default, \code{NULL}, unmapped values are themselves returned unchanged.
#' @param ... Additional arguments passed to internals of specific S3 methods.
#' @return A factor (or character) vector with the new mapping applied.
#' @author Stu Field
#' @seealso \code{\link[base]{setdiff}}, \code{\link[base]{factor}}
#' @examples
#'
#' # factor
#' mapVector(test_data$TimePoint,
#'           list(c("baseline","24 months"),c("6 months","12 months")),
#'           c("one","two"))
#'
#' # numeric -> character (with warning)
#' mapVector(rep(1:4, each=10), list(c(1,2), c(3,4)), c("one","two"))
#'
#' # character ("C" is un-mapped)
#' mapVector(head(LETTERS, 5), list(c("A","B"), c("D","E")), c("one","two"))
#'
#' # character with missing (nomatch)
#' mapVector(head(LETTERS, 5), list(c("A","B"), c("D","E")), c("one","two"), nomatch="No")
#'
#' # integer
#' mapVector(1:5, list(c(1,3,5), c(2,4)), c(10,100))
#'
#' # character -> integer
#' mapVector(head(LETTERS, 5), list(c("A","B"), c("C","D","E")), 1:2)
#'
#' @export
mapVector <- function(v, from.list, to.vec, nomatch=NULL) UseMethod("mapVector")


#' S3 mapVector default method
#'
#' @noRd
#' @method mapVector default
#' @export
mapVector.default <- function(v, ...)
   stop("Couldn't find the appropriate S3 method for class ... ", class(v))


#' S3 mapVector method for character factor
#'
#' @noRd
#' @method mapVector factor
#' @export
mapVector.factor <- function(v, from.list, to.vec, nomatch=NULL) {

   if ( is.null(nomatch) ) {
      new.v <- as.character(v)
   } else {
      new.v <- rep(nomatch, length(v))
   }

   if ( missing(to.vec) && !is.null(names(from.list)) )
      to.vec <- names(from.list)

   if ( length(from.list)==length(to.vec) && !inherits(from.list, "list") )
      from.list <- as.list(from.list)

   my_dict <- mapVsubfun(from.list %names% to.vec)

   for ( i in names(my_dict) )
      new.v[ v==i ] <- my_dict[[which(names(my_dict)==i)]]

   miss.vec <- setdiff(v, unlist(from.list, recursive=FALSE))
   #print(miss.vec)
   factor(new.v, levels=c(to.vec, miss.vec))

}


#' S3 mapVector method for character class
#'
#' @noRd
#' @method mapVector character
#' @export
mapVector.character <- function(v, from.list, to.vec, nomatch=NULL) {

   if ( !is.null(nomatch) ) {
      new.v <- rep(nomatch, length(v))
   } else {
      new.v <- v
   }

   if ( missing(to.vec) && !is.null(names(from.list)) )
      to.vec <- names(from.list)

   if ( length(from.list)==length(to.vec) && !inherits(from.list, "list") )
      from.list <- as.list(from.list)

   my_dict <- mapVsubfun(from.list %names% to.vec)

   for ( i in names(my_dict) )
      new.v[ v==i ] <- my_dict[[which(names(my_dict)==i)]]

   miss.vec <- setdiff(v, unlist(from.list, recursive=FALSE))
   #print(miss.vec)

   if ( class(to.vec) != class(v) ) {
      warning(sprintf("* mapVector is changing object class of [v]: %s -> %s",
                      class(v), class(to.vec)), call.=FALSE)
      if ( inherits(to.vec, "factor") )
         new.v %<>% as.factor
      else if ( inherits(to.vec, "numeric") )
         new.v %<>% as.numeric
      else if ( inherits(to.vec, "integer") )
         new.v %<>% as.integer
   }

   return(new.v)

}


#' S3 mapVector method for numeric class
#'
#' @noRd
#' @method mapVector numeric
#' @export
mapVector.numeric <- function(v, from.list, to.vec, nomatch=NULL) {

   if ( !is.null(nomatch) ) {
      new.v <- rep(nomatch, length(v))
   } else {
      new.v <- v
   }

   if ( missing(to.vec) && !is.null(names(from.list)) )
      to.vec <- names(from.list)

   if ( length(from.list)==length(to.vec) && !inherits(from.list, "list") )
      from.list <- as.list(from.list)

   my_dict <- mapVsubfun(from.list %names% to.vec)

   for ( i in names(my_dict) )
      new.v[ v==i ] <- my_dict[[which(names(my_dict)==i)]]

   miss.vec <- setdiff(v, unlist(from.list, recursive=FALSE))
   #print(miss.vec)

   if ( class(to.vec) != class(v) ) {
      warning(sprintf("* mapVector is changing object class of [v]: %s -> %s",
                      class(v), class(to.vec)), call.=FALSE)
      if ( inherits(to.vec, "factor") )
         new.v %<>% as.factor
      if ( inherits(to.vec, "integer") )
         new.v %<>% as.integer
   } else if ( inherits(v, "numeric") ) {
      new.v %<>% as.numeric
   } else if ( inherits(v, "integer") ) {
      new.v %<>% as.integer
   }

   return(new.v)
}


#' S3 mapVector method for integer class
#'
#' @noRd
#' @method mapVector integer
#' @export
mapVector.integer <- function(...) mapVector.numeric(...)




#' Internal subfunction for all methods
#'
#' @noRd
mapVsubfun <- function(list.in) {
   list_out <- list()
   if ( is.null(names(list.in)) ) {
      for ( i in 1:length(list.in) ) {
         for ( val in list.in[[i]] ) {
            if ( is.integer(val) ) {
               if ( length(list_out ) < val) {
                  list_out[[val]] <- i
               } else {
                  list_out[[val]] <- c(list_out[[val]], i)
               }
            } else {
               val <- as.character(val)
               list_out[[val]] <- c(list_out[[val]], i)
            }
         }
      }
   }
   for ( name in names(list.in) )
      for ( value in list.in[[name]] )
         list_out[[as.character(value)]] <- c(list_out[[as.character(value)]], name)

   return(list_out)
}


