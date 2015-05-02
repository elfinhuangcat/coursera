rankall <- function(outcome, num="best") {
    ## Read outcome data.
    data <- read.csv("outcome-of-care-measures.csv",colClasses="character")
    ## Check that state and outcome are valid
    if (!(outcome %in% c("heart attack","heart failure","pneumonia"))) {
        stop("invalid outcome")
    }
    
    ## For each state, find the hospital of the given rank.
    ## 1. Rank by which outcome?
    if (outcome == "heart attack") {
        ## 2. Select the related columns.
        result <- data[,c(2,7,11)]
        ## 3. Split the data frame by states.
        result <- split(result,as.factor(result$State))
        ## 4. Sort every data frame in the split list.
        result <- sort_dataframes_in_list(result)
        ## 5. Return the data frame with hospital names of given rank.
        construct_df_hospital_state(result,num)
    }
    else if (outcome == "heart failure"){
        ## 2. Select the related columns.
        result <- data[,c(2,7,17)]
        ## 3. Split the data frame by states.
        result <- split(result,as.factor(result$State))
        ## 4. Sort every data frame in the split list.
        result <- sort_dataframes_in_list(result)
        ## 5. Return the data frame with hospital names of given rank.
        construct_df_hospital_state(result,num)
    }
    else if (outcome == "pneumonia"){
        ## 2. Select the related columns.
        result <- data[,c(2,7,23)]
        ## 3. Split the data frame by states.
        result <- split(result,as.factor(result$State))
        ## 4. Sort every data frame in the split list.
        result <- sort_dataframes_in_list(result)
        ## 5. Return the data frame with hospital names of given rank.
        construct_df_hospital_state(result,num)
    }    
}

sort_dataframes_in_list <- function(list) {
    for (i in 1:length(list)) {
        list[[i]][,3] <- as.numeric(list[[i]][,3])
        list[[i]] <- list[[i]][!is.na(list[[i]][,3]),]
        list[[i]] <- list[[i]][order(list[[i]][,3],list[[i]][,1]),]
    }
    list
}

# list is sorted
construct_df_hospital_state <- function(list,num) {
    if (num == "best") {
        result <- matrix(list[[1]][1,c(1,2)],nrow=1)
        for (i in 2:length(list)){
            result <- rbind(result,matrix(list[[i]][1,c(1,2)],nrow=1))
        }
        result <- data.frame(result,row.names=result[,2])
        names(result) <- c("hospital","state")
        result
    }
    else if (num == "worst") {
        result <- matrix(list[[1]][nrow(list[[1]]),c(1,2)],nrow=1)
        for (i in 2:length(list)){
            result <- rbind(result,
                            matrix(list[[i]][nrow(list[[i]]),c(1,2)],
                                   nrow=1))
        }
        result <- data.frame(result,row.names=result[,2])
        names(result) <- c("hospital","state")
        result
    }
    else {
        result <- matrix(c("hospital","AK"),nrow=1)
        if (num > nrow(list[[1]])) {
            result[1,1] <- NA
        }
        else {
            result[1,1] <- list[[1]][num,1] 
        }
        
        for (i in 2:length(list)){
            if (num > nrow(list[[i]])) {
                result <- rbind(result,matrix(list[[i]][1,c(1,2)],
                                              nrow=1))
                result[i,1] <- NA
            }
            else {
                result <- rbind(result,matrix(list[[i]][num,c(1,2)],
                                              nrow=1))
            }
        }
        result <- data.frame(result,row.names=result[,2])
        names(result) <- c("hospital","state")
        result
    }
}
