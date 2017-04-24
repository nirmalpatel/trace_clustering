#' Cluster event log
#'
#' This function does cluster assignments using a given
#' model of class \link{hclust} and \link{cutree} function
#'
#' @param eventlog event log
#' @param m model of class \link{hclust}
#' @param ... further arguments to be passed to \link{cutree}
#'
#' @return event log with column cluster
#'
#' @import dplyr
#' @importFrom stats cutree
#'
#' @export
cluster_eventlog <- function(eventlog, m, ...) {

  stopifnot(class(m) == "hclust")

  # cut tree at a specific place to generate cluster assignments
  clusters <- cutree(m, ...)

  # make log with cluster information
  eventlog_clustered <- eventlog %>%
    mutate(cluster = clusters[as.character(case)])

  eventlog_clustered
}
