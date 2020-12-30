#' All Values Same
#'
#' Returns a logical as to whether all values *within* a vector
#' are identical. This function does NOT compare two independent
#' vectors. Please use [all.equal()], for such a purpose
#' combined with [isTRUE()].
#'
#' @rdname all_same
#' @param x A vector of values. Can be one of the following objects
#' classes: `numeric`, `character`, `factor`, or `logical`.
#' @return Logical. `TRUE` or `FALSE`.
#' @author Stu Field
#' @seealso [isTRUE()], [all.equal()]
#' @examples
#' all_same(1:4)
#' all_same(rep(5, 10))
#' all_same(rep("A", 10))
#' all_same(letters)
#' all_same(c(TRUE, TRUE, TRUE))
#' all_same(c(TRUE, TRUE, FALSE))
#' @importFrom purrr map_lgl
#' @export
all_same <- function(x) UseMethod("all_same")


#' S3 all_same method for numeric
#'
#' @noRd
#' @export
all_same.numeric <- function(x) {
  if ( all(floor(x) == x, na.rm = TRUE) ) {
    # if integer
    isTRUE(diff(range(x, na.rm = TRUE)) == 0)
  } else {
    # if double
    isTRUE(diff(range(x, na.rm = TRUE)) < .Machine$double.eps^0.5)
  }
}

#' S3 all_same method for character
#'
#' @noRd
#' @importFrom purrr map_lgl
#' @export
all_same.character <- function(x) {
  isTRUE(all(purrr::map_lgl(x, function(i) i == x[1L])))
}

#' S3 all_same method for factor
#'
#' @noRd
#' @export
all_same.factor <- function(x) {
  all_same(as.character(x))
}

#' S3 all_same method for logical
#'
#' @noRd
#' @export
all_same.logical <- function(x) {
  all_same(as.numeric(x))
}
