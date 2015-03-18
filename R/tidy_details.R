# small codeblock
# appends detail_memento.R
# 
# response from Timetravel JSON API is a list of differently structured lists
# turn it into tidy data frame

## expect variable temp with results from detail_momento()

library(plyr)
library(lubridate)

herenow <- here()

# mementos are a group of lists with nested structure
first <- ldply(temp$mementos, data.frame)
colnames(first) <- c("rel", "datetime", "uri")
## convert datetime to R time object
first$datetime <- ymd_hms(first$datetime)

# timegate URI is a simple string
third <- cbind("timegate", herenow, ldply(temp$timegate_uri, data.frame))
colnames(third) <- c("rel", "datetime", "uri")

# timemap URI's are provided in two formats
fourth <- cbind("timemap-json", herenow, ldply(temp$timemap_uri$json_format, data.frame))
colnames(fourth) <- c("rel", "datetime", "uri")
fifth <- cbind("timemap-link", herenow, ldply(temp$timemap_uri$link_format, data.frame))
colnames(fifth) <- c("rel", "datetime", "uri")

# all together
result <- rbind(first, third, fourth, fifth)

# original URI is a simple string

## could be mapped as a row with NA as a timestamp
## second <- cbind("original", NA, ldply(temp$original_uri, data.frame))
## colnames(second) <- c("rel", "datetime", "uri")

## should be mapped as a column with fixed content
result <- cbind(result, rep(temp$original_uri, nrow(result)))
colnames(result) <- c("rel", "datetime", "uri", "original")



View(result)