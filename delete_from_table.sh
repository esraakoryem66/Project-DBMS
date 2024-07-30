#!/bin/bash

read -p "Enter table name : " table_name

while [ ! -f "db/$db_name/$table_name" ]
do
    echo -e "\e[31mTable not found enter the name again\e[0m"
    read table_name
done

clear;
PS3='Enter Your Choice:'
select opt in  "delete data from table" "delete only record by using ID"
do
case $REPLY in 

1)
echo -e "\e[31mAre you sure to delete all data in table\e[0m"
PS3='Enter Your Choice:'
select ol in "yes" "No"
do
case $REPLY in 
1)
sed -i '3,$d' "db/$db_name/$table_name"
clear
echo -e "\e[32m~~~~~~~~~~The data deleted~~~~~~~~~~~~~\e[0m"
source ./table-menu.sh
;;
2)
source ./table-menu.sh
;;
esac
done

;;
2)
read -p "Enter the Id of the record you want to delete : " id
while ! [[ $id =~ ^[0-9]*$ ]] || [[ $id =~ ['!@#$%^&*():_+'] ]] || [[ $id == "" ]] || [[ $id =~ [a-zA-z] ]]
	do
	echo -e "\e[31mInvalid value for the id! enter your value again\e[0m"
	read id
	done
    if [ `awk '(NR>2)' "db/$db_name/$table_name"  | awk -F : ' {print $1}'| grep $id ` ]
then
echo -e "\e[31mAre you sure you want to delete this record $id\e[0m"
PS3='Enter Your Choice:'
select rel in "Yes" "No" 
do 
    case $REPLY in 
    1)
   
    `sed -i '/^'$id'/ d' "db/$db_name/$table_name"`;
    clear
    echo -e "\e[32m~~~~~~~~~~Record was deleted successfully~~~~~~~~~~~~~~\e[0m";
    echo -e "\e[34mDo you want to see the file after delete ? "db/$db_name/$table_name" Table??\e[0m";
        PS3='Enter Your Choice:'
        select relp in "Yes" "Back To Previous Menu"
        do  
            case $REPLY in
                1)
                   
                    clear
                    tail -n +3 "db/$db_name/$table_name"
                    source ./table-menu.sh
                    
                    
                    # cd ..;
                    
                    ;;
                2)
                
                # cd ..;
                source table-menu.sh 
                ;;
                *) 
                echo -e "\e[31mPlease enter a valid choice\e[0m";;

            esac
        done
    ;;
    2)
    source ./table-menu.sh
        
    ;;
     *) 
    echo -e "\e[31mNot in menu\e[0m";;
    esac
done

else 
    echo -e "\e[31mNo record with ID : $id\e[0m"
    source ./table-menu.sh
fi
esac
done


