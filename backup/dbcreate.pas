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
    ' question_id INTEGER REFERENCES questions,'+
    ' answertext  TEXT,'+
    ' points      INTEGER );';

  tablesResults: string = ' CREATE TABLE results (' +
    ' id           INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,' +
    ' action_id    INTEGER REFERENCES actions,'+
    ' level1       INTEGER,'+
    ' level2       INTEGER,'+
    ' level3       INTEGER,'+
    ' questiontext TEXT,'+
    ' answertext   TEXT,'+
    ' points       INTEGER );';

procedure dbcreate;

 implementation
 uses loginform;

 procedure dbcreate;
 begin
  { FormLogin.SQLIte3Conn.ExecuteDirect(tableUsers);
   FormLogin.SQLIte3Conn.ExecuteDirect(tableDoctors);
   FormLogin.SQLIte3Conn.ExecuteDirect(tableActions);
   FormLogin.SQLIte3Conn.ExecuteDirect(tableQuestions);
   FormLogin.SQLIte3Conn.ExecuteDirect(tablesAnswers);
   FormLogin.SQLIte3Conn.ExecuteDirect(tablesResults);
   FormLogin.SQLIte3Conn.ExecuteDirect('insert into users(login, password, role) values("admin","qwerty","admin");');
   FormLogin.SQLIte3Conn.ExecuteDirect('CREATE UNIQUE INDEX "users_id_idx" on users(id);');
   FormLogin.SQLTransact.Commit;
   }
end;

end.

