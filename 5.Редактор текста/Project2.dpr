program Project2;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  Document in 'Document.pas',
  Book in 'Book.pas',
  LastFileController in 'LastFileController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
