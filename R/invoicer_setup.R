
#' Run this function to create the googlesheets template
#' @param name Company name
#' @export
invoicer_setup <- function(name = "AVP Consulting", email = "apileggi20@gmail.com") {

  # create sample data
  sample_company <-
    tibble::tibble(
      name = name,
      address = "",
      city = "",
      start = "",
      zip_code = "",
      email = email,
      logo = ""
    )
  sample_clients <-
    tibble::tibble(
      client = c("Client A", "Client B"),
      address = c("Address A", "Address B"),
      city = c("City A", "City B"),
      state = c("CA", "PA"),
      zip_code = c(12345, 67890),
      email = email,
      rate = c(50, 75)
    )
  sample_worklog <-
    tibble::tibble(
      date = Sys.Date(),
      client = c("Client A", "Client A"),
      project = c("Project 1", "Project 2"),
      details = c("", ""),
      links = c("https://github.com/anthonypileggi/invoicer/issues/1", "https://github.com/anthonypileggi/invoicer/issues/1"),
      hours = c(5, 10)
    )
  sample_invoice <-
    tibble::tibble(
      id = 0,
      client = "test",
      start_date = Sys.Date(),
      end_date = Sys.Date(),
      total = 0,
      drive_id = "xxxx",
      file = "xxxx.pdf"
    )

  # create google sheets
  googlesheets::gs_auth()
  ss <-
    googlesheets::gs_new(
      title = name,
      ws_title = "worklog",
      input = sample_worklog,
      col_extent = ncol(sample_worklog)
      )
  googlesheets::gs_ws_new(
    ss,
    ws_title = "company",
    input = sample_company,
    col_extent = ncol(sample_company)
  )
  googlesheets::gs_ws_new(
    ss,
    ws_title = "clients",
    input = sample_clients,
    col_extent = ncol(sample_clients)
  )
  googlesheets::gs_ws_new(
    ss,
    ws_title = "invoices",
    input = sample_invoice,
    col_extent = ncol(sample_invoice)
  )
  # googlesheets::gs_ws_new(
  #   ss,
  #   ws_title = "emails",
  #   input = c("id", "recipient", "date"),
  #   col_extent = 3
  # )
  # googlesheets::gs_ws_new(
  #   ss,
  #   ws_title = "payments",
  #   input = c("id", "date", "total"),
  #   col_extent = 3
  # )

  Sys.setenv(INVOICER_GS_KEY = ss$sheet_key)
}