
rm(list=ls())


library(foreign)				
dat <- read.dta("Ideodrift.dta")	# load the Stata data flle

dat <- dat[order(dat$justice, dat$term),]		# manipulate the data. here: sort by justice and term

avgs <- aggregate(post_mn ~ justice, data=dat, mean)	# aggregate by justice over years

plot(seq(1, dim(avgs)[1]), avgs$post_mn)			# scatterplot
identify(avgs$post_mn, labels=avgs$justice)		# click on points to identify justices




##################

rm(list=ls())

library(xlsx)		# lets you load in Excel files directly
library(plyr)

dpi <- read.dta("DPI2012.dta")		# load Database of Political Institutions
dpi$percentl[dpi$percentl==-999] <- NA
dpi <- dpi[!is.na(dpi$percentl),]

newdata <- read.xlsx("moredata.xlsx", 1)		# load your new variable from this Excel file

dpi <- join(dpi, newdata, by="ifs")			# merge your new data and the DPI data

plot(dpi$percentl, dpi$newdata, pch=16)		# scatterplot



dpi$percentl[dpi$percentl<5] <- NA		# get rid of that weird outlier
dpi <- dpi[!is.na(dpi$percentl),]





##########

library(scrapeR)		# a useful web scraping package
library(pscl)
library(fastmatch)


url <- "http://vote.duma.gov.ru/vote/50401?print&sort=name_asc"
page <- readLines(url)		# load the full HTML data



