up2-Edward-Zamora
================

``` r
load("nba2017-salary-points.RData")
ls()
```

    ## [1] "experience" "player"     "points"     "points1"    "points2"   
    ## [6] "points3"    "position"   "salary"     "team"

``` r
summary(salary)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##     5145  1286160  3500000  6187014  9250000 30963450

*Average value for salary is 6187014. Most salaries are 5 million or less as shown by histogram which is swkewed right with subsequent values decreasing in frequency.*

``` r
hist(salary)
```

![](up02-Edward-Zamora_files/figure-markdown_github-ascii_identifiers/s-1.png)

``` r
boxplot(salary)
```

![](up02-Edward-Zamora_files/figure-markdown_github-ascii_identifiers/s-2.png)

``` r
plot(density(salary))
```

![](up02-Edward-Zamora_files/figure-markdown_github-ascii_identifiers/s-3.png)

``` r
table(team)
```

    ## team
    ## ATL BOS BRK CHI CHO CLE DAL DEN DET GSW HOU IND LAC LAL MEM MIA MIL MIN 
    ##  14  15  15  15  15  15  15  15  15  15  14  14  15  15  15  14  14  14 
    ## NOP NYK OKC ORL PHI PHO POR SAC SAS TOR UTA WAS 
    ##  14  15  15  15  15  15  14  15  15  15  15  14

``` r
prop.table(table(team))
```

    ## team
    ##        ATL        BOS        BRK        CHI        CHO        CLE 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03401361 
    ##        DAL        DEN        DET        GSW        HOU        IND 
    ## 0.03401361 0.03401361 0.03401361 0.03401361 0.03174603 0.03174603 
    ##        LAC        LAL        MEM        MIA        MIL        MIN 
    ## 0.03401361 0.03401361 0.03401361 0.03174603 0.03174603 0.03174603 
    ##        NOP        NYK        OKC        ORL        PHI        PHO 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03401361 
    ##        POR        SAC        SAS        TOR        UTA        WAS 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03174603

*Players per team is a relatively uniform distribution with each team having at least 14 players but most have 15.*

``` r
barplot(table(team))
```

![](up02-Edward-Zamora_files/figure-markdown_github-ascii_identifiers/bar-1.png)
