
#' Generate an invoice.html based on the invoice data in 'x'
#' @param x invoicer object
#' @return html
#' @export
invoicer_html <- function(x,
                          include_dates = FALSE) {
  htmltools::tags$div(
    class = "invoice-box",
    htmltools::tags$table(
      cellpadding = "0",
      cellspacing = "0",
      invoicer_html_header(x),
      invoicer_html_info(x),
      invoicer_html_details(x, include_dates)
    )
  )
}