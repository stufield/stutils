context("Test Zeros")

test_that("zeros unit test", {
			 m = zeros(4)
			 expect_is(m, "matrix")
			 expect_equal(length(m), 16)
			 expect_equal(sum(m), 0)
})
