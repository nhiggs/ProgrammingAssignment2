## These functions cache the inverse of a matrix so as to potentially save
## the trouble of constantly computing the inverse of a matrix. This is
## because it can be quite costly to compute the inverse of a matrix
## so if it has already been computed, or if the inverse is already
## known independently, these functions allow you to retrieve or set
## the inverse without having to compute it again. If the inverse is not
## cached or already known, these functions will then compute the inverse.

## makeCacheMatrix takes in or creates a matrix and returns a fully formed
## object of type makeCacheMatrix to be used by downstream R code. The 
## object is a list of functions that can can set the matrix, get the 
## matrix, set the inverse, or get the inverse, while also caching the 
## matrix and its inverse.

makeCacheMatrix <- function(x = matrix()) {
  mInverse <- NULL
  setMatrix <- function(y) {
    x <<- y
    mInverse <<- NULL
  }
  getMatrix <- function() x
  setInverse <- function(newInverse) mInverse <<- newInverse
  getInverse <- function() mInverse
  list(setMatrix = setMatrix, getMatrix = getMatrix,
       setInverse = setInverse, getInverse = getInverse)
}


## cacheSolve will check to see if the inverse of the matrix already exists
## and will then return it. Otherwise it computes the inverse of the matrix
## itself, and then sets the inverse to the appropriate object variable.

cacheSolve <- function(x, ...){
  mInverse <- x$getInverse
  if(!is.null(mInverse)) {
    message("getting cached data")
    return(m)
  }
  data <- x$getMatrix
  mInverse <- solve(data, ...)
  x$setInverse(mInverse)
}
