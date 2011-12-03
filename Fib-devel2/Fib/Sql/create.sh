sudo rm /var/lib/firebird/2.5/data/T.FDB
isql-fb -i create.sql -user SYSDBA -p masterkey
