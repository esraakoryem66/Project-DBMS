
read -p "Enter table name: " table_name

while [ ! -f "db/$db_name/$table_name" ] || [ -z "$table_name" ]; do
    echo -e "\e[31mTable not found or name is empty\e[0m"
    PS3="Enter your Choice: "
    select opt in "Try again" "Go back to menu"; do
        case $REPLY in
            1) 
                read -p "Enter correct table name: " table_name
                if [ -f "db/$db_name/$table_name" ]; then
                    break
                fi
                ;;
            2)
                echo "Returning to menu"
                source ./menuTable.sh
                return
                ;;
            *)
                echo "Invalid option. Try again."
                ;;
        esac
    done
done

if [[ -f "db/$db_name/$table_name" ]]; then
    rm "db/$db_name/$table_name"
    clear
    echo -e "\e[32m*** Table deleted **\e[0m"
    source menuTable.sh
else 
    echo -e "\e[32m*** Table not found ***\e[0m"
    source menuTable.sh
fi
