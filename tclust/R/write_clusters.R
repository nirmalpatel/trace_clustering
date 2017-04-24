#' Write clusters
#'
#' Output CSV files for clusters (one CSV per cluster). Currently this function
#' only exports case, event and completeTime columns. It also outputs a cluster_summary.csv
#' file having summary metrics of all clusters.
#'
#' @param eventlog clustered event log (event log with cluster column)
#' @param cluster_nums which cluster numbers to export
#' @param subdirname in which sub directory you want to export files?
#' @param filename_prefix prefix to attach to each output file
#'
#' @return This is a function just for side effects.
#'
#' @importFrom readr write_csv
#' @import dplyr
#'
#' @export
write_clusters <- function(eventlog, cluster_nums, subdirname = "eventlog_clusters", filename_prefix = "cluster_") {

  stopifnot("cluster" %in% colnames(eventlog))

  dir.create(subdirname, recursive = TRUE)

  cat("Writing clusters to", subdirname, "with prefix", filename_prefix, "\n\n")

  lapply(split(eventlog, eventlog[["cluster"]]), function(cluster_data) {
    cluster_number <- cluster_data[["cluster"]][[1]]

    if (cluster_number %in% cluster_nums) {

      output_filename <- paste0(filename_prefix, cluster_number, ".csv")
      output_path <- file.path(subdirname, output_filename)
      output_data <- cluster_data %>%
        select(case, event, completeTime)

      write_csv(output_data, output_path, na = "")
      cat("Exported cluster", cluster_number, "to", output_path, "\n")
    }
  })

  cluster_summary <- summarise_clusters(eventlog)
  output_filename <- "cluster_summary.csv"
  output_path <- file.path(subdirname, output_filename)
  write_csv(cluster_summary, output_path)
}
