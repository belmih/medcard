unit actionsform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb,sqlite3conn, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  ComCtrls, Menus, DbCtrls, StdCtrls, DBGrids, ExtCtrls, ActnList, Buttons,
  Types;

type

  { TFormActions }

  TFormActions = class(TForm)
    btnAdd: TButton;
    DBComboBox1: TDBComboBox;
    DBGrid1: TDBGrid;
    dblcDoctor: TDBLookupComboBox;
    dsActions: TDataSource;
    dsDoctors: TDataSource;
    eMedCard: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    qActions: TSQLQuery;
    qDoctors: TSQLQuery;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    procedure actRowAddExecute(Sender: TObject);
    procedure actRowDeleteExecute(Sender: TObject);
    procedure actShowUsersFormExecute(Sender: TObject);
    procedure actUsersSaveExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure ShowLogClick(Sender: TObject);
    procedure miRowDeleteClick(Sender: TObject);
    procedure miShowUsersFormClick(Sender: TObject);
  private

  public

  end;

var
  FormActions: TFormActions;

implementation

uses loginform, usersform, aboutform, logform;
{$R *.lfm}

{ TFormActions }

procedure TFormActions.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

procedure TFormActions.FormCreate(Sender: TObject);
begin

end;

procedure TFormActions.FormShow(Sender: TObject);
begin
  //StatusBar1.Panels.Items[0].Width := 250;
  //StatusBar1.Panels.Items[0].Text := userFullName + ' (' + Form1.eLogin.Text+')';
end;

procedure TFormActions.Button1Click(Sender: TObject);
begin
  ;



end;

procedure TFormActions.DBGrid1DblClick(Sender: TObject);
var id: Integer;
begin
    id:=DBGrid1.DataSource.DataSet.FieldByName('id').AsInteger;
    //ShowMessage(IntToStr(id));
    //Form5.tmpID:=id;
    //Form5.Show;
end;


procedure TFormActions.actRowDeleteExecute(Sender: TObject);
var id: Integer;
begin
  if MessageDlg('Вопрос', 'Удалить запись?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
  then
  begin
    id:=DBGrid1.DataSource.DataSet.FieldByName('id').AsInteger;
    ShowMessage(IntToStr(id));
    DBGrid1.SelectedRows.Delete;
  end;
end;

procedure TFormActions.actShowUsersFormExecute(Sender: TObject);
begin
  FormUsers := TFormUsers.Create(self);
  FormActions.InsertControl(FormUsers);
  FormUsers.Show;
end;

procedure TFormActions.actUsersSaveExecute(Sender: TObject);
begin

end;

procedure TFormActions.actRowAddExecute(Sender: TObject);
var
 query: TSQLQuery;
 key: Integer;
 id: Integer;
begin
 key := dblcDoctor.KeyValue;
 try
   query := TSQLQuery.Create(nil);
   query.DataBase := FormLogin.SQLite3Conn;
   query.SQL.Text := 'insert into actions(user_id, doc_id, medcardnum) values(:u,:d,:m)';
   query.Prepare;
   query.ParamByName('u').AsInteger := user_id;
   query.ParamByName('d').AsInteger := key;
   query.ParamByName('m').AsString  := eMedCard.Text;
   query.ExecSQL;
   FormLogin.SQLTransact.Commit;
 finally
   query.Close;
   query.Free;
 end;
 qDoctors.Open;
 qActions.Open;
 dblcDoctor.KeyValue := key;
 //Form5.Show;
end;

procedure TFormActions.FormActivate(Sender: TObject);
begin
    qDoctors.Open;
  qActions.Open;
end;

procedure TFormActions.MenuItem3Click(Sender: TObject);
begin
 FormLogin.Close;
end;

procedure TFormActions.MenuItem7Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TFormActions.ShowLogClick(Sender: TObject);
begin
  FormLog.Show;
end;

procedure TFormActions.miRowDeleteClick(Sender: TObject);
var id: Integer;
begin

  if MessageDlg('Вопрос', 'Удалить запись?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
  then
  begin
    //id := DBGrid1.Columns.Items[0].Field.AsInteger;
    id:=DBGrid1.DataSource.DataSet.FieldByName('id').AsInteger;
    ShowMessage(IntToStr(id));
    DBGrid1.SelectedRows.Delete;
  end;
end;

procedure TFormActions.miShowUsersFormClick(Sender: TObject);
begin

end;



{ TFormActions }



end.

