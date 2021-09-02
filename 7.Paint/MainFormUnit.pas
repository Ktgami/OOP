unit MainFormUnit;



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ColorGrd, ExtCtrls, Buttons, EditorUnit, sState, Menus;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    ColorGrid1: TColorGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Save1: TMenuItem;
    Open1: TMenuItem;
    Help1: TMenuItem;
    Clear1: TMenuItem;
    New1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure ColorGrid1Change(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    Editor : TEditor;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Editor := TEditor.Create;
  Editor.SetOutPort(PaintBox1.Canvas, PaintBox1.Width, PaintBox1.Height);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Editor.Destroy;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Editor.MouseDwn(x,y);
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Editor.MouseUp(x,y);
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssLeft	 in Shift then
    Editor.MouseDrag(x,y);
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  Editor.Draw;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin {Rectangle}
  Editor.ChooseActiveState(sRect);
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin {Line}
  Editor.ChooseActiveState(sLine);
end;

procedure TForm1.Help1Click(Sender: TObject);
begin
  ShowMessage('Программа для нубо-рисования. Все права защищены!');
end;

procedure TForm1.ColorGrid1Change(Sender: TObject);
begin
   Editor.SetColor(ColorGrid1.ForegroundColor, ColorGrid1.BackgroundColor);
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin {Ellipse}
  Editor.ChooseActiveState(sEllp);
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin {Pencil}
  Editor.ChooseActiveState(sPen);
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
  ShowMessage('Oops! 404 Not Found');
  {PaintBox1.Canvas.Pen.Color := ClWhite;
  PaintBox1.Canvas.Brush.Color := ClWhite;
  PaintBox1.Canvas.Rectangle(0,0,PaintBox1.Width,PaintBox1.Height); }
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  Editor.ChooseActiveState(sSpray);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin {Eraser}
  Editor.ChooseActiveState(sEras);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin {Filler}
  Editor.ChooseActiveState(sFill);
end;

end.
