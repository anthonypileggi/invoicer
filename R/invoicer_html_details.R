#' Create invoice details (project, hours, price)
#' @param worklog worklog data.frame/tibble
#' @return html
#' @export
invoicer_html_details <- function(worklog = NULL, include_dates = FALSE) {

  # generate line-item html
  worklog <- dplyr::mutate(
    worklog,
    html =
      purrr::pmap(
        list(date, project, links, hours, rate),
        function(d, p, l, h, r) {
          tags$tr(
            class = "item",
            switch(
              include_dates + 1,
              "",
              tags$td(format(as.Date(d, origin = "1970-01-01"), format = "%m/%d"))
              ),
            tags$td(
              invoicer_format_project_title(p),
              switch(
                is.na(l) + 1,
                tags$span("(", invoicer_format_links(l), ")"),
                ""
              )
            ),
            tags$td(format(h, nsmall = 1)),
            tags$td(paste0("$", h * r))
          )
        }
      )
  )

  htmltools::tagList(
    htmltools::tags$tr(
      class = "heading",
      switch(include_dates + 1, "", htmltools::tags$td("Date")),
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
