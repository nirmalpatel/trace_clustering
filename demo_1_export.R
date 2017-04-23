source("functions/trace_clustering_functions.R")

# data import
log <- read_eventlog_csv("data/hospital_log.csv.gz")

# distance matrix
distance_matrix <- trace_distmatrix(log)

# model
mod <- hclust(distance_matrix, method = "average")

# cluster assignment
log_with_clusters <- cluster_eventlog(log, mod, h = 20)

# cluster summary
cluster_summary <- summarise_clusters(log_with_clusters)

# export top 5 clusters in subdirectory hospital_log
# with file prefix clusterdata_
write_clusters(log_with_clusters,
               cluster_nums = top_n_cluster_nums(cluster_summary, 5),
               subdirname = "export/hospital_log",
               filename_prefix = "clusterdata_")