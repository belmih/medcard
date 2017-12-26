unit logform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFormLog }

  TFormLog = class(TForm)
    btnClear: TButton;
    memoLog: TMemo;
    procedure btnClearClick(Sender: TObject);
  private

  public
    procedure AddLog(str: String);
    procedure AddLogInt(i: Integer);
  end;

var
  FormLog: TFormLog;

implementation

{$R *.lfm}

{ TFormLog }

procedure TFormLog.btnClearClick(Sender: TObject);
begin
  memoLog.Lines.Clear;
end;

procedure TFormLog.AddLog(str: String);
begin
  memoLog.Lines.Add(str);
end;
procedure TFormLog.AddLogInt(i: Integer);
begin
  memoLog.Lines.Add(IntToStr(i));
end;

end.

