#!/bin/bash

clear

db_folder="db"

echo -e "\e[34m<<<<<<<<<<<<<<< DataBases are here >>>>>>>>>>>>>>>>>>\e[0m"
ls -d "$db_folder"/* | awk -F/ '{print $NF}'


select reply in "Back to database Menu" "Exit"
do
    case $REPLY in
        1) 
            clear
            source ./main_menu.sh
            break
            ;;
        2)
            echo "Good Bye ^_^"
            break 20
            ;;
        *) 
            echo "Not in menu"
            ;;
    esac
done

