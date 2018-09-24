#' Create invoice contractor/client info
#' @param contractor name/address of contractor
#' @param client name/address of client
#' @return html
#' @export
invoicer_html_info <- function(contractor = "Anthony Pileggi", client = "iFixit") {
  tags$tr(
    class = "information",
    tags$td(
      colspan = "2",
      tags$table(
        tags$tr(
          tags$td(
            contractor
          ),
          tags$td(
            client
          )
        )
      )
    )
  )
}
