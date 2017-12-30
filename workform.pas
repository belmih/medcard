unit workform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DbCtrls, DBGrids, ComCtrls, StdCtrls;

type

  { TForm5 }

  TForm5 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    ImageList1: TImageList;
    SQLQuery1: TSQLQuery;
    TreeView1: TTreeView;
    procedure FormShow(Sender: TObject);
  private

  public
   tmpID: Integer;
  end;

var
  Form5: TForm5;

implementation
 uses loginform, logform;
{$R *.lfm}

procedure FillTree(query: TSQLQuery);

var
  level1, level2, level3 : Integer;
  node1, node2, node3: TTreeNode;
  node: TTreeNode;
begin

  //ShowMessage(IntToStr(Form5.tmpID));

  query.SQL.Text := 'select * from results where action_id = :a';
  query.Prepare;
  query.ParamByName('a').AsInteger := Form5.tmpID;
  query.Open;


  node := Form5.TreeView1.Items.Add(nil,'Критерии качества');
  FormLog.AddLogInt(node.Index);
  while not query.EOF do
  begin
    level1 := query.FieldByName('level1').AsInteger;
    level2 := query.FieldByName('level2').AsInteger;
    level3 := query.FieldByName('level3').AsInteger;
    node1 := Form5.TreeView1.Items.AddChild(node,'Критерии оценки');


    //node2 := Form5.TreeView1.Items.AddChild(node1,'Критерии оценки');
    //node3 := Form5.TreeView1.Items.AddChild(node1,'Критерии оценки');
    //Form5.TreeView1.Items.AddChild(node,'Критерии оценки');
    ///FormLog.AddLogInt(node1.AbsoluteIndex );
    {if level1 <> level1prev then
    begin

    end;
    }

    query.Next;
  end;
end;

{ TForm5 }

procedure TForm5.FormShow(Sender: TObject);
var
  query: TSQLQuery;
  id: Integer;
begin
  id := FormLogin.SQLite3Conn.GetInsertID;
  //ShowMessage(IntToStr(id));
  try
    query := TSQLQuery.Create(nil);
    query.DataBase := FormLogin.SQLite3Conn;
    query.SQL.Text := ''
      + 'insert into results (action_id, level1, level2, level3,'#13#10
      + '                     questiontext,answertext,points,comment)'#13#10
      + 'select a.id, level1, level2, level3,questiontext, null, null, null'#13#10
      + '  from actions a, questions q where a.id = :id'#13#10
      + ' order by level1, level2, level3, questionorder';
    query.Prepare;
    query.ParamByName('id').AsInteger := id;
    //query.ExecSQL;
    FormLogin.SQLTransact.Commit;
    FillTree(query);
  finally
    query.Close;
    query.Free;
  end;




  {query := TSQLQuery.Create(Application);
 try
   query.SQLConnection  := Form1.SQLite3Conn;
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

  insert into results (action_id,level1,level2,level3,questiontext,answertext,points,comment)
 select a.id, level1, level2, level3,questiontext, null, null, null from actions a, questions q  where a.id = 23
order by level1, level2, level3, questionorder      }
end;

end.

