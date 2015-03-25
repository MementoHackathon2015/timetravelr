#' Memento details converted to tidy dataframe
#' 
#'  Response from Timetravel JSON API is a list of differently structured lists
#' 
#'  Shows the memento for a given resource with an archival/version datetime 
#'  that is close to a desired one, as a dataframe.
#'  
#'  @param uri desired uri of the web resource
#'  @param date_time date and time of the desired archived version
#'  
#'  @examples \dontrun{
#'  tidy_details("http://cnn.com", "2001-09-11")
#'  }
#'  @export

tidy_details <- function(uri = NULL, date_time = NULL) {
  if(is.null(uri)) 
    stop ("Please provide a uri")
  if(is.null(date_time)) 
    stop("Please provide a date, eg. 2011-01-02")

  # get memento
  temp <- detail_memento(uri = uri, date_time = date_time)

  library(plyr)
  library(lubridate)
  herenow <- here()

  # mementos are a group of lists with nested structure
  first <- ldply(temp$mementos, data.frame)
  colnames(first) <- c("rel", "datetime", "uri")
  ## convert datetime to R time object
  first$datetime <- ymd_hms(first$datetime)
  
  # timegate URI is a string
  third <- cbind("timegate", herenow, ldply(temp$timegate_uri, data.frame))
  colnames(third) <- c("rel", "datetime", "uri")
  
  # timemap URI's are provided in two formats
  fourth <- cbind("timemap-json", herenow, ldply(temp$timemap_uri$json_format, data.frame))
  colnames(fourth) <- c("rel", "datetime", "uri")
  fifth <- cbind("timemap-link", herenow, ldply(temp$timemap_uri$link_format, data.frame))
  colnames(fifth) <- c("rel", "datetime", "uri")
  
  # all together
  result <- rbind(first, third, fourth, fifth)
  
  # repeat original URI as a column
  result <- cbind(result, rep(temp$original_uri, nrow(result)))
  colnames(result) <- c("rel", "datetime", "uri", "original")
  
  result
}
