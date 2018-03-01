unit memoform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls;

type

  { TmemoForm1 }

  TmemoForm1 = class(TForm)
    Memo1: TMemo;
    ToolBar1: TToolBar;
    procedure Memo1Change(Sender: TObject);
  private

  public

  end;

var
  memoForm1: TmemoForm1;

implementation

{$R *.lfm}

{ TmemoForm1 }

procedure TmemoForm1.Memo1Change(Sender: TObject);
begin

end;

end.

