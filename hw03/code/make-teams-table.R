title: "Team Tables"
description: "Data preparation of .csv file containg NBA team data."
output: csv_document

stats <- read.csv("stat133/stat133-hws-fall17/hw03/data/nba2017-stats.csv")
roster <- read.csv("stat133/stat133-hws-fall17/hw03/data/nba2017-roster.csv")

library("ggplot2")
library("dplyr")

stats <- mutate(stats,
                missed_fg=field_goals_atts-field_goals_made,
                missed_ft=points1_atts-points1_made,
                points=3*points3_made+2*points2_made+points1_made,
                rebounds=off_rebounds+def_rebounds,
                efficiency=(points+rebounds+steals+assists+blocks-missed_fg-missed_ft-turnovers)/games_played)

sink(file = "stat133/stat133-hws-fall17/hw03/output/efficiency-summary.txt")
summary(stats$efficiency)
sink()

merged <- merge(stats,roster)

teams <- select(merged,experience,salary,points3=points3_made,points2=points2_made,free_throws=points1_made,points,off_rebounds,def_rebounds,assists,steals,blocks,turnovers,fouls,efficiency)
teams$salary=teams$salary/1000000
teams <- aggregate(teams,by=list(merged$team),FUN=sum)
teams[1] <- levels(merged$team)
colnames(teams)[1] <- "team"
summary(teams)

sink(file="stat133/stat133-hws-fall17/hw03/output/teams-summary.txt")
summary(teams)
sink()

write.csv(teams,file="stat133/stat133-hws-fall17/hw03/data/nba2017-teams.csv")

stars(teams[,-1],labels = teams$team)
pdf(file="stat133/stat133-hws-fall17/hw03/images/teams_star_plot.pdf")
stars(teams[,-1],labels = teams$team)
dev.off()

ggplot(teams,aes(x=experience,y=salary,label=team))+geom_point()+geom_label()
pdf(file="stat133/stat133-hws-fall17/hw03/images/experienc_salary.pdf")
ggplot(teams,aes(x=experience,y=salary,label=team))+geom_point()+geom_label()
dev.off()


