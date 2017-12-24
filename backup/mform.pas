unit mform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  ComCtrls, Menus, DbCtrls, StdCtrls, Types;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    DBLookupListBox1: TDBLookupListBox;
    dsDoctors: TDataSource;
    Edit1: TEdit;
    Label1: TLabel;
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
    PageControl1: TPageControl;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure MenuItem3Click(Sender: TObject);
    procedure miShowUsersFormClick(Sender: TObject);
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

procedure TForm2.MenuItem3Click(Sender: TObject);
begin
 Form1.Close;
end;

procedure TForm2.miShowUsersFormClick(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm2.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin


end;

{ TForm2 }



end.

