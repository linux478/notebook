#!/usr/bin/bash

update-phone-list () {
  FILE=phone-list.psv
  EMPLOYEES=db_employees.tbl
  EXTENSIONS=db_employees_extenion.tbl

  join -t\| $EMPLOYEES $EXTENSIONS | awk -F\| 'BEGIN { printf "Employee First, Last Name|Extenion\n"}{printf "%s|%s\n", $2, $3}' > $FILE
}

isPhoneListOld () {
  FILE=phone-list.pcv
  EMPLOYEES=db_employees.tbl
  EXTENSIONS=db_employees_extenion.tbl

  [ ! -f "$FILE" ] || [ "$FILE" -ot "$EMPLOYEES" ] || [ "$FILE" -ot "$EXTENSIONS" ]
}

isPhoneListOld && update-phone-list


asciidoctor-pdf -D Output index.adoc
