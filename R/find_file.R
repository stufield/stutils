#' Determine Path to File
#'
#' Determine the path of a defined file via brute force search of
#' (optionally) the root directory.
#'
#' @param pattern Character string of the pattern match.
#' @param root The path of the root directory to start the highest level
#' search.
#' @return The path(s) containing the regular expression specified in `pattern`.
#' @examples
#' \dontrun{
#' find_file("infection_data.csv")
#' fs::file_create("myfile.txt")
#' find_file("myfile.txt")
#' }
#' @importFrom fs dir_ls
#' @export
find_file <- function(pattern, root = Sys.getenv("HOME")) {
  fs::dir_ls(root, regexp = pattern, recurse = TRUE)
}
