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
    actActionAdd: TAction;
    actActionDelete: TAction;
    actBlock: TAction;
    actStartTest: TAction;
    actUnblock: TAction;
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
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem9: TMenuItem;
    miAboutForm: TMenuItem;
    MenuItem8: TMenuItem;
    miShowUsersForm: TMenuItem;
    pmActions: TPopupMenu;
    qActions: TSQLQuery;
    ShowLog: TMenuItem;
    SQLite3Conn: TSQLite3Connection;
    qUsers: TSQLQuery;
    qDoctors: TSQLQuery;
    qQuestions: TSQLQuery;
    SQLTransaction: TSQLTransaction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure actActionAddExecute(Sender: TObject);
    procedure actActionDeleteExecute(Sender: TObject);
    procedure actBlockExecute(Sender: TObject);
    procedure actCommitExecute(Sender: TObject);
    procedure actQuestionAddExecute(Sender: TObject);
    procedure actQuestionDeleteExecute(Sender: TObject);
    procedure actShowDoctorsFormExecute(Sender: TObject);
    procedure actShowQuestionsFormExecute(Sender: TObject);
    procedure actShowUsersFormExecute(Sender: TObject);
    procedure actStartTestExecute(Sender: TObject);
    procedure actUnblockExecute(Sender: TObject);
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
    procedure GetTreeQuestions(nodes:TTreeNodes; rootnode:TTreeNode=nil; id:Integer = 0; lvl:String = '');
    procedure SetQuestTemplate(l,q:String;qid:Integer);
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
 uses loginform, usersform, doctorsform, aboutform, questsform, addquestionform, testform;
{$R *.lfm}

{ TFormMain }

procedure TFormMain.actShowUsersFormExecute(Sender: TObject);
begin
  FormUsers := TFormUsers.Create(self);
  FormUsers.Show;
end;

procedure TFormMain.actStartTestExecute(Sender: TObject);
var
  id: Integer;
begin
  id := qActions.FieldByName('id').AsInteger;
  if (id > 0) then
  begin
    Form1 := TForm1.Create(self);
    Form1.ActionID:=id;
    Form1.Show;
  end;
end;

procedure TFormMain.actUnblockExecute(Sender: TObject);
var
   Query: TSQLQuery;
   id: Integer;
 begin
   try
     id := qActions.FieldByName('id').AsInteger;
     Query := TSQLQuery.Create(nil);
     Query.DataBase := SQLite3Conn;
     Query.SQL.Text := 'update actions set enddate = null where id = :id and enddate is not null';
     Query.Prepare;
     Query.ParamByName('id').AsInteger := id;
     Query.ExecSQL;
     SQLTransaction.Commit;
     qActions.Refresh;
     qActions.Locate('id',id,[]);
   finally
     Query.Close;
     Query.Free;
   end;
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

procedure TFormMain.actActionAddExecute(Sender: TObject);
var
  query: TSQLQuery;
  key: Integer;
  id: Integer;
begin
 key := dblcDoctor.KeyValue;
 try
   query := TSQLQuery.Create(nil);
   query.DataBase := SQLite3Conn;
   query.SQL.Text := 'insert into actions(user_id, doc_id, medcardnum) values(:u,:d,:m)';
   query.Prepare;
   query.ParamByName('u').AsInteger := UserID;
   query.ParamByName('d').AsInteger := key;
   query.ParamByName('m').AsString  := eMedCard.Text;
   query.ExecSQL;
   SQLTransaction.Commit;
   id := SQLite3Conn.GetInsertID;
   {ShowMessage(IntToStr(id));
   query.SQL.Text := ''
     + 'insert into results (action_id,lvl,questiontext,points,question_id)'#13#10
     + 'select a.id, lvl, questiontext, null,q.question_id'#13#10
     + '  from actions a, quest_template q where a.id = :id'#13#10
     + ' order by q.id';
   query.Prepare;
   query.ParamByName('id').AsInteger := id;
   query.ExecSQL;
   SQLTransaction.Commit;}
   Form1 := TForm1.Create(self);
   Form1.ActionID:=id;
   Form1.Show;
 finally
   query.Close;
   query.Free;
 end;
 dblcDoctor.KeyValue := key;
 qActions.Refresh;
end;

procedure TFormMain.actActionDeleteExecute(Sender: TObject);
var
  Query: TSQLQuery;
