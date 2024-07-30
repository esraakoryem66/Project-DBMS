
echo -e "\e[34m<<<<<<<<<<<< the tables in this database is >>>>>>>>>>>>>>>>>>>\e[0m"
       if [ "$(ls -A "db/$db_name")" ]; then
    ls ""db/$db_name""/* | awk -F/ '{print $NF}'
  else
    echo "The database is empty."
  fi 
          source ./menuTable.sh
