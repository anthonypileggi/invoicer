## html formatting for the invoice

#' Convert a comma-separated string of github links to href tags
#' @param urls url(s)
invoicer_format_links <- function(urls = "https://github.com/iFixit/Stats/issues/280, https://github.com/iFixit/Stats/issues/290") {
  urls <- stringr::str_trim(stringr::str_split(urls, ",")[[1]])
  htmltools::tagList(purrr::map(urls, invoicer_format_link))
}

#' Convert a github link to a href html tag
#' @param x url
invoicer_format_link <- function(url = "https://github.com/iFixit/Stats/issues/280") {
  label <- stringr::str_replace_all(url, "https://github.com/", "")
  label <- stringr::str_replace_all(label, "/issues/|/pull/", "#")
  tags$a(href = url, label)
}

#' Create an invoice project title; if a github link is provided, convert to its 'title'
#' @param title project title
invoicer_format_project_title <- function(title = "This Project") {
  # TODO: add try-catch when tapping github api
  if (stringr::str_detect(title, "https://github.com/")) {
    endpoint <- stringr::str_replace(title, "https://github.com", "/repos")
    x <- gh::gh(endpoint)
    title <- htmltools::tags$a(x$title, href = title)
  }
  title
}