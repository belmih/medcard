unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ActnList, ComCtrls;

type

  { TFormMain }

  TFormMain = class(TForm)
    ActionList1: TActionList;
    actRefresh: TAction;
    actRowAdd: TAction;
    actRowDelete: TAction;
    actShowUsersForm: TAction;
    actUsersSave: TAction;
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
    ShowLog: TMenuItem;
    procedure actShowUsersFormExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FormMain: TFormMain;

implementation
 uses loginform, usersform, unit2;
{$R *.lfm}

{ TFormMain }

procedure TFormMain.actShowUsersFormExecute(Sender: TObject);
begin
  FormUsers := TFormUsers.Create(self);
  FormUsers.ShowModal;
end;

procedure TFormMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FormLogin.Close;
end;



end.

