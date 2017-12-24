unit LoginForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, dbcreate;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
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
  SQLite3Connection1.CharSet := 'UTF8';
  SQLite3Connection1.Transaction := SQLTransaction1;
  SQLite3Connection1.DatabaseName := databasefile;
  SQLTransaction1.DataBase := SQLite3Connection1;
  SQLQuery1.DataBase := SQLite3Connection1;
  InitDb;
end;

procedure TForm1.InitDb;
var
  newdb: Boolean;
begin
  try
    newdb := not FileExists(databasefile);
    SQLIte3Connection1.Open;
    if newdb then
    begin
      SQLTransaction1.Active := True;
      dbcreate.dbcreate(SQLite3Connection1);
      SQLTransaction1.Commit;
      ShowMessage('Была создана новая БД!');
    end;
  except
    ShowMessage('Ошибка подключения к базе!');
  end;
  SQLIte3Connection1.ExecuteDirect('PRAGMA foreign_keys = ON;');
end;

end.

