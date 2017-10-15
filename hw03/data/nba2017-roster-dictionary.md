## Data `nba2017-roster-dictionary.csv`

Here's the description of the R objects in `nba2017-roster.csv`:

- `player`: name of the player.
- `team`: team name abbreviation.
- `position`: player position.
- `height`: player height.
- `weight`: player weight.
- `age`: age of player at February 1st of that season.
- `experience`: years of experience.
- `salary`: salary (in dollars).


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
| `height`       | quantitative |
| `weight`       | quantitative |
| `age`          | quantitative |
| `experience`   | quantitative |
| `salary`       | quantitative |


