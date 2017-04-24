#' Summarise event log
#'
#' Returns summary metrics of event log
#'
#' @param eventlog event log
#'
#' @return named vector having summary metrics
#'
#' @export
summarise_eventlog <- function(eventlog) {

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
