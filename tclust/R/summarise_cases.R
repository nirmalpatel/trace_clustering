#' Summarise cases
#'
#' Get trace length and number of unique activity
#' for every case in event log.
#'
#' @param eventlog event log having case and event columns
#'
#' @return tibble having case, trace_length and unique_activities
#' columns
#'
#' @import dplyr
#'
#' @export
summarise_cases <- function(eventlog) {

  case_summary <- eventlog %>%
    group_by(case) %>%
    summarise(trace_length = n(),
              unique_activities = n_distinct(event))

  case_summary
}
