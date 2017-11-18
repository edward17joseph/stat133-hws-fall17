source("functions.r")


dat <- read.csv('../data/rawdata/rawscores.csv')

sink('../output/summary-rawscores.txt')
str(dat)
i <- 1
while (i <= length(dat)){
  print(names(dat[i]))
  print_stats(summary_stats(col))
  i=i+1
}
sink()


for (i in 1:length(dat)){
  for (j in 1:length(dat[[i]])){
    if (is.na(dat[[i]][j])){
      dat[[i]][j]=0
    }
  }
}

dat$QZ1 <- rescale100(dat$QZ1,0,12)
dat$QZ2 <- rescale100(dat$QZ2,0,18)
dat$QZ3 <- rescale100(dat$QZ3,0,20)
dat$QZ4 <- rescale100(dat$QZ4,0,20)
dat$Test1 <- rescale100(dat$EX1,0,80)
dat$Test2 <- rescale100(dat$EX2,0,90)
dat$Lab <- score_lab(dat$ATT)
for (i in 1:nrow(dat)){
  dat$Homework[i] <- score_hws(as.numeric(dat[1:9][i,]), drop = TRUE)
}
for (i in 1:nrow(dat)){
  dat$Quiz[i] <- score_quiz(as.numeric(dat[11:14][i,]),drop = TRUE)
}
dat$Overall <- .10*dat$Lab+.3*dat$Homework+.15*dat$Quiz+.2*dat$Test1+.25*dat$Test2


grade <- function(x){
  rng <-c(50,60,70,77.5,79.5,82,86,88,90,95)
  grd <- c('F ','D ','C-','C ','C+','B-','B ','B+','A-','A ','A+')
  for (i in 1:length(rng)){
    if (x<rng[i]){
      return(grd[i])
    }
  }
  return ('A+')
}
dat$Grade <- sapply(dat$Overall,grade)

for (i in 17:22){
  path <- paste0('../output/',names(dat[i]),'-stats.txt')
  sink(path)
  print_stats(summary_stats(dat[[i]]))
  sink()
}

sink('../output/summary-cleanscores.txt')
str(dat)
sink()

write.csv(dat,file = '../data/cleandata/cleanscores.csv',row.names = FALSE)

