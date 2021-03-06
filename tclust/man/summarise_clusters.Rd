% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summarise_clusters.R
\name{summarise_clusters}
\alias{summarise_clusters}
\title{Summarise clusters}
\usage{
summarise_clusters(eventlog)
}
\arguments{
\item{eventlog}{event log with column cluster in it (clustered event log)}
}
\value{
tibble of summary metrics per cluster
}
\description{
Get summary information for each cluster. This includes
number of cases and average and standard deviation of trace length.
}
