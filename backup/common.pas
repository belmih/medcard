unit common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DBGrids, sqldb, db, Forms,
  ComCtrls, DbCtrls, StdCtrls, matrix,
  Grids;

Type
  TCommon = class
    private
    public
      procedure DBGridOnGetText(Sender: TField; var aText: string; DisplayText: Boolean);
      procedure DBGridFix(DBGrid: TDBGrid);
    end;

implementation

procedure TCommon.DBGridOnGetText(Sender: TField; var aText: string; DisplayText: Boolean);
begin
  if (DisplayText) then
    aText := Sender.AsString;
end;

procedure TCommon.DBGridFix(DBGrid: TDBGrid);
var
  ds: TDataSet;
  i: Integer;
begin
  ds := DBGrid.DataSource.DataSet;
  for i := 0 to Pred( ds.FieldCount) do
    if ds.Fields[i].DataType in [ftMemo,ftWideMemo] then
      ds.Fields[i].OnGetText := @DBGridOnGetText;
  DBGrid.AutoAdjustColumns;
end;

end.

