rankall <- function(outcome, num = "best") {
    ## Read outcome data
    filename <- "rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"
    data <- read.csv(filename, colClasses = "character")

    ## Check that state and outcome are valid
    col_names <- colnames(data)
    outcome <- sub(" ", ".", outcome)
    outcome_matches <- grep(pattern=outcome, x=col_names, value=TRUE, ignore.case=TRUE)
    if (length(outcome_matches) == 0) stop("invalid outcome")

    ## Trim the data to just what we want.
    data <- data[, c("Hospital.Name", outcome_matches[1], "State")]
    colnames(data) <- c("name", "outcome", "state")
    data$outcome <- as.numeric(data$outcome)
    data <- na.omit(data)

    ## For each state, find the hospital of the given rank
    # First, get a list of unique states:
    states <- sort(unique(unlist(data$state)))
    rv <- data.frame(hospital=NA, state=states, row.names=states)
    for (state in states)
    {
        state_data <- data[data$state == state, ]
        if (num == "best") this_num <- 1
        else if (num == "worst") this_num <- nrow(state_data)
        else this_num <- num
        ordering <- with(state_data, order(outcome, name))
        hospital <- state_data[ordering, ][this_num, "name"]
        rv[state, "hospital"] <- hospital
    }

    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    rv
}
