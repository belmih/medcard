unit testform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, DbCtrls, ComCtrls, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    DBMemo3: TDBMemo;
    DBNavigator2: TDBNavigator;
    dsResultAnswers: TDataSource;
    dsResults: TDataSource;
    DBGroupBox1: TDBGroupBox;
    DBNavigator1: TDBNavigator;
    gbQuestions: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    qResults: TSQLQuery;
    qResultsAnswers: TSQLQuery;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure DBMemo1Change(Sender: TObject);
    procedure dsResultsDataChange(Sender: TObject; Field: TField);
    procedure dsResultsUpdateData(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qResultsAfterRefresh(DataSet: TDataSet);
    procedure ToolButton2Click(Sender: TObject);
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
  qResults.DataBase:= FormMain.SQLite3Conn;
  qResults.Options:=[sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  qResults.Prepare;
  qResults.ParamByName('a').AsInteger := ActionID;
  qResults.Open;

  qResultsAnswers.DataBase:= FormMain.SQLite3Conn;
  qResultsAnswers.Options:=[sqoCancelUpdatesOnRefresh, sqoRefreshUsingSelect, sqoKeepOpenOnCommit];
  qResultsAnswers.OPen;

end;

procedure TForm1.qResultsAfterRefresh(DataSet: TDataSet);
begin
  FormMain.actCommit.Enabled:=False;
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  if gbQuestions.Showing then
    gbQuestions.Hide
  else
    gbQuestions.Show;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
end;

procedure TForm1.DBGrid1ColEnter(Sender: TObject);
begin

end;

procedure TForm1.DBMemo1Change(Sender: TObject);
begin

end;

procedure TForm1.dsResultsDataChange(Sender: TObject; Field: TField);
var
id: Integer;
begin
 id:= qResults.FieldByName('question_id').AsInteger;
 //ShowMessage(IntToStr(id));
end;

procedure TForm1.dsResultsUpdateData(Sender: TObject);
begin
  FormMain.actCommit.Enabled:=True;
end;

end.

