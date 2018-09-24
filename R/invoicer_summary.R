
#' Invoice summary
#' @param x invoice data from \code{\link{invoicer_filter_data}}
invoicer_summary <- function(x) {
  dplyr::summarize(
    x$worklog,
    id = x$next_invoice_id,
    client = x$params$client,
    start_date = format(x$params$start_date, format = "%m/%d/%Y"),
    end_date = format(x$params$end_date, format = "%m/%d/%Y"),
    total = sum(hours * rate)
  )
}