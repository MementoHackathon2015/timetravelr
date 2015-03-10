# small codeblock
# appends detail_memento.R
# 
# response from Timetravel JSON API is a list of differently structured lists
# turn it into tidy data frame

library(plyr)
library(lubridate)

# mementos are a group of lists with nested structure
first <- ldply(temp$mementos, data.frame)
colnames(first) <- c("rel", "datetime", "uri")
## convert datetime to R time object
first$datetime <- ymd_hms(first$datetime)

# original URI is a simple string
second <- cbind("original", here(), ldply(temp$original_uri, data.frame))
colnames(second) <- c("rel", "datetime", "uri")

# timegate URI is a simple string
third <- cbind("timegate", here(), ldply(temp$timegate_uri, data.frame))
colnames(third) <- c("rel", "datetime", "uri")

# timemap URI's are provided in two formats
fourth <- cbind("timemap-json", here(), ldply(temp$timemap_uri$json_format, data.frame))
colnames(fourth) <- c("rel", "datetime", "uri")
fifth <- cbind("timemap-link", here(), ldply(temp$timemap_uri$link_format, data.frame))
colnames(fifth) <- c("rel", "datetime", "uri")

# all together
result <- rbind(first, second, third, fourth, fifth)

View(result)