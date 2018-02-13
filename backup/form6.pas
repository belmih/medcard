unit form6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, sqldb, sqlite3conn, db, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, DbCtrls, ComCtrls, StdCtrls, DBGrids, ComObj, ActiveX;

type

  { TFormReports }

  TFormReports = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    memoReport: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    SQLQuery1: TSQLQuery;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  FormReports: TFormReports;

implementation
   uses mainform;
{$R *.lfm}

{ TFormReports }

procedure TFormReports.Label1Click(Sender: TObject);
begin

end;

procedure TFormReports.Button1Click(Sender: TObject);
var
  q: TSQLQuery;
  id: Integer;
  QueryStr: String;
  dt1str,dt2str : string;
  fio: string;
 begin
   dt1str := FormatDateTime('yyyy-mm-dd HH:MM:SS',dt1.DateTime);
   dt2str := FormatDateTime('yyyy-mm-dd HH:MM:SS',dt2.DateTime);
   QueryStr := '' +LineEnding+
  'select substr(r.lvl,1,4) lvl,'+LineEnding+
  '       fullname,'+LineEnding+
  '	   post,'+LineEnding+
  '	   round(sum(points)*100.0/sum(maxpoints),2) percent,'+LineEnding+
  '	   (select count(1) from actions where doc_id = a.doc_id and enddate is not null ) cnt'+LineEnding+
  '  from actions a left join results r on a.id=r.action_id left join doctors d on a.doc_id=d.id'+LineEnding+
  ' where skipquest = 0 and enddate is not null and maxpoints > 0'+LineEnding+
  '   and datetime(enddate, ''localtime'') between datetime(''' + dt1str + ''') and datetime('''+dt2str+''')'+LineEnding+
  ' group by substr(r.lvl,1,4), fullname, post'+LineEnding+
  ' order by fullname, enddate, lvl';

   try
     memoReport.Lines.Clear;
     memoReport.Lines.Add(
     'Пункт' + Chr(9) +
     'ФИО'  + Chr(9) +
     'Должность'  + Chr(9) +
     'Баллы'  + Chr(9) +
     'Количество карт'  + Chr(9) +
     ''
     );
     q := TSQLQuery.Create(nil);
     q.DataBase := FormMain.SQLite3Conn;
     q.SQL.Text := QueryStr;
     q.Prepare;
     q.Open;
     q.First;
     fio := q.FieldByName('fullname').AsString;
     while not q.EOF do
     begin
        if fio <> q.FieldByName('fullname').AsString then
        begin
        fio := q.FieldByName('fullname').AsString;
        memoReport.Lines.Add('');
        end ;
        memoReport.Lines.Add(
        q.FieldByName('lvl').AsString + Chr(9) +
        q.FieldByName('fullname').AsString +  Chr(9)+
        q.FieldByName('post').AsString + Chr(9) +
        q.FieldByName('percent').AsString  + Chr(9) +
        q.FieldByName('cnt').AsString + Chr(9)
        );
        q.Next;
     end;
   finally
     q.Close;
     q.Free;
   end;

end;

procedure TFormReports.FormShow(Sender: TObject);
begin
  dt1.Date:= now;
  dt1.Time:= StrToTime('00:00:00');

  dt2.Date:= now;
  dt2.Time:= StrToTime('23:59:59');
end;

end.

