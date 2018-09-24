
#' Generate an invoice.html based on the invoice data in 'x'
#' @param x custom invoice data (class)
#' @return html
#' @export
invoicer_html <- function(id = 1,
                          date_created = Sys.Date(),
                          date_due = Sys.Date() + 14,
                          logo = system.file("logo.png", package = "invoicer"),
                          contractor = "Anthony Pileggi",
                          client = "Client A",
                          worklog = NULL) {
  htmltools::tags$div(
    class = "invoice-box",
    htmltools::tags$table(
      cellpadding = "0",
      cellspacing = "0",
      invoicer_html_header(id, date_created, date_due, logo),
      invoicer_html_info(contractor, client),
      invoicer_html_details(worklog)
    )
  )
}