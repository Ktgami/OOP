unit Approximation;

interface

 uses DataSetUnit, ChartUnit, DataUnit, Slau;

  type

  TApproximation = class (TDataSet)
  private
    Chart : TChart;
    Data : TData;
    CoefCount : integer;
    Coefs : array of real;
    SLAU : TSlau;
    procedure BuildLine; override;
  public
    constructor Create(Chart : TChart; Data : TData);
    destructor Destroy; override;
    procedure Execute;
  end;

  TApprAlgorythm = class (TObject)
  protected
    SLAU : TSLAU;
    Data : TData;
    _Coefs : array of real;
    _CoefCount : Integer;
    procedure FillSLAU; virtual; abstract;
    function GetCoef(i : integer) : real;
  public
    constructor Create(Data : TData);
    destructor Destroy; override;
    procedure Execute;
    property CoefCount : Integer read _CoefCount;
    property Coefs[i : integer]: real read GetCoef;
  end;

  TInteprolAlg = class (TApprAlgorythm)
  private
    procedure FillSLAU; override;
  end;

  TMNKAlg = class(TApprAlgorythm)
  private
    procedure FillSLAU; override;
  end;

implementation

{ TApproximation }

constructor TApproximation.Create(Chart: TChart; Data: TData);
begin
  inherited Create(Chart);
  self.Chart := Chart;
  self.Data := Data;
end;

destructor TApproximation.Destroy;
begin
  Coefs := nil;
  inherited Destroy;
end;

procedure TApproximation.Execute;
var Algorythm : TApprAlgorythm;
    i :integer;
begin
  Algorythm := TMNKAlg.Create(Data);//TInteprolAlg.Create(Data);
  Algorythm.Execute;
  SetLength(Coefs, Algorythm.CoefCount);
  CoefCount := Algorythm.CoefCount;
  for i := 0 to Algorythm.CoefCount-1 do
    Coefs[i] := Algorythm.Coefs[i];
  Algorythm.Destroy;
  Replot;
end;

procedure TApproximation.BuildLine;
var a, b, h, StX : real;
    x, y : array of real;
    i, j : integer;
const N = 100;
begin
  a := Data.MinX;
  b := Data.MaxX;
  h := (b-a) / (N-1);
  SetLength(x, N);
  SetLength(y, N);

  for i := 0 to N-1 do
    begin
      x[i] := a + h * i;
      y[i] := 0;
      StX := 1;
      for j := 0 to CoefCount-1 do
      begin
        y[i] := y[i] + Coefs[j] * StX;
        StX := StX * x[i];
      end;
    end;
  LineID := Chart.AddLine(x,y);    //
  x := nil;
  y := nil;
end;

{ TApprAlgorythm }

constructor TApprAlgorythm.Create(Data: TData);
begin
  inherited Create;
  SLAU := TSLAU.Create(0);
  self.Data := Data;
  _CoefCount := 0;
end;

destructor TApprAlgorythm.Destroy;
begin
  SLAU.Destroy;
  _Coefs := nil;
  inherited Destroy;
end;

procedure TApprAlgorythm.Execute;
var i : integer;
begin
  FillSlau;
  _Coefs := nil;
  if SLAU.Gauss < 0 then exit;
  SetLength(_Coefs, SLAU.Size);
  for i := 0 to SLAU.Size - 1 do
     _Coefs[i] := SLAU.XX[i];
end;

function TApprAlgorythm.GetCoef(i: integer): real;
begin
  if i < _CoefCount then Result := _Coefs[i];
end;

{ TInteprolAlg }

procedure TInteprolAlg.FillSLAU;
var n, i, j : integer;
    x : real;
begin
  n := Data.PairCount;
  SLAU.Size := n;
  _CoefCount := n;
  for i := 0 to n-1 do SLAU[i,0] := 1;
  for i := 0 to n-1 do
  begin
    x := Data[0,i];
    for j := 1 to n-1 do SLAU[i,j] := SLAU[i,j-1] * x;
    SLAU[i,n] := Data[1,i];
  end;
end;

{ TMNKAlg }

procedure TMNKAlg.FillSLAU;
  function Step(x: real; n : integer): real;
    var i : integer;
        P : real;
  begin
    P := 1;
    for i := 1 to n do P := P * x;
    Result := P;
  end;
var i,j,k,M,N : integer;
    Koef, FF : real;
begin
  M := 2;
  _CoefCount := 3;

  N := Data.PairCount - 1;
  Slau.Size := M +1;
  for k := 0 to M do
  begin
    for j := 0 to M do
    begin
      Koef := 0;
      for i := 0 to N do Koef := Koef + Step(Data[0,i], j+k);
      SLAU[k,j] := Koef;
    end;
    FF := 0;
    for i := 0 to N do FF := FF + Data[1,i] * Step(Data[0,i], k);
    SLAU[k,M+1] := FF;
  end;
end;

end.
