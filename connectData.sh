#!/bin/bash

read -p "Enter database name that you want to connect with it: " db_name
export db_name

if [ -d db/$db_name ]; then
    select opt in "create table" "remove table" "use table" "show table" "go to database menu" "exit"; do
        case $REPLY in
            1)	clear
                source ./createTable.sh
                ;;
            2)
            	clear
                source ./delete_table.sh
                ;;
            3)
            	clear
               source ./table-menu.sh
                ;;
            4)
            	clear
                source ./list_tables.sh 
                ;;
            5)
            	clear
                source ./main_menu.sh
                ;;
            6)
            	clear
                break
                ;;
            *)
                echo -e "\e[31mPlease enter a valid choice\e[0m"
                ;;
        esac
    done
else
    echo -e "\e[31m<<<<<<<<<<<<<<< Database enterd not found >>>>>>>>>>>>>>>\e[0m"
    source main_menu.sh
fi

