% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cluster_eventlog.R
\name{cluster_eventlog}
\alias{cluster_eventlog}
\title{Cluster event log}
\usage{
cluster_eventlog(eventlog, m, ...)
}
\arguments{
\item{eventlog}{event log}

\item{m}{model of class \link{hclust}}

\item{...}{further arguments to be passed to \link{cutree}}
}
\value{
event log with column cluster
}
\description{
This function does cluster assignments using a given
model of class \link{hclust} and \link{cutree} function
}
