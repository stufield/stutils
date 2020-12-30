#' Deprecated function(s) of the \pkg{stutils} package
#'
#' These functions are provided for compatibility with older versions of
#' \pkg{stuRpkg} package. They may eventually be completely
#' removed, so please re-code your scripts accordingly as soon as possible.
#'
#' \tabular{rl}{
#'   `collapse2df()`   \tab now use `do.call(rbind, ...)` \cr
#'   `mapVector()`     \tab now use `dplyr::inner_join(x, hashmap)` (hashmap contains mappings) \cr
#'   `Mapply()`        \tab now use [purrr::pmap()] \cr
#'   `mergeMetaData()` \tab now use [dplyr::left_join()] \cr
#'   `getFileExt()`    \tab now use [fs::path_ext()] \cr
#'   `optimizer()`     \tab no replacement \cr
#' }
#'
#' @rdname stutils-deprecated
#' @name stutils-deprecated
#' @docType package
#' @author Stu Field
#' @param ... A simple pass-through to a replacement alternative if available.
#' @aliases collapse2df mapVector Mapply mergeMetaData optimizer getFileExt
#' @export collapse2df mapVector Mapply mergeMetaData optimizer getFileExt
NULL


#' @noRd
collapse2df <- function(...) {
  .Deprecated("do.call(rbind, ...)", package = "stutils")
  do.call(rbind, ...)
}

#' @noRd
mapVector <- function(...) {
  .Deprecated("dplyr::inner_join()", package = "stutils")
  stop("You shall not pass!", call. = FALSE)
}

#' @noRd
Mapply <- function(...) {
  .Deprecated("purrr::pmap()", package = "stutils")
  stop("You shall not pass!", call. = FALSE)
}

#' @noRd
mergeMetaData <- function(...) {
  .Deprecated("dplyr::left_join()", package = "stutils")
  stop("You shall not pass!", call. = FALSE)
}

#' @noRd
optimizer <- function(...) {
  .Deprecated(NULL, package = "stutils")
  stop("This was a stupid function. You should not even be trying.",
       call. = FALSE)
}

#' @noRd
getFileExt <- function(...) {
  .Deprecated("fs::path_ext()", package = "stutils")
  stop("You shall not pass!", call. = FALSE)
}
