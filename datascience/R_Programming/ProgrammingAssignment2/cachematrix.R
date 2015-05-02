## The functions provided below can calculate the inverse of
## a matrix in a faster way by caching the result, since we
## suppose that the input matrix will not be changed in the 
## future.

## Function name: makeCacheMatrix
## Inputs: A matrix x
## Outputs: A special matrix, with its inverse cached.

makeCacheMatrix <- function(x = matrix()) {
    inverseX <- NULL
    set <- function(y) {
        x <<- y
        inverseX <<- NULL
    }
    get <- function() x
    setInverse <- function(inv) inverseX <<- inv
    getInverse <- function() inverseX
    list(set = set, get = get,
         setInverse = setInverse, getInverse = getInverse)
}


## Function name: cacheSolve
## Inputs: The special matrix like the one produced by
##         "makeCacheMatrix(x)"
## Outputs: The inverse of the matrix x

cacheSolve <- function(x, ...) {
    inverseX <- x$getInverse()
    if(!is.null(inverseX)) {
        message("Getting cached data.")
        return(inverseX)
    }
    ## Else we need to calculate the inverse and cache it.
    data <- x$get()
    inverseX <- solve(data)
    x$setInverse(inverseX)
    inverseX
}
