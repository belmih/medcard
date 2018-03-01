unit questsform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, PrintersDlgs, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ComCtrls, DBGrids, DbCtrls, Menus, ExtCtrls;

type

  { TFormQuests }

  TFormQuests = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    dsAnswersQ: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    miQuestionDelete: TMenuItem;
    miQuestionAdd: TMenuItem;
    Panel1: TPanel;
    pmQuestions: TPopupMenu;
    qAnswersQ: TSQLQuery;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolBar3: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    TreeView1: TTreeView;

    procedure dsAnswersQUpdateData(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qAnswersQAfterDelete(DataSet: TDataSet);
    procedure qAnswersQBeforeInsert(DataSet: TDataSet);
    procedure qAnswersQNewRecord(DataSet: TDataSet);
    procedure tbSaveQuestionsClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1SelectionChanged(Sender: TObject);

  private

  public

  end;

var
  FormQuests: TFormQuests;

implementation
  uses mainform, memoform;
{$R *.lfm}

{ TFormQuests }



procedure TFormQuests.FormShow(Sender: TObject);
begin
  FormMain.GetTreeQuestions(TreeView1.Items);
  qAnswersQ.Options := [sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit, sqoAutoApplyUpdates];
  try
    qAnswersQ.Open;
  except
    ShowMessage('Ошибка при запуске редактора вопросов и ответов!');
  end;
end;

procedure TFormQuests.qAnswersQAfterDelete(DataSet: TDataSet);
begin

end;

procedure TFormQuests.qAnswersQBeforeInsert(DataSet: TDataSet);
begin

end;

procedure TFormQuests.qAnswersQNewRecord(DataSet: TDataSet);
begin
  qAnswersQ.FieldByName('question_id').AsInteger := FormMain.qQuestions.FieldByName('id').AsInteger;
end;


procedure TFormQuests.dsAnswersQUpdateData(Sender: TObject);
begin
  FormMain.actCommit.Enabled:=True;
end;


procedure TFormQuests.tbSaveQuestionsClick(Sender: TObject);
begin
  FormMain.qQuestions.ApplyUpdates;
  FormMain.qQuestions.Refresh;
  TreeView1.Items.Clear;
  FormMain.GetTreeQuestions(TreeView1.Items);
  FormMain.SQLTransaction.Commit;
  FormMain.actCommit.Enabled:=False;
end;

procedure TFormQuests.ToolButton1Click(Sender: TObject);
begin
  TreeView1.Items.Clear;
  FormMain.GetTreeQuestions(TreeView1.Items);
  FormMain.SQLTransaction.Commit;
  FormMain.actCommit.Enabled:=False;
end;

procedure TFormQuests.ToolButton2Click(Sender: TObject);
var
  Query,q2: TSQLQuery;
  buffer : String;
begin
  memoForm1.Memo1.Lines.Clear;
  try
    Query := TSQLQuery.Create(nil);
    q2 := TSQLQuery.Create(nil);
    Query.DataBase := FormMain.SQLite3Conn;
    q2.DataBase := FormMain.SQLite3Conn;
    Query.SQL.Text := 'select lvl, questiontext, question_id'#13#10
                    + '  from quest_template'#13#10
                    + ' order by lvl';
    q2.SQL.Text:='select answertext, points from answers where question_id = :q order by answerorder, id';
    Query.Prepare;
    q2.Prepare;
    Query.Open;
    while not Query.EOF do
    begin
       memoForm1.Memo1.Lines.Add('');
       q2.Close;
       buffer := Query.Fields[0].AsString + ' ' + Query.Fields[1].AsString ;
       memoForm1.Memo1.Lines.Add(buffer);
       memoForm1.Memo1.Lines.Add('--');
       q2.ParamByName('q').AsInteger := Query.Fields[2].AsInteger;
       q2.Open;
       while not q2.EOF do
       begin
         memoForm1.Memo1.Lines.Add(q2.Fields[0].AsString + ' ' + q2.Fields[1].AsString);
         q2.Next;
       end;
       Query.Next;
    end;
  finally
    q2.Close;
    q2.Free;
    Query.Close;
    Query.Free;
  end;
  memoForm1.ShowModal;
end;

procedure TFormQuests.TreeView1Click(Sender: TObject);
begin
  //ShowMessage(TQuestion(TreeView1.Selected.Data).txt);
  //FormMain.qQuestions.GotoBookmark(pointer(TQuestion(TreeView1.Selected.Data).id));
end;

procedure TFormQuests.TreeView1SelectionChanged(Sender: TObject);
begin
  if TreeView1.Selected <> nil then
  begin
    FormMain.qQuestions.locate('id',TQuestion(TreeView1.Selected.Data).id,[]);
  end;

  //ShowMessage(IntToStr(TQuestion(TreeView1.Selected.Data).id));
end;

end.

