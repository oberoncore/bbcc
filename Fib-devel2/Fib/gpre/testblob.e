#include "ibase.h"


char  	db[255];

EXEC SQL 
	SET DATABASE DB1 = COMPILETIME '/var/lib/firebird/2.5/data/T.FDB' RUNTIME :db;


EXEC SQL BEGIN DECLARE SECTION;

	BASED ON BL.B blob_id;
	BASED ON BL.B.SEGMENT blob_segment_buf;
	unsigned short blob_segment_len;
EXEC SQL END DECLARE SECTION;

//-----------------------------------------------------------------
  int __declspec(dllexport) db_init(char * dbname)
{
  strcpy(db,dbname);	

  EXEC SQL CONNECT DB1;
  if (SQLCODE==0)
  {
     EXEC SQL SET TRANSACTION READ WRITE USING DB1;
  }
  return SQLCODE;
}
//-----------------------------------------------------------------
 int __declspec(dllexport) db_done()
{
  if (SQLCODE==0)
  {
     EXEC SQL COMMIT;
  }
  if (SQLCODE==0)
  {
    EXEC SQL DISCONNECT DB1;
  }
  return SQLCODE;
}
//-----------------------------------------------------------------
 int __declspec(dllexport) delete ()
{
    EXEC SQL DELETE FROM BL;
    return SQLCODE;
}
//-----------------------------------------------------------------
 int __declspec(dllexport) insert1 ()
{
	EXEC SQL DECLARE BC CURSOR FOR INSERT BLOB B INTO BL;

	EXEC SQL OPEN BC INTO :blob_id;

	blob_segment_len = 3;
	blob_segment_buf[0] = 9;
	blob_segment_buf[1] = 8;
	blob_segment_buf[2] = 7;

	EXEC SQL INSERT CURSOR BC VALUES (:blob_segment_buf:blob_segment_len);

        EXEC SQL CLOSE BC;

	EXEC SQL INSERT INTO BL (B) VALUES (:blob_id);
    return SQLCODE;
}
