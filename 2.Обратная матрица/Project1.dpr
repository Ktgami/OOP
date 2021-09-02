program Project1;

uses
  Forms,
  Resizer in 'Resizer.pas' {SizeForm},
  Slau in 'Slau.pas',
  Unit1 in 'Unit1.pas' {FormSlau},
  TransMatrixUnit in 'TransMatrixUnit.pas' {FormTransMatrix};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormSlau, FormSlau);
  Application.CreateForm(TSizeForm, SizeForm);
  Application.CreateForm(TFormTransMatrix, FormTransMatrix);
  Application.Run;
end.
