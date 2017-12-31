unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, sqlite3conn, db, FileUtil, Forms, Controls,
  Graphics, Dialogs, Menus, ActnList, ComCtrls, StdCtrls, DbCtrls, DBGrids, Grids;

type

  { TFormMain }

  TFormMain = class(TForm)
    actCommit: TAction;
    actShowDoctorsForm: TAction;
    ActionList1: TActionList;
    actShowUsersForm: TAction;
    btnAdd: TButton;
    dsUsers: TDataSource;
    dsDoctors: TDataSource;
    DBGrid1: TDBGrid;
    dblcDoctor: TDBLookupComboBox;
    dsActions: TDataSource;
    eMedCard: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    imgList: TImageList;
    imgListDBNavigator: TImageList;
    Label1: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    miAboutForm: TMenuItem;
    MenuItem8: TMenuItem;
    miShowUsersForm: TMenuItem;
    qActions: TSQLQuery;
    ShowLog: TMenuItem;
    SQLite3Conn: TSQLite3Connection;
    qUsers: TSQLQuery;
    qDoctors: TSQLQuery;
    SQLTransaction: TSQLTransaction;
    ToolBar1: TToolBar;
    procedure actCommitExecute(Sender: TObject);
    procedure actShowDoctorsFormExecute(Sender: TObject);
    procedure actShowUsersFormExecute(Sender: TObject);
    procedure dsDoctorsUpdateData(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBConnect();
    procedure miAboutFormClick(Sender: TObject);
    procedure qDoctorsAfterRefresh(DataSet: TDataSet);
    procedure QueryOpen();
    procedure qUsersAfterRefresh(DataSet: TDataSet);
  private
    FUserID: Integer;
  public
    property UserID: Integer read FUserID write FUserID;
  end;

const
  version='0.1.0';

var
  FormMain: TFormMain;

implementation
 uses loginform, usersform, doctorsform, aboutform;
{$R *.lfm}

{ TFormMain }

procedure TFormMain.actShowUsersFormExecute(Sender: TObject);
begin
  FormUsers := TFormUsers.Create(self);
  FormUsers.Show;
end;

procedure TFormMain.actShowDoctorsFormExecute(Sender: TObject);
begin
  FormDoctors := TFormDoctors.Create(self);
  FormDoctors.Show;
end;

procedure TFormMain.actCommitExecute(Sender: TObject);
begin
  SQLTransaction.Commit;
  actCommit.Enabled:=False;
end;

procedure TFormMain.dsDoctorsUpdateData(Sender: TObject);
begin
 actCommit.Enabled:=True;
end;

procedure TFormMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FormLogin.Close;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  DBConnect();
  QueryOpen();
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
    SQLite3Conn.Open;
    SQLTransaction.StartTransaction;
    qUsers.DataBase:=SQLite3Conn;
    qDoctors.DataBase:=SQLite3Conn;
  except;
    ShowMessage('Ошибка подключения к базе!');
  end;
end;

procedure TFormMain.miAboutFormClick(Sender: TObject);
begin
  FormAbout := TFormAbout.Create(self);
  FormAbout.Show;
end;

procedure TFormMain.qDoctorsAfterRefresh(DataSet: TDataSet);
begin
  actCommit.Enabled:=False;
end;

Procedure TFormMain.QueryOpen();
begin
  qUsers.Options   := [sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  qDoctors.Options := [sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  qUsers.Open;
  qDoctors.Open;
end;

procedure TFormMain.qUsersAfterRefresh(DataSet: TDataSet);
begin
  actCommit.Enabled:=False;
end;

end.