begin
 if MessageDlg('Вопрос', 'Удалить запись?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
  then
  begin
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := SQLite3Conn;
      Query.SQL.Text := 'delete from actions where id = :id';
      Query.Prepare;
      Query.ParamByName('id').AsInteger := qActions.FieldByName('id').AsInteger;
      Query.ExecSQL;
      SQLTransaction.Commit;
      qActions.Refresh;
    finally
      Query.Close;
      Query.Free;
    end;
  end;
end;

procedure TFormMain.actBlockExecute(Sender: TObject);
 var
   Query: TSQLQuery;
   id: Integer;
 begin
   try
     id := qActions.FieldByName('id').AsInteger;
     Query := TSQLQuery.Create(nil);
     Query.DataBase := SQLite3Conn;
     Query.SQL.Text := 'update actions set enddate = datetime("now") where id = :id and enddate is null';
     Query.Prepare;
     Query.ParamByName('id').AsInteger := id;
     Query.ExecSQL;
     SQLTransaction.Commit;
     qActions.Refresh;
     qActions.Locate('id',id,[]);
   finally
     Query.Close;
     Query.Free;
   end;
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
    try
    Query := TSQLQuery.Create(nil);
    Query.DataBase := SQLite3Conn;
    Query.SQL.Text := 'delete from questions where id = :id';
    Query.Prepare;
    Query.ParamByName('id').AsInteger := TQuestion(FormQuests.TreeView1.Selected.Data).id;
    Query.ExecSQL;
    qQuestions.Refresh;
    FormQuests.TreeView1.Items.Clear;
    FormMain.GetTreeQuestions(FormQuests.TreeView1.Items);
    except
      ;
    end;
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
  SQLTransaction.Active:=False;
  SQLite3Conn.Close();
  FormLogin.Close;
  CloseAction := caFree;
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
    SQLite3Conn.Close();
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
  qActions.DataBase:=SQLite3Conn;
  qUsers.Options     := [sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  qDoctors.Options   := [sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  qQuestions.Options := [sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  qActions.Options   := [sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  try
    qUsers.Open;
    qDoctors.Open;
    qQuestions.Open;
    qActions.Open;
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

procedure TFormMain.SetQuestTemplate(l,q:String;qid:Integer);
var
   Query: TSQLQuery;
begin
  Query:= TSQLQuery.Create(nil);
  try
    Query.DataBase := SQLite3Conn;
    Query.SQL.Text:='insert into quest_template(lvl,questiontext,question_id)'#13#10
                   + 'values(:l,:q,:qid)';
    Query.Prepare;
    Query.ParamByName('l').AsString := l;
    Query.ParamByName('q').AsString := q;
    Query.ParamByName('qid').AsInteger := qid;
    Query.ExecSQL;

  finally
    Query.Close;
    Query.Free;
  end;

end;

procedure TFormMain.GetTreeQuestions(nodes:TTreeNodes; rootnode:TTreeNode=nil; id:Integer = 0; lvl:String = '');
var
  node: TTreeNode;
  Query: TSQLQuery;
  txt: String;
  lvltmp:String;
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
       if UTF8Length(Query.FieldByName('questiontext').AsString)>60 then
       txt:= txt+' [...]';

       if id=0 then
       begin
        lvltmp := Query.FieldByName('questionorder').AsString + '.';
        txt :=  lvltmp + ' ' + txt;
        node := nodes.Add(nil, txt)
       end else
        begin
          lvltmp := lvl + Query.FieldByName('questionorder').AsString + '.';
          txt :=  lvltmp + ' ' + txt;
          node := nodes.AddChild(rootnode, txt);
        end;

      node.Data:=TQuestion.Create;
      TQuestion(node.Data).id := Query.FieldByName('id').AsInteger;
      TQuestion(node.Data).questionorder := Query.FieldByName('questionorder').AsInteger;
      TQuestion(node.Data).txt := Query.FieldByName('questiontext').AsString;
      TQuestion(node.Data).parentid := Query.FieldByName('parentid').AsInteger;
      SetQuestTemplate(lvltmp,Query.FieldByName('questiontext').AsString,Query.FieldByName('id').AsInteger);
      GetTreeQuestions(nodes,node,Query.FieldByName('id').AsInteger,lvltmp);
      Query.Next;
    end;
  finally
    Query.Close;
    Query.Free;
  end;
end;



end.

