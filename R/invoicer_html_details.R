#' Create invoice details (project, hours, price)
#' @param x invoicer object
#' @return html
#' @export
invoicer_html_details <- function(x, include_dates = FALSE) {

  # generate line-item html
  x$worklog <- dplyr::mutate(
    x$worklog,
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
    htmltools::tagList(x$worklog$html),
    htmltools::tags$tr(
      class = "total",
      htmltools::tags$td(" "),
      htmltools::tags$td("Total:"),
      htmltools::tags$td(paste0("$", sum(x$worklog$hours * x$worklog$rate)))
    )
  )
}
