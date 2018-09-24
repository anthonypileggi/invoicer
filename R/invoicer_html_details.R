#' Create invoice details (project, hours, price)
#' @param worklog worklog data.frame/tibble
#' @return html
#' @export
invoicer_html_details <- function(worklog = NULL) {
  htmltools::tagList(
    htmltools::tags$tr(
      class = "heading",
      htmltools::tags$td("Project"),
      htmltools::tags$td("Hours"),
      htmltools::tags$td("Price")
    ),
    htmltools::tagList(worklog$html),
    htmltools::tags$tr(
      class = "total",
      htmltools::tags$td(" "),
      htmltools::tags$td("Total:"),
      htmltools::tags$td(paste0("$", sum(worklog$hours * worklog$rate)))
    )
  )
}
