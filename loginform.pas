unit loginform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, FileUtil, Forms, Controls,
  Graphics, Dialogs, StdCtrls,LCLProc, ExtCtrls;

type

  { TFormLogin }

  TFormLogin = class(TForm)
    btnLogin: TButton;
    eLogin: TEdit;
    ePassword: TEdit;
    ilDBNavigator: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnLoginClick(Sender: TObject);

  private

  public

  end;
var
  FormLogin: TFormLogin;
  databasefile: String;
  userFullName: String;
  CurDir: String;




implementation
  uses mainform;
{$R *.lfm}

{ TFormLogin }

procedure TFormLogin.btnLoginClick(Sender: TObject);
var
  ShowMainForm: Boolean;
  Query: TSQLQuery;
begin
  ShowMainForm := False;
  try
    Query := TSQLQuery.Create(nil);
    Query.DataBase := FormMain.SQLite3Conn;
    Query.SQL.Text := 'select u.id,'#13#10
                    + '       d.fullname'#13#10
                    + '  from users u left join doctors d'#13#10
                    + '    on u.doctor_id = d.id'#13#10
                    + ' where login = :l'#13#10
                    + '   and passwrd = :p';
    Query.Prepare;
    Query.ParamByName('l').AsString := eLogin.Text;
    Query.ParamByName('p').AsString := ePassword.Text;
    Query.Open;
    Query.First;
    if not Query.EOF then
    begin
      FormMain.UserID := Query.Fields.FieldByName('id').AsInteger;
      //userFullName := query.Fields.FieldByName('fullname').AsString;
      ShowMainForm := True;
    end;
  finally
    Query.Close;
    Query.Free;
  end;
  if ShowMainForm then
  begin
    FormLogin.Hide;
    FormMain.Show;
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

