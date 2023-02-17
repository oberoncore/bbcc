sudo rm /var/lib/firebird/2.5/data/T.FDB
gbak -r -user SYSDBA -pas masterkey -v T.FBK /var/lib/firebird/2.5/data/T.FDB

