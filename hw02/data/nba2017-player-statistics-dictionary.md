## Data `nba2017-player-statistics-dictionary.csv`

Here's the description of the R objects in `nba2017-player-statistics-dictionary.csv`:

- `player`: name of the player.
- `team`: team name abbreviation.
- `position`: player position.
- `experience`: years of experience.
- `salary`: salary (in dollars).
- `rank`: rank of player in his team.
- `age`: age of player at February 1st of that season.
- `GP`: games played.
- `GS`: games started.
- `MIN`: minutes played.
- `FGM`: field goals made.
- `FGA`: field goal attempts.
- `points3`: 3-point field goals.
- `points3_atts`: 3-point field goal attempts.
- `points2`: 2-point field goals.
- `points2_atts`: 2-point field goal attempts.
- `FTM`: free throws made.
- `FTA`: free throw attempts.
- `OREB`: offensive rebounds.
- `DREB`: defensive rebounds.
- `AST`: assists.
- `STL`: steals.
- `BLK`: blocks.
- `TO`: turnovers.

(see [basketball reference](www.basketball-reference.com) for mor information)


There are 30 teams in the NBA (see [GSW](https://www.basketball-reference.com/teams/GSW/2017.html) for example.)

There are five types of player positions (see [wikipedia](https://en.wikipedia.org/wiki/Basketball_positions) for more details):

+ `PG`: point guard
+ `SG`: shooting guard
+ `SF`: small forward
+ `PF`: power forward
+ `C`: center



Although each object has its own data type, you can think of each of them as a variable from a statistics standpoint like so:

| Object         | Variable     |
|:---------------|:-------------|
| `player`       | categorical  |
| `team`         | categorical  |
| `position`     | categorical  |
| `experience`   | quantitative |
| `salary`       | quantitative |
| `rank`         | quantitative |
| `age`          | quantitative |
| `GP`           | quantitative |
| `GS`           | quantitative |
| `MIN`          | quantitative |
| `FGM`          | quantitative |
| `FGA`          | quantitative |
| `points3`      | quantitative |
| `points3_atts` | quantitative |
| `points2`      | quantitative |
| `points2_atts` | quantitative |
| `FTM`          | quantitative |
| `FTA`          | quantitative |
| `OREB`         | quantitative |
| `DREB`         | quantitative |
| `AST`          | quantitative |
| `STL`          | quantitative |
| `BLK`          | quantitative |
| `TO`           | quantitative |