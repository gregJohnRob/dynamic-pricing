#!/bin/bash

select_random_element() {
    local received_array=("$@") 
    num_elements=${#received_array[@]}
    random_index=$(( $RANDOM % num_elements ))
    echo "${received_array[$random_index]}"
} 

# Define the set as an array
VALID_PERIODS=("Summer" "Autumn" "Winter" "Spring")
VALID_HOTELS=("FloatingPointResort" "GitawayHotel" "RecursionRetreat")
VALID_ROOMS=("SingletonRoom" "BooleanTwin" "RestfulKing")

for i in {1..10000}; do
  random_period=$(select_random_element "${VALID_PERIODS[@]}")
  random_hotel=$(select_random_element "${VALID_HOTELS[@]}")
  random_room=$(select_random_element "${VALID_ROOMS[@]}")
  result=$(curl "http://localhost:3000/pricing?period=$random_period&hotel=$random_hotel&room=$random_room" -s | jq '.rate')
  echo "period=$random_period, hotel=$random_hotel, room=$random_room, result=$result \n"
done
