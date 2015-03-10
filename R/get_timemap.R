#' TimeMap for access to version history
#' 
#' @param uri desired uri of the web resource
#' @param limit limit
#' 
#' @examples \dontrun{
#' # mementos
#' tt <- get_timemap("http://www.base-search.net/about/de/about_sources_date_dn.php?menu=2")
#' # timemap
#' tt <- get_timemap("http://cnn.com")
#' }
#' @export

get_timemap <- function(uri = NULL) {
  if(is.null(uri)) 
    stop ("Please provide a uri")
  # path
  path <- paste("timemap/json", uri, sep ="/")
  req <- tt_GET(path)
  out <- tt_parse_js(req)
  if(!is.null(out$mementos)) {
    plyr::rbind.fill(out$mementos)
  } else {
    get_timemap_uri(out)
  }
}

get_timemap_uri <- function(x) {
  if(is.null(x$timemap_index))
    stop("No Timemap available")
  plyr::rbind.fill(x$timemap_index)
}
