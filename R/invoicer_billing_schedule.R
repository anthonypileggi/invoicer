#' Create a billing schedule for a client (through today)
#' @param client client name (character/scalar)
#' @param first_bill_date date of the first invoice (Date/scalar)
#' @param billing_period length of billing period in days (numeric/scalar)
#' @export
invoicer_billing_schedule <- function(client = "iFixit",
                                      first_bill_date = as.Date("2018-09-24"),
                                      billing_period = 14) {

  # get date of first project
  worklog <- invoicer_get_worklog()
  first_work_date <- min(worklog$date[worklog$client == client])

  # build schedule
  x <- tibble::tibble(start_date = first_work_date, end_date = first_bill_date - 1)
  billing_days <- as.integer(difftime(Sys.Date(), first_bill_date, units = "day"))
  bill_seq <- seq(0, billing_days, by = billing_period)
  billing_schedule <- tibble::tibble(
    start_date = first_bill_date + bill_seq,
    end_date = first_bill_date + billing_period - 1 + bill_seq
  )
  billing_schedule <- dplyr::bind_rows(x, billing_schedule)
  billing_schedule <- dplyr::filter(billing_schedule, end_date < Sys.Date())
  billing_schedule <- dplyr::mutate(billing_schedule, id = dplyr::row_number())
  dplyr::select(billing_schedule, id, start_date, end_date)
}