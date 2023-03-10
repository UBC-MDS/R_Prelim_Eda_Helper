% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/num_dist_scatter.R
\name{num_dist_scatter}
\alias{num_dist_scatter}
\title{num_dist_scatter
Creates a scatter plot given two numerical features.}
\usage{
num_dist_scatter(num1, num2, data, title = "", stat = FALSE, trend = FALSE)
}
\arguments{
\item{num1}{A string for the name of the column for the first numeric feature.}

\item{num2}{A string for the name of the column for the second numeric feature.}

\item{data}{A dataframe for visualization.}

\item{title}{A string for the title for the chart.}

\item{stat}{Boolean whether or not to include simple statistics.}

\item{trend}{A string for the type of trend line. Options are: FALSE, 'lm', 'loess'.}
}
\value{
A ggplot scatter plot object
@examples
num_dist_scatter(
num1='num1', num2='num2', data=df, title='num1 v num2', stat = TRUE, trend='lm'
)
}
\description{
num_dist_scatter
Creates a scatter plot given two numerical features.
}
