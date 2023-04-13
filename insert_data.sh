#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

while IFS=, read year stage teamOne teamTwo winner_goals opponent_goals 
do 
  echo "$($PSQL "INSERT INTO teams(name) VALUES ('$teamOne')")"
  echo "$($PSQL "INSERT INTO teams(name) VALUES ('$teamTwo')")"
  winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$teamOne'")
  opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name ='$teamTwo' ")
  echo "$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES ($year,'$stage',$winner_id,$opponent_id,$winner_goals,$opponent_goals)")"
done < <(tail -n +2 games.csv) 
