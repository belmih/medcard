unit testform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, DbCtrls, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    dsQuestTemplate: TDataSource;
    DBGrid1: TDBGrid;
    DBGroupBox1: TDBGroupBox;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
    DBRadioGroup1: TDBRadioGroup;
    qQuestTemplate: TSQLQuery;
    ToolBar1: TToolBar;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    FActionID: Integer;
  public
    property ActionID: Integer read FActionID write FActionID;
  end;

var
  Form1: TForm1;

implementation
   uses mainform ;
{$R *.lfm}

{ TForm1 }

procedure TForm1.FormShow(Sender: TObject);
begin
  qQuestTemplate.DataBase:= FormMain.SQLite3Conn;
  qQuestTemplate.Options:=[sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  qQuestTemplate.Prepare;
  qQuestTemplate.ParamByName('a').AsInteger := ActionID;
  qQuestTemplate.Open;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
var
  id: Integer;
begin
  id:= qQuestTemplate.FieldByName('id').AsInteger;
  ShowMessage(IntToStr(id));
end;

end.

