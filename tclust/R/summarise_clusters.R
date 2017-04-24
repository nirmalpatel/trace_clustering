#' Summarise clusters
#'
#' Get summary information for each cluster. This includes
#' number of cases and average and standard deviation of trace length.
#'
#' @param eventlog event log with column cluster in it (clustered event log)
#'
#' @return tibble of summary metrics per cluster
#'
#' @import dplyr
#'
#' @export
summarise_clusters <- function(eventlog) {

  stopifnot("cluster" %in% colnames(eventlog))

  cluster_summary <- eventlog %>%
    count(cluster, case) %>%
    group_by(cluster) %>%
    summarise(n_cases = n_distinct(case),
              avg_trace_length = mean(n),
              sd_trace_length = sd(n)) %>%
    arrange(desc(n_cases))

  cluster_summary
}
