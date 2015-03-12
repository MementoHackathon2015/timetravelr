#' Memento details
#' 
#'  Shows the memento for a given resource with an archival/version datetime 
#'  that is close to a desired one.
#'  
#'  @param uri desired uri of the web resource
#'  @param date_time date and time of the desired archived version
#'  
#'  @examples \dontrun{
#'  detail_memento("http://cnn.com", "2001-09-11")
#'  }
#'  @export

detail_memento <- function(uri = NULL, date_time = NULL) {
  if(is.null(uri)) 
    stop ("Please provide a uri")
  if(is.null(date_time)) 
    stop("Please provide a date, eg. 2011-01-02")
  # path
  path <- paste("api/json", tt_format(date_time), uri, sep ="/")
  req <- tt_GET(path)
  out <- tt_parse_js(req)
  out
}


