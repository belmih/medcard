unit form6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, sqldb, sqlite3conn, db, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, DbCtrls, ComCtrls, StdCtrls, ComObj, ActiveX;

type

  { TFormReports }

  TFormReports = class(TForm)
    Button1: TButton;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    memoReport: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    rgReports: TRadioGroup;
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

     case rgReports.ItemIndex of
     0: begin



        QueryStr := '  select lvl,'+LineEnding+
        '       substr(questiontext,1,15) questiontext,'+LineEnding+
        '	   sum(sumpoints) s1,'+LineEnding+
        '	   fullname,'+LineEnding+
        '	   post'+LineEnding+
        '  from actions a left join results_sum r'+LineEnding+
        '    on a.id=r.action_id left join doctors d'+LineEnding+
        '	on a.doc_id = d.id'+LineEnding+
        ' where enddate is not null'+LineEnding+
        '   and datetime(enddate, ''localtime'') between datetime(''' + dt1str + ''') and datetime('''+dt2str+''')'+LineEnding+
        ' group by lvl, questiontext, fullname, post'+LineEnding+
        ' order by fullname,post,lvl';
       end;
    end;
   try
     memoReport.Lines.Clear;
     memoReport.Lines.Add(
     'Пункт' + Chr(9) +
     'Вопрос'  + Chr(9) + Chr(9) +
     'Баллы'  + Chr(9) +
     'ФИО,должность'
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
        q.FieldByName('lvl').AsString
        + Chr(9)+ q.FieldByName('questiontext').AsString
        + Chr(9) + q.FieldByName('s1').AsString
        + Chr(9) + q.FieldByName('fullname').AsString
        + ', ' + q.FieldByName('post').AsString
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

