#!/bin/bash
PS3='Enter Your Choice:'
select val in "Insert into table" "Update Table" "Delete from Table" "List Tables" "Search in table" "Exit"

do
    case $REPLY in 
    1)
    
    #cd ..;
    clear
    source ./insertTabledata.sh
    ;;
    2)
    clear
    source ./updateDataintable.sh
    
    #cd .. ;
    
    ;;
    3)
    clear
    source ./delete_from_table.sh
    
    #cd .. ;
    
    ;;
    4)
    
    source ./list_tables.sh
    clear
    #cd .. ;
    
    ;;
    5)
    clear
    source ./select_from_table.sh
    #cd ..;
    
    ;;
    6)
    clear
    #cd ..;
    echo "GoodBye :)" ; break 100
    ;;
     *) 
      echo -e "\e[31mNot in menu, please enter a valid choice\e[0m";;

    esac 
done
