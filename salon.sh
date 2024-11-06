#! /bin/bash

echo -e "\n~~~~ My Salon ~~~~\n"

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "Welcome to my salon, how can i help you?\n"

MAIN_MENU() {
  # get the sevices
  SERVICES_OFFERED=$($PSQL "SELECT * FROM services")

  # if services not found
  if [[ -z $SERVICES_OFFERED ]]
  then
    # if no sevices in the database
    echo -e "\nNo services to choose from"
  else
    # display the services
    echo "$SERVICES_OFFERED" | while read SERVICE_ID BAR NAME BAR
    do
    echo "$SERVICE_ID) $NAME"
    done
  fi

  
}

PICK_A_SERVICE() {
  read SERVICE_ID_SELECTED

  # check if SERVICE_ID_SELECED is a value
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    # if SERVICE_ID_SELECED is not a value, return to main menu
    echo -e "\nThat is not a valid service number"
    MAIN_MENU 
  else
    # get the service info
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

    if [[ -z $SERVICE_NAME ]]
    then
      # send to main menu
      echo -e "I could not find that service. What would you like today"
      MAIN_MENU
    else
      # get customer info
      echo -e "\nWhat's your number?"
      read CUSTOMER_PHONE

      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

      # if not found
      if [[ -z $CUSTOMER_NAME ]]
      then
        # request customer info
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME

        INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      fi

      # get customer info
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

      echo -e "\nWhat time would you like your$SERVICE_NAME, $CUSTOMER_NAME?"
      read SERVICE_TIME

      INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
      
      if [[ $INSERT_APPOINTMENT_RESULT == "INSERT 0 1" ]]
      then
        echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
      fi
    fi
  fi
}
MAIN_MENU
PICK_A_SERVICE

