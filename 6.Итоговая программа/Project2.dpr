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
  Approximation in 'Approximation.pas',
  Slau in 'Slau.pas',
  FormSettings in 'FormSettings.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
