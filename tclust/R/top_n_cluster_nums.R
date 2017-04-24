#' Pick top n clusters
#'
#' Simply picks top n rows from cluster summary tibble
#'
#' @param cluster_summary cluster summary tibble made using
#' \link{summarise_clusters}
#' @param n how many top clusters to pick?
#'
#' @export
top_n_cluster_nums <- function(cluster_summary, n = 5) {

  stopifnot(all(c("cluster", "n_cases") %in% colnames(cluster_summary)))

  top_clusters <- head(cluster_summary, n = n)
  top_clusters[["cluster"]]
}
