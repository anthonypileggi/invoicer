#' Check if an invoice should be created based on the data provided
#' @param x invoice data
#' @export
invoicer_check_data <- function(x) {

  # check: is it for a single client?
  if (nrow(x$clients) != 1) {
    message("Can only generate an invoice for 1 client per invoice.")
    return(FALSE)
  }

  # check: does it already exists?
  tmp <-
    dplyr::filter(
      x$invoices,
      client == x$params$client,
      start_date == x$params$start_date,
      end_date == x$params$end_date
      )
  if (nrow(tmp) > 0) {
    message("A matching invoice already exists.")
    return(FALSE)
  }

  # check: are there any projects?
  if (nrow(x$worklog) == 0) {
    message("No projects.")
    return(FALSE)
  }

  return(TRUE)
}