unit usersform;

{$mode objfpc}{$H+}

interface

uses
  Classes, sqldb, db, Forms,
  ComCtrls, DbCtrls, StdCtrls, DBGrids,
  Grids;
type

  { TFormUsers }

  TFormUsers = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    GroupBox2: TGroupBox;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private

  public

  end;


var
  FormUsers: TFormUsers;

implementation
  uses mainform;
{$R *.lfm}


 { TFormUsers }

 procedure TFormUsers.FormCreate(Sender: TObject);
 begin

 end;


procedure TFormUsers.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction := caFree;
end;


procedure TFormUsers.ToolButton1Click(Sender: TObject);
begin
  FormMain.qUsers.ApplyUpdates;
  FormMain.SQLTransaction.Commit;
end;

end.

