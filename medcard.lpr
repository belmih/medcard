program medcard;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, loginform, actionsform, usersform, aboutform, workform, logform,
  doctorsform, mainform, common, dbcreate, questsform, addquestionform,
  testform, form6;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormQuests, FormQuests);
  Application.CreateForm(TFormAddQuest, FormAddQuest);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormReports, FormReports);
  Application.Run;
end.

