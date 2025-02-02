#!/bin/bash

while true; do
    read -p "Enter table name: " db_table
    db_table=$(echo "$db_table" | tr " " "_")

    if [[ ${#db_table} -lt 2 ]]; then
        echo -e "\e[31mTable must contain at least 2 characters. Press 1 to enter the name again.\e[0m"
    elif [[ ${#db_table} -gt 20 ]]; then
        echo -e "\e[31mTable name is too long. Press 1 to enter the name again.\e[0m"
    elif [[ $db_table = [0-9]* ]]; then
        echo -e "\e[31mTable can't start with a number. Press 1 to enter the name again.\e[0m"
    elif [[ $db_table = "" ]]; then
        echo -e "\e[31mEmpty name! Press 1 to enter the name again.\e[0m"
    elif [[ $db_table =~ ['!@#$%^&*:/\\()+'] ]]; then
        echo -e "\e[31mTable can't contain special characters. Press 1 to enter the name again.\e[0m"
    else
        if [[ -e "db/$db_name/$db_table" ]]; then
            echo -e "\e[31mThis name already exists. Press 1 to enter the name again.\e[0m"
        else
            touch "db/$db_name/$db_table"
            clear;
            echo -e "\e[32mYour table is created <3\e[0m"
            break
        fi
    fi  
done

if [[ -e "db/$db_name/$db_table" ]]; then
    cd "db/$db_name"
    columns="ID:"
    datatype="auto:"
    echo -e "\e[32m** tableID is created automatically in the first field as (PK) **\e[0m"
    echo -e "\e[32m** Table columns can't exceed 5 columns *\e[0m"
    FieldNumber=2

    function insert {
        read -p "Enter field number $FieldNumber:" field

       while [[ $field =~ ^[a-zA-Z]{1}$ ]] || [[ ${#field} -gt 20 ]] || [[ $field = [0-9]* ]] || [[ $field = "" ]] || [[ $field =~ ['!@#$%^&*:/\\()+'] ]] || [[ "$field" =~ ^ID$ ]] || [[ "$field" =~ ^id$ ]] || [[ "$field" =~ ^Id$ ]] || [[ "$field" =~ ^iD$ ]]
        do
            if [[ "$field" =~ ^ID$ ]] || [[ "$field" =~ ^id$ ]] || [[ "$field" =~ ^Id$ ]] || [[ "$field" =~ ^iD$ ]]; then
                echo -e "\e[31mField named 'ID' already exists! Enter a different name\e[0m"
            else
                echo -e "\e[31mInvalid input! Enter your feild again\e[0m"
            fi
            read -p "Enter field number $FieldNumber: " field
        done
        
        export field

        if echo "$columns" | grep -iq ":$field:"; then
            echo "Field named $field already exists."
            insert
        else
            columns+="$field"

            echo -e "\e[34mChoose the datatype:\e[0m"
            select data in "Integer" "String"
            do
                case $REPLY in
                    1 ) datatype+="int"; break;;
                    2 ) datatype+="string"; break;;
                    * ) echo "Invalid choice";;
                esac
            done

            echo -e "\e[34mChoose if it can be NULL or not:\e[0m"
            select opt in "NULL" "Not NULL"
            do
                case $REPLY in
                    1 ) datatype+=""; break;;
                    2 ) datatype+=" (Not NULL)"; break;;
                    * ) echo "Not in menu";;
                esac
            done

            echo -e "\e[34mInsert another field?\e[0m"
            select opt in "Yes" "No"
            do
                case $REPLY in
                    1 )
                    if [ $FieldNumber -le 5 ]; then
                        ((FieldNumber=FieldNumber+1))
                        columns+=":"
                        datatype+=":"
                        insert
                    else
                        clear
                        echo -e "\e[31m*** The table is limited to 5 fields **\e[0m"
                        echo -e "\e[32mYour meta data saved successfully \e[0m"
                    fi
                    break;;

                    2 ) break;;
                    * ) echo -e "\e[31mNot in menu, please enter a valid choice\e[0m";;
                esac
            done
        fi
    }

    insert
    echo "$columns" >> "$db_table"
    echo "$datatype" >> "$db_table"

    cd ..
    cd ..
    
    source ./menuTable.sh
fi
