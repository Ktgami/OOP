Unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  Book, Menus, ExtCtrls,Chart, Grids;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    New1: TMenuItem;
    Save1: TMenuItem;
    Save2: TMenuItem;
    Saveas1: TMenuItem;
    Close1: TMenuItem;
    Close2: TMenuItem;
    Last1: TMenuItem;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Document1: TMenuItem;
    AddPoint1: TMenuItem;
    DeletePoint1: TMenuItem;
    Clear1: TMenuItem;
    BuildLine1: TMenuItem;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Save2Click(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Close2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure AddPoint1Click(Sender: TObject);
    procedure DeletePoint1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure BuildLine1Click(Sender: TObject);
    procedure ActiveDocumentChange(Sender: TObject);
  private
    Book : TBook;
    Chart: TChart;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Chart:=TChart.Create(PaintBox1);
 // Chart.SetOutPort(PaintBox1.canvas, 0,0,PaintBox1.Width,PaintBox1.Height);
  Chart.LegendOn:=false;
  Book := TBook.Create(Panel1, Last1, Chart);
  Book.OnChange := ActiveDocumentChange;
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
  BuildLine1.Checked := Book.IsActiveDocumentPlotted;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Book.Close;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
Chart.Drow;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
   Chart.SetOutPort(PaintBox1.canvas, 0,0,PaintBox1.Width,PaintBox1.Height);
end;

procedure TForm1.AddPoint1Click(Sender: TObject);
begin
     Book.AddPoint;
end;

procedure TForm1.DeletePoint1Click(Sender: TObject);
begin
     Book.DelPoint;
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
     Book.Clear;
     BuildLine1.Checked := Book.IsActiveDocumentPlotted;
end;

procedure TForm1.BuildLine1Click(Sender: TObject);
begin
     BuildLine1.Checked := Not BuildLine1.Checked;
     Book.IsActiveDocumentPlotted := BuildLine1.Checked;
end;

procedure TForm1.ActiveDocumentChange(Sender: TObject);
begin
     BuildLine1.Checked := Book.IsActiveDocumentPlotted;
end;

end.
