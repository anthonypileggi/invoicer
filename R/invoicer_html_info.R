#' Create invoice contractor/client info
#' @param x invoicer object
#' @return html
#' @export
invoicer_html_info <- function(x) {
  tags$tr(
    class = "information",
    tags$td(
      colspan = "2",
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