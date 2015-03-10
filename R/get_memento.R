#' Redirecting to a Memento
#' 
#' @import httr XML jsonlite
#' @param uri desired uri of the resource
#' @param date_time date and time of the desired archived version
#' 
#' @examples \dontrun{
#' # cnn
#' tt <- get_memento(uri = "http://cnn.com", date_time = "2011-09-11")
#' summary(tt)
#' tt$header
#' 
#' # get most web-archived version of github repo
#' tt <- get_memento(uri = "https://github.com/librecat/catmandu, date_time = "2014-01-02")
#' 
#' # get oai-pmh source and record counts stored in BASE from 2013
#' 
#' tt <- get_memento("http://www.base-search.net/about/de/about_sources_date_dn.php?menu=2", 
#' date_time ="2014-01-01")
#' tables <- readHTMLTable(tt$response)
#' oai_table <- tables[4]
#' oai_df <- do.call("rbind",oai_table))
#' }
#' @export

get_memento <- function(uri = NULL, date_time = NULL){
  if(is.null(uri)) 
    stop ("Please provide a uri")
  if(is.null(date_time)) 
    stop("Please provide a date, eg. 2011-01-02")
  # path
  path <- paste("memento", tt_format(date_time), uri, sep ="/")
  req <- tt_GET(path)
  out <- tt_parse_html(req)
  list(header = req$header, response = out)
}
