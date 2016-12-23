context("Test R diag")

test_that("diagR unit test", {
			 m <- diagR(1:6)
			 expect_is(m, "matrix")
			 expect_equal(length(m), 6*6)
			 expect_equal(sum(m), sum(1:6))
})
