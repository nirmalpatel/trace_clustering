#' Compute trace distance matrix
#'
#' This function uses \link{seq_distmatrix} from \code{stringdist} package
#' to compute pairwise distance matrix.
#'
#' @param method string distance method to be used as discussed in
#' \link{stringdist-metrics}
#' @param ... further arguments to be passed to \link{seq_distmatrix}
#'
#' @return \code{dist} object having pairwise distances between
#' traces
#'
#' @importFrom stringdist seq_distmatrix
#'
#' @export
trace_distmatrix <- function(eventlog, method = "lv", ...) {

  # going to encode events with integers
  intify <- function(x) {
    y <- sort(unique(x))
    z <- setNames(1:length(y), y)
    z[x]
  }

  eventlog[["event_encoded"]] <- intify(eventlog[["event"]])

  # encoded trace list
  trace_list <- lapply(split(eventlog, eventlog[["case"]]), function(case_data) case_data[["event_encoded"]])

  trace_distances <- seq_distmatrix(trace_list, method = method, ...)

  trace_distances
}
