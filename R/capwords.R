
#' Capitalize Title Format
#'
#' Change case to capitalize first letter of each word in a character string.
#'
#' @param s A character string in the form of a sentence to be converted to
#' "title case" (i.e. first letter capitalized).
#' @param strict Logical. Should first letter capitalization be \emph{strictly}
#' applied? See example.
#' @return A character string with "title case" conversion.
#' @author Stu Field
#' @seealso \code{\link[base]{toupper}}, \code{\link[base]{tolower}}, \code{\link[base]{strsplit}}
#' @examples
#' capwords("using AIC for model selection")
#' ## ->  [1] "Using AIC For Model Selection"
#' capwords(c("using AIC", "for MODEL selection"), strict = TRUE)
#' ## ->  [1] "Using Aic"  "For Model Selection"
#' ##                ^^^        ^^^^^
#' ##               "bad"       "good"
#' @export capwords
capwords <- function(s, strict = FALSE) {
  sapply(strsplit(s, split = " "), function(.s) {
    ss <- substring(.s, 2)
    tt <- if ( strict ) tolower(ss) else ss
    paste(toupper(substring(.s, 1, 1)), tt, sep = "", collapse = " ")
  }, USE.NAMES = !is.null(names(s)))
}
