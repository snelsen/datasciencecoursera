corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0

    ## Return a numeric vector of correlations

    # Assume that the user has already sourced complete.R
    # This gets a table of site ID to number of complete cases.
    completes <- complete(directory)

    # Now trim the completes data.frame down to only those sites
    #  that have a number of completes > threshold.
    completes_mask <- completes[,"nobs"] > threshold
    completes <- completes[completes_mask, ]

    # For each remaining site, find the correlation between
    #  sulfate and nitrate measurements using cor().
    ids <- completes$id
    rv <- vector("numeric", length=length(ids))
    for(i in seq_along(ids))
    {
        site = ids[i]
        # Load the data for the site.
        filename <- sprintf("%s/%03d.csv", directory, ids[i])
        data <- read.csv(filename, header=TRUE)

        # Trim data down to only the complete cases.
        mask <- complete.cases(data)
        data <- data[mask,]

        # Compute the correlation between sulfate and nitrate.
        #rv[i] <- cor(data$sulfate, data$nitrate)
        rv[i] <- cor(data$sulfate, data$nitrate, use="everything")
    }
    rv
}
