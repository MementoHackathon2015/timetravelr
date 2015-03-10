# timetravelr


```r
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  warning = FALSE, 
  message = FALSE
)
```

## About

timetravelr is an R Client for the [Memento Time Travel API](http://timetravel.mementoweb.org/about/).

## Installation


```r
require(devtools)
install_github("mementohackathon2015/timetravelr")
```

Load `timetravelr`


```r
library("timetravelr")
```

## Redirecting URI to a Memento


```r
tt <- get_memento(uri = "http://cnn.com", date_time = "2011-09-11")
summary(tt)
#>          Length Class                Mode       
#> header   21     insensitive          list       
#> response  1     HTMLInternalDocument externalptr
tt$header
#> $server
#> [1] "Apache-Coyote/1.1"
#> 
#> $`memento-datetime`
#> [1] "Sat, 10 Sep 2011 22:55:03 GMT"
#> 
#> $link
#> [1] "<http://www.cnn.com/>; rel=\"original\", <http://wayback.archive-it.org/all/timemap/link/http://www.cnn.com/>; rel=\"timemap\"; type=\"application/link-format\", <http://wayback.archive-it.org/all/http://www.cnn.com/>; rel=\"timegate\", <http://wayback.archive-it.org/all/20050928224658/http://www.cnn.com/>; rel=\"first memento\"; datetime=\"Wed, 28 Sep 2005 22:46:58 GMT\", <http://wayback.archive-it.org/all/20110910172750/http://www.cnn.com/>; rel=\"prev memento\"; datetime=\"Sat, 10 Sep 2011 17:27:50 GMT\", <http://wayback.archive-it.org/all/20110910225503/http://www.cnn.com/>; rel=\"memento\"; datetime=\"Sat, 10 Sep 2011 22:55:03 GMT\", <http://wayback.archive-it.org/all/20110911114631/http://www.cnn.com/>; rel=\"next memento\"; datetime=\"Sun, 11 Sep 2011 11:46:31 GMT\", <http://wayback.archive-it.org/all/20150309023849/http://www.cnn.com/>; rel=\"last memento\"; datetime=\"Mon, 09 Mar 2015 02:38:49 GMT\""
#> 
#> $`set-cookie`
#> [1] "JSESSIONID=A95338F9A4BA828E0574A963D6099570; Path=/; HttpOnly"
#> 
#> $`x-archive-orig-expires`
#> [1] "Sat, 10 Sep 2011 22:56:00 GMT"
#> 
#> $`x-archive-orig-content-length`
#> [1] "103589"
#> 
#> $`x-archive-orig-connection`
#> [1] "close"
#> 
#> $`x-archive-guessed-charset`
#> [1] "windows-1252"
#> 
#> $`x-archive-orig-set-cookie`
#> [1] "CG=US:--:--; path=/"
#> 
#> $`x-archive-orig-cache-control`
#> [1] "max-age=60, private, private"
#> 
#> $`x-archive-orig-date`
#> [1] "Sat, 10 Sep 2011 22:55:02 GMT"
#> 
#> $`x-archive-orig-vary`
#> [1] "User-Agent,Accept-Encoding"
#> 
#> $`x-archive-orig-content-type`
#> [1] "text/html"
#> 
#> $`x-archive-orig-accept-ranges`
#> [1] "bytes"
#> 
#> $`x-archive-orig-server`
#> [1] "Apache"
#> 
#> $`cache-control`
#> [1] "max-age=0, no-cache, no-store, must-revalidate"
#> 
#> $pragma
#> [1] "no-cache"
#> 
#> $`content-type`
#> [1] "text/html;charset=utf-8"
#> 
#> $`content-length`
#> [1] "136605"
#> 
#> $date
#> [1] "Tue, 10 Mar 2015 10:59:23 GMT"
#> 
#> $connection
#> [1] "close"
#> 
#> attr(,"class")
#> [1] "insensitive" "list"
```

