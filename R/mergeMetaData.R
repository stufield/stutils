#' Merge Meta Data
#'
#' Merge additional meta data to an existing data frame based on 
#' unique row sample identifiers. This is a wrapper around the 
#' existing \code{\link[dplyr]{left_join}}.
#'
#' @param df The existing data frame to which the meta data is to be merged.
#' @param meta Can be either:
#'   \enumerate{
#'   \item A data frame of additional meta data, with at
#'   least one common column name to match the samples OR
#'   \item A file name (and path) pointing to where to get a
#'   "*.csv" file containing meta data (this option uses a call
#'   to \code{\link[utils]{read.csv}}).
#'   }
#' @param ... Additional arguments passed to \code{\link[dplyr]{left_join}}.
#' @return A tibble object with extra columns corresponding to the meta data
#' added and indexed to the appropriate sample IDs.
#' @author Stu Field
#' @seealso \code{\link[dplyr]{left_join}}, \code{\link[utils]{read.csv}}
#' @examples
#' set.seed(101)
#' new <- data.frame(pid = sample(test_data$pid, 10), new.clin = rnorm(10))
#' mergeMetaData(test_data, new)            # use default 'by'
#' mergeMetaData(test_data, new, by = "pid") # same
#' @importFrom tibble as.tibble
#' @importFrom utils read.csv
#' @importFrom dplyr left_join
#' @export mergeMetaData
mergeMetaData <- function(df, meta, ...)  {
  if ( !is.null(tryCatch(file.exists(path.expand(meta)),
                         error = function(e) NULL)) ) {
    meta_df <- utils::read.csv(meta, stringsAsFactors = FALSE)
  } else if ( inherits(meta, c("data.frame", "tbl_df")) ) {
    meta_df <- meta
  } else {
    stop("The [meta=] argument must be either:
    1) a data.frame containing meta data OR
    2) a path to a file containing meta data", call. = FALSE)
  }
  df_merge <- dplyr::left_join(df, meta_df, ...)
  if ( nrow(df) != nrow(df_merge) ) {
    warning("New rows added during merg despite left_join()", call. = FALSE)
  }
  return(tibble::as.tibble(df_merge))
}
