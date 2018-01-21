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
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    dblcDoctor: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    memoReport: TMemo;
    Panel1: TPanel;
    RadioGroup1: TRadioGroup;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    procedure Button1Click(Sender: TObject);
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
  Query: TSQLQuery;
  id: Integer;
 begin
   try
     memoReport.Lines.Clear;
     memoReport.Lines.Add('1');
     //id := qActions.FieldByName('id').AsInteger;
     Query := TSQLQuery.Create(nil);
     Query.DataBase := FormMain.SQLite3Conn;
     Query.SQL.Text := 'select * from ';
     Query.Prepare;
     Query.ParamByName('id').AsInteger := id;
     Query.ExecSQL;
   finally
     Query.Close;
     Query.Free;
   end;

end;

end.

