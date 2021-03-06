% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/invoicer.R
\name{invoicer}
\alias{invoicer}
\title{Generate an invoice}
\usage{
invoicer(client, start_date, end_date, due_date = Sys.Date() + 14,
  include_dates = TRUE, aggregate = TRUE,
  key = Sys.getenv("INVOICER_GS_KEY"))
}
\arguments{
\item{client}{client name (character/scalar)}

\item{start_date}{first day of work (Date/scalar)}

\item{end_date}{last day of work (Date/scalar)}

\item{due_date}{date the invoice is due (Date/scalar)}

\item{include_dates}{include a Date column in the invoice (logical/scalar)}

\item{aggregate}{aggregate projects across dates (logical/scalar)}

\item{key}{googlesheets key}
}
\description{
Generate an invoice
}
