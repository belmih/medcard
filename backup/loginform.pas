unit LoginForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, dbcreate, mform;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    eLogin: TEdit;
    ePassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SQLite3Conn: TSQLite3Connection;
    SQLQueryDoctors: TSQLQuery;
    SQLQueryUsers: TSQLQuery;
    SQLTransact: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure InitDb;
  public

  end;
var
  Form1: TForm1;
  databasefile: string;
  CurDir: string;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  CurDir := ExtractFilePath(Application.ExeName);
  databasefile := CurDir + 'database.db';
  SQLite3Conn.CharSet := 'UTF8';
  SQLite3Conn.Transaction := SQLTransact;
  SQLite3Conn.DatabaseName := databasefile;
  SQLTransact.DataBase := SQLite3Conn;
  SQLQueryUsers.DataBase := SQLite3Conn;
  InitDb;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  showMainForm: Boolean;
begin
  showMainForm:=False;
  SQLQueryUsers.Close;
  SQLQueryUsers.SQL.Text := 'select id from users where login = :l and password = :p';
  SQLQueryUsers.ParamByName('l').AsString := eLogin.Text;
  SQLQueryUsers.ParamByName('p').AsString := ePassword.Text;
  SQLTransact.Active := True;
  SQLQueryUsers.Open;
  SQLQueryUsers.First;
  if not SQLQueryUsers.EOF then
  begin
    showMainForm:=True;
  end;
  SQLQueryUsers.Close;
  if showMainForm then
  begin
    Form1.Hide;
    Form2.Show;
  end;
end;

procedure TForm1.InitDb;
var
  newdb: Boolean;
begin
  try
    newdb := not FileExists(databasefile);
    SQLite3Conn.Open;
    if newdb then
    begin
      SQLTransact.Active := True;
      dbcreate.dbcreate;
      SQLTransact.Commit;
      ShowMessage('Была создана новая БД!');
    end;
    SQLite3Conn.ExecuteDirect('PRAGMA foreign_keys = ON;');
  except
    ShowMessage('Ошибка подключения к базе!');
  end;

end;

end.

