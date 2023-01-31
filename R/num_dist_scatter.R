#' num_dist_scatter
#' Creates a scatter plot given two numerical features.
#'
#' @param num1 A string for the name of the column for the first numeric feature.
#' @param num2 A string for the name of the column for the second numeric feature.
#' @param data A dataframe for visualization.
#' @param title A string for the title for the chart.
#' @param stat Boolean whether or not to include simple statistics.
#' @param trend A string for the type of trend line. Options are: FALSE, 'lm', 'loess'.
#' @export
#' @return A ggplot scatter plot object
#'  @examples
#' num_dist_scatter(
#'   num1='num1', num2='num2', data=df, title='num1 v num2', stat = TRUE, trend='lm'
#' )
num_dist_scatter <- function(num1, num2, data, title = '', stat = FALSE, trend = FALSE){
  df1 <- data |>
    dplyr::select(all_of(num1), all_of(num2))

  # simple stats
  num1_stat <- tibble::tibble(
    column = num1,
    num_na = sum(is.na(df1[[num1]])),
    mean = round(mean(df1[[num1]], na.rm=TRUE),3),
    median = round(mean(df1[[num1]], na.rm=TRUE),3),
    stdev = round(sd(df1[[num1]], na.rm=TRUE),3)
  )
  num2_stat <- tibble::tibble(
    column = num2,
    num_na = sum(is.na(df1[[num2]])),
    mean = round(mean(df1[[num2]], na.rm=TRUE),3),
    median = round(mean(df1[[num2]], na.rm=TRUE),3),
    stdev = round(sd(df1[[num2]], na.rm=TRUE),3)
  )
  stats <- dplyr::bind_rows(num1_stat, num2_stat)

  if(stat == TRUE){
    print(stats)
  }

  # replace na with mean value
  imp_obj <- mice::mice(df1, m=1, method='mean', maxit=1, seed=123)
  df1 <- mice::complete(imp_obj,1)

  if(num1_stat$num_na != 0){
    message("**num1 NaN replaced with mean ", stats[[1,3]], '**')
  }
  if(num2_stat$num_na != 0){
    message('**num2 NaN replaced with mean ', stats[[2,3]], '**')
  }

  # correlation table
  pear <- stats::cor.test(df1[[num1]], df1[[num2]],
                          method = "pearson", alternative = "two.sided")$estimate
  ppear <- stats::cor.test(df1[[num1]], df1[[num2]],
                           method = "pearson", alternative = "two.sided")$p.value
  spear <- stats::cor.test(df1[[num1]], df1[[num2]],
                           method = "spearman", alternative = "two.sided")$estimate
  pspear <- stats::cor.test(df1[[num1]], df1[[num2]],
                            method = "spearman", alternative = "two.sided")$p.value
  corr <- tibble::tibble(
    Method = c("Pearson's", "Spearman's"),
    Correlation = c(round(pear,3), round(spear, 3)),
    P_value = c(ppear, pspear)
  )
  print(corr)

  # scatter plot
  plot <- df1 |>
    ggplot2::ggplot(ggplot2::aes(x=df1[[num1]], y=df1[[num2]])) +
    ggplot2::geom_point() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = 20, face = "bold"),
      axis.text = ggplot2::element_text(size = 12),
      axis.title = ggplot2::element_text(size = 12)
    ) +
    ggplot2::ggtitle(title) +
    ggplot2::labs(x = num1,
                  y = num2)

  reg_line <- ggplot2::geom_smooth(ggplot2::aes(x=df1[[num1]], y=df1[[num2]]),
                                   se=FALSE, method=trend)

  if (trend != FALSE){
    suppressWarnings(print(plot + reg_line))
  } else{
    suppressWarnings(print(plot))
  }
}
