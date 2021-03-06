% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/get_memento.R
\name{get_memento}
\alias{get_memento}
\title{Redirecting to a Memento}
\usage{
get_memento(uri = NULL, date_time = NULL)
}
\arguments{
\item{uri}{desired uri of the resource}

\item{date_time}{date and time of the desired archived version}
}
\description{
Redirecting to a Memento
}
\examples{
\dontrun{
# cnn
tt <- get_memento(uri = "http://cnn.com", date_time = "2011-09-11")
summary(tt)
tt$header

# get most web-archived version of github repo
tt <- get_memento(uri = "https://github.com/librecat/catmandu, date_time = "2014-01-02")

# get oai-pmh source and record counts stored in BASE from 2013

tt <- get_memento("http://www.base-search.net/about/de/about_sources_date_dn.php?menu=2",
date_time ="2014-01-01")
tables <- readHTMLTable(tt$response)
oai_table <- tables[4]
oai_df <- do.call("rbind",oai_table)
}
}

