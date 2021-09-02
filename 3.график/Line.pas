unit Line;

interface
  uses Graphics, classes, SysUtils, Scaler;

  type

  TLine = class(TObject)
    private
      scaler: TScaler;
      FXArr    : array of real;
      FYArr    : array of real;
      FXMin    : real;
      FXMax    : real;
      FYMin    : real;
      FYMax    : real;
      FColor   : TColor;
      FCaption : string;
      FId      : integer;
    public
      constructor Create (const x, y: array of real; _scaler: TScaler; id: integer);
      procedure Plot(canvas: TCanvas);
      Property XMin     : real read FXMin;
      Property XMax     : real read FXMax;
      Property YMin     : real read FYMin;
      Property YMax     : real read FYMax;
      Property Color    : TColor read FColor write FColor;
      Property Caption  : string read FCaption write FCaption;
      Property Id       : integer read FId;
      destructor Destroy;
  end;

implementation


  var

    LastId : integer = 0;


  constructor TLine.Create(const x, y: array of real; _scaler: TScaler; id: integer);
    var i : integer;
  begin
    inherited Create;
    FId := id;
    scaler := _scaler;

    if (Length(x) <> Length(y)) or (Length(x) = 0) then exit;

    SetLength(FXArr, Length(x));
    SetLength(FYArr, Length(y));


    FXMin := x[0];
    FXMax := x[0];


    for i:= 0 to High(x) do
    begin
      FXArr[i] := x[i];
      if x[i] > FXMax then FXMax := x[i];
      if x[i] < FXMin then FXMin := x[i];
    end;

    FYMin := y[0];
    FYMax := y[0];


    for i:= 0 to High(y) do
    begin
      FYArr[i] := y[i];
      if y[i] > FYMax then FYMax := y[i];
      if y[i] < FYMin then FYMin := y[i];
    end;
    Color := clBlack;
    self.scaler.SetSingleLineBounds(fXMin, fXMax, fYMin, fYMax);
  end;

  procedure TLine.Plot(canvas: TCanvas);
  var curXg, curYg, i: integer;
  begin
    scaler.RealToScreen(FXArr[0], FYArr[0], curXg, curYg);
    canvas.MoveTo(curXg, curYg);
    canvas.Pen.Color := FColor;
     for i := 0 to length(FXArr)-1 do
    begin
      scaler.RealToScreen(FXArr[i], FYArr[i], curXg, curYg);
      canvas.LineTo(curXg, curYg);
    end;
  end;


  destructor TLine.Destroy;
  begin

    SetLength(FXArr, 0);
    SetLength(FYArr, 0);
    inherited;
  end;

  

end.
