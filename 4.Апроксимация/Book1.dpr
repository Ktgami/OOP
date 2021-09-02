program Book1;

uses
  Forms,
  MainFormUnit in 'MainFormUnit.pas' {Form1},
  DocumentUnit in 'DocumentUnit.pas',
  LastFiles in 'LastFiles.pas',
  DataUnit in 'DataUnit.pas',
  SizeFormUnit in 'SizeFormUnit.pas' {Form2},
  DataSetUnit in 'DataSetUnit.pas',
  ChartUnit in 'ChartUnit.pas',
  LineUnit in 'LineUnit.pas',
  Approximation in 'Approximation.pas',
  Slau in 'SLAU\Slau.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.                                         
