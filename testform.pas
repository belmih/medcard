unit testform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, DbCtrls, ComCtrls, ExtCtrls, StdCtrls, Grids,
  LCLType;
type

  { TForm1 }

  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGroupBox1: TDBGroupBox;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    DBMemo3: TDBMemo;
    DBNavigator2: TDBNavigator;
    DBText1: TDBText;
    dsResultAnswers: TDataSource;
    dsResults: TDataSource;
    DBNavigator1: TDBNavigator;
    gbQuestions: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Panel1: TPanel;
    pbar1: TProgressBar;
    qResults: TSQLQuery;
    qResultsAnswers: TSQLQuery;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure dsResultAnswersDataChange(Sender: TObject; Field: TField);
    procedure dsResultAnswersUpdateData(Sender: TObject);



    procedure dsResultsStateChange(Sender: TObject);
    procedure dsResultsUpdateData(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure qResultsAfterPost(DataSet: TDataSet);
    procedure qResultsAfterRefresh(DataSet: TDataSet);

    procedure qResultsAnswersAfterPost(DataSet: TDataSet);
    procedure qResultsAnswersAfterRefresh(DataSet: TDataSet);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure progressbarfill;
    procedure ToolButton4Click(Sender: TObject);
  private

    FActionID: Integer;
  public
    property ActionID: Integer read FActionID write FActionID;
  end;

var
  Form1: TForm1;
  AfterShow: Boolean = False;

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

  progressbarfill ;
  AfterShow := True;
end;

procedure TForm1.qResultsAfterPost(DataSet: TDataSet);
begin

end;

procedure TForm1.qResultsAfterRefresh(DataSet: TDataSet);
begin

end;



procedure TForm1.qResultsAnswersAfterPost(DataSet: TDataSet);
var id: Integer;

begin


   qResultsAnswers.ApplyUpdates;
   id := qResults.FieldByName('id').AsInteger;
   qResults.Refresh;
   qResults.Locate('id',id,[]);


end;

procedure TForm1.qResultsAnswersAfterRefresh(DataSet: TDataSet);
begin

end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin

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
{var
id: Integer;
query : TSQLQuery;
begin
if  AfterShow then
try
query := TSQLQuery.Create(nil);
query.DataBase := FormMain.SQLite3Conn;
query.SQL.Text := 'select id from results_answer where results_id = :rid and points = :p';
query.Prepare;
query.ParamByName('rid').AsInteger := qResults.FieldByName('id').AsInteger;
query.ParamByName('p').AsInteger := qResults.FieldByName('points').AsInteger;
query.Open;

id:= query.FieldByName('id').AsInteger;
if id>0 then
  qResultsAnswers.locate('id',id,[]);

finally
 query.close;
 query.Free;
 end;
}
end;

procedure TForm1.DBGrid1ColEnter(Sender: TObject);
begin

end;



procedure TForm1.dsResultAnswersDataChange(Sender: TObject; Field: TField);
begin
  progressbarfill;
end;

procedure TForm1.dsResultAnswersUpdateData(Sender: TObject);
begin
  FormMain.actCommit.Enabled:=True;
end;














procedure TForm1.dsResultsStateChange(Sender: TObject);
begin

end;

procedure TForm1.progressbarfill;
var
  q: TSQLQuery;
begin
   q:=TSQLQuery.Create(nil);
 try
  q.DataBase := FormMain.SQLite3Conn;
  q.SQL.Text := 'select  count(distinct r.id) cnt from results r inner join results_answer ra on r.id =ra.results_id where action_id = :id';
  q.Prepare;
  q.ParamByName('id').AsInteger := FActionID;
  q.Open;
  pbar1.Max := q.FieldByName('cnt').AsInteger;
  q.Close;
  q.SQL.Text := 'select count(distinct r.id) cnt from results r inner join results_answer ra on r.id =ra.results_id where action_id = :id and r.points is not null';
  q.Prepare;
  q.ParamByName('id').AsInteger := FActionID;
  q.Open;
  pbar1.Position := q.FieldByName('cnt').AsInteger;
  StatusBar1.Panels[0].Text:='Отмечено вопросов ' + IntToStr(pbar1.Position) + ' из ' + IntToStr(pbar1.Max);
   finally
   q.Close;
   q.Free;
   end;
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  if pbar1.Showing then
    pbar1.Hide
  else
    pbar1.Show;
end;

procedure TForm1.dsResultsUpdateData(Sender: TObject);
begin
  FormMain.actCommit.Enabled:=True;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FormMain.qActions.Refresh;
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

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = VK_F2 then DBNavigator1.BtnClick(TNavigateBtn.nbNext);
  if Key = VK_F1 then DBNavigator1.BtnClick(TNavigateBtn.nbPrior);
  end;

end.

