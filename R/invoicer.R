
#' Generate an invoice
#' @param client client name (character/scalar)
#' @param start_date first day of work (Date/scalar)
#' @param end_date last day of work (Date/scalar)
#' @param due_date date the invoice is due (Date/scalar)
#' @param include_dates include a Date column in the invoice (logical/scalar)
#' @param aggregate aggregate projects across dates (logical/scalar)
#' @param key googlesheets key
#' @export
invoicer <- function(client,
                     start_date,
                     end_date,
                     due_date = Sys.Date() + 14,
                     include_dates = TRUE,
                     aggregate = TRUE,
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
  html_file <- invoicer_create(rds_file, due_date, include_dates, aggregate)
  unlink(rds_file)

  # generate a 'pdf' (via screenshot)
  pdf_file <- stringr::str_replace(html_file, ".html", ".pdf")
  webshot::webshot(html_file, pdf_file)

  # store invoice_{#}.pdf on googledrive
  googledrive::drive_auth()
  gd <- googledrive::drive_upload(pdf_file)

  # file cleanup
  #unlink(html_file)
  #unlink(pdf_file)

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

  dplyr::mutate_at(invoice_summary, c("start_date", "end_date"), as.Date, format = c("%m/%d/%Y"))
}