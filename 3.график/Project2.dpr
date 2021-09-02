program Project2;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  Document in 'Document.pas',
  Book in 'Book.pas',
  LastFileController in 'LastFileController.pas',
  Data in 'Data.pas',
  Chart in 'Chart.pas',
  DiscretSet in 'DiscretSet.pas',
  Legend in 'Legend.pas',
  Line in 'Line.pas',
  LineList in 'LineList.pas',
  Scaler in 'Scaler.pas',
  PointRec in 'PointRec.pas',
  Approximation in 'Approximation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
