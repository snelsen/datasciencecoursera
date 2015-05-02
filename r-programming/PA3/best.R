best <- function(state, outcome)
{
    ## Read outcome data
    filename <- "rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"
    data <- read.csv(filename, colClasses = "character")

    ## Check that state and outcome are valid
    state_mask <- data[,"State"] == state
    if (sum(state_mask) == 0) stop("invalid state")

    col_names <- colnames(data)
    outcome <- sub(" ", ".", outcome)
    outcome_matches <- grep(pattern=outcome, x=col_names, value=TRUE, ignore.case=TRUE)
    if (length(outcome_matches) == 0) stop("invalid outcome")

    ## Return hospital name in that state with lowest
    ## 30-day death rate.
    outcome_col <- outcome_matches[1]
    state_data <- data[state_mask,]
    state_data[,outcome_col] <- as.numeric(state_data[,outcome_col])

    min_index <- which(state_data[,outcome_col]==min(state_data[,outcome_col], na.rm=TRUE))
    names <- state_data[min_index, "Hospital.Name"]
    sort(names)[1]
}
