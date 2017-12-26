unit loginform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, sqldblib, FileUtil, Forms, Controls,
  Graphics, Dialogs, StdCtrls,LCLProc, dbcreate, mform;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnLogin: TButton;
    eLogin: TEdit;
    ePassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SQLite3Conn: TSQLite3Connection;
    SQLTransact: TSQLTransaction;
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure InitDb;
  public

  end;
var
  Form1: TForm1;
  databasefile: String;
  user_id: Integer;
  userFullName: String;
  CurDir: String;




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
  InitDb;
end;

procedure TForm1.InitDb;
var
  newdb: Boolean;
begin
  try
    newdb := not FileExists(databasefile);
    SQLite3Conn.Open;
    SQLTransact.Active := True;
    if newdb then
    begin
      dbcreate.dbcreate;
      SQLTransact.Commit;
      ShowMessage('Была создана новая БД!');
    end;
    SQLite3Conn.ExecuteDirect('PRAGMA foreign_keys = ON;');

  except
    ShowMessage('Ошибка подключения к базе!');
  end;

end;

procedure TForm1.btnLoginClick(Sender: TObject);
var
  showMainForm: Boolean;
  query: TSQLQuery;
begin
  showMainForm := False;
  try
    query := TSQLQuery.Create(nil);
    query.DataBase := SQLite3Conn;
    query.SQL.Text := 'select u.id,'#13#10
                    + '       d.fullname'#13#10
                    + '  from users u left join doctors d'#13#10
                    + '    on u.doctor_id = d.id'#13#10
                    + ' where login = :l'#13#10
                    + '   and passwrd = :p';
    query.Prepare;
    query.ParamByName('l').AsString := eLogin.Text;
    query.ParamByName('p').AsString := ePassword.Text;
    query.Open;
    query.First;
    if not query.EOF then
    begin
      user_id := query.Fields.FieldByName('id').AsInteger;
      userFullName := query.Fields.FieldByName('fullname').AsString;
      showMainForm := True;
    end;
  finally
    query.Close;
    query.Free;
  end;
  if showMainForm then
  begin
    Form1.Hide;
    Form2.Show;
  end;
end;


function Translate(Name,Value : AnsiString; Hash : Longint; arg:pointer) : AnsiString;
begin
 case StringCase(Value,['&Yes','&No','Cancel']) of
  0: Result:='&Да';
  1: Result:='&Нет';
  2: Result:='Отмена';
  else Result:=Value;
 end;
end;

initialization
  SetResourceStrings(@Translate,nil);

end.

