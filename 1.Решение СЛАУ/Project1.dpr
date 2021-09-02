program Project1;

uses
  Forms,
  MainFormUnit in 'MainFormUnit.pas' {FormSLAU},
  GetSolutionUnit in 'GetSolutionUnit.pas',
  SizeFormUnit in 'SizeFormUnit.pas' {SizeForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormSLAU, FormSLAU);
  Application.CreateForm(TSizeForm, SizeForm);
  Application.Run;
end.
