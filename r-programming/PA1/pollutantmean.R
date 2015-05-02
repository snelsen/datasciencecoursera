pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".

    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used

    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)

    full_dataset <- c()
    for (each_id in id)
    {
        filename <- sprintf("%s/%03d.csv", directory, each_id)
        data = read.csv(filename, header=TRUE)
        pollutant_data <- na.omit(data[, pollutant])
        full_dataset <- c(full_dataset, pollutant_data)
    }

    mean(full_dataset)
}
