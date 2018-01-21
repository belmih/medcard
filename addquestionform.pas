unit addquestionform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls,sqldb, db;

type

  { TFormAddQuest }

  TFormAddQuest = class(TForm)
    btnAdd: TButton;
    btnCancel: TButton;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Panel1: TPanel;
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormAddQuest: TFormAddQuest;

implementation
  uses mainform,questsform;
{$R *.lfm}

{ TFormAddQuest }

procedure TFormAddQuest.FormShow(Sender: TObject);
begin
  //ShowMessage(IntToStr(TQuestion(FormQuests.TreeView1.Selected.Data).id));
end;

procedure TFormAddQuest.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction := caFree;
end;

procedure TFormAddQuest.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormAddQuest.btnAddClick(Sender: TObject);
var
  query: TSQLQuery;
  id: Integer;
  parentid:Integer;
  ordernum: Integer;
begin
 try
   query := TSQLQuery.Create(nil);
   query.DataBase := FormMain.SQLite3Conn;
   query.SQL.Text := 'select ifnull(max(questionorder),0) as mo from questions where parentid = :pid';
   query.Prepare;
   query.ParamByName('pid').AsInteger := TQuestion(FormQuests.TreeView1.Selected.Data).id;
   query.Open;
   ordernum := query.FieldByName('mo').AsInteger;
   query.Close;
   query.SQL.Text := 'insert into questions(questionorder, questiontext, parentid) values(:qo,:qt,:pid)';
   query.Prepare;
   query.ParamByName('qo').AsInteger := ordernum + 1;
   query.ParamByName('qt').AsString := Memo1.Lines.Text;
   query.ParamByName('pid').AsInteger := TQuestion(FormQuests.TreeView1.Selected.Data).id;
   query.ExecSQL;
   FormQuests.tbSaveQuestionsClick(self);
   {
   FormMain.SQLTransaction.Commit;
   FormMain.qQuestions.Refresh;
   FormQuests.TreeView1.Items.Clear;
   FormMain.GetTreeQuestions(FormQuests.TreeView1.Items);
   }
   Close;
 finally
   query.Close;
   query.Free;
 end;
end;

end.

