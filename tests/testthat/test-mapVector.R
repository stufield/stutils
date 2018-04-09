# --------------------
# Revision Info
# --------------------
# $Id$
# $Author$
# $Date$
##################################
context("Map Vectors")

time <- factor(rep(c("baseline", "6 months", "12 months", "24 months"), each = 10),
               levels = c("baseline", "6 months", "12 months", "24 months"))

test_that("MapVector Factor", {
  f <- mapVector(time,
                 list(c("baseline", "24 months"),
                      c("6 months", "12 months")),
                 c("one", "two"))
  expect_is(f, "factor")
  expect_equal(levels(f), c("one", "two"))
  expect_equal(c(table(f)), c("one" = 20, "two" = 20))
  expect_equal(as.character(f), rep(c("one", "two", "two", "one"), rep(10, 4)))
})


test_that("MapVector Character", {
  f <- mapVector(head(LETTERS, 5), list(c("A", "B"), c("D", "E")),
                 c("one", "two"))
  expect_is(f, "character")
  expect_null(levels(f))
  expect_equal(c(table(f)), c("C" = 1, "one" = 2, "two" = 2))
  expect_equal(f, c("one", "one", "C", "two", "two"))

  f <- mapVector(head(LETTERS, 5), list(c("A","B"), c("D","E")),
                 c("one","two"), nomatch = "No")
  expect_is(f, "character")
  expect_null(levels(f))
  expect_equal(c(table(f)), c("No" = 1, "one" = 2, "two" = 2))
  expect_equal(f, c("one", "one", "No", "two", "two"))

  # character -> integer
  expect_warning(f <- mapVector(head(LETTERS, 5),
                                list(c("A", "B"), c("C", "D", "E")),
                                1:2))
  expect_is(f, "integer")
  expect_null(levels(f))
  expect_equal(c(table(f)), c("1" = 2, "2" = 3))
  expect_equal(f, rep(1:2, c(2, 3)))
})


test_that("MapVector Intger", {
  f <- mapVector(1:5, list(1:3, 4:5), 1:2)
  expect_is(f, "integer")
  expect_equal(c(table(f)), c("1" = 3, "2" = 2))
  expect_equal(f, rep(1:2, c(3, 2)))

  f <- mapVector(1:5, list(1:2, 4:5), 1:2)  # '3' is unmatched
  expect_is(f, "integer")
  expect_equal(c(table(f)), c("1" = 2, "2" = 2, "3" = 1))
  expect_equal(f, c(1, 1, 3, 2, 2))

  f <- mapVector(1:5, list(1:2, 4:5), 1:2, nomatch = 8)  # '3' -> '8'
  expect_is(f, "integer")
  expect_equal(c(table(f)), c("1" = 2, "2" = 2, "8" = 1))
  expect_equal(f, c(1, 1, 8, 2, 2))

  # integer -> character
  expect_warning(f <- mapVector(rep(1:4, each = 10),
                 list(c(1, 2), c(3, 4)), c("one", "two")))
  expect_is(f, "character")
  expect_equal(c(table(f)), c("one" = 20, "two" = 20))
  expect_equal(f, rep(c("one","two"), rep(20, 2)))
})


