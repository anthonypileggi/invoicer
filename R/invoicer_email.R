#' Send an invoice via email
#' @param id invoice id
invoicer_email <- function(id) {

  # identify file using invoice id
  invoices <- invoicer_get_invoices()
  file <- invoices$file[invoices$id == 1]

  # get file from googledrive
  out_file <- tempfile()
  googledrive::drive_auth()
  googledrive::drive_download(file, path = out_file)

  # format email (blastula?)
  #invoicer_email_compose()

  # send email
  #invoicer_email_send()
}