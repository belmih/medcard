unit mform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb,sqlite3conn, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  ComCtrls, Menus, DbCtrls, StdCtrls, DBGrids, ExtCtrls, ActnList, Buttons,
  Types,workform;

type

  { TForm2 }

  TForm2 = class(TForm)
    actUsersSave: TAction;
    actRefresh: TAction;
    actRowAdd: TAction;
    actRowDelete: TAction;
    ActionList1: TActionList;
    btnAdd: TButton;
    DBComboBox1: TDBComboBox;
    dblcDoctor: TDBLookupComboBox;
    dsActions: TDataSource;
    dsDoctors: TDataSource;
    DBGrid1: TDBGrid;
    DBLookupListBox1: TDBLookupListBox;
    eMedCard: TEdit;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    ShowLog: TMenuItem;
    miShowUsersForm: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    qActions: TSQLQuery;
    qDoctors: TSQLQuery;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    procedure actRowAddExecute(Sender: TObject);
    procedure actRowDeleteExecute(Sender: TObject);
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
  Form2: TForm2;

implementation

uses loginform, usersform, aboutform, logform;
{$R *.lfm}

{ TForm2 }

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form1.Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.FormShow(Sender: TObject);
begin
  StatusBar1.Panels.Items[0].Width := 250;
  StatusBar1.Panels.Items[0].Text := userFullName + ' (' + Form1.eLogin.Text+')';
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  ;



end;

procedure TForm2.DBGrid1DblClick(Sender: TObject);
var id: Integer;
begin
    id:=DBGrid1.DataSource.DataSet.FieldByName('id').AsInteger;
    //ShowMessage(IntToStr(id));
    Form5.tmpID:=id;
    Form5.Show;
end;


procedure TForm2.actRowDeleteExecute(Sender: TObject);
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

procedure TForm2.actUsersSaveExecute(Sender: TObject);
begin

end;

procedure TForm2.actRowAddExecute(Sender: TObject);
var
 query: TSQLQuery;
 key: Integer;
 id: Integer;
begin
 key := dblcDoctor.KeyValue;
 try
   query := TSQLQuery.Create(nil);
   query.DataBase := Form1.SQLite3Conn;
   query.SQL.Text := 'insert into actions(user_id, doc_id, medcardnum) values(:u,:d,:m)';
   query.Prepare;
   query.ParamByName('u').AsInteger := user_id;
   query.ParamByName('d').AsInteger := key;
   query.ParamByName('m').AsString  := eMedCard.Text;
   query.ExecSQL;
   Form1.SQLTransact.Commit;
 finally
   query.Close;
   query.Free;
 end;
 qDoctors.Open;
 qActions.Open;
 dblcDoctor.KeyValue := key;
 Form5.Show;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
    qDoctors.Open;
  qActions.Open;
end;

procedure TForm2.MenuItem3Click(Sender: TObject);
begin
 Form1.Close;
end;

procedure TForm2.MenuItem7Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm2.ShowLogClick(Sender: TObject);
begin
  FormLog.Show;
end;

procedure TForm2.miRowDeleteClick(Sender: TObject);
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

procedure TForm2.miShowUsersFormClick(Sender: TObject);
begin
  Form3.Show;
end;



{ TForm2 }



end.

