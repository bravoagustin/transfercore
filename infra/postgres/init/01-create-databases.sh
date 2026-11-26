#!/bin/sh
# Runs only on the FIRST start of the Postgres container (empty volume).
# One logical database + one dedicated user per microservice: each service can only reach its own data.
set -eu

create_db() {
  db="$1"; user="$2"; password="$3"
  echo "Creating database ${db} owned by ${user}"
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-SQL
    CREATE USER ${user} WITH PASSWORD '${password}';
    CREATE DATABASE ${db} OWNER ${user};
    REVOKE ALL ON DATABASE ${db} FROM PUBLIC;
SQL
}

create_db contacts_db  contacts  "${CONTACTS_DB_PASSWORD}"
create_db accounts_db  accounts  "${ACCOUNTS_DB_PASSWORD}"
create_db transfers_db transfers "${TRANSFERS_DB_PASSWORD}"
