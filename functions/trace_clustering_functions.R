read_eventlog_csv <- function(filename) {
  require(readr)
  
  # read given file
  log <- read_csv(filename)
  
  # stop if case and event columns are not found
  stopifnot(all(c("case", "event") %in% colnames(log)))
  
  # return log if there are no errors
  log
}

trace_distmatrix <- function(eventlog) {
  require(stringdist)
  
  # going to encode events with integers
  intify <- function(x) {
    y <- sort(unique(x))
    z <- setNames(1:length(y), y)
    z[x]
  }
  
  eventlog[["event_encoded"]] <- intify(eventlog[["event"]])
  
  # encoded trace list
  trace_list <- lapply(split(eventlog, eventlog[["case"]]), function(case_data) case_data[["event_encoded"]])
  
  trace_distances <- seq_distmatrix(trace_list, method = "lv")
  
  trace_distances
}

summarise_cases <- function(eventlog) {
  require(dplyr)
  
  case_summary <- eventlog %>%
    group_by(case) %>%
    summarise(trace_length = n(),
              unique_activities = n_distinct(event))
  
  case_summary
}

summarise_log <- function(eventlog) {
  require(dplyr)
  
  case_summary <- summarise_cases(eventlog)
  
  n_cases <- nrow(case_summary)
  
  avg_trace_length <- mean(case_summary[["trace_length"]])
  sd_trace_length <- sd(case_summary[["trace_length"]])
  
  avg_unique_activities <- mean(case_summary[["unique_activities"]])
  sd_unique_activities <- sd(case_summary[["unique_activities"]])
  
  log_summary <- c("Number of cases" = n_cases,
    "Average trace length" = avg_trace_length,
    "SD trace length" = sd_trace_length,
    "Average unique activities (per trace)" = avg_unique_activities,
    "SD unique activities (per trace)" = sd_unique_activities)
  
  log_summary
  
}

cluster_eventlog <- function(eventlog, m, ...) {
  require(dplyr)
  
  stopifnot(class(m) == "hclust")
  
  # cut tree at a specific place to generate cluster assignments
  clusters <- cutree(m, ...)
  
  # make log with cluster information
  eventlog_clustered <- eventlog %>%
    mutate(cluster = clusters[as.character(case)])
  
  eventlog_clustered
}

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

top_n_cluster_nums <- function(cluster_summary, n = 5) {
  
  stopifnot(all(c("cluster", "n_cases") %in% colnames(cluster_summary)))
  
  top_clusters <- head(cluster_summary, n = n)
  top_clusters[["cluster"]]
}

write_clusters <- function(eventlog, cluster_nums, subdirname = "eventlog_clusters", filename_prefix = "cluster_") {
  require(readr)
  
  stopifnot("cluster" %in% colnames(eventlog))
  
  dir.create(subdirname, recursive = TRUE)
  
  cat("Writing clusters to", subdirname, "with prefix", filename_prefix, "\n\n")
  
  lapply(split(eventlog, eventlog[["cluster"]]), function(cluster_data) {
    cluster_number <- cluster_data[["cluster"]][[1]]
    
    if (cluster_number %in% cluster_nums) {
      output_filename <- paste0(filename_prefix, cluster_number, ".csv")
      output_path <- file.path(subdirname, output_filename)
      write_csv(cluster_data, output_path, na = "")
      cat("Exported cluster", cluster_number, "to", output_path, "\n")
    }
  })
  
  cluster_summary <- summarise_clusters(eventlog)
  output_filename <- "cluster_summary.csv"
  output_path <- file.path(subdirname, output_filename)
  write_csv(cluster_summary, output_path)
}