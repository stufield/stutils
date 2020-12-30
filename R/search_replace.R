#' Search and Replace
#'
#' A global search & replace of entries within a vector, matrix, or data frame
#' **Note:** The lengths of `s` and `r` *must* be identical.
#'
#' @param x The object to be searched, typically a matrix or data frame but
#' can be a vector of character or numeric class.
#' @param s The search index.
#' @param r The replace with. Must be same length as `s`.
#' @return An object of the same dimensions and class as `x`, with the
#' `s` matches replaced with `r`.
#' @author Stu Field
#' @examples
#' # matrix
#' Y <- matrix(1:25, ncol = 5)
#' Y
#' search_replace(Y, s = c(8, 20), r = c(99, 99))
#'
#' # data.frame
#' X <- data.frame(x = c(1, 2, 3), y = c(2, 2, 4), z = c(1, 2, 4))
#' rownames(X) <- c("one", "two", "three")
#' X
#' search_replace(X, s = 1:4, r = c("A", "C", "G", "T"))
#'
#' # numeric
#' search_replace(1:10, s = 4, r = 19)
#'
#' # character
#' search_replace(head(LETTERS, 10), s = "G", r = "Z")
#' @importFrom usethis ui_stop ui_done
#' @export
search_replace <- function(x, s, r) UseMethod("search_replace")

#' S3 default method search_replace
#' @noRd
#' @export
search_replace.default <- function(x, ...) {
  usethis::ui_stop(
    "Could not find the appropriate S3 method definition for this object: \\
    {class(x)}"
  )
}

#' S3 search_replace method for data.frame
#' @noRd
#' @export
search_replace.data.frame <- function(x, s, r) {
  if ( length(s) != length(r) ) {
    usethis::ui_stop("Search & Replace Are Unequal Lengths")
  }
  for ( i in 1:length(s) ) {
    usethis::ui_done("Replacing: {s[i]} -> {r[i]}")
    x <- apply(x, 2, function(.c) {
               .c[ .c == s[i] ] <- r[i]
               .c})
  }
  data.frame(x)
}

#' S3 search_replace method for matrix
#' @noRd
#' @export
search_replace.matrix <- function(x, s, r) {
  if ( length(s) != length(r) ) {
    usethis::ui_stop("Search & Replace Are Unequal Lengths")
  }
  for ( i in 1:length(s) ) {
    usethis::ui_done("Replacing: {s[i]} -> {r[i]}")
    x <- apply(x, 2, function(.c) {
              .c[ .c == s[i] ] <- r[i]
              .c})
  }
  x
}

#' S3 search_replace method for numeric
#' @noRd
#' @export
search_replace.numeric <- function(x, s, r) {
  if ( length(s) != length(r) ) {
    usethis::ui_stop("Search & Replace Are Unequal Lengths")
  }
  for ( i in 1:length(s) ) {
    usethis::ui_done("Replacing: {s[i]} -> {r[i]}")
    x[ x == s[i] ] <- r[i]
  }
  x
}

#' S3 search_replace method for character
#' @noRd
#' @export
search_replace.character <- search_replace.numeric

