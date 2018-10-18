
#' Generate an invoice.html based on the invoice data in 'x'
#' @param x invoicer object
#' @param include_dates include a 'Date' column in invoice?
#' @param aggregate aggregate projects over multiple days
#' @return html
#' @export
invoicer_html <- function(x,
                          include_dates = FALSE,
                          aggregate = FALSE) {
  htmltools::tags$div(
    class = "invoice-box",
    htmltools::tags$table(
      cellpadding = "0",
      cellspacing = "0",
      invoicer_html_header(x, include_dates),
      invoicer_html_info(x, include_dates),
      invoicer_html_details(x, include_dates, aggregate)
    )
  )
}