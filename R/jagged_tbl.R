#' Create a Jagged Tibble
#'
#' From a list of un-equal length vectors, fill in lengths with `NA` and
#' convert to a `tibble` object.
#'
#' @param x A list of vectors to convert to 2-dimantional `tibble`.
#' @param col.names Character. A vector of names for the resulting `tibble`.
#' @return A `tibble` with columns coerced from list vector entries.
#' @examples
#' # blah
#' @importFrom tibble as_tibble
#' @importFrom usethis ui_stop
#' @importFrom purrr map_if map_int
#' @export
jagged_tbl <- function(x, col.names = NULL) {

  if ( is.null(names(x)) && is.null(col.names) ) {
    usethis::ui_stop(
      "Must pass either a *named* list OR the `col.names =` argument."
    )
  }

  if ( !is.null(col.names) && length(x) != length(col.names) ) {
    usethis::ui_stop("Incorrect length of `col.names =` argument")
  } else if ( !is.null(col.names) ) {
    names(x) <- as.character(col.names)
  }

  lengths <- purrr::map_int(x, length)
  max     <- max(lengths)
  x %>%
    purrr::map_if(lengths < max,
                  ~ c(.x, rep(NA, max - length(.x)))) %>%
    tibble::as_tibble()
}
