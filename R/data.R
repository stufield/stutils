
#' Tree Data
#' 
#' Data set containing tree characteristic metric data, that has been blinded
#' and anonymized from its original source. Used heavily in the \code{R}
#' tutorial and for general data frame usage (e.g. package testing).
#' 
#' @name TreeData
#' @docType data
#' @format A data frame containing 20 cases and numerous random variables
#' @references Originally from Sala et al., but heavily modified to be
#' unrecognizable and used as the main example data set for the R tutorial.
#' @source Stu Field
#' @examples
#'
#' head(TreeData)
#' summary(TreeData)
#' suppressWarnings(sapply(TreeData, mean))
#'
#' @keywords R_tutorial
NULL

#' 6 Class Population Projection
#' 
#' This data set it the data produced by the projection for the 6 class example
#' used in the R tutorial
#' 
#' @name popdata
#' @aliases popdata
#' @docType data
#' @format A matrix of the 6-class population projection with classes
#' as columns and the map/step solutions as the rows
#' @references Stu Field, The R Tutorial.
#' @source Stu Field
#' @examples
#'
#' head(popdata, 10)
#'
#' @keywords R Tutorial
NULL

#' Coefficient Interclass Correlation Data Example
#' 
#' Coefficient Interclass Correlation Data Example from Sokal & Rohlf
#' (Biometry; 3rd ed.), pages 210-214.
#' 
#' @name Ri_data
#' @docType data
#' @format A data frame of data with treatments as columns and rows as
#' cases
#' @references Sokal & Rohlf (Biometry; 3rd ed.), p. 210-214.
#' @source Stu Field
#' @examples
#'
#' Ri_data
#'
#' @keywords Ri
NULL

#' Monte-Carlo Integration Simulation
#' 
#' Vector containing 1000 simulation estimates of the 
#' Monte-Carlo integral estimate (area under curve) for a 
#' given function. The simulation is time greedy so these 
#' data are saved as an object.
#' 
#' @name MC_sims
#' @aliases MC_sims
#' @docType data
#' @format Vector containing the estimates of the Monte-Carlo simulation of the
#' integral of a given function
#' @references Stu Field
#' @source Bill Black
#' @examples
#'
#' head(MC_sims)
#' tail(MC_sims)
#' mean(MC_sims)
#' hist(MC_sims)
#'
#' @keywords Student Demo
NULL

#' Infection data by US County
#' 
#' Infection data describing the infections count data of an infectious disease
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
#' 
#' @name InfectionByCounty
#' @docType data
#' @format A data frame containing 3082 individual cases/records.
#' @references Infection data originally from Dylan George and 
#' used for an exercise data set in the EEID R tutorial (2010). 
#' @source Stu Field
#' @examples
#'
#' head(InfectionByCounty)
#'
#' @keywords R tutorial
NULL


#' Sample Test Data Frame
#'
#' A quick sample tibble data frame for running examples and 
#' checking data frame functionalities. See \code{?tibble}.
#'
#' @name test_data
#' @docType data
#' @format test_data a tibble object:
#'
#' \tabular{ll}{
#'   Column \tab Definition \cr
#'   pid \tab seq(1041, 1080, 1) \cr
#'   Pop \tab rep(LETTERS[\verb{1:10]}) \cr
#'   Sample \tab sample(c("small", "medium", "large"), 20) \cr
#'   TimePoint \tab rep(c("baseline", "6 mths", "12 mths", "24 mths"), each = 10) \cr
#'   a \tab 1:length(test_data$TimePoint) \cr
#'   b \tab sample(\verb{1:10}, 40, replace = TRUE) \cr
#'   ABCD.1234.56.8 \tab rnorm(40, 25, 3) \cr
#'   XYZZ.6969.4.7 \tab rnorm(40, 25, 3) \cr
#'   x \tab test_data$a * runif (length(test_data$a), 0.25, 0.75) \cr
#'   y \tab sample(11:20, 40, replace = TRUE) \cr
#'   z \tab Mod(round(sample(rnorm(40)), 3)) \cr
#'   Response \tab sample(c("control", "disease"), 40, replace = TRUE)) \cr
#' }
#'
#' @source Stu Field
#' @keywords datasets
#' @examples
#'
#' dim(test_data)
#' head(test_data)
#'
NULL
