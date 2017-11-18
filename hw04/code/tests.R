source("functions.r")
library(testthat)



a <- c(1,4,7,NA,10)
b <- c(18,15,16,4,17,9)
c <- c(NA,NA,NA,1)
d <- rep(NA+NA,4)
e <- c('a',1,'f',NA,7,9)

context("Remove Missing")
test_that("NAs removed",{
  expect_equal(remove_missing(a),c(1,4,7,10))
  expect_equal(remove_missing(b),b)
  expect_equal(remove_missing(c),1)
  expect_equal(remove_missing(d),numeric(0))
})

context("Minimum")
test_that("Minimum returned",{
  expect_equal(get_minimum(a,TRUE),min(a,na.rm = TRUE))
  expect_equal(get_minimum(a,FALSE),min(a))
  expect_equal(get_minimum(b),min(b,na.rm = TRUE))
  expect_equal(get_minimum(c),min(c,na.rm = TRUE))
  expect_equal(get_minimum(c,FALSE),min(c))
  expect_error(get_minimum(e),"non-numeric argument")
})

context("Maximum")
test_that("Maximum returned",{
  expect_equal(get_maximum(a,TRUE),max(a,na.rm = TRUE))
  expect_equal(get_maximum(a,FALSE),max(a))
  expect_equal(get_maximum(b),max(b,na.rm = TRUE))
  expect_equal(get_maximum(c),max(c,na.rm = TRUE))
  expect_equal(get_maximum(c,FALSE),max(c))
  expect_error(get_maximum(e),"non-numeric argument")
})

context("Range")
test_that("Range calculated",{
  expect_equal(get_range(a,TRUE),9)
  expect_equivalent(get_range(a,FALSE),as.numeric(NA))
  expect_equal(get_range(b),14)
  expect_equal(get_range(c,TRUE),0)
  expect_equal(get_range(c,FALSE),as.numeric(NA))
  expect_error(get_range(e),"non-numeric argument")
})

context("Percentile10")
test_that("10th Percentile calculated",{
  expect_equal(get_percentile10(a,TRUE),1.9)
  expect_error(get_percentile10(a,FALSE))
  expect_equal(get_percentile10(b),6.5)
  expect_equal(get_percentile10(c,TRUE),1)
  expect_error(get_percentile10(e),"non-numeric argument")
})

context("Percentile90")
test_that("90th Percentile calculated",{
  expect_equal(get_percentile90(a,TRUE),9.1)
  expect_error(get_percentile90(a,FALSE))
  expect_equal(get_percentile90(b),17.5)
  expect_equal(get_percentile90(c,TRUE),1)
  expect_error(get_percentile90(e),"non-numeric argument")
})

context("Median")
test_that("Median returned",{
  expect_equal(get_median(a,TRUE),median(a,na.rm = TRUE))
  expect_equal(get_median(a,FALSE),median(a))
  expect_equal(get_median(b),median(b))
  expect_equal(get_median(c,TRUE),median(c,na.rm = TRUE))
  expect_equal(get_median(d,FALSE),median(d))
  expect_error(get_median(e),"non-numeric argument")
})

test_that("Average returned",{
  expect_equal(get_average(a,TRUE),mean(a,na.rm = TRUE))
  expect_equal(get_average(a,FALSE),mean(a))
  expect_equal(get_average(b),mean(b))
  expect_equal(get_average(c,TRUE),mean(c,na.rm = TRUE))
  expect_equal(get_average(d,TRUE),mean(d,na.rm = TRUE))
  expect_error(get_average(e),"non-numeric argument")
})

context("Standard Deviation")
test_that("Standard Deviation calculated",{
  expect_equal(get_stdev(a,TRUE),sd(a,na.rm = TRUE))
  expect_equal(get_stdev(a,FALSE),sd(a))
  expect_equal(get_stdev(b),sd(b))
  expect_equal(get_stdev(c,TRUE),sd(c,na.rm = TRUE))
  expect_equal(get_stdev(d,FALSE),sd(d))
  expect_error(get_stdev(e),"non-numeric argument")
})

context("Count Missing")
test_that("Missing Counts",{
  expect_equal(count_missing(a),1)
  expect_equal(count_missing(b),0)
  expect_equal(count_missing(c),3)
  expect_equal(count_missing(d),4)
  expect_equal(count_missing(e),1)
})

context("Summary Stats")
test_that('Stats Summarized',{
  expect_equal(summary_stats(a)[[1]],get_minimum(a))
  expect_equal(summary_stats(b)[[2]],get_percentile10(b))
  expect_equal(summary_stats(a)[[11]],count_missing(a))
  expect_equal(summary_stats(b)[[10]],get_stdev(b))
})

context("Drop Lowest")
test_that("Lowest Dropped",{
  expect_equal(drop_lowest(a),a[-1])
  expect_equal(drop_lowest(b),b[-4])
  expect_equal(drop_lowest(c(10,21,3)),c(10,21))
  expect_error(drop_lowest(e),"non-numeric argument")
})

test_that("Rescaled by 100",{
  expect_equal(rescale100(a,0,10),c(10,40,70,NA,100))
  expect_equal(rescale100(b,0,100),b)
  expect_equal(rescale100(c,0,200),c(NA,NA,NA,.5))
  expect_equal(rescale100(d,10,20),d)
  expect_error(rescale100(e,0,1),"non-numeric argument")
})

context("Score Homework")
test_that("Homework Scored",{
  expect_equal(score_hws(b),mean(b))
  expect_equal(score_hws(b,TRUE),mean(b[-4]))
  expect_equal(score_hws(c(10,10,10,9)),9.75)
  expect_equal(score_hws(c(10,10,10,9),TRUE),10)
})

context("Score Quiz")
test_that("Quiz Scored",{
  expect_equal(score_hws(b),mean(b))
  expect_equal(score_hws(b,TRUE),mean(b[-4]))
  expect_equal(score_hws(c(10,10,10,9)),9.75)
  expect_equal(score_hws(c(10,10,10,9),TRUE),10)
})

context("Score Lab")
test_that("Lab Scored",{
  expect_equal(score_lab(12),100)
  expect_equal(score_lab(6),0)
  expect_equal(score_lab(9),60)
  expect_equal(score_lab(1),0)
})