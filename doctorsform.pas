unit doctorsform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids;

type

  { TFormDoctors }

  TFormDoctors = class(TForm)
    DBGrid1: TDBGrid;
  private

  public

  end;

var
  FormDoctors: TFormDoctors;

implementation

{$R *.lfm}

end.

