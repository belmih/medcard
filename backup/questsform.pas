unit questsform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, DBGrids, DbCtrls;

type

  { TFormQuests }

  TFormQuests = class(TForm)
    DBGrid2: TDBGrid;
    DBMemo1: TDBMemo;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    TreeView1: TTreeView;
    procedure FormShow(Sender: TObject);

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
  TreeView1.Items:= FormMain.GetTreeQuestions(Sender);
end;

end.

