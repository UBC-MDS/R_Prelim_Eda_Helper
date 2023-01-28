empty <- data.frame( matrix( nrow = 0, ncol = 2))
names( empty) <- c( 'f', 'g')
test_that( 'An error should be raised when an empty data frame is passed.', {
  expect_error( num_dist_summary( col_name = 'f',  data = empty))
})

test_that( 'An error should be raised when an wrong data  is passed to threshold.', {
  expect_error( num_dist_summary( col_name = "mpg",  data = mtcars, thresh_corr = "12"))
})
test_that( 'An error should be raised when an wrong data  is passed to threshold.', {
  expect_error( num_dist_summary( col_name = "mpg",  data = mtcars,title =12,  thresh_corr = "12"))
})

test_that( 'An error should be raised when an wrong data  is passed to stat', {
  expect_error( num_dist_summary( col_name = "mpg",  data = mtcars,title ="Title",  thresh_corr = 0.3, stat = 1))
})

test_that( 'An error should be raised when an wrong data  is passed to label', {
  expect_error( num_dist_summary( col_name = "mpg",  data = mtcars,label =123, title ="test",  thresh_corr = 0.3, stat = TRUE))
})

test_that( 'An error should be raised when an wrong data  is passed to label', {
  expect_error( num_dist_summary( col_name = "mp",  data = mtcars,label ='', title ="test",  thresh_corr = 0.3, stat = TRUE))
})

