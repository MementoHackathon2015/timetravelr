# timetravelr



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
## Example

The [Open Archive Initiative](http://www.openarchives.org) is listing [registered OAI conforming repositories](http://www.openarchives.org/Register/BrowseSites) for many years. With the help of web archives and the Memento Time Travel API, it should be possible to assess the evolution of OAI-PMH repositoires.

### Get Timemap index


```r
uri <- "http://www.openarchives.org/Register/BrowseSites"
my_oai <- get_timemap(uri)
head(my_oai)
#>               datetime
#> 1 2004-10-10T06:39:21Z
#> 2 2004-10-21T09:03:06Z
#> 3 2004-10-31T08:43:02Z
#> 4 2004-11-22T09:27:00Z
#> 5 2004-12-09T16:09:29Z
#> 6 2004-12-12T03:46:59Z
#>                                                                                          uri
#> 1 http://web.archive.org/web/20041010063921/http://www.openarchives.org/Register/BrowseSites
#> 2 http://web.archive.org/web/20041021090306/http://www.openarchives.org/Register/BrowseSites
#> 3 http://web.archive.org/web/20041031084302/http://www.openarchives.org/Register/BrowseSites
#> 4 http://web.archive.org/web/20041122092700/http://www.openarchives.org/Register/BrowseSites
#> 5 http://web.archive.org/web/20041209160929/http://www.openarchives.org/Register/BrowseSites
#> 6 http://web.archive.org/web/20041212034659/http://www.openarchives.org/Register/BrowseSites
```

The timemap documents 237mementos.

### Get first Memento


```r
my_memo <- get_memento(uri, date_time = my_oai$datetime[1])
tables <- XML::readHTMLTable(my_memo$response)
my_df <- plyr::rbind.fill(tables[5])

head(my_df)
#>       V1       V2
#> 1 Record Identify
#> 2 Record Identify
#> 3 Record Identify
#> 4 Record Identify
#> 5 Record Identify
#> 6 Record Identify
#>                                                                              V3
#> 1                                    11th Joint Symposium on Neural Computation
#> 2                 @rchiveSIC : Sciences de l'Information et de la Communication
#> 3                                                A Celebration of Women Writers
#> 4                                                      Academic Archive On-line
#> 5 Acervo General de la biblioteca "Dr Jorge Villalobos Padilla, S.J." del ITESO
#> 6                                                    AIM25 - Archives in London
#>                                                        V4
#> 1               http://jsnc.library.caltech.edu/perl/oai2
#> 2               http://archiveSIC.ccsd.cnrs.fr/perl/oai20
#> 3 http://digital.library.upenn.edu/webbin/OAI-celebration
#> 4                    http://publications.uu.se/portal/OAI
#> 5               http://docu.gdl.iteso.mx/oai/default.aspx
#> 6               http://www.aim25.ac.uk/cgi-bin/oai/OAI2.0
#>                         V5
#> 1 jsnc.library.caltech.edu
#> 2  archiveSIC.ccsd.cnrs.fr
#> 3              celebration
#> 4                  DiVA.se
#> 5          acervo.iteso.mx
#> 6
```

In the beginning, OAI initiative listed 183 OAI repos (date : 2004-10-10T06:39:21Z)

### Get time series

To get a time series, we need to parse all mementos. Let's define a function


```r

oai_list <- function(uri = NULL, date_time = NULL) {
	my_memo <- get_memento(uri, date_time)
	tables <- XML::readHTMLTable(my_memo$response)
	out <- plyr::rbind.fill(tables[5])
	nrow(out)
}

my_oai <- my_oai[1:10,]

tt <- plyr::ldply(my_oai$datetime, oai_list, uri = "http://www.openarchives.org/Register/BrowseSites")

my_oai$counts <- tt

my_oai
#>                datetime
#> 1  2004-10-10T06:39:21Z
#> 2  2004-10-21T09:03:06Z
#> 3  2004-10-31T08:43:02Z
#> 4  2004-11-22T09:27:00Z
#> 5  2004-12-09T16:09:29Z
#> 6  2004-12-12T03:46:59Z
#> 7  2005-02-07T08:44:43Z
#> 8  2005-02-07T09:08:23Z
#> 9  2005-02-08T08:47:37Z
#> 10 2005-02-09T09:24:01Z
#>                                                                                           uri
#> 1  http://web.archive.org/web/20041010063921/http://www.openarchives.org/Register/BrowseSites
#> 2  http://web.archive.org/web/20041021090306/http://www.openarchives.org/Register/BrowseSites
#> 3  http://web.archive.org/web/20041031084302/http://www.openarchives.org/Register/BrowseSites
#> 4  http://web.archive.org/web/20041122092700/http://www.openarchives.org/Register/BrowseSites
#> 5  http://web.archive.org/web/20041209160929/http://www.openarchives.org/Register/BrowseSites
#> 6  http://web.archive.org/web/20041212034659/http://www.openarchives.org/Register/BrowseSites
#> 7  http://web.archive.org/web/20050207084443/http://www.openarchives.org/Register/BrowseSites
#> 8  http://web.archive.org/web/20050207090823/http://www.openarchives.org/Register/BrowseSites
#> 9  http://web.archive.org/web/20050208084737/http://www.openarchives.org/Register/BrowseSites
#> 10 http://web.archive.org/web/20050209092401/http://www.openarchives.org/Register/BrowseSites
#>     V1
#> 1  183
#> 2  191
#> 3  192
#> 4  201
#> 5  209
#> 6  209
#> 7  230
#> 8  230
#> 9  230
#> 10 230
```

## Get Timemap


```r
tt <- get_timemap("http://www.base-search.net/about/de/about_sources_date_dn.php?menu=2")

head(tt)
#>               datetime
#> 1 2012-05-26T01:03:18Z
#> 2 2012-07-25T22:08:22Z
#> 3 2012-09-18T20:44:42Z
#> 4 2013-01-23T19:01:09Z
#> 5 2013-03-17T02:58:07Z
#> 6 2013-05-29T08:59:05Z
#>                                                                                                              uri
#> 1 http://web.archive.org/web/20120526010318/http://www.base-search.net/about/de/about_sources_date_dn.php?menu=2
#> 2 http://web.archive.org/web/20120725220822/http://www.base-search.net/about/de/about_sources_date_dn.php?menu=2
#> 3 http://web.archive.org/web/20120918204442/http://www.base-search.net/about/de/about_sources_date_dn.php?menu=2
#> 4 http://web.archive.org/web/20130123190109/http://www.base-search.net/about/de/about_sources_date_dn.php?menu=2
#> 5 http://web.archive.org/web/20130317025807/http://www.base-search.net/about/de/about_sources_date_dn.php?menu=2
#> 6 http://web.archive.org/web/20130529085905/http://www.base-search.net/about/de/about_sources_date_dn.php?menu=2

tt <- get_timemap("http://cnn.com")

head(tt)
#>                   from                until
#> 1 2000-06-20T18:02:59Z 2001-07-09T01:11:49Z
#> 2 2001-07-09T01:11:49Z 2001-09-24T23:10:53Z
#> 3 2001-09-24T23:11:02Z 2001-09-25T03:07:56Z
#> 4 2001-09-25T03:08:21Z 2001-09-25T12:31:04Z
#> 5 2001-09-25T12:31:12Z 2001-09-25T22:55:01Z
#> 6 2001-09-25T22:55:04Z 2001-09-26T02:28:20Z
#>                                                                 uri
#> 1    http://timetravel.mementoweb.org/timemap/json/1/http://cnn.com
#> 2 http://timetravel.mementoweb.org/timemap/json/1000/http://cnn.com
#> 3 http://timetravel.mementoweb.org/timemap/json/2000/http://cnn.com
#> 4 http://timetravel.mementoweb.org/timemap/json/3000/http://cnn.com
#> 5 http://timetravel.mementoweb.org/timemap/json/4000/http://cnn.com
#> 6 http://timetravel.mementoweb.org/timemap/json/5000/http://cnn.com
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
#> [1] "<http://www.cnn.com/>; rel=\"original\", <http://wayback.archive-it.org/all/timemap/link/http://www.cnn.com/>; rel=\"timemap\"; type=\"application/link-format\", <http://wayback.archive-it.org/all/http://www.cnn.com/>; rel=\"timegate\", <http://wayback.archive-it.org/all/20050928224658/http://www.cnn.com/>; rel=\"first memento\"; datetime=\"Wed, 28 Sep 2005 22:46:58 GMT\", <http://wayback.archive-it.org/all/20110910172750/http://www.cnn.com/>; rel=\"prev memento\"; datetime=\"Sat, 10 Sep 2011 17:27:50 GMT\", <http://wayback.archive-it.org/all/20110910225503/http://www.cnn.com/>; rel=\"memento\"; datetime=\"Sat, 10 Sep 2011 22:55:03 GMT\", <http://wayback.archive-it.org/all/20110911114631/http://www.cnn.com/>; rel=\"next memento\"; datetime=\"Sun, 11 Sep 2011 11:46:31 GMT\", <http://wayback.archive-it.org/all/20150309232459/http://www.cnn.com/>; rel=\"last memento\"; datetime=\"Mon, 09 Mar 2015 23:24:59 GMT\""
#> 
#> $`set-cookie`
#> [1] "JSESSIONID=D804C34A4585FD0AFE64A042ADF32934; Path=/; HttpOnly"
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
#> [1] "Tue, 10 Mar 2015 14:57:04 GMT"
#> 
#> $connection
#> [1] "close"
#> 
#> attr(,"class")
#> [1] "insensitive" "list"
```

## Show Mementos for a given uri and date


```r
detail_memento("http://cnn.com", "2001-09-11")
#> $original_uri
#> [1] "http://cnn.com"
#> 
#> $mementos
#> $mementos$last
#> $mementos$last$datetime
#> [1] "2015-02-28T07:43:24Z"
#> 
#> $mementos$last$uri
#> [1] "http://web.archive.org/web/20150228074324/http://www.cnn.com/"
#> 
#> 
#> $mementos$`next`
#> $mementos$`next`$datetime
#> [1] "2001-09-11T20:03:32Z"
#> 
#> $mementos$`next`$uri
#> [1] "http://wayback.vefsafn.is/wayback/20010911200332/http://cnn.com/"
#> 
#> 
#> $mementos$closest
#> $mementos$closest$datetime
#> [1] "2001-09-11T20:03:18Z"
#> 
#> $mementos$closest$uri
#> [1] "http://wayback.vefsafn.is/wayback/20010911200318/http://www.cnn.com/"
#> [2] "http://web.archive.org/web/20010911200318/http://www.cnn.com/"       
#> 
#> 
#> $mementos$first
#> $mementos$first$datetime
#> [1] "2000-06-20T18:02:59Z"
#> 
#> $mementos$first$uri
#> [1] "http://wayback.vefsafn.is/wayback/20000620180259/http://cnn.com/"
#> [2] "http://web.archive.org/web/20000620180259/http://cnn.com/"       
#> 
#> 
#> $mementos$prev
#> $mementos$prev$datetime
#> [1] "2001-08-23T12:03:56Z"
#> 
#> $mementos$prev$uri
#> [1] "http://wayback.vefsafn.is/wayback/20010823120356/http://www.cnn.com/"
#> [2] "http://web.archive.org/web/20010823120356/http://www.cnn.com/"       
#> 
#> 
#> 
#> $timegate_uri
#> [1] "http://timetravel.mementoweb.org/timegate/http://cnn.com"
#> 
#> $timemap_uri
#> $timemap_uri$json_format
#> [1] "http://timetravel.mementoweb.org/timemap/json/http://cnn.com"
#> 
#> $timemap_uri$link_format
#> [1] "http://timetravel.mementoweb.org/timemap/link/http://cnn.com"
```

