#' Send an invoice via email
#' @param id invoice id
invoicer_email <- function(id = 2) {

  # identify file using invoice id
  invoices <- invoicer_get_invoices()
  invoice <- invoices[invoices$id == id, ]

  # check if email can/should be sent
  if (nrow(invoice) == 0)
    return(message("No matching invoice found.  No email sent."))
  if (nrow(invoice) > 1)
    return(message("More than 1 matching invoice found.  No email sent."))

  # compose/send email
  invoicer_email_send(invoice)
}



# Helpers --------------------

#' Setup emails (gmail only)
#' @export
invoicer_email_setup <- function() {
  me <- invoicer_get_company()
  blastula::create_email_creds_file(
    user = me$email,
    password = Sys.getenv("INVOICER_EMAIL_PASSWORD"),
    provider = "gmail",
    sender = me$name,
    creds_file_name = "~/.e_creds"
  )
}

#' Compose/send an invoice email
#' @param x invoice data
#' @param preview preview email
invoicer_email_send <- function(x, preview = FALSE) {

  # load info
  me <- invoicer_get_company()
  client <- dplyr::filter(invoicer_get_clients(), client == x$client)

  # download invoice file
  pdf_file <- file.path(tempdir(), "invoice.pdf")
  #pdf_file <- paste0("invoice_", invoice$id, ".pdf")
  googledrive::drive_download(
    googledrive::as_id(x$drive_id),
    path = pdf_file
    )

  # compose email
  email <-
    blastula::compose_email(
      body = "
    ## Invoice Number {id}

    Here is your invoice for {start_date} to {end_date}:

    {blastula::add_image(pdf_file)}

    {sender}",
      footer = "Sent on {blastula::add_readable_time()}",
      id = x$id,
      start_date = x$start_date,
      end_date = x$end_date,
      sender = me$name
    )

  # preview email
  if (preview)
    blastula::preview_email(email = email)

  # send email
  blastula::send_email_out(
    email,
    from = me$email,
    #to = client$email,
    to = me$email,
    cc = me$email,
    subject = paste0("Invoice #", x$id, " (", x$start_date, " - ", x$end_date, ")"),
    attachments = pdf_file,
    creds_file = "~/.e_creds"
  )
}
