#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"
SYMBOL=$1
# check if there's no argument
if [[ -z $SYMBOL ]]
then
  echo "Please provide an element as an argument."
else
  # check if input is not number
  if [[ ! $SYMBOL =~ ^[0-9]+$ ]]
  then
    # check if innput is greater than two letters
    LENGTH=$(echo -n "$SYMBOL" | wc -m)
    if [[ $LENGTH -gt 2 ]]
    then
      # get data by full name
      DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$SYMBOL'")
      # if data doesn't exist
      if [[ -z $DATA ]]
      then
        # display data doesn't exist
        echo "I could not find that element in the database."
      else
        # display data
        echo "$DATA" | while read BAR BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    else
      # get data by symbol
      DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$SYMBOL'")
      # if data doesn't exist
      if [[ -z $DATA ]]
      then
        # display data doesn't exist
        echo "I could not find that element in the database."
      else
        # display data
        echo "$DATA" | while read BAR BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    fi
  else
    # get data by atomic number
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$SYMBOL")
    # if data doesn't exist
      if [[ -z $DATA ]]
      then
        # display data doesn't exist
        echo "I could not find that element in the database."
      else
        # display data
        echo "$DATA" | while read BAR BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
  fi
fi

