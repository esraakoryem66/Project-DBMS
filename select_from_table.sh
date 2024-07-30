#!/bin/bash

read -p "Enter table name : " table_name

while [ ! -e "db/$db_name/$table_name" ]
do
    echo -e "\e[31mTable not found enter the name again\e[0m"
    read table_name
done

clear
read -p "Enter the data you want to find it " id

tail -n +3 "db/$db_name/$table_name" | grep "$id" 


if [ $? -ne 0 ]; then
    echo -e "\e[31m************* Record not found for $id. ****************\e[0m"
fi

select rl in "Back to table operation menu" "Back to table menu"
do
   case $REPLY in 
     1) 
     source ./menuabledata.sh
     ;;
     2)
      source ./menuTable.sh
     ;;
     *) 
     echo -e "\e[31mPlease enter a valid choice\e[0m";;
     esac
     
done
