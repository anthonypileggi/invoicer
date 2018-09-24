#' Record data in a google sheet
#' @param key googlesheets key
#' @param gs registered googlesheet
#' @param ws worksheet
#' @param x data.frame to insert
invoicer_record <- function(key = "1auWdQK9f0db09rVItdgAqMEUHrgYt8x-vt4coQi0g3w",
                            gs = NULL,
                            ws,
                            x) {

  # TODO: fix authentication pipeline
  if (is.null(gs)) {
    googlesheets::gs_auth()
    gs <- googlesheets::gs_key(key)
  }

  # write data
  googlesheets::gs_add_row(gs, ws = ws, input = x)
}