\name{timetravelr-package}
\alias{timetravelr}
\docType{package}
\title{
This package offers a client for the APIs that are associated with the Memento Time Travel service. 
}

\description{
The Time Travel service helps you find versions of a page that existed at some time in the past.
These prior versions of web pages are named Mementos, as per RFC7089: "HTTP Framework for Time-Based Access to Resource States -- Memento". 
Mementos can be found in web archives or in systems that support versioning such as wikis and revision control systems. 

When you enter the web address of a page and a time in the past, the Time Travel service tries to find a Memento for that page as it existed around the time of your choice. 
This will work for addresses of pages that currently exist on the web but also for those that have meanwhile vanished. 
When entering a time, don't forget the web is relatively young and web archives are even younger.

More at http://timetravel.mementoweb.org/about/
}
\details{

\tabular{ll}{
Package: \tab timetravelr\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2015-03-10\cr
License: \tab What license is it under?\cr
}

1. you have a URI and a date, you the closest Memento
The Time Travel service provides an easy way to be redirected to a Memento for a given resource with an archival/version datetime that is close to a desired one.

From R, use the function get_memento() to get a html response from a web archive. 


2. list mementos for a given uri and date
The Time Travel service provides the Memento for the requested resource that is temporally closest (closest) to the desired datetime, irrespective of the Memento-compliant archive or versioning system it resides in. 
It also lists, when possible, the Mementos that are adjacent to the closest one (prev, next) as well as very first and most recent Mementos (first, last). 
For each Memento, it lists the archival/version datetime (datetime). 
For each of these Mementos, the response may list duplicates, i.e. Mementos with the same datetime but different URIs. 
In addition the document lists the URI for which the JSON was requested (original_uri), as well as the URI of the TimeGate (timegate_uri) and the TimeMap (timemap_uri) provided by the Time Travel service.

From R, use the function detail_memento() to get a list of mementos. 


3. get a full TimeMap for access to version history
The Time Travel service provides access to a TimeMap for a resource with a given URI. 

A TimeMap, as defined in the Memento protocol (RFC 7089), provides an overview of all Mementos (and their archival/version datetimes) known to the responding server. 
A brief description of TimeMaps is available in the Introduction to Memento, http://mementoweb.org/guide/quick-intro/. 
As the Time Travel service covers many web archives and versioning systems, a TimeMap for any given resource can list Mementos available in multiple remote servers. 

R function still todo.


4. find available versions through TimeGates
The Time Travel service exposes a TimeGate for a resource with a given URI. 

A TimeGate, as defined in the Memento protocol (RFC 7089), supports datetime negotiation, a variant of content negotiation. 
Datetime negotiation allows direct access to an archived snapshot or a version of the resource as it existed at some desired datetime in the past. 
A brief description of TimeGates is available in the Introduction to Memento, http://mementoweb.org/guide/quick-intro/. 

R function still todo.


}
\author{
Najko Jahn <najko.jahn@uni-bielefeld.de>

Maintainer: Najko Jahn <najko.jahn@uni-bielefeld.de>

}
\references{
Van de Sompel, H., Nelson, M. L., Sanderson, R., Balakireva, L. L., Ainsworth, S., & Shankar, H. (2009). Memento: Time travel for the web. arXiv preprint arXiv:0911.1112.
Van de Sompel, H., Nelson, M. L., Sanderson, R. (2013). HTTP Framework for Time-Based Access to Resource States -- Memento. http://tools.ietf.org/html/rfc7089.
}

