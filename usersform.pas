unit usersform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, Grids, StdCtrls, DbCtrls, ExtCtrls, ComCtrls;

type

  { TFormUsers }

  TFormUsers = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBNavigator1: TDBNavigator;
    dsUsers: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    SQLQUsers: TSQLQuery;
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

  uses loginform;

{$R *.lfm}


 { TFormUsers }

 procedure TFormUsers.FormCreate(Sender: TObject);
 begin
   SQLQUsers.Options := [sqoAutoApplyUpdates,
                         sqoCancelUpdatesOnRefresh,
                         sqoRefreshUsingSelect,
                         sqoKeepOpenOnCommit];
   SQLQUsers.UpdateMode:= upWhereKeyOnly;
   SQLQUsers.Close;
   SQLQUsers.Open;


 end;

procedure TFormUsers.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction := caFree;
end;

procedure TFormUsers.ToolButton1Click(Sender: TObject);
begin
  SQLQUsers.ApplyUpdates;
  FormLogin.SQLTransact.Commit;
end;

end.

