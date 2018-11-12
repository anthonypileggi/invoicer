#' Create invoice details (project, hours, price)
#' @param x invoicer object
#' @param include_dates include a 'Date' column in invoice?
#' @param aggregate aggregate projects over multiple days
#' @return html
#' @export
#' @importFrom magrittr "%>%"
invoicer_html_details <- function(x, include_dates = FALSE, aggregate = FALSE) {

  # aggregate worklog by project
  if (aggregate) {
    x$worklog <- x$worklog %>%
      dplyr::group_by(client, project) %>%
      dplyr::summarize(
        min_date = min(date),
        max_date = max(date),
        date = dplyr::case_when(
          min_date == max_date ~ format(min_date, "%m/%d"),
          min_date != max_date ~ paste0(format(min_date, "%m/%d"), "-", format(max_date, "%m/%d"))
        ),
        details = paste(unique(unlist(stringr::str_split(details, ","))), collapse = ","),
        details = ifelse(details == "NA", NA_character_, details),
        links = paste(unique(unlist(stringr::str_split(links, ","))), collapse = ","),
        links = ifelse(links == "NA", NA_character_, links),
        rate = weighted.mean(rate, hours),
        hours = sum(hours)
      ) %>%
      dplyr::arrange(min_date) %>%
      dplyr::select(date, client, project, details, links, hours, rate)
  }

  # generate line-item html
  x$worklog <- dplyr::mutate(
    x$worklog,
    html =
      purrr::pmap(
        list(date, project, links, hours, rate),
        function(d, p, l, h, r) {
          tags$tr(
            class = "item",
            switch(include_dates + 1,
              "",
              switch(is.character(d) + 1,
                tags$td(format(as.Date(d, origin = "1970-01-01"), format = "%m/%d")),
                tags$td(d)
                )
              ),
            tags$td(
              invoicer:::invoicer_format_project_title(p),
              switch(
                is.na(l) + 1,
                tags$span("(", invoicer:::invoicer_format_links(l), ")"),
                ""
              )
            ),
            tags$td(format(h, nsmall = 1)),
            tags$td(scales::dollar(h * r))
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
      switch(include_dates + 1, "", htmltools::tags$td(" ")),
      htmltools::tags$td(" "),
      htmltools::tags$td("Total:"),
      htmltools::tags$td(scales::dollar(sum(x$worklog$hours * x$worklog$rate)))
    )
  )
}
