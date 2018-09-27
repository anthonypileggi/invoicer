
## Invoicer

A simple R package that can organize, generate, and send invoices.  So you can focus on what's important: getting the project done.

## Installation

```
library(devtools)
devtools::install_github("anthonypilegg/invoicer")
```

## Setup (local)

To use all the features, you'll need to setup each of the following:
  - googlesheets
  - github
  - email (gmail)
  
Add these lines to your `.Renviron`:
```
# Put your googlesheets key here (if using automated setup this is done for you
INVOICER_GS_KEY = "your_googlesheets_key"

# github PAT
INVOICER_GH_PAT = "your_github_pat"

# email password
INVOICER_EMAIL_PASSWORD = "your_email_password"

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

Getting started is easy!

```r
library(invoicer)

# Create googlesheets templates
invoicer_setup("My Company")
#invoicer_setup("My Company", "me@email.com")

# Send a sample invoice (to confirm everything is working!)
x <- invoicer(client = "Client A", start_date = Sys.Date(), end_date = Sys.Date())

# Email a test invoice to yourself
invoicer_email(x)
```

If you received the email with an attached invoice, then that's a good sign!

Now, you can edit each worksheet:
  - **company**: information about your company
  - **clients**: information about your clients
  - **worklog**: information about your projects


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