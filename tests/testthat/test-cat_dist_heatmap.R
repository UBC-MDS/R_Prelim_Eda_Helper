empty <- data.frame( matrix( nrow = 0, ncol = 2))
names(empty) <- c( 'a', 'b')

test_that( 'An error should be raised when an empty data frame is passed.', {
  expect_error(cat_dist_heatmap(cat_1 = a,  cat_2 = b, data = empty))
})

df = mtcars
test_that( 'An error should be raised when neither heatmap or barchart is selected.', {
  expect_error(
    cat_dist_heatmap(
      cat_1 = vs, cat_2 = am, data = data,
      title = 'Engine vs Transmission',
      lab_1 = 'Engine', lab_2 = 'Transmission', 
      heatmap = FALSE, barchart = FALSE
    )
  )
})

test_that( 'An error should be raised when neither heatmap or barchart is selected.', {
  expect_error(
    cat_dist_heatmap(
      cat_1 = vs, cat_2 = qsec, data = data,
      title = 'Engine vs 1/4 mile time',
      lab_1 = 'Engine', lab_2 = '1/4 mile time', 
      heatmap = TRUE, barchart = FALSE
    )
  )
})