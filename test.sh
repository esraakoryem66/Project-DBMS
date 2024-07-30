read -p "enter" db_name
if [[ $db_name =~ [!@#$%^&*:/\\()+[]{}] ]]; then
   echo "Database cannot contain special characters .. press 1 to enter name again"
   else 
   echo "That is right" 
   fi  
       
