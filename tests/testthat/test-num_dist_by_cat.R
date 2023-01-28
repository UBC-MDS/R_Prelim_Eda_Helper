df = mtcars
result <- num_dist_by_cat( num = mpg, group = vs, data = df)
test_that( 'A ggplot object is returned', {
  expect_equal( 'list', typeof( result))
  expect_equal( class( result)[[1]], 'gg')
})

empty <- data.frame( matrix( nrow = 0, ncol = 2))
names( empty) <- c( 'f', 'g')
test_that( 'An error should be raised when an empty data frame is passed.', {
  expect_error( num_dist_by_cat( num = f, group = g, data = empty))
})

single_group <- df |>
  dplyr::filter( vs == '1')
test_that( 'An error should be raised when there is only 1 class in the group column', {
  expect_error( num_dist_by_cat( num = mpg, group = vs, data = single_group))
})
