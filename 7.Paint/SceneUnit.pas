unit SceneUnit;



interface

uses PainterUnit, FigureUnit, Graphics, Types;

type
  TScene = class(TObject)
  private
    UserCanvas : TCanvas;
    Painter : TPainter;
    Figure : TFigure;
    Buffer, BkGround : Graphics.TBitMap;
    AreaRect : TRect;
    DrawSettings : TDrawSettings;
  public
    constructor Create(DrawSettings : TDrawSettings);
    destructor Destroy; override;
    procedure SetFigure(Figure : TFigure);
    procedure SetOutPort(Canvas : TCanvas; Width, Height : integer);
    procedure Draw;
end;

implementation

{ TScene }

constructor TScene.Create(DrawSettings : TDrawSettings);
begin
  inherited create;
  self.DrawSettings := DrawSettings;
  Painter := TPainter.Create(DrawSettings);
  Figure := nil;
  Buffer := Graphics.TBitMap.Create;
  BkGround := Graphics.TBitMap.Create;
end;

destructor TScene.Destroy;
begin
  Buffer.Destroy;
  BkGround.Destroy;
  Painter.destroy;
  inherited destroy;
end;

procedure TScene.Draw;
begin
  if UserCanvas = nil then exit;
  Buffer.Canvas.CopyRect(AreaRect, BkGround.Canvas, AreaRect);
  if Figure <> nil then
  begin
    Painter.SetCanvas(Buffer.Canvas);
    Figure.Draw(Painter);
    if Figure.BuiltIn then
    begin
      Painter.SetCanvas(BkGround.Canvas);
      Figure.Draw(Painter);
    end;
  end;
  UserCanvas.CopyRect(AreaRect, Buffer.Canvas, AreaRect);
end;

procedure TScene.SetFigure(Figure: TFigure);
begin
  self.Figure := Figure;
end;

procedure TScene.SetOutPort(Canvas: TCanvas; Width, Height: integer);
begin
  UserCanvas := Canvas;
  Painter.SetCanvas(Canvas);
  Buffer.Width := Width;
  Buffer.Height := Height;
  BkGround.Width := Width;
  BkGround.Height := Height;
  AreaRect := Rect(0, 0, Width, Height);
end;

end.
