
#' Generate an invoice
#' @param client client name (character/scalar)
#' @param start_date first day of work (Date/scalar)
#' @param end_date last day of work (Date/scalar)
#' @param key googlesheets key
#' @export
invoicer <- function(client,
                     start_date,
                     end_date,
                     key = Sys.getenv("INVOICER_GS_KEY")) {

  # load/prepare data based on params
  x <- invoicer_get_data(key)
  xs <- invoicer_filter_data(x, client = client, start_date = start_date, end_date = end_date)

  # check if an invoice should be created
  if (!invoicer_check_data(xs))
    return("No invoice will be generated.")

  # save data (to pass to invoice)
  rds_file <- tempfile(fileext = ".rds")
  saveRDS(xs, rds_file)

  # generate a new invoice (in current working directory)
  html_file <- invoicer_create(rds_file)
  unlink(rds_file)

  # store invoice_{#}.html on googledrive
  googledrive::drive_auth()
  gd <- googledrive::drive_upload(html_file)
  #unlink(html_file)

  # generate invoice summary
  invoice_summary <-
    dplyr::mutate(
      invoicer_summary(xs),
      drive_id = gd$id,
      file = gd$drive_resource[[1]]$webContentLink
      )

  # write invoice summary to 'invoice' tab of google sheet
  invoicer_record(key = key, ws = "invoices", x = invoice_summary)

  # create user message
  msg <- dplyr::mutate(invoice_summary, msg = paste0("Generated an invoice for ", client, " for $", total, "."))$msg
  message(msg)

  return(invoice_summary)
}