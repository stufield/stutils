GitHub stuRpkg Library
-----------
Small suite of useful functions, subroutines, and data objects for
data set manipulation and analysis in R.

-------------------------

[![Travis-CI Build Status](https://travis-ci.org/stufield/stuRpkg.svg?branch=master)](https://travis-ci.org/stufield/stuRpkg)
[![codecov.io](http://codecov.io/github/stufield/stuRpkg/coverage.svg?branch=master)](http://codecov.io/github/stufield/stuRpkg?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/stuRpkg)](https://cran.r-project.org/package=stuRpkg)

-------------------------


## Installation of development version ##
To install the latest development version of stuRpkg from GitHub:
```r
devtools::install_github("stufield/stuRpkg")
```

-------------------------

### Datasets

* **nyflights13**
    + new york city airport flight data from 2013 (**must install**)
    + install with `install.packages("nyflights13", repos="http://cran.rstudio.com")`
* **TreeData**
    + Sala et. al.
* **popdata**
    + This data set it the data produced by the projection for
      the 6 class example used in the EEID R tutorial.
* **Ri_data**
    + Coefficient Interclass Correlation Data Example from Sokal & Rohlf
      (Biometry; 3rd ed.), pages 210-214.
* **MC_sims**
    + Vector containing 1000 simulation estimates of the 
      Monte-Carlo integral estimate (area under curve) for a 
      given function. The simulation is time greedy so these 
      data are saved as an object.
* **InfectionByCounty**
    + Infection data describing the infections count data of an infectious disease
      by geographic position for 3082 individual cases.
    + Source: Dylan George, EEID 2008
* **test_data**
      + A quick sample tibble data frame for running examples and 
        checking data frame functionalities. See `\code{?tibble}`.
      + The format of `test_data` is:

| Column          | Definition           |
| --------------: | :------------------- | 
| pid             | `seq(1041, 1080, 1)` |
| Pop             | `rep(LETTERS[1:10])` |
| Sample          | `sample(c("small", "medium", "large"), 20)` |
| TimePoint       | `rep(c("baseline", "6 mths", "12 mths", "24 mths"), each = 10)` |
| a               | `1:length(test_data$TimePoint)` |
| b               | `sample(1:10, 40, replace = TRUE)` |
| ABCD.1234.56.8  | `rnorm(40, 25, 3)` |
| XYZZ.6969.4.7   | `rnorm(40, 25, 3)` |
| x               | `test_data$a * runif (length(test_data$a), 0.25, 0.75)` |
| y               | `sample(11:20, 40, replace = TRUE)` |
| z               | `Mod(round(sample(rnorm(40)), 3))` |
| Response        | `sample(c("control", "disease"), 40, replace = TRUE))` |


-------------------------

### Hadley Wickham Book
[R for Data Science](http://r4ds.had.co.nz/)

-------------------------

### Cheatsheets:
RStudio [cheatsheets](https://www.rstudio.com/resources/cheatsheets/)

-------------------------

### Vignettes:
  * [dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)
  * [tidyr](http://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)

-------------------------

### What is the Tidyverse?

  * The [tidyverse](https://www.tidyverse.org/)
  * The tidyverse [packages](https://www.tidyverse.org/packages/)
  * Converting to the [Tidyverse](http://www.significantdigits.org/2017/10/switching-from-base-r-to-tidyverse/)

