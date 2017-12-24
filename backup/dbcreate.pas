unit dbcreate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb ;


const
  tableUsers: string = ' CREATE TABLE users (' +
    ' id         INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,' +
    ' login      TEXT,'+
    ' password   TEXT,'+
    ' role       TEXT);';

  tableDoctors: string =  ' CREATE TABLE doctors (' +
    ' id         INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,' +
    ' surname    TEXT,'+
    ' name       TEXT,'+
    ' patronymic TEXT,'+
    ' fullname   TEXT,'+
    ' post       TEXT);';

  tableActions: string =  ' CREATE TABLE actions (' +
    ' id         INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,' +
    ' actiondate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,'+
    ' user_id    INTEGER REFERENCES users,'+
    ' doc_id     INTEGER REFERENCES doctors,'+
    ' medcardnum VARCHAR (256));';

  tableQuestions: string =  ' CREATE TABLE questions (' +
    ' id            INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,' +
    ' level1        INTEGER,'+
    ' level2        INTEGER,'+
    ' level3        INTEGER,'+
    ' questionorder INTEGER,'+
    ' questiontext  TEXT);';

  tablesAnswers: string = ' CREATE TABLE answers (' +
    ' id          INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,' +
    ' answerorder INTEGER,'+
    ' question_id INTEGER REFERENCES questions,'
    ' answertext  TEXT,'+
    ' points      INTEGER );';

  tablesResults: string = ' CREATE TABLE results (' +
    ' id           INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,' +
    ' action_id    INTEGER REFERENCES actions,'+
    ' level1       INTEGER,'+
    ' level2       INTEGER,'+
    ' level3       INTEGER,'+
    ' questiontext TEXT,'
    ' answertext   TEXT,'+
    ' points       INTEGER );';

procedure dbcreate(SQLite3Connection1: TSQLite3Connection);

 implementation
 procedure dbcreate(SQLite3Connection1: TSQLite3Connection);
 begin
   SQLIte3Connection1.ExecuteDirect(tableUsers);
   SQLIte3Connection1.ExecuteDirect(tableDoctors);
   SQLIte3Connection1.ExecuteDirect(tableActions);
   SQLIte3Connection1.ExecuteDirect(tableQuestions);
   SQLIte3Connection1.ExecuteDirect(tablesAnswers);
   SQLIte3Connection1.ExecuteDirect(tablesResults);

   SQLIte3Connection1.ExecuteDirect('CREATE UNIQUE INDEX "users_id_idx" on users(id);');

 end;

end.

