#' Generate and send any outstanding invoices to the client
#' @param client client name
#' @param first_bill_date date to send first bill
#' @param billing_period length of billing period (in days)
#' @export
invoicer_bill_client <- function(client = "iFixit",
                                 first_bill_date = as.Date("2018-09-24"),
                                 billing_period = 14) {

  # generate schedule
  schedule <- invoicer_billing_schedule(client, first_bill_date, billing_period)

  # compare to existing invoices
  invoices <- invoicer_get_invoices()
  invoices <- invoices[invoices$client == client, ]
  x <- dplyr::anti_join(schedule, invoices, by = c("start_date", "end_date"))

  # generate missing invoices and email them to clients
  purrr::map(
    seq_along(x$start_date),
    function(i) {
      y <- invoicer(client, x$start_date[i], x$end_date[i])
      invoicer_email(y)
    }
  )
}
