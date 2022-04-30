#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo "$($PSQL "TRUNCATE TABLE games, teams;")"

function ADDTEAM () {
  RESULT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$1';")
  if [[ -z $RESULT_TEAM_ID ]]
  then 
    INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$1');")
    if [[ $INSERT_TEAM_RESULT == 'INSERT 0 1' ]]
    then
      echo TEAM ADDED $1
    fi
  fi
  RESULT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$1';")
}

cat games.csv | while IFS=, read YEAR ROUND WINNER OPPOMENT WINNER_GOALS OPPONENT_GOALS
do
  # Skip the header line
  if [[ $YEAR != 'year' ]]
  then
    # Add the teams
    ADDTEAM "$WINNER"
    WINNER_ID=$RESULT_TEAM_ID
    ADDTEAM "$OPPOMENT"
    OPPOMENT_ID=$RESULT_TEAM_ID
    
    # Add the game
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, \
    winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPOMENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")
    if [[ $INSERT_GAME_RESULT == 'INSERT 0 1' ]]
    then
      echo GAME ADDED: $YEAR, $ROUND, $WINNER_ID, $OPPOMENT_ID
    fi
  fi
done
