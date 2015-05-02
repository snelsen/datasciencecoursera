rankhospital <- function(state, outcome, num = "best") {
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

    ## Trim to just the hopital name and its rank for the specified outcome.
    state_data <- data[state_mask, c("Hospital.Name", outcome_matches[1])]
    colnames(state_data) <- c("name", "outcome")
    state_data[,"outcome"] <- as.numeric(state_data[,"outcome"])
    state_data <- na.omit(state_data)

    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    if (num == "best") num = 1
    if (num == "worst") num = nrow(state_data)
    ordering <- with(state_data, order(outcome, name, na.last=NA))
    pick <- state_data[ordering, ][num, "name"]
    pick
}
