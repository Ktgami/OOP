program Paint;

uses
  Forms,
  MainFormUnit in 'MainFormUnit.pas' {Form1},
  PainterUnit in 'PainterUnit.pas',
  SceneUnit in 'SceneUnit.pas',
  FigureUnit in 'FigureUnit.pas',
  StateUnit in 'StateUnit.pas',
  EditorUnit in 'EditorUnit.pas',
  sState in 'sState.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
