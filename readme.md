
## Invoicer

A simple R package that can organize, generate, and send invoices.  So you can focus on what's important: getting the project done.

## Installation

```
library(devtools)
devtools::install_github("anthonypilegg/invoicer")
```

## Setup (local)

Add these lines to your `.Renviron`:
```
# Put your googlesheets key here (if using automated setup this is done for you
INVOICER_GS_KEY = "asdfsad"

# github PAT
INVOICER_GH_PAT = "asdfsd"
```

Add these links to your `.Rprofile`:
```
# google authentication
library(googlesheets)
token <- gs_auth(cache = FALSE)
gd_token()
saveRDS(token, file = "googlesheets_token.rds")
# now you can auth with:
googlesheets::gs_auth(token = "googlesheets_token.rds")
# TODO: add to .Renviron file, fix gs_auth() (make sure to setup absolute path)
```

## Getting Started

Getting started is easy!  Just run the `invoicer_setup()` function to generate googlesheets templates that you can start editting.

```r
library(invoicer)
invoicer_setup()
```

## Emails

Right now this only works if you have a Gmail address.  Steps to get started are:

```r
# Add this line to your .Renviron file
INVOICER_EMAIL_PASSWORD = "my_gmail_password"

# Create credentials file
invoicer_setup()

# Start sending emails
library(invoicer)
invoicer_email(id = 1)   # email out invoice #1 to the client
```

## Billing

Once you have everything setup, you can easily send any/all outstanding invoices to a client:

```r
# Bill client on a bi-weekly schedule
invoicer_bill_client("your_client", billing_period = 14)
```

## Docker Setup

Coming soon!

## Deploy to Google Cloud  (i.e., automated emails)

Coming soon!