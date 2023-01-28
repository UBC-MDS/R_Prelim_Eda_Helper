#' Create a distribution plot of the numeric variable
#'  in general and statistical summary  of the feature .
#' In addition, the  correlation values of the input
#' variable with other features based on a threshold will also be returned
#'
#' @param col_name A string  with the name of the column
#' @param data A dataframe , target DataSet for visualization
#' @param title A string , Title for chart , default =''
#' @param label_x A string,  X-axis label for numeric column
#' @param thresh_corr Number Threshold value for correlation
#' @param stat  Boolean, whether to show statistic information or not
#' @export
#' @return plot and dataframe to display summary statistics and correlation values
#'  @examples
#' num_dist_summary(
#'   col_name =num1, data=df, title='num_col1',label_x= 'distribution of num1', thresh_corr = 0.3,stat = TRUE
#' )
num_dist_summary <- function(col_name,  data, title = '', label_x = '',   thresh_corr = 0.0, stat = TRUE) {

  if (nrow(data) == 0) {
    stop("Please use a data frame with data inside")
  }
  ## check if thresh_corris numeric
  if  (is.numeric(thresh_corr) == FALSE)  {
    stop( 'Please use a numeric value for threshold')
  }
  ## check if title is string
  if ( is.character(title)== FALSE) {
    stop( "Please enter the title as string")
  }
  ## check if stat is boolean
  if (is.logical(stat) == FALSE) {
    stop( "Please enter the value for stat be  as boolean true or false")
  }
  # check if label is string
  if  (is.character(label_x) == FALSE)  {
    stop( "Please enter axis label as string")
  }
  # check if a column is present in data
  if (col_name %in% colnames(data) == FALSE) {
    stop("Column is not present in the data  ")
  }
  ## check if the column is numeric
  if (col_name %in% colnames(select_if(data, is.numeric)) == FALSE) {
    stop("Please select a numeric column")
  }



  ## create a bar chart
  hist <- ggplot2::ggplot(data, aes(.data[[col_name]])) +  ggplot2::geom_bar() +
          ggplot2::xlab(label_x) +
          ggtitle(title) + ggplot2::theme(
      plot.title = ggplot2::element_text(size = 20, face = "bold"),
      axis.text = ggplot2::element_text(size = 12),
      axis.title = ggplot2::element_text(size = 12)
    )

  num_stat <- dplyr::tibble(
    column = col_name,
    num_na = sum(is.na(data[[col_name]])),
    mean = round(mean(data[[col_name]], na.rm=TRUE),3),
    median = round(mean(data[[col_name]], na.rm=TRUE),3),
    stdev = round(sd(data[[col_name]], na.rm=TRUE),3)
  )
  if (stat == TRUE ) {
    print("Summary statistics \n" )
    print(num_stat)
  }
  colnames <-  colnames(select_if(mtcars , is.numeric))
  features <- c()
  correlation <- c()
  for (col in colnames ){

    r <-  cor(data[[col_name]], data[[col]], method = 'pearson')
    if ( r != 1 && r >= thresh_corr) {
      features <- append(features,col)
      correlation <- append(correlation, r)
    }
  }


  corr_table <- dplyr::tibble(features, correlation)
  if (nrow(corr_table)>0 ){
    print("Correlation Values \n" )
    print(corr_table)
  }
  print(hist)
}
