#' Create invoice header
#' @param id invoice number/id
#' @param date_created date of invoice creation
#' @param date_due date the invoice should be paid by
#' @param logo contractor logo
#' @return html
#' @export
invoicer_html_header <- function(id = 1,
                                 date_created = Sys.Date(),
                                 date_due = Sys.Date() + 14,
                                 logo = system.file("logo.png", package = "invoicer")) {
  tags$tr(
    class = "top",
    tags$td(
      colspan = "2",
      tags$table(
        tags$tr(
          tags$td(
            class = "title",
            tags$img(src = logo, style = "width:100%; max-width:300px; max-height:200px")
          ),
          tags$td(
            paste("Invoice #:", id),
            tags$br(),
            paste("Created:", format(date_created, "%B %d, %Y")),
            tags$br(),
            paste("Due:", format(date_due, "%B %d, %Y"))
          )
        )
      )
    )
  )
}
