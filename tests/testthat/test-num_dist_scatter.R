df = palmerpenguins::penguins
df_empty <- tibble::tibble()

result <- num_dist_scatter(num1='bill_length_mm', num2='body_mass_g', data=df,
                           title = 'num1 vs num2', stat=FALSE, trend=FALSE)
test_that( 'A ggplot object is not returned!', {
  expect_equal(class(result)[[2]], 'ggplot')
})

test_that( 'Errors should be raised if column must be numeric!', {
  expect_error(num_dist_scatter(num1='island', num2='body_mass_g', data=df,
                                title = 'num1 vs num2', stat=FALSE, trend=FALSE))
})

test_that( 'Errors should be raised if column must be numeric!', {
  expect_error(num_dist_scatter(num1='bill_length_mm', num2='species', data=df,
                                title = 'num1 vs num2', stat=FALSE, trend=FALSE))
})

test_that( 'Error should be raised if dataframe is empty', {
  expect_error(num_dist_scatter(num1='bill_length_mm', num2='body_mass_g', data=df_empty,
                                stat=TRUE, trend=FALSE))
})
