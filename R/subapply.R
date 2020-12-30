#' Apply Function to Subsets of Data
#'
#' Apply a function, written on the fly (`.fun`), to the subsets of data
#' determined by an appropriate subsetting variable (column)
#' If the `x` is a vector, the `index` argument must
#' be of the same length as `x`, and the function reduces to a simple
#' \code{\link{tapply}}. If `x` is a data frame, then `y` must be
#' supplied and corresponds to a column in `x`.
#'
#' THIS FUNCTION WILL EVENTUALLY BE REPLACED BY \code{\link[dplyr]{summarise}}.
#'
#' @param x A vector, data frame, of matrix of values evaluate.
#' @param index If `x` is a vector, the sub-setting index of same length
#' as `x`. If `x` is a data frame, a character string indicating the
#' column name(s) in `x` to use as indices. Character string currently
#' cannot be more than length 2.
#' @param .fun The function to apply to each subset of the data. Can be
#' written on the fly using the `function(x)` syntax.
#' @param y Character. Only used if `x` is a data frame, then a character
#' string corresponding to a column name in `x`.
#' @param sum.field Character. The summary field column name in the
#' returned data frame that summarizes the function called upon each
#' subset of the data. Ignored if `longform = FALSE`.
#' @param longform Alternative version of output for the returned value.
#' Returns a table.
#' @param ... Additional arguments passed to \code{\link{tapply}}
#' @return A data frame with summary data, and the result of the applied
#' function.
#' @author Stu Field
#' @seealso \code{\link{tapply}}, \code{\link[dplyr]{select}}
#' @examples
#' # S3 numeric
#' subapply(test_data$z, index = test_data$Sample, .fun = mean)
#'
#' # S3 character
#' set.seed(10)
#' y <- sample(LETTERS, 10, replace = TRUE)
#' subapply(y, rep("a",length(y)), duplicated)
#'
#' # S3 data.frame
#' subapply(test_data, index = "Sample", .fun = mean, y = "z")  # same as above
#'
#' # cross tabulated
#' subapply(test_data, c("Sample", "Response"), .fun = mean, y = "z")
#'
#' # cross tabulated long-format
#' subapply(test_data, index = c("Sample","Response"), .fun = mean, y = "z",
#'          longform = TRUE, sum.field = "Mean")
#'
#' # S3 matrix
#' test_data$Sample %<>% as.numeric
#' m <- test_data[, c(1, 3, 11)] %>% data.matrix()
#' subapply(m, index = "Sample", .fun = mean, y = "z", longform = TRUE) # same as data.frame
#' @importFrom dplyr select
#' @export subapply
subapply <- function(x, index, .fun, ...) UseMethod("subapply")


#' S3 subapply default method
#'
#' @noRd
#' @method subapply default
#' @export
subapply.default <- function(x, ...) {
  stop("Couldn't find the appropriate S3 method definition for this object: ",
       class(x))
}



#' S3 subapply method for numeric
#'
#' @noRd
#' @method subapply numeric
#' @export
subapply.numeric <- function(x, index, .fun, ...) {
  if ( length(index) != length(x) ) {
    stop("The [index=] argument must be a vector the same length as `x`",
         call. = FALSE)
  }
  tapply(x, INDEX = index, FUN = .fun, ...)
}

#' S3 subapply method for character
#'
#' @noRd
#' @rdname subapply
#' @method subapply character
#' @export
subapply.character <- function(x, ...) subapply.numeric(x, ...)



#' S3 subapply method for data.frame
#'
#' @rdname subapply
#' @method subapply data.frame
#' @export
subapply.data.frame <- function(x, index, .fun, y, longform = FALSE,
                                sum.field = deparse(substitute(.fun)),
                                ...) {

  if ( missing(y) ) {
    stop("Value of `y` must be passed if `x` is a data frame", call. = FALSE)
  }

  if ( !y %in% names(x) ) {
    stop("`y` does not exist in the names of `x`; check spelling of `y`")
  }

  index <- dplyr::select(x, index) %>% as.list()

  if ( length(index) == 1 ) {
    ret <- tapply(x[[y]], INDEX = index, FUN = .fun, ...)

    if ( longform ) {
      n <- index %>% table() %>% as.vector()
      #print(n)
      ret <- data.frame(n, ret) %>% purrr::set_names(c("n", sum.field))
    }

  } else if ( length(index) == 2 ) {

    ret    <- tapply(x[[y]], INDEX = index, FUN = .fun, ...)
    n      <- table(index)
    dnames <- dimnames(n)

    if ( longform ) {
      ret <- data.frame(rep(dnames[[1]], length(dnames[[2]])),
                        rep(dnames[[2]], each = length(dnames[[1]])),
                        as.vector(n), as.vector(ret)) %>%
        purrr::set_names(c(index, "n", sum.field))
    }
  } else {
    stop("subapply can handle only 1 or 2 subset indices ... ", call. = FALSE)
  }

  return(ret)

}


#' S3 subapply method for matrix
#'
#' @noRd
#' @method subapply matrix
#' @export
subapply.matrix <- function(x, ...) {
  x %>% as.data.frame() %>% subapply.data.frame(...)
}



