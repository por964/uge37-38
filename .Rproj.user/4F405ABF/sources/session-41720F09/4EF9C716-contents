library(remotes)
remotes::install_github("ropengov/eurostat")

evaluate <- curl::has_internet()

# Load the package
library(eurostat)
# library(rvest)

# Get Eurostat data listing
toc <- get_eurostat_toc()

# Check the first items
library(knitr)
kable(tail(toc))

# info about passengers
kable(head(search_eurostat("passenger transport")))

# For the original data, see
# http://ec.europa.eu/eurostat/tgm/table.do?tab=table&init=1&plugin=1&language=en&pcode=tsdtr210
id <- search_eurostat("Modal split of passenger transport",
                      type = "table"
)$code[1]
print(id)

dat <- get_eurostat(id, time_format = "num")

#install.packages("eurostat")

getwd()
