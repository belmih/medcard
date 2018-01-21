unit testform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, DbCtrls, ComCtrls, ExtCtrls, StdCtrls, Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    DBMemo3: TDBMemo;
    dsResultAnswers: TDataSource;
    dsResults: TDataSource;
    DBNavigator1: TDBNavigator;
    gbQuestions: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Panel1: TPanel;
    qResults: TSQLQuery;
    qResultsAnswers: TSQLQuery;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure DBGrid2PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBMemo1Change(Sender: TObject);
    procedure dsResultAnswersDataChange(Sender: TObject; Field: TField);
    procedure dsResultsDataChange(Sender: TObject; Field: TField);
    procedure dsResultsUpdateData(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure qResultsAfterRefresh(DataSet: TDataSet);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
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
  qResultsAnswers.Open;

end;

procedure TForm1.qResultsAfterRefresh(DataSet: TDataSet);
begin
  FormMain.actCommit.Enabled:=False;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  qResults.ApplyUpdates();
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  if gbQuestions.Showing then
    gbQuestions.Hide
  else
    gbQuestions.Show;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  ShowMessage(qResultsAnswers.FieldByName('points').AsString);
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin

end;

procedure TForm1.DBGrid1ColEnter(Sender: TObject);
begin

end;

procedure TForm1.DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TForm1.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
id: Integer;
query : TSQLQuery;
begin
try
query := TSQLQuery.Create(nil);
query.DataBase := FormMain.SQLite3Conn;
query.SQL.Text := 'select id from results_answer where results_id = :rid and points = :p';
query.Prepare;
query.ParamByName('rid').AsInteger := qResults.FieldByName('id').AsInteger;
query.ParamByName('p').AsInteger := qResults.FieldByName('points').AsInteger;
query.Open;

id:= query.FieldByName('id').AsInteger;
ShowMessage(IntToStr(id));
qResultsAnswers.locate('id',id,[]);

finally
 query.close;
 query.Free;
end;
end;



procedure TForm1.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
begin

end;


procedure TForm1.DBGrid2CellClick(Column: TColumn);
var
    id: Integer;
 begin
   id := qResultsAnswers.FieldByName('id').AsInteger;
   qResults.Edit;
   qResults.FieldByName('points').AsInteger:=qResultsAnswers.FieldByName('points').AsInteger;
   qResultsAnswers.locate('id',id,[]);
end;

procedure TForm1.DBGrid2PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
begin

end;



procedure TForm1.DBMemo1Change(Sender: TObject);
begin

end;

procedure TForm1.dsResultAnswersDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TForm1.dsResultsDataChange(Sender: TObject; Field: TField);
begin

end;


procedure TForm1.dsResultsUpdateData(Sender: TObject);
begin
  FormMain.actCommit.Enabled:=True;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
   if (FormMain.actCommit.Enabled) then
   if MessageDlg('Вопрос', 'Закрыть без сохранения?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
   then
   begin
     qResults.CancelUpdates;
     FormMain.actCommit.Enabled:=False;
     CanClose:=True;
   end
   else
     CanClose:=False;
end;

end.

