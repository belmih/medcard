unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, sqlite3conn, db, FileUtil, Forms, Controls,
  Graphics, Dialogs, Menus, ActnList, ComCtrls;

type

  { TFormMain }

  TFormMain = class(TForm)
    ActionList1: TActionList;
    actRefresh: TAction;
    actRowAdd: TAction;
    actRowDelete: TAction;
    actShowUsersForm: TAction;
    actUsersSave: TAction;
    dsActions: TDataSource;
    dsDoctors: TDataSource;
    dsUsers: TDataSource;
    imgList: TImageList;
    imgListDBNavigator: TImageList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    miShowUsersForm: TMenuItem;
    qActions: TSQLQuery;
    qDoctors: TSQLQuery;
    ShowLog: TMenuItem;
    SQLite3Conn: TSQLite3Connection;
    SQLQUsers: TSQLQuery;
    SQLTransaction: TSQLTransaction;
    procedure actShowUsersFormExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBConnect();
  private
    FUserID: Integer;
  public
    property UserID: Integer read FUserID write FUserID;
  end;

var
  FormMain: TFormMain;

implementation
 uses loginform, usersform;
{$R *.lfm}

{ TFormMain }

procedure TFormMain.actShowUsersFormExecute(Sender: TObject);
begin
  FormUsers := TFormUsers.Create(self);
  FormUsers.Show;
end;

procedure TFormMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FormLogin.Close;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  DBConnect();
end;

procedure TFormMain.DBConnect();
var
  CurDir, DataBaseFile: String;

begin
  CurDir := ExtractFilePath(Application.ExeName);
  DataBaseFile := CurDir + '\database.db';
  SQLite3Conn.CharSet := 'UTF8';
  SQLite3Conn.DatabaseName := databasefile;
  SQLite3Conn.Transaction := SQLTransaction;
  try
    ;
    //SQLite3Conn.Open;
  //SQLite3Conn.ExecuteDirect('PRAGMA foreign_keys=ON;');
  {


  SQLite3Conn.Options:=;
  SQLTransaction.DataBase := SQLite3Conn;
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
  }
  except
    ShowMessage('Ошибка подключения к базе!');
  end;

end;

end.

