unit Scaler;

interface
  uses Graphics, SysUtils,Windows,Types;
  
  type

  TScaler = class(TObject)
    private
      FXMin   : real;
      FXMax   : real;
      FYMin   : real;
      FYMax   : real;
      FXeMin  : integer;
      FXeMax  : integer;
      FYeMin  : integer;
      FYeMax  : integer;
      FXGMin  : integer;
      FXGMax  : integer;
      FYGMin  : integer;
      FYGMax  : integer;
      KnowRealBounds : boolean;
    public
      constructor Create;
      procedure SetSingleLineBounds(XMin, XMax, YMin, YMax: real);
      procedure RealToScreen(Xr, Yr : real; var Xg: integer; var Yg: integer);
      procedure ScreenToReal(Xg: integer; var Xr: real);
      procedure SetScreenBounds(XMin, XMax, YMin, YMax: integer);
      procedure SkipRealBounds;
      procedure Scale(xe:integer;coef:integer);
      procedure DrowGrid(canvas: TCanvas);
      procedure FixClipRect(Canvas:TCanvas);
      procedure ReleaseClipRect(Canvas:TCanvas);
    end;

implementation

  constructor TScaler.Create;
  begin
    inherited Create;
    SkipRealBounds;
  end;

  procedure TScaler.SetSingleLineBounds(XMin, XMax, YMin, YMax: real);
  begin

    if KnowRealBounds then
    begin
      if XMin < FXMin then
        FXMin := XMin;
      if XMax > FXMax then
        FXMax := XMax;
      if YMin < FYMin then
        FYMin := Ymin;
      if YMax > FYMax then
        FYMax := YMax;
    end
    else
    begin
      FXMin := XMin;
      FXMax := XMax;
      FYMin := Ymin;
      FYMax := YMax;
    end;

    KnowRealBounds := true;
  end;

  procedure TScaler.RealToScreen(Xr, Yr : real; var Xg: integer; var Yg: integer);
  begin
    Xg := round(FXeMin + (Xr - FXMin)/(FXMax - FXMin)*(FXeMax - FXeMin));
    Yg := round(FYeMin + (FYMax - Yr)/(FYMax - FYMin)*(FYeMax - FYeMin));
  end;

  procedure TScaler.ScreenToReal(Xg : integer; var Xr: real);
  begin
     Xr:=(Xg-FXeMin)/(FXeMax - FXeMin)+FXMin;
  end;

  procedure TScaler.SetScreenBounds(XMin, XMax, YMin, YMax: integer);
  begin
    FXGMin  := XMin;
    FXGMax  := XMax;
    FYGMin  := Ymin;
    FYGMax  := YMax;
    FXeMin  := XMin + 80;
    FXeMax  := XMax;
    FYeMin  := Ymin;
    FYeMax  := YMax - 20;
  end;

  procedure TScaler.SkipRealBounds;
  begin
   KnowRealBounds:=false;
   FXMin:=0;
   FYMin:=0;
   FYMax:=1;
   FXMax:=1;
  end;

 procedure TScaler.Scale(xe:integer;coef:integer);
   var _x,_x1,_x2:real;
       coeff:integer;
  begin
   if (xe>FXeMax) or (xe<FXeMin)  then exit;
   coeff:=2;
   ScreentoReal(xe,_x);
       if coef=1 then
       begin
      _x1:=(FXMin-_x*(1-coeff))/coeff;
      _x2:=(FXMax-_x*(1-coeff))/coeff;
      If (_x1>FXMin) then FXMin:=_x1;
      If (_x2<FXMax) then FXMAx:=_x2;
       end
       else
       begin
      _x1:=(FXMin-_x*(1-coeff))*coeff;
      _x2:=(FXMax-_x*(1-coeff))*coeff;
      If (_x1<FXMin) then
      If (_x1>FXeMin) then FXMin:=_x1
      else FXMin:=FXeMin;
      If _x2>FXmax then
      if _x2<FXeMax then FXmax:=_x2
      else
      FXmax:=FXemax;
      end;
end;

  procedure TScaler.DrowGrid(canvas: TCanvas);
    const dXe = 100;
    var n, m, i : integer;
    var curX, curY, dX, dY : integer;
    var length: integer;
    R, dXr, dyr : real;
    S : string;
  begin
    Canvas.Pen.Color := clBlack;
    Canvas.Rectangle(FXeMin, FYeMin, FXeMax, FYeMax);
    n := round(abs(FXeMax - FXeMin) / dXe) + 1;
    m := round(abs(FYeMax - FYeMin) / dXe) + 1;
    dX := round((FXeMax - FXeMin) / n);
    dY := round((FYeMax - FYeMin) / m);
    dXr := (FXMax - FXMin) / n;
    dYr := (FYMax - FYMin) / m;
    for i := 1 to n-1 do
    begin
      canvas.MoveTo(FXeMin + dX * i, FYeMin);
      canvas.LineTo(FXeMin + dX * i, FYeMax);
      R := FXMin + i * dXr;
      S := FloatToStrF(R, ffFixed, 5, 2);
      canvas.TextOut(FXeMin + dX * i - 25, FYeMax+5, S);
    end;
    for i := 1 to m-1 do
    begin
      canvas.MoveTo(FxeMin,FYeMin + dY * i);
      canvas.LineTo(FXeMax, FyeMin + dY * i);
      R := FYMax - i * dYr;
      S := FloatToStrF(R, ffFixed, 5, 2);
      canvas.TextOut(FXeMin-60,FYeMin + dy * i-5, S);
    end;

  end;

procedure TScaler.FixClipRect(Canvas:TCanvas);
Var MyRgn:HRGN;
Begin
MyRgn:=CreateRectRgn(FXeMin,FYeMin,FXeMax,FYeMax);
SelectClipRgn(Canvas.Handle,MyRgn);
end;

procedure TScaler.ReleaseClipRect(Canvas:TCanvas);
Var MyRgn:HRGN;
Begin
 MyRgn:=HRGN(nil);
 SelectClipRgn(Canvas.Handle,MyRgn);
end;
end.
