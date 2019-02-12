
#' Print Object to File
#'
#' A convenient wrapper around the \code{\link[base]{sink}} function to print
#' the resulting \code{\link[base]{print}} command to a corresponding file
#' connection. Useful for sharing data only results with collaborators or
#' medical group.
#'
#' @param ... Object(s) to be printed to file as standard output.
#' @param file File name for the output.
#' @param width Numeric. Controls the maximum number of columns on a line used
#' in printing vectors, matrices and arrays, and when filling by `cat`.
#' See also `getOption("width")`.
#' @author Stu Field
#' @seealso \code{\link[base]{sink}}, \code{\link[base]{print}}
#' @examples
#' tab <- crossTab(test_data, c("Pop", "Sample"))
#' print2file(tab, file = "table_file.txt")
#' @export print2file
print2file <- function(..., file, width = 250) {
  op <- options(width = width)
  on.exit(sink(file = NULL))
  on.exit(cat(sprintf("* Creating text file ... %s\n", file)), add = TRUE)
  on.exit(options(op), add = TRUE)
  sink(file)
  invisible(lapply(list(...), print))
}

