tt_GET <- function(path, ...){
  if (is.null(path)) 
    stop("Nothing to parse")
  uri <- "http://timetravel.mementoweb.org/"
  # call api
  req <- httr::GET(uri, path = path, ...)
  # check for http status
  tt_check(req)
  req
}

tt_check <- function(req) {
  if (req$status_code < 400) 
    return(invisible())
  stop(http_status(x)$message, "\n", call. = FALSE)
}

tt_parse_js <- function(req) {
  text <- httr::content(req, as = "text")
  if (identical(text, "")) 
    stop("Not output to parse", call. = FALSE)
  jsonlite::fromJSON(text)
}

tt_parse_html <- function(req) {
  text <- httr::content(req, as = "text")
  if (identical(text, "")) 
    stop("Not output to parse", call. = FALSE)
  XML::htmlTreeParse(text, useInternal = TRUE)
}

tt_format <- function(x){
  if(!exists("x"))
    stop ("No datetime provided")
  date_time <- as.POSIXct(x)
  format(date_time, "%Y%m%d%H%M%S")
}