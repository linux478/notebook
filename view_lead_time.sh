#!/bin/sh

SEARCH=$1
sqlite3 database.sqlite3 <<EOF
.header on
.mode column
.width 40

SELECT description as DESCRIPTION,
       date(due_date) as DUE,
       date(finish_date) as DONE,
       finish_date - due_date as "LEADTIME(DAYS)"
FROM todo;
EOF
