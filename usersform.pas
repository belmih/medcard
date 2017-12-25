unit usersform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, Grids, StdCtrls, DbCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    dsUsers: TDataSource;
    eLogin: TEdit;
    ePassword: TEdit;
    Edit3: TEdit;
    SQLQUsers: TSQLQuery;
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure SQLQUsersAfterOpen(DataSet: TDataSet);
    procedure SQLQUsersCalcFields(DataSet: TDataSet);

  private

  public

  end;


var
  Form3: TForm3;

implementation
 uses LoginForm;
{$R *.lfm}




 { TForm3 }

 procedure TForm3.FormCreate(Sender: TObject);
 begin
   SQLQUsers.Close;

   SQLQUsers.Open;
 end;

procedure TForm3.SQLQUsersAfterOpen(DataSet: TDataSet);
var i: integer;
begin
 for i := 0 to Pred(SQLQUsers.FieldCount) do
   if SQLQUsers.Fields[i].DataType in [ftMemo,ftWideMemo] then
     SQLQUsers.FieldDefs[i].DataType := ftString;
 DBGrid1.Repaint;
end;

procedure TForm3.SQLQUsersCalcFields(DataSet: TDataSet);
var i: integer;
begin
 for i := 0 to Pred(SQLQUsers.FieldCount) do
   if SQLQUsers.Fields[i].DataType in [ftMemo,ftWideMemo] then
     SQLQUsers.FieldDefs[i].DataType := ftString;
 DBGrid1.Repaint;
end;

procedure TForm3.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
var
  i: integer;
begin
  for i := 0 to Pred(SQLQUsers.FieldCount) do
    if SQLQUsers.Fields[i].DataType in [ftMemo,ftWideMemo] then
      SQLQUsers.FieldDefs[i].DataType := ftString;

//SQLQuery1.Fields[i].OnGetText := @DBGridOnGetText;
end;




end.

