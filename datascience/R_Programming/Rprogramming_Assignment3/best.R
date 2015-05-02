best <- function(state,outcome) {
    # Read outcome data
    data <- read.csv(file="outcome-of-care-measures.csv",colClasses="character")
    # Check that state and outcome are valid
    if (!(state %in% data$State)) {
        stop("invalid state")
    }
    if (!(outcome %in% c("heart attack","heart failure","pneumonia"))) {
        stop("invalid outcome")
    }
    
    # Return hospital name in that state with lowest 30-day death rate.
    if (outcome == "heart attack") {
        result <- data[data$State==state,c(2,11)]
        result[,2] <- as.numeric(result[,2])
        sortResult <- result[order(result[,2],result[,1]),]
        sortResult[1,1]
    }
    else if (outcome == "heart failure") {
        result <- data[data$State==state,c(2,17)]
        result[,2] <- as.numeric(result[,2])
        sortResult <- result[order(result[,2],result[,1]),]
        sortResult[1,1]
    }
    else if (outcome == "pneumonia") {
        result <- data[data$State==state,c(2,23)]
        result[,2] <- as.numeric(result[,2])
        sortResult <- result[order(result[,2],result[,1]),]
        sortResult[1,1]
    }
}