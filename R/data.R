

#' Package Objects
#'
#' @description Below is a listing of all the objects contained in the
#' "stuRpkg" beginner package. There is a short description of
#' each object, and perhaps a description of its elements, how they were
#' derived, and their sources. Authorship of the object is attributed where
#' it is known.
#' @name objects
NULL


# Tree Data

#' @describeIn objects Data set containing tree characteristic metric data,
#' that has been blinded
#' and anonymized from its original source. Used heavily in the \code{R}
#' tutorial and for general data frame usage (e.g. package testing).
#' The format is "tibble" data frame containing 20 cases and numerous random variables
#' @references \code{TreeData}: originally from Sala et al., but heavily modified to be
#' unrecognizable and used as the main example data set for the EEID R tutorial.
#' @source TreeData: Stu Field
#' @examples
#' head(TreeData)
#' summary(TreeData)
#' suppressWarnings(sapply(TreeData, mean))
#'
#' @keywords Rtutorial
#' @usage TreeData
TreeData <- function() NULL


# 6 Class Population Projection

#' @describeIn objects A data set it the data produced by the
#' projection for the 6 class example used in the EEID R tutorial.
#' The format is a matrix of the 6-class population projection with classes
#' as columns and the map/step solutions as the rows
#' @references \code{popdata}: Stu Field (The EEID R Tutorial)
#' @source popdata: Stu Field
#' @examples
#' head(popdata, 10)
#'
#' @keywords Rtutorial
#' @usage popdata
popdata <- function() NULL


# Coefficient Interclass Correlation Data Example

#' @describeIn objects Coefficient Interclass Correlation Data Example
#' from Sokal & Rohlf (Biometry; 3rd ed.), pages 210-214.
#' The format is a data frame of data with treatments as
#' columns and rows as  cases.
#' @references \code{Ri_data}: Sokal & Rohlf (Biometry; 3rd ed.), p. 210-214.
#' @examples
#' Ri_data
#'
#' @keywords Ri
#' @usage Ri_data
Ri_data <- function() NULL


# Monte-Carlo Integration Simulation

#' @describeIn objects A vector containing 1000 Monte-Carlo simulation
#' estimates of the integral estimate (area under curve) for a
#' given function. The simulation is time greedy so these
#' data are saved as an object.
#' The format is a numeric vector of length = 1000.
#' @references \code{MC_sims}: Bill Black IV
#' @examples
#' head(MC_sims)
#' tail(MC_sims)
#' mean(MC_sims)
#' hist(MC_sims)
#'
#' @usage MC_sims
MC_sims <- function() NULL


# Infection data by US County

#' @describeIn objects Infection data describing the infections
#' count data of an infectious disease
#' by geographic position. Includes the following headings: \cr
#' \itemize{
#'   \item CountyNo
#'   \item CountyNo
#'   \item CountyName
#'   \item State
#'   \item Fips
#'   \item Site
#'   \item Lat
#'   \item Long
#'   \item Population
#'   \item Area
#'   \item Density
#'   \item Infected
#' }
#' A "tibble" data frame containing 3082 individual cases/records.
#' @references \code{InfectionByCounty}: originally from Dylan George and
#' used for an exercise data set in the EEID R tutorial (2010).
#' @source InfectionByCounty: Dylan George
#' @examples
#' head(InfectionByCounty)
#'
#' @usage InfectionByCounty
InfectionByCounty <- function() NULL


# Sample Test Data Frame

#' @describeIn objects A quick sample tibble data frame for
#' running examples and checking data frame functionalities.
#' See \code{?tibble}.
#' \tabular{lr}{
#'   Variable       \tab Definition \cr
#'   pid            \tab seq(1041, 1080, 1) \cr
#'   Pop            \tab rep(LETTERS[\verb{1:10]}) \cr
#'   Sample         \tab sample(c("small", "medium", "large"), 20) \cr
#'   TimePoint      \tab rep(c("baseline", "6 mths", "12 mths", "24 mths"), each = 10) \cr
#'   a              \tab 1:length(test_data$TimePoint) \cr
#'   b              \tab sample(\verb{1:10}, 40, replace = TRUE) \cr
#'   ABCD.1234.56.8 \tab rnorm(40, 25, 3) \cr
#'   XYZZ.6969.4.7  \tab rnorm(40, 25, 3) \cr
#'   x              \tab test_data$a * runif (length(test_data$a), 0.25, 0.75) \cr
#'   y              \tab sample(11:20, 40, replace = TRUE) \cr
#'   z              \tab Mod(round(sample(rnorm(40)), 3)) \cr
#'   Response       \tab sample(c("control", "disease"), 40, replace = TRUE)) \cr
#' }
#' @source test_data: Stu Field
#' @examples
#' dim(test_data)
#' head(test_data)
#' @usage test_data
test_data <- function() NULL
