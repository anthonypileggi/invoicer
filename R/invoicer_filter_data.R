#' Filter invoice data
#' @param x invoice data (\code{\link{invoicer_get_data}})
#' @param client client name (character/scalar)
#' @param start_date first day of work (Date/scalar)
#' @param end_date last day of work (Date/scalar)
#' @export
invoicer_filter_data <- function(x, client, start_date, end_date) {

  # rename inputs
  this_client <- client
  this_start_date <- start_date
  this_end_date <- end_date

  # apply filters
  x$clients <- dplyr::filter(x$clients, client == this_client)
  x$worklog <- dplyr::filter(x$worklog, client == this_client, date >= this_start_date, date <= this_end_date)
  x$invoices <- dplyr::filter(x$invoices, client == this_client)

  # attach parameters
  x$params$client <- client
  x$params$start_date <- start_date
  x$params$end_date <- end_date

  x
}