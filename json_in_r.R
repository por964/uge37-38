

foodbank <- httr::GET('https://www.givefood.org.uk/api/2/foodbanks/')

str(foodbank)

# se JSON string indhold
str(foodbank$content)

#konverter til text
foodbankcontent <- httr::content(foodbank, as = 'text')
str(foodbankcontent)

foodbankJSON <- jsonlite::fromJSON(foodbankcontent)

View(foodbankJSON)




#reed.co.uk
my_url <- paste('https://www.reed.co.uk/api/1.0/search?keywords=dentist',
                '&location=london&distancefromlocation=50',
                '?details=true', sep="")
jobsearch <- httr::GET(my_url,
                       httr::authenticate(
                         user = '39fc8a73-d947-42a7-981d-06b17e4caa3d',
                         password = '',
                         type = 'basic'
                       ))

str(jobsearch)

str(jobsearch$content)

jobsearchcontent <- httr::content(jobsearch, as = 'text')

jobsearchJSON <- jsonlite::fromJSON(jobsearchcontent)

#colnames() virker ikke
my_cols <- names(jobsearchJSON)
my_cols

sapply(jobsearchJSON, class)

#df kan ikke ses ved at trykke på den i Data
View(jobsearchJSON$results)






