unit questsform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, DBGrids, DbCtrls, Menus, ExtCtrls;

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
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    TreeView1: TTreeView;
    procedure FormShow(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1SelectionChanged(Sender: TObject);

  private

  public

  end;

var
  FormQuests: TFormQuests;

implementation
  uses mainform;
{$R *.lfm}

{ TFormQuests }



procedure TFormQuests.FormShow(Sender: TObject);
begin
  FormMain.GetTreeQuestions(TreeView1.Items);
  qAnswersQ.Options := [sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  try
    qAnswersQ.Open;
  except
    ShowMessage('Ошибка при запуске редактора вопросов и ответов!');
  end;
end;

procedure TFormQuests.ToolButton1Click(Sender: TObject);
begin
  FormMain.qQuestions.ApplyUpdates();
  while FormMain.qQuestions.State = dsEdit do
    Sleep(1000);
  FormMain.qQuestions.Refresh;
  TreeView1.Items.Clear;
  FormMain.GetTreeQuestions(TreeView1.Items);
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

