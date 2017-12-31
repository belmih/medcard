unit doctorsform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, ComCtrls, DbCtrls, Grids, db;

type

  { TFormDoctors }

  TFormDoctors = class(TForm)
    DBGrid2: TDBGrid;
    DBNavigator1: TDBNavigator;
    GroupBox1: TGroupBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private

  public

  end;

var
  FormDoctors: TFormDoctors;

implementation
  uses mainform, common;
{$R *.lfm}

  { TFormDoctors }



procedure TFormDoctors.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TFormDoctors.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
 if (FormMain.actCommit.Enabled) then
   if MessageDlg('Вопрос', 'Закрыть справочник без сохранения?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
   then
   begin
     FormMain.qDoctors.CancelUpdates;
     FormMain.actCommit.Enabled:=False;
     CanClose:=True;
   end
   else
     CanClose:=False;
end;

procedure TFormDoctors.ToolButton1Click(Sender: TObject);
begin
  FormMain.qDoctors.ApplyUpdates();
end;

procedure TFormDoctors.ToolButton2Click(Sender: TObject);
var
  s,n,p: String;
begin
  DBGrid2.DataSource.Edit;
  s := FormMain.qDoctors.FieldByName('surname').AsString;
  n := FormMain.qDoctors.FieldByName('name').AsString;
  p := FormMain.qDoctors.FieldByName('patronymic').AsString;
  FormMain.qDoctors.FieldByName('fullname').AsString:=s+' '+n+' '+p;
  DBGrid2.DataSource.DataSet.Post;
end;

end.

