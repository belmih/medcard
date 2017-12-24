unit dbcreate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb;


const
  sqlcreate: string = 'CREATE TABLE person (' +
    'id         INTEGER      PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,' +
    'family     VARCHAR (50),                                          ' +
    'name       VARCHAR (50),                                          ' +
    'middlename VARCHAR (50),                                          ' +
    'dbirth     DATE,                                                  ' +
    'photo      BLOB,                                                  ' +
    'dateappend DATETIME,                                              ' +
    'prim       TEXT);';

procedure DBCreate(SQLite3Connection1: TSQLite3Connection);


 implementation

 procedure DBCreate(SQLite3Connection1: TSQLite3Connection);
 begin
   SQLIte3Connection1.ExecuteDirect(sqlcreate);
 end;


end.

