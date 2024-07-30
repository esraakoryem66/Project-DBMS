select a in "Back to Database menu" "Table menu" "Exit"
do
  case $REPLY in 
  1)
   clear
   source ./main_menu.sh
  ;;
  2)
  clear
   source ./menuTable.sh
  ;;
  3)
  echo "Good Bye ^_^"
  break 20
  ;;
  *)
  echo -e "\e[31mNot in menu, please enter a valid choice\e[0m"

  ;;
  esac
done
