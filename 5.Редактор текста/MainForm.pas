unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  Book, Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    New1: TMenuItem;
    Save1: TMenuItem;
    Save2: TMenuItem;
    Saveas1: TMenuItem;
    Close1: TMenuItem;
    Close2: TMenuItem;
    Last1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Save2Click(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Close2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    Book : TBook;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Book := TBook.Create(self, Last1);
  Book.Parent := self;
  Book.Align := alClient;
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
  Book.NewDocument;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Save2Click(Sender: TObject);
begin
  Book.SaveDocument;
end;

procedure TForm1.Saveas1Click(Sender: TObject);
begin
  Book.SaveAsDocument;
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
  Book.OpenDocument;
end;

procedure TForm1.Close2Click(Sender: TObject);
begin
  Book.CloseDocument;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Book.Close;
end;

end.
