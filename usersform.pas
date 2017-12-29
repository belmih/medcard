unit usersform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, Grids, StdCtrls, DbCtrls, ExtCtrls, ComCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);

  private

  public

  end;


var
  Form3: TForm3;

implementation

  uses loginform;

{$R *.lfm}


 { TForm3 }

 procedure TForm3.FormCreate(Sender: TObject);
 begin
   SQLQUsers.Options := [sqoAutoApplyUpdates,
                         sqoCancelUpdatesOnRefresh,
                         sqoRefreshUsingSelect,
                         sqoKeepOpenOnCommit];
   SQLQUsers.UpdateMode:= upWhereKeyOnly;
   SQLQUsers.Close;
   SQLQUsers.Open;


 end;

procedure TForm3.ToolButton1Click(Sender: TObject);
begin
  SQLQUsers.ApplyUpdates;
  Form1.SQLTransact.Commit;
end;







end.

