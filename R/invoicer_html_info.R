#' Create invoice contractor/client info
#' @param x invoicer object
#' @param include_dates include a 'Date' column in invoice?
#' @return html
#' @export
invoicer_html_info <- function(x, include_dates = TRUE) {
  tags$tr(
    class = "information",
    tags$td(
      colspan = ifelse(include_dates, "4", "3"),
      tags$table(
        tags$tr(
          tags$td(
            tags$span(
              x$company$name,
              htmltools::tags$br(),
              x$company$address,
              htmltools::tags$br(),
              x$company$city,
              ", ",
              x$company$state,
              " ",
              x$company$zip_code
              )
          ),
          tags$td(" "),
          switch(include_dates + 1, tags$td(" "), ""),
          tags$td(
            tags$span(
              x$clients$client,
              htmltools::tags$br(),
              x$clients$address,
              htmltools::tags$br(),
              x$clients$city,
              ", ",
              x$clients$state,
              " ",
              x$clients$zip_code
            )
          )
        )
      )
    )
  )
}