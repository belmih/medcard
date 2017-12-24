unit usersform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, Grids, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    eLogin: TEdit;
    ePassword: TEdit;
    Edit3: TEdit;
    SQLQuery1: TSQLQuery;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure DBGridOnGetText(Sender: TField; var aText: string; DisplayText: Boolean);
  private

  public

  end;


var
  Form3: TForm3;

implementation
 uses LoginForm;
{$R *.lfm}



 procedure TForm3.DBGridOnGetText(Sender: TField; var aText: string; DisplayText: Boolean);
begin
  if (DisplayText) then
    aText := Sender.AsString;
end;
 { TForm3 }

 procedure TForm3.FormCreate(Sender: TObject);
 begin
   SQLQuery1.Close;
   SQLQuery1.Open;
 end;

procedure TForm3.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
var
  MyTextStyle: TTextStyle;
  i: integer;
begin
  for i := 0 to Pred(SQLQuery1.FieldCount) do
    if SQLQuery1.Fields[i].DataType in [ftMemo,ftWideMemo] then
      SQLQuery1.Fields[i].OnGetText := @DBGridOnGetText;
  {
  // Here you choose what column will be affected (the columns of the DBGrid not SQL).
  if (DataCol = 1) then
  begin
    // The next is not neccesary but you can use it to adjust your text appearance.
    // you can change colors, font, size, as well other parameters.
    MyTextStyle := TDBGrid(Sender).Canvas.TextStyle;
    MyTextStyle.SingleLine := False;
    MyTextStyle.Wordbreak  := False;
    TDBGrid(Sender).Canvas.TextStyle := MyTextStyle;

    // Here how to show any text:
    // just assign an event procedure to OnGetText of the Field.
    Column.Field.OnGetText := @Form3.DBGridOnGetText;
    //SQLQuery1.FieldCount;

    for i := 0 to Pred(SQLQuery1.FieldCount) do
    if SQLQuery1.Fields[i].DataType in [ftMemo,ftWideMemo] then
      SQLQuery1.Fields[i].OnGetText := @DBGridOnGetText;



  end; }
end;

procedure TForm3.DBGrid1CellClick(Column: TColumn);
begin
  eLogin.Text:= DBGrid1.columns[0].title.caption;
  ePassword.Text:=DbGrid1.columns[0].field.asString;
  //[DBGrid1.columns[0].title.caption,DbGrid1.columns[0].field.asString
 // DBGrid1.SelectedRows[i]
 // DBGrid1.SelectedIndex; //column
 // DBGrid1.DataSource.DataSet.RecNo; //row



end;

end.

