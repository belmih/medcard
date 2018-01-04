unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, sqlite3conn, db, FileUtil, Forms, Controls,
  Graphics, Dialogs, Menus, ActnList, ComCtrls, StdCtrls, DbCtrls, DBGrids, Grids,
  LazUtf8 ;
type

  { TFormMain }

  TFormMain = class(TForm)
    actCommit: TAction;
    actQuestionDelete: TAction;
    actQuestionAdd: TAction;
    actShowQuestionsForm: TAction;
    actShowDoctorsForm: TAction;
    ActionList1: TActionList;
    actShowUsersForm: TAction;
    btnAdd: TButton;
    dsQuestions: TDataSource;
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
    qQuestions: TSQLQuery;
    SQLTransaction: TSQLTransaction;
    ToolBar1: TToolBar;
    procedure actCommitExecute(Sender: TObject);
    procedure actQuestionAddExecute(Sender: TObject);
    procedure actQuestionDeleteExecute(Sender: TObject);
    procedure actShowDoctorsFormExecute(Sender: TObject);
    procedure actShowQuestionsFormExecute(Sender: TObject);
    procedure actShowUsersFormExecute(Sender: TObject);
    procedure dsDoctorsDataChange(Sender: TObject; Field: TField);
    procedure dsDoctorsStateChange(Sender: TObject);
    procedure dsDoctorsUpdateData(Sender: TObject);
    procedure dsQuestionsUpdateData(Sender: TObject);
    procedure dsUsersUpdateData(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBConnect();
    procedure FormShow(Sender: TObject);
    procedure miAboutFormClick(Sender: TObject);
    procedure qDoctorsAfterDelete(DataSet: TDataSet);
    procedure qDoctorsAfterRefresh(DataSet: TDataSet);
    procedure qQuestionsAfterDelete(DataSet: TDataSet);
    procedure qQuestionsAfterRefresh(DataSet: TDataSet);
    procedure QueryOpen();
    procedure qUsersAfterDelete(DataSet: TDataSet);
    procedure qUsersAfterRefresh(DataSet: TDataSet);
    procedure GetTreeQuestions(nodes:TTreeNodes; rootnode:TTreeNode=nil; id:Integer = 0);
  private
    FUserID: Integer;
    FTreeQuestions: TTreeNode;
  public
    property UserID: Integer read FUserID write FUserID;
  end;

const
  version='0.1.0';

var
  FormMain: TFormMain;
  type
    TQuestion = Class(TObject)
    public
      id:integer;
      questionorder: Integer;
      txt:string;
      parentid:Integer;
    end;

implementation
 uses loginform, usersform, doctorsform, aboutform, questsform, addquestionform;
{$R *.lfm}

{ TFormMain }

procedure TFormMain.actShowUsersFormExecute(Sender: TObject);
begin
  FormUsers := TFormUsers.Create(self);
  FormUsers.Show;
end;

procedure TFormMain.dsDoctorsDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TFormMain.dsDoctorsStateChange(Sender: TObject);
begin
   //actCommit.Enabled:=True;
end;

procedure TFormMain.actShowDoctorsFormExecute(Sender: TObject);
begin
  FormDoctors := TFormDoctors.Create(self);
  FormDoctors.Show;
end;

procedure TFormMain.actShowQuestionsFormExecute(Sender: TObject);
begin
  FormQuests := TFormQuests.Create(self);
  FormQuests.Show;
end;

procedure TFormMain.actCommitExecute(Sender: TObject);
begin

  SQLTransaction.Commit;
  actCommit.Enabled:=False;
end;

procedure TFormMain.actQuestionAddExecute(Sender: TObject);
begin
  FormAddQuest := TFormAddQuest.Create(self);
  FormAddQuest.Show;
end;

procedure TFormMain.actQuestionDeleteExecute(Sender: TObject);
var
  Query: TSQLQuery;
begin
  try
    Query := TSQLQuery.Create(nil);
    Query.DataBase := SQLite3Conn;
    Query.SQL.Text := 'delete from questions where id = :id';
    Query.Prepare;
    Query.ParamByName('id').AsInteger := TQuestion(FormQuests.TreeView1.Selected.Data).id;
    Query.ExecSQL;
    SQLTransaction.Commit;
    qQuestions.Refresh;
    FormQuests.TreeView1.Items.Clear;
    FormMain.GetTreeQuestions(FormQuests.TreeView1.Items);
  finally
    Query.Close;
    Query.Free;
  end;
end;

procedure TFormMain.dsDoctorsUpdateData(Sender: TObject);
begin
 actCommit.Enabled:=True;
end;

procedure TFormMain.dsQuestionsUpdateData(Sender: TObject);
begin
  actCommit.Enabled:=True;
end;

procedure TFormMain.dsUsersUpdateData(Sender: TObject);
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
  except;
    ShowMessage('Ошибка подключения к базе!');
  end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin

end;

procedure TFormMain.miAboutFormClick(Sender: TObject);
begin
  FormAbout := TFormAbout.Create(self);
  FormAbout.Show;
end;

procedure TFormMain.qDoctorsAfterDelete(DataSet: TDataSet);
begin
  actCommit.Enabled:=True;
end;

procedure TFormMain.qDoctorsAfterRefresh(DataSet: TDataSet);
begin
  actCommit.Enabled:=False;
end;

procedure TFormMain.qQuestionsAfterDelete(DataSet: TDataSet);
begin
  actCommit.Enabled:=True;
end;

procedure TFormMain.qQuestionsAfterRefresh(DataSet: TDataSet);
begin
  actCommit.Enabled:=False;
end;

Procedure TFormMain.QueryOpen();
begin
  qUsers.DataBase:=SQLite3Conn;
  qDoctors.DataBase:=SQLite3Conn;
  qQuestions.DataBase:=SQLite3Conn;
  qUsers.Options     := [sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  qDoctors.Options   := [sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  qQuestions.Options := [sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  try
    qUsers.Open;
    qDoctors.Open;
    qQuestions.Open;
  except
    ShowMessage('Ошибка при запуске запроса! Программа будет закрыта!');
    Application.Terminate;
  end;

end;

procedure TFormMain.qUsersAfterDelete(DataSet: TDataSet);
begin
  actCommit.Enabled:=True;
end;

procedure TFormMain.qUsersAfterRefresh(DataSet: TDataSet);
begin
  actCommit.Enabled:=False;
end;

procedure TFormMain.GetTreeQuestions(nodes:TTreeNodes; rootnode:TTreeNode=nil; id:Integer = 0);
var
  node: TTreeNode;
  nodes1: TTreeNodes;
  Query: TSQLQuery;
  txt: String;
begin

  try
    Query := TSQLQuery.Create(nil);
    Query.DataBase := SQLite3Conn;
    Query.SQL.Text:='select id, questiontext, substr(questiontext,1,60) txt,'#13#10
                   +' parentid, questionorder from questions'#13#10
                   +' where ifnull(parentid,0) = :p order by parentid, questionorder';
    Query.Prepare;
    Query.ParamByName('p').AsInteger := id;
    Query.Open;
    Query.First;
    while not Query.EOF do
    begin
       txt := Query.FieldByName('txt').AsString;
       if UTF8Length(Query.Fields.FieldByName('questiontext').AsString)>60 then
       txt:=txt+' [...]';
       if id=0 then
        node := nodes.Add(nil, txt)
      else
        begin
          txt :=  Query.Fields.FieldByName('questionorder').AsString + '. ' + txt;
          node := nodes.AddChild(rootnode, txt);
        end;

      node.Data:=TQuestion.Create;
      TQuestion(node.Data).id := Query.FieldByName('id').AsInteger;
      TQuestion(node.Data).questionorder := Query.FieldByName('questionorder').AsInteger;
      TQuestion(node.Data).txt := Query.FieldByName('questiontext').AsString;
      TQuestion(node.Data).parentid := Query.FieldByName('parentid').AsInteger;

      GetTreeQuestions(nodes,node,Query.Fields.FieldByName('id').AsInteger);
      Query.Next;
    end;
  finally
    Query.Close;
    Query.Free;
  end;
end;


end.

