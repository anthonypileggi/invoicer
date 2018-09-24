
#' Run this function to create the googlesheets template
#' @param name Company name
#' @export
invoicer_setup <- function(name = "AVP Consulting") {

  # create sample data
  sample_clients <-
    tibble::tibble(
      client = c("Client A", "Client B"),
      address = c("Address A", "Address B"),
      city = c("City A", "City B"),
      state = c("CA", "PA"),
      zip_code = c(12345, 67890),
      email = c("clienta@gmail.com", "clientb@gmail.com"),
      rate = c(50, 75)
    )
  sample_worklog <-
    tibble::tibble(
      date = c("9/17/2018", "9/18/2018"),
      client = c("Client A", "Client A"),
      project = c("Project 1", "Project 2"),
      details = c("", ""),
      links = c("http://github.com/anthonypileggi/invoicer/issues/1", "http://github.com/anthonypileggi/invoicer/issues/2"),
      hours = c(5, 10)
    )

  # create google sheets
  googlesheets::gs_auth()
  ss <-
    googlesheets::gs_new(
      title = name,
      ws_title = "worklog",
      input = sample_worklog,
      col_extent = 6
      )
  googlesheets::gs_ws_new(
    ss,
    ws_title = "clients",
    input = sample_clients,
    col_extent = 6
  )
  googlesheets::gs_ws_new(
    ss,
    ws_title = "invoices",
    input = c(
      "id", "client", "start_date", "end_date", "total", "drive_id", "file",
      0, "test", "9/17/2018", "9/18/2018", 0, "xxxx", "xxx.html"
      ),
    col_extent = 7
  )
  googlesheets::gs_ws_new(
    ss,
    ws_title = "emails",
    input = c("id", "recipient", "date"),
    col_extent = 3
  )
  googlesheets::gs_ws_new(
    ss,
    ws_title = "payments",
    input = c("id", "date", "total"),
    col_extent = 3
  )

  Sys.setenv(INVOICER_GS_KEY = ss$sheet_key)
}