unit questsform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, DBGrids, DbCtrls;

type

  { TFormQuests }

  TFormQuests = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    TreeView1: TTreeView;
    procedure FormShow(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);

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
end;

procedure TFormQuests.TreeView1Click(Sender: TObject);
begin
  //ShowMessage(TQuestion(TreeView1.Selected.Data).txt);
  //FormMain.qQuestions.GotoBookmark(pointer(TQuestion(TreeView1.Selected.Data).id));
end;

end.

