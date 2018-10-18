#' Create invoice header
#' @param x invoicer object
#' @param include_dates include a 'Date' column in invoice?
#' @return html
#' @export
invoicer_html_header <- function(x, include_dates = TRUE) {
  tags$tr(
    class = "top",
    tags$td(
      colspan = ifelse(include_dates, "4", "3"),
      tags$table(
        tags$tr(
          tags$td(
            class = "title",
            tags$img(src = x$company$logo, style = "width:100%; max-width:300px; max-height:200px")
          ),
          tags$td(" "),
          switch(include_dates + 1, tags$td(" "), ""),
          tags$td(
            paste("Invoice #:", x$next_invoice_id),
            tags$br(),
            paste("Period:", format(x$params$start_date, "%m/%d/%Y"), "-", format(x$params$end_date, "%m/%d/%Y")),
            tags$br(),
            paste("Created:", format(x$params$date_created, "%B %d, %Y")),
            tags$br(),
            paste("Due:", format(x$params$date_due, "%B %d, %Y"))
          )
        )
      )
    )
  )
}
