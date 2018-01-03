program medcard;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, loginform, actionsform, usersform, aboutform, workform, logform,
  doctorsform, mainform, common, dbcreate, questsform, addquestionform;

{$R *.res}

begin
  Application.Scaled:=True;
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormQuests, FormQuests);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

