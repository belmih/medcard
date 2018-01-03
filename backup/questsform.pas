unit questsform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, DBGrids, DbCtrls, Menus;

type

  { TFormQuests }

  TFormQuests = class(TForm)
    dsAnswersQ: TDataSource;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    memoAnswer: TMemo;
    miQuestionDelete: TMenuItem;
    miQuestionAdd: TMenuItem;
    pmQuestions: TPopupMenu;
    qAnswersQ: TSQLQuery;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    TreeView1: TTreeView;
    procedure FormShow(Sender: TObject);
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

procedure TFormQuests.TreeView1Click(Sender: TObject);
begin
  //ShowMessage(TQuestion(TreeView1.Selected.Data).txt);
  //FormMain.qQuestions.GotoBookmark(pointer(TQuestion(TreeView1.Selected.Data).id));
end;

procedure TFormQuests.TreeView1SelectionChanged(Sender: TObject);
begin
  if TreeView1.Selected <> nil then
  begin
    memoAnswer.Lines.Clear;
    memoAnswer.Lines.AddText(TQuestion(TreeView1.Selected.Data).txt);
  end;

  //ShowMessage(IntToStr(TQuestion(TreeView1.Selected.Data).id));
end;

end.

