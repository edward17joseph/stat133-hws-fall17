#' @title Remove Missing Values
#' @description Removes all missing values within a vector.
#' @param x A vector.
#' @return Vector x without all instances of NA.
remove_missing <- function(x){
  remove <- c(NA)
  x[! x %in% remove]
}

#' @title Minimum Value
#' @description Returns the minima of a numeric input vector.
#' @param x A numeric vector.
#' @param na.rm A logical indicating whether missing values should be removed.
#' @return Minimum number of input values.
get_minimum <- function(x,na.rm=TRUE){
  if (!is.numeric(x)){
    stop('non-numeric argument')
  }
  if (na.rm){
    x <- remove_missing(x)
  }
  sort(x,na.last = FALSE)[1]
}

#' @title Maximum Value
#' @description Returns the maxima of a numeric input vector.
#' @param x A numeric vector.
#' @param na.rm A logical indicating whether missing values should be removed.
#' @return Maximum number of input values.
get_maximum <- function(x,na.rm=TRUE){
  if (!is.numeric(x)){
    stop('non-numeric argument')
  }
  if (na.rm){
    x <- remove_missing(x)
  }
  sort(x,decreasing = TRUE,na.last = FALSE)[1]
}

#' @title Range of Values
#' @description Computes the overall range of an input vector.
#' @param x A numeric vector.
#' @param na.rm A logical indicating whether missing values should be removed.
#' @return Difference between the maximum and minimum values of x.
get_range <- function(x,na.rm=TRUE){
  if (!is.numeric(x)){
    stop('non-numeric argument')
  }
  if (na.rm){
    x <- remove_missing(x)
  }
  return(get_maximum(x,FALSE)-get_minimum(x,FALSE))
}

#' @title 10th Percentile
#' @description Computes 10th percentile value of input vector.
#' @param x A numeric vector.
#' @param na.rm A logical indicating whether missing values should be removed.
#' @return Numeric value representing 10th percentile of x.
get_percentile10 <- function(x,na.rm=TRUE){
  if (!is.numeric(x)){
    stop('non-numeric argument')
  }
  quantile(x,c(.10),na.rm)[[1]]
}

#' @title 90th Percentile
#' @description Computes 90th percentile value of input vector.
#' @param x A numeric vector.
#' @param na.rm A logical indicating whether missing values should be removed.
#' @return Numeric value representing 90th percentile of x.
get_percentile90 <- function(x,na.rm=TRUE){
  if (!is.numeric(x)){
    stop('non-numeric argument')
  }
  quantile(x,c(.90),na.rm)[[1]]
}

#' @title Median Value
#' @description Computes median of input vector.
#' @param x A numeric vector.
#' @param na.rm A logical indicating whether missing values should be removed.
#' @return Middle value of sorted input vector if odd number of elements or average of middle two values if even.
get_median <- function(x,na.rm=TRUE){
  if (!is.numeric(x)){
    stop('non-numeric argument')
  }else if (na.rm){
    x <- remove_missing(x)
  }
  x <- sort(x,na.last = FALSE)
  if (NA %in% x){
    return(x[1])
  }else if(length(x)%%2==0){
    return((x[length(x)/2]+x[length(x)/2+1])/2)
  }else{
    return(x[length(x)/2+1])
  }
}

#' @title Average Value
#' @description Computes average of input vector values.
#' @param x A numeric vector.
#' @param na.rm A logical indicating whether missing values should be removed.
#' @return Value computed by sum of input values divided by total number of elements.
get_average <- function(x,na.rm=TRUE){
  if (!is.numeric(x)){
    stop('non-numeric argument')
  }
  if (na.rm){
    x <- remove_missing(x)
  }
  sum <- 0
  for (n in x){
    sum <- sum + n
  }
  sum/length(x)
}

#' @title Standard Deviation
#' @description Computes the standard deviation of input vector values.
#' @param x A numeric vector.
#' @param na.rm A logical indicating whether missing values should be removed.
#' @return Typical distance of a value in input vector from the mean.
get_stdev <- function(x,na.rm=TRUE){
  if (!is.numeric(x)){
    stop('non-numeric argument')
  }
  if (na.rm){
    x <- remove_missing(x)
  }
  x_bar <- get_average(x,FALSE)
  sum <- 0
  for (n in x){
    sum <- sum + (n-x_bar)^2
  }
  return(sqrt(sum/(length(x)-1)))
}

