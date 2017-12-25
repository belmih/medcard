unit mform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  ComCtrls, Menus, DbCtrls, StdCtrls, DBGrids, ExtCtrls, ActnList, Types;

type

  { TForm2 }

  TForm2 = class(TForm)
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
    procedure actRowDeleteExecute(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure miRowDeleteClick(Sender: TObject);
    procedure miShowUsersFormClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private

  public

  end;

var
  Form2: TForm2;

implementation

uses LoginForm, usersform;
{$R *.lfm}

{ TForm2 }

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form1.Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  qDoctors.Open;
  qActions.Open;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  ;



end;

procedure TForm2.btnAddClick(Sender: TObject);
var
 query: TSQLQuery;
 key: Integer;
begin
 key := dblcDoctor.KeyValue;
 query := TSQLQuery.Create(Application);
 try
   query.SQLConnection := Form1.SQLite3Conn;
   query.SQLTransaction := Form1.SQLTransact;
   query.SQL.Text := 'insert into actions(user_id, doc_id, medcardnum) values(:u,:d,:m)';
   query.ParamByName('u').AsInteger := user_id;
   query.ParamByName('d').AsInteger := key;
   query.ParamByName('m').AsString  := eMedCard.Text;
   query.ExecSQL;
   Form1.SQLTransact.Commit;
   query.Close;
 finally
   query.Free;
 end;
 qDoctors.Open;
 qActions.Open;
 dblcDoctor.KeyValue := key;
end;

procedure TForm2.actRowDeleteExecute(Sender: TObject);
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

procedure TForm2.FormActivate(Sender: TObject);
begin
  StatusBar1.Panels.Items[0].Width := 250;
  StatusBar1.Panels.Items[0].Text := userFullName + ' (' + Form1.eLogin.Text+')';

end;

procedure TForm2.MenuItem3Click(Sender: TObject);
begin
 Form1.Close;
end;

procedure TForm2.MenuItem7Click(Sender: TObject);
begin

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

procedure TForm2.PageControl1Change(Sender: TObject);
begin

end;

procedure TForm2.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin


end;

{ TForm2 }



end.

