complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used

    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases

    rv <- data.frame(id=id, nobs=0)
#    print(rv)
    for (i in seq_along(id))
    {
        filename <- sprintf("%s/%03d.csv", directory, id[i])
#        print(filename)
        data <- read.csv(filename, header=TRUE)
        rv[i,2] <- sum(complete.cases(data))
#        print(rv[i,])
    }
    rv
}