#' @title First Quartile
#' @description Computes 25th percentile value of input vector.
#' @param x A numeric vector.
#' @param na.rm A logical indicating whether missing values should be removed.
#' @return Numeric value representing 25th percentile of x.
get_quartile1 <- function(x,na.rm=TRUE){
  if (!is.numeric(x)){
    stop('non-numeric argument')
  }
  quantile(x,na.rm = na.rm)[[2]]
}

#' @title Third Quartile
#' @description Computes 75th percentile value of input vector.
#' @param x A numeric vector.
#' @param na.rm A logical indicating whether missing values should be removed.
#' @return Numeric value representing 75th percentile of x.
get_quartile3 <- function(x,na.rm=TRUE){
  if (!is.numeric(x)){
    stop('non-numeric argument')
  }
  quantile(x,na.rm = na.rm)[[4]]
}

#' @title Missing Value Count
#' @description Counts the number of missing values within input vector.
#' @param x A vector.
#' @return Number of times NA appears within vector x.
count_missing <- function(x){
  y <- remove_missing(x)
  return(length(x)-length(y))
}

#' @title Summary of Statistics
#' @description Produces results of calling various vector fitting functions on input vector.
#' @param x A numeric vector.
#' @return List of function results when called on x with respective value names.
summary_stats <- function(x){
  ls <- list()
  ls[["minimum"]] <- get_minimum(x)
  ls[["percent10"]] <- get_percentile10(x)
  ls[["quartile1"]] <- get_quartile1(x)
  ls[["median"]] <- get_median(x)
  ls[["mean"]] <- get_average(x)
  ls[["quartile3"]] <- get_quartile3(x)
  ls[["percent90"]] <- get_percentile90(x)
  ls[["maximum"]] <- get_maximum(x)
  ls[["range"]] <- get_range(x)
  ls[["stdev"]] <- get_stdev(x)
  ls[["missing"]] <- count_missing(x)
  return(ls)
}

#' @title Statistics Summary Printer
#' @description Prints list of summary statistics in easily readable format.
#' @param x List of summary statistics.
print_stats <- function(x) {
  for (i in 1:length(x)){
    stat_label <- sprintf("%-9s", names(x[i]))
    val <- sprintf(" %1.4f", x[[i]])
    cat(paste0(stat_label,':', val,"\n"))
  }
}

#' @title Rescale by 100
#' @description Rescales input vector with potential scale from 1 to 100.
#' @param x A numeric vector.
#' @param xmin A numeric.
#' @param xmax A numeric.
#' @return Rescaled vector.
rescale100 <- function(x,xmin,xmax){
  for (i in 1:length(x)){
    x[i] <- 100*(x[i]-xmin)/(xmax-xmin)
  }
  return(x)
}

#' @title Drop Lowest Value
#' @description Removes minimum value from a vector.
#' @param x A numeric vector.
#' @return Input vector without lowest value.
drop_lowest <- function(x){
  low <- get_minimum(x)
  for (i in 1:length(x)){
    if (x[i]==low){
      return(x[-i])
    }
  }
}

#' @title Homework Score
#' @description Computes the average value of the vector containing homework scores.
#' @param x Numeric vector of homework scores.
#' @param drop A logical indicating whether the lowest score should be dropped.
#' @return The average of all homework scores if drop is FALSE or all homework scores except the lowest if TRUE.
score_hws <- function(x,drop=FALSE){
  if (drop){
    x <- drop_lowest(x)
  }
  get_average(x)
}

#' @title Quiz Score
#' @description Computes the average value of the vector containing quiz scores.
#' @param x Numeric vector of quiz scores.
#' @param drop A logical indicating whether the lowest score should be dropped.
#' @return The average of all quiz scores if drop is FALSE or all quiz scores except the lowest if TRUE.
score_quiz <- function(x,drop=FALSE){
  if (drop){
    x <- drop_lowest(x)
  }
  get_average(x)
}

#' @title Lab Score
#' @description Computes lab score based on attendance.
#' @param x Number of lab attendances.
#' @return Score based on grading scale set by professor.
score_lab <- function(x){
  score <- 100 + (x-11)*20
  for (i in 1:length(score)){
    if (score[i]>100){
      score[i] <- 100
    }
    if (score[i]<0){
      score[i] <- 0
    }
  }
  score
}