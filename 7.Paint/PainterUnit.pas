unit PainterUnit;

interface



uses Graphics, Types;

type

  TDrawSettings = class(TObject)
  private
    FFGColor, FBGColor : TColor;
    _WidthCoef : Byte;
  public
   constructor Create;
   property FGColor : TColor read FFGColor write FFGColor;
   property BGColor : TColor read FBGColor write FBGColor;
   property WidthCoef : byte read _WidthCoef write _WidthCoef;
  end;

  TPainter = class(TObject)
  private
    Canvas : TCanvas;
    DrawSettings : TDrawSettings;
  public
    constructor Create(DrawSettings : TDrawSettings);
    procedure SetCanvas(Canvas : TCanvas);   //????? ?????? ?? ?????
    procedure DrawRect(x1, y1, x2, y2 : integer);
    procedure DrawLine(x1, y1, x2, y2 : integer);
    procedure DrawEllp(x1, y1, x2, y2 : integer);
    procedure DrawSpray(x1, y1 : integer);
    procedure DrawEraser(X1, Y1, X2, Y2:integer);
    procedure Fill(x1, y1 : integer);
end;

implementation

{ TPainter }

procedure TPainter.DrawLine(x1, y1, x2, y2: integer);
begin
  Canvas.Pen.Color := DrawSettings.FGColor;
  Canvas.MoveTo(x1,y1);
  Canvas.LineTo(x2,y2);
end;

procedure TPainter.DrawRect(x1, y1, x2, y2: integer);
begin
  Canvas.Pen.Color := DrawSettings.FGColor;
  Canvas.Brush.Color := DrawSettings.BGColor;
  Canvas.Rectangle(x1, y1, x2, y2);
end;

procedure TPainter.DrawEllp(x1, y1, x2, y2: integer);
begin
  Canvas.Pen.Color := DrawSettings.FGColor;
  Canvas.Brush.Color := DrawSettings.BGColor;
  Canvas.Ellipse(x1, y1, x2, y2);
end;

procedure TPainter.DrawSpray(x1, y1: integer);
var i, r, x, y: integer; a : real;
begin
  randomize;
  for i := 1 to 20 do
    begin
      r := random(20);
      a := random(360)*pi/180;
      x := round(r*cos(a) + x1);
      y := round(r*sin(a) + y1);
      Canvas.Pixels[x,y] := DrawSettings.FGColor;
    end;
end;

procedure TPainter.SetCanvas(Canvas: TCanvas);
begin
  self.Canvas := Canvas;
end;

constructor TPainter.Create(DrawSettings: TDrawSettings);
begin
  inherited Create;
  self.DrawSettings := DrawSettings;
end;

procedure TPainter.DrawEraser(X1, Y1, X2, Y2: integer);
  var WidthCoef : byte;
begin
  WidthCoef := DrawSettings.WidthCoef;
  Canvas.Pen.Color := DrawSettings.BGColor;
  Canvas.Brush.Color := DrawSettings.BGColor;
  {Canvas.Polygon([Point(x1-5*WidthCoef, y1-5*WidthCoef),
                  Point(x1+5*WidthCoef, y1-5*WidthCoef),
                  Point(x1+5*WidthCoef, y1+5*WidthCoef),
                  Point(x2+5*WidthCoef, y2+5*WidthCoef),
                  Point(x2-5*WidthCoef, y2+5*WidthCoef),
                  Point(x2-5*WidthCoef, y2-5*WidthCoef)]);  }
  Canvas.Pen.Width := 30 ;
  Canvas.MoveTo(x1,y1);
  Canvas.LineTo(x2,y2);
end;

procedure TPainter.Fill(x1, y1: integer);
begin
  Canvas.Brush.Color := DrawSettings.FGColor;
  Canvas.FloodFill(x1,y1,clRed, fsBorder);//DrawSettings.FGColor,fssurface);
end;

{ TDrawSettings }

constructor TDrawSettings.Create;
begin
  inherited Create;
  FFGColor := 0;
  FBGColor := clWhite;
  _WidthCoef := 1;
end;

end.
