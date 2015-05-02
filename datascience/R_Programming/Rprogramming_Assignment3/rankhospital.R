rankhospital <- function(state,outcome,num="best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv",colClasses="character")
    ## Check that state and outcome are valid
    if (!(state %in% data$State)) {
        stop("invalid state")
    }
    if (!(outcome %in% c("heart attack","heart failure","pneumonia"))) {
        stop("invalid outcome")
    }
    
    ## Return name of the hospital in that state with the given rank
    ## 30-day death rate.
    if (outcome == "heart attack") {
        result <- data[data$State==state,c(2,11)]
        result[,2] <- as.numeric(result[,2])
        result <- result[!is.na(result[,2]),]
        sort_and_return_rank_hos(result,num)
    }
    else if (outcome == "heart failure"){
        result <- data[data$State==state,c(2,17)]
        result[,2] <- as.numeric(result[,2])
        result <- result[!is.na(result[,2]),]
        sort_and_return_rank_hos(result,num)
    }
    else if (outcome == "pneumonia"){
        result <- data[data$State==state,c(2,23)]
        result[,2] <- as.numeric(result[,2])
        result <- result[!is.na(result[,2]),]
        sort_and_return_rank_hos(result,num)
    }
}

sort_and_return_rank_hos <- function(result,num) {
    sortResult <- result[order(result[,2],result[,1]),]
    if (num=="best"){
        return(sortResult[1,1])
    }
    else if (num=="worst") {
        return(sortResult[nrow(sortResult),1])
    }
    else {
        if (num > nrow(sortResult)) {
            return(NA)
        }
        else {
            return(sortResult[num,1])
        }
    }
}