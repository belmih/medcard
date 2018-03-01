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
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private

  public

  end;
var
  FormLogin: TFormLogin;
  databasefile: String;
  userFullName: String;
  CurDir: String;




implementation
  uses mainform, fileinfo;
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
      ShowMainForm := True;
    end
    else
      ShowMessage('Неверный логин или пароль!');
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

procedure TFormLogin.FormShow(Sender: TObject);
var
 FileVerInfo: TFileVersionInfo;
begin
  FileVerInfo:=TFileVersionInfo.Create(nil);
  try
    FileVerInfo.ReadFileInfo;
    Label3.Caption:=FileVerInfo.VersionStrings.Values['FileVersion'];
   { writeln('Company: ',FileVerInfo.VersionStrings.Values['CompanyName']);
    writeln('File description: ',FileVerInfo.VersionStrings.Values['FileDescription']);
    writeln('File version: ',FileVerInfo.VersionStrings.Values['FileVersion']);
    writeln('Internal name: ',FileVerInfo.VersionStrings.Values['InternalName']);
    writeln('Legal copyright: ',FileVerInfo.VersionStrings.Values['LegalCopyright']);
    writeln('Original filename: ',FileVerInfo.VersionStrings.Values['OriginalFilename']);
    writeln('Product name: ',FileVerInfo.VersionStrings.Values['ProductName']);
    writeln('Product version: ',FileVerInfo.VersionStrings.Values['ProductVersion']);  }

  finally
    FileVerInfo.Free;
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

