#' Print Object to File
#'
#' A thin wrapper around the [sink()] function to print
#' the corresponding object to a file connection.
#'
#' @param ... Object(s) to be printed to file as standard output.
#' @param file File name for the output.
#' @param width Numeric. Controls the maximum number of columns on a line used
#' in printing vectors, matrices and arrays, and when filling by [cat()].
#' See also `getOption("width")`.
#' @author Stu Field
#' @seealso [sink()]
#' @examples
#' tab <- cross_tabulate(mtcars, cyl, carb)
#' print2file(tab, file = "table_file.txt")
#' @importFrom usethis ui_done
#' @importFrom withr defer with_options
#' @export
print2file <- function(..., file, width = 250) {
  usethis::ui_done("Creating text file ... {file}.")
  withr::defer(sink(file = NULL))
  withr::with_options(c(width = width), {
    sink(file)
    invisible(lapply(list(...), print))
  })
}
