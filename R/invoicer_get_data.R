#' Load invoice data from googlesheets
#' @param key googlesheets key
#' @note requires authentication via googlesheets
#' @export
invoicer_get_data <- function(key = Sys.getenv("INVOICER_GS_KEY")) {

  library(htmltools)

  # TODO: fix authentication pipeline
  googlesheets::gs_auth()
  gs <- googlesheets::gs_key(key, verbose = FALSE)

  # prepare client data
  clients <- invoicer_get_clients(gs = gs)

  # prepare worklog data
  worklog <- invoicer_get_worklog(gs = gs)
  worklog <- dplyr::left_join(worklog, dplyr::select(clients, client, rate), by = "client")

  # invoice data
  invoices <- invoicer_get_invoices(gs = gs)

  list(
    company = invoicer_get_company(gs = gs),
    clients = clients,
    worklog = worklog,
    invoices = invoices,
    next_invoice_id = max(invoices$id) + 1
  )
}


#' Load company data from googlesheets
#' @param key googlesheets key
#' @param gs registered googlesheet
#' @note requires authentication via googlesheets
#' @export
invoicer_get_company <- function(key = Sys.getenv("INVOICER_GS_KEY"), gs = NULL) {

  # TODO: fix authentication pipeline
  if (is.null(gs)) {
    googlesheets::gs_auth()
    gs <- googlesheets::gs_key(key, verbose = FALSE)
  }

  # prepare company data
  googlesheets::gs_read(gs, ws = "company", verbose = FALSE, col_types = readr::cols())
}

#' Load client data from googlesheets
#' @param key googlesheets key
#' @param gs registered googlesheet
#' @note requires authentication via googlesheets
#' @export
invoicer_get_clients <- function(key = Sys.getenv("INVOICER_GS_KEY"), gs = NULL) {

  # TODO: fix authentication pipeline
  if (is.null(gs)) {
    googlesheets::gs_auth()
    gs <- googlesheets::gs_key(key, verbose = FALSE)
  }

  # prepare client data
  googlesheets::gs_read(gs, ws = "clients", verbose = FALSE, col_types = readr::cols())
}

#' Load worklog data from googlesheets
#' @param key googlesheets key
#' @param gs registered googlesheet
#' @note requires authentication via googlesheets
#' @export
invoicer_get_worklog <- function(key = Sys.getenv("INVOICER_GS_KEY"), gs = NULL) {

  # TODO: fix authentication pipeline
  if (is.null(gs)) {
    googlesheets::gs_auth()
    gs <- googlesheets::gs_key(key, verbose = FALSE)
  }

  # prepare worklog data
  worklog <- googlesheets::gs_read(gs, ws = "worklog", verbose = FALSE, col_types = readr::cols())
  dplyr::mutate_at(worklog, "date", as.Date, format = c("%m/%d/%Y"))
}

#' Load invoice data from googlesheets
#' @param key googlesheets key
#' @param gs registered googlesheet
#' @note requires authentication via googlesheets
#' @export
invoicer_get_invoices <- function(key = Sys.getenv("INVOICER_GS_KEY"), gs = NULL) {

  # TODO: fix authentication pipeline
  if (is.null(gs)) {
    googlesheets::gs_auth()
    gs <- googlesheets::gs_key(key, verbose = FALSE)
  }

  # prepare invoice data
  invoices <- googlesheets::gs_read(gs, ws = "invoices", verbose = FALSE, col_types = readr::cols())
  invoices <- dplyr::mutate_at(invoices, c("start_date", "end_date"), as.Date, format = c("%m/%d/%Y"))
  dplyr::filter(invoices, !is.na(id))
}
