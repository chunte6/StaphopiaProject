#library("curlconverter")
library("devtools")
library("staphopia")
library(httr)  #for GET(...)
library(rjson)   # for fromJSON(...)

query <- "https://staphopia.emory.edu/api/sample"
getdata <- GET(url=query,accept_json(), add_headers(Authorization="token 40808ced9d94726e0fb241b32a18018398acabb1"))

getdata<-unlist(getdata, recursive = TRUE, use.names = TRUE)
tdata<-fromJSON(content(getdata,type="text/html",encoding = "utf-8"))
print(getdata)
#print(tdata)
#curlExample <- "curl -X GET --header 'Accept: application/json' --header 'Authorization: Token 40808ced9d94726e0fb241b32a18018398acabb1' 'https://staphopia.emory.edu/api/sample'"

#resp <- make_req(straighten(curlExample))
#resp
#curl -H 'Authorization: Token 40808ced9d94726e0fb241b32a18018398acabb1' 'https://staphopia.emory.edu/api/sample/'
