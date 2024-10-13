#!/bin/bash
# Simple tic tac toe game 

echo "Welcome to our Tic tac toe game"
sleep 1
echo "Please enter yout name below "
read name
echo "Hello ${name}"

# Initialize the game board
board=("1" "2" "3" "4" "5" "6" "7" "8" "9")
wining_combinations=("0 1 2" "3 4 5" " 6 7 8" "0 3 6" "1 4 7" "2 5 8" "0 4 8" "2 4 6")

# Function  to display the board 
display_board(){
 echo " ${board[0]} | ${board[1]} | ${board[2]} "
 echo "---|---|---"
 echo " ${board[3]} | ${board[4]} | ${board[5]} "
 echo "---|---|---"
 echo " ${board[6]} | ${board[7]} | ${board[8]} " 
}

display_board

echo  "Please enter digit from 1 to 9 where you want to put an X"


# Validate and update board
validate_and_update_board(){
 local position=$1
 local symbol=$2
 if [[ "$position" =~ ^[1-9]$ ]]; then
 if [[ "${board[$((position-1))]}" != "X" && "${board[((position-1))]}" != "O" ]]; then
  board[$((position-1))]="${symbol}"
 else 
 echo "The position is already taken. Try again!"
 return 1
 fi
 else
 echo "Invalid input, try again"
 continue
 fi
}

generate_random_number(){
 echo $(( (RANDOM % 9) + 1))
}

checkWining(){
# Set wining algorithm
 local player=$1
 for combination in "${wining_combinations[@]}"; do
  set -- $combination
  if [[ "${board[$1]}" == "${board[$2]}" && "${board[$2]}" == "${board[$3]}" && "${board[$1]}" == "$player" ]]; then
  if [[ "$player" == "X" ]]; then
   echo "Congrats $name you beat the computer, nice job"
   exit 0
  else
   echo "Sorry $name, you failed! Computer won. Try again!"
  exit 0
 fi
 fi 
 done
}

computersTurn(){
 echo "Ok, now it's my turn"
 sleep 1
 number=$(generate_random_number)
 validate_and_update_board "$number" "O"
 status2=$?
 if [[ $status2 -ne 0 ]]; then
  computersTurn
 fi
 display_board
 echo - - - - - - - 
}

for i in {0..9}
do
 read position
 validate_and_update_board "$position" "X"
 status=$?
 if [[ $status -ne 0 ]]; then
 continue
 fi
 display_board
 computersTurn
 #echo "Ok, now it's my turn"
 checkWining "X"
 # echo if player won if not
 checkWining "O"
 # if computer won end the game and echo the wining player
 echo "Input please "
done

sleed 1
display_board
