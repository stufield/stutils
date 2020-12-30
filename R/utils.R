stutils_env <- new.env(parent = emptyenv())


# friendly version of !x %in% y
`%!in%` <- function(x, y) {
  !x %in% y
}

# friendly version of ifelse
`%||%` <- function(x, y) {
  if ( is.null(x) || length(x) <= 0 ) {
    y
  } else {
    x
  }
}

# test equality of R objects
`%==%` <- function(x, y) {
  isTRUE(all.equal(x, y))
}

# test identical of R objects
`%===%` <- function(x, y) {
  identical(x, y)
}

# easily test inequality of R objects
`%!=%` <- function(x, y) {
  !identical(x, y)
}

# alias for x %in% y
`%$%` <- function(x, y) {
  x[ x %in% y ]
}

# alias for !x %in% y
`%!$%` <- function(x, y) {
  x[ !x %in% y ]
}
