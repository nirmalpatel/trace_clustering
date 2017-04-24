#' Read event log in CSV format
#'
#' Currently, this function requires case, event and completeTime
#' columns to be present in event log to be read.
#'
#' @param filename path to event log
#'
#' @return tibble having event log
#'
#' @importFrom readr read_csv
#'
#' @export
read_eventlog_csv <- function(filename) {

  # read given file
  log <- read_csv(filename)

  # stop if case and event columns are not found
  stopifnot(all(c("case", "event", "completeTime") %in% colnames(log)))

  # return log if there are no errors
  log
}
