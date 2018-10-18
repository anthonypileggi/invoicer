#' Generate an HTML invoice document
#' @param rds_file full path to .rds file containing invoice data
#' @param date_due due date for invoice (Date/scalar)
#' @param include_dates include a 'Date' column in invoice?
#' @param aggregate aggregate projects over multiple days
invoicer_create <- function(rds_file = NULL,
                            date_due = Sys.Date() + 14,
                            include_dates = TRUE,
                            aggregate = FALSE) {

  if (is.null(rds_file))
    return("You must provide a data file in 'rds_file'.")

  x <- readRDS(rds_file)

  output_file <- file.path(getwd(), paste0("invoice_", x$next_invoice_id, ".html"))
  rmarkdown::render(
    system.file("invoice.Rmd", package = "invoicer"),
    output_file = output_file,
    output_dir = getwd(),
    params = list(
      data = rds_file,
      date_due = date_due,
      include_dates = include_dates,
      aggregate = aggregate
      )
  )
  output_file
}