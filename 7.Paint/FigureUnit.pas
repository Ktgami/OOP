
unit FigureUnit;

interface

uses PainterUnit;

type
  TFigure = class(TObject)
  protected
    X1, Y1 : integer;
    _BuiltIn : boolean;
  public
    constructor Create(X1, Y1 : integer);
    procedure Drag(x,y: integer); virtual; abstract;
    procedure Draw(Painter : TPainter); virtual; abstract;
    property BuiltIn : boolean read _BuiltIn write _BuiltIn;
  end;

  TStretchFigure = class(TFigure)
  protected
    X2, Y2 : integer;
  public
    constructor Create(X1, Y1, X2, Y2: integer);
    procedure Drag(x,y: integer); override;
  end;

  TRectFigure = class(TStretchFigure)
    procedure Draw(Painter : TPainter); override;
  end;

  TLineFigure = class(TStretchFigure)
    procedure Draw(Painter : TPainter); override;
  end;

  TEllpFigure = class(TStretchFigure)
    procedure Draw(Painter : TPainter); override;
  end;

  TCaterPillarFigure = class(TStretchFigure)
  public
    constructor Create(X1, Y1, X2, Y2: integer);
    procedure Drag(x,y: integer); override;
  end;

  TPenFigure = class(TCaterPillarFigure)
    procedure Draw(Painter : TPainter); override;
  end;

  TErasFigure = class(TCaterPillarFigure)
    procedure Draw(Painter : TPainter); override;
  end;

  TPointFigure = class(TFigure)
    procedure Drag(x,y: integer); override;
  end;

  TSprayFigure = class(TPointFigure)
    //procedure Drag(x,y: integer); override;
    procedure Draw(Painter : TPainter); override;
  end;

  TFillFigure = class(TPointFigure)
    procedure Draw(Painter : TPainter); override;
  end;

implementation

{ TFigure }

constructor TFigure.Create(X1, Y1 : integer);
begin
  inherited Create;
  self.X1 := X1;
  self.Y1 := Y1;
  _BuiltIn := true;
end;

{ TDragFigure }

constructor TStretchFigure.Create(X1, Y1, X2, Y2: integer);
begin
  inherited Create(X1, Y1);
  self.X2 := X2;
  self.Y2 := Y2;
  _BuiltIn := false;
end;

procedure TStretchFigure.Drag(x, y: integer);
begin
  X2 := x;
  Y2 := y;
end;

{ TRectFigure }

procedure TRectFigure.Draw(Painter : TPainter);
begin
  Painter.DrawRect(X1, Y1, X2, Y2)
end;

{ TLineFigure }

procedure TLineFigure.Draw(Painter: TPainter);
begin
  Painter.DrawLine(X1, Y1, X2, Y2);
end;

{ TEllpFigure }

procedure TEllpFigure.Draw(Painter: TPainter);
begin
  Painter.DrawEllp(X1, Y1, X2, Y2);
end;

{ TCaterPillarFigure }

constructor TCaterPillarFigure.Create(X1, Y1, X2, Y2: integer);
begin
  inherited Create(X1, Y1, X2, Y2);
  _BuiltIn := true;
end;

procedure TCaterPillarFigure.Drag(x, y: integer);
begin
  X1 := X2;
  Y1 := Y2;
  X2 := x;
  Y2 := y;
end;

{ TPenFigure }

procedure TPenFigure.Draw(Painter: TPainter);
begin
  Painter.DrawLine(X1, Y1, X2, Y2);
end;

{ TSprayFigure }

procedure TSprayFigure.Draw(Painter: TPainter);
begin
  Painter.DrawSpray(X1, Y1);
end;

{ TPointFigure }

procedure TPointFigure.Drag(x, y: integer);
begin
  x1 := x;
  y1 := y;

end;

{ TErasFigure }

procedure TErasFigure.Draw(Painter: TPainter);
begin
  Painter.DrawEraser(X1, Y1, X2, Y2);
end;

{ TFillFigure }

procedure TFillFigure.Draw(Painter: TPainter);
begin
  Painter.Fill(X1, Y1);
end;

end.
