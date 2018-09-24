
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


## Docker Setup

Coming soon!

## Deploy to Google Cloud  (i.e., automated emails)

Coming soon!