#!/bin/sh

SEARCH=$1
sqlite3 database.sqlite3 <<EOF
.header on
.mode column

select p.first_name as "First Name",
       p.last_name as "Last Name",
       e.extension as "Extension"
from people as p, phone_extension as e
WHERE e.fk_people = p.id AND
      p.first_name LIKE "${SEARCH}"
EOF
