unit Approximation;
{$R+}
interface

 uses  DiscretSet, Data, Chart,slau;

 type

 TApproximation= class (TDiscretSet)
 private
   Actual : boolean;
   Data : TData;
   CoefCount : integer;
   Coefs : array of real;
   
 public
property LineID : integer read GetLineID;
   Constructor Create (Data : TData; Chart:TChart);
   Destructor Destroy; override;
   Procedure execute(name:string);
   procedure BuildLine; override;
 end;

  TApprAlgorythm = class (TObject)
  protected
    SLAU : TSLAU;
    Data : TData;
    ACoefs : array of real;
    ACoefCount : Integer;
    procedure FillSLAU; virtual; abstract;
    function GetCoef(i : integer) : real;
  public
    constructor Create(Data : TData);
    destructor Destroy; override;
    procedure Execute;
    property CoefCount : Integer read ACoefCount;
    property Coefs[i : integer]: real read GetCoef;
  end;

  TInteprolAlg = class (TApprAlgorythm)
  public
 //    constructor Create (Data: TData) ;
     destructor Destroy;
  //  function getSizeForalgoritm:integer;
     procedure FillSLAU; override;
  end;

  TMNKAlg = class (TApprAlgorythm)
  private
    m:integer;
    public
  constructor create(Data:Tdata;m_Lv:integer);
  Destructor Destroy;
  procedure FillSlau;override;
  function Power(x:real;Power_LV:integer):real;
  end;
implementation

 Constructor TApproximation.Create (Data:TData; Chart:TChart);
 begin
   inherited Create(chart);
   self.Data := Data;
   Actual := false;
 end;

 Destructor TApproximation.Destroy;
 Begin
 end;

procedure TApproximation.Execute(name:string);
var AppAlgorythm : TApprAlgorythm;
    i,m_Lv1 :integer;
begin
// appAlgorythm
 // AppAlgorythm := TInteprolAlg.Create(Data);
 m_LV1:=Data.MNKpower ;
 if name='Interpol' then AppAlgorythm := TInteprolAlg.Create(Data);
 if name='MNK' then   appAlgorythm := TMNKAlg.create(Data,M_Lv1);
  if name='' then AppAlgorythm := TInteprolAlg.Create(Data);



  AppAlgorythm.Execute;
  SetLength(Coefs, AppAlgorythm.CoefCount);
  CoefCount := AppAlgorythm.CoefCount;
  for i := 0 to AppAlgorythm.CoefCount-1 do
    Coefs[i] := AppAlgorythm.Coefs[i];
 AppAlgorythm.Destroy;
 Plotted := true;
  //;
end;
procedure TApproximation.BuildLine;
var x,y:array of real; p,max,min,h:real;
      i,j, N:integer;
begin
     begin
  if (Not self.Plotted) then begin
       self.plottedField := true;
    //  self.plottedFieldaprox:=True;
      N := 10;
         SetLength(x, N);
         SetLength(y, N);

        max:=Data.maxx;
        min:=Data.minx ;
        h := (max-min) / (N-1);
        for i := 0 to N-1 do
          begin
            x[i] := min + h * i;
            y[i] := 0;
            p := 1;
            for j := 0 to CoefCount-1 do   ///n-1 do
            begin
              y[i] := y[i] + Coefs[j] * p;
              p :=p  * x[i];
            end;
          end;
      self.id := ChartInstance.AddLine(x,y);
       id:=self.id;

      ChartInstance.Invalidate;
      x := nil;
      y := nil;
     end;
end;      end;
  {----------apprAlgorithm-----------}
 constructor TApprAlgorythm.Create(Data: TData);
begin
  inherited Create;
  SLAU := TSLAU.Create(0);
  self.Data := Data;
  ACoefCount := 0;
end;
destructor TApprAlgorythm.Destroy;
begin
  SLAU.Destroy;
  Acoefs := nil;
  inherited Destroy;
end;

  {

procedure TapprAlgorythm.FillSlau;
  Begin
   interpol.FillSLAU;

  end;



   }



procedure TApprAlgorythm.Execute;
var i,a : integer;
begin
  FillSLAU;
  Acoefs := nil;
  {slau.size:=interpol.getSizeForalgoritm; }
  SetLength(Acoefs, SLAU.Size);
  a:=slau.size;
  slau.solve;
  if slau.Solved then begin
  for i := 0 to SLAU.Size - 1 do
     Acoefs[i] := SLAU.solution[i];

   end;
end;

function TApprAlgorythm.GetCoef(i: integer): real;
begin
  if i < ACoefCount then Result := Acoefs[i];
end;

{---------????????????------------}
{constructor TInteprolAlg.create(Data:Tdata);
begin
  inherited Create;
  self.Data := Data;
end;  } {
function TInteprolalg.getSizeForalgoritm:integer;

begin
result:=slau.size;
end;  }

procedure TInteprolAlg.FillSLAU;
var n, i, j : integer;
    x,a : real;
begin
//  if not data.PointsSetted then exit;
  n := Data.CountPoints;
  SLAU.Size := n;
  ACoefCount := n;
  for i := 0 to n-1 do SLAU.data[i,0] := 1;


  for i := 0 to n-1 do
  begin
    x := Data.GetX(i);
    for j := 1 to n-1 do SLAU.Data[i,j] := SLAU.Data[i,j-1] * x;
    SLAU.Data[i,n] := Data.gety(i);
  end;
end;
//-----------???---------------//
constructor TMNKalg.create(Data:Tdata;m_LV:integer);
begin
  inherited create(Data);
  M:= m_LV;

end;
function TMNKAlg.Power(x:real;Power_LV:integer):real;
var p:integer;LE_LV:real;
begin
LE_LV:=1;
for p:=0 to Power_LV do lE_LV:=x*LE_LV;
result:=LE_LV;
end;

procedure TMNKAlg.FillSLAU;
 var i,j,k,N,p: integer;
   LeftEquation, RE,lE_LV,RE_LV : real;
begin

 // if not data.PointsSetted then exit;
  N := Data.CountPoints;
  ACoefCount:=m;
  Slau.Size := M+1 ;


 

  for k := 0 to M do
  begin
    for j := 0 to M do
    begin
      LeftEquation := 0;
      re:=0;
      for i := 0 to N-1 do
          begin


               LeftEquation:= LeftEquation + self.Power(Data.GetX(i),j+k);

               SLAU.Data[k,j] := LeftEquation;

               RE := RE + data.gety(i) * self.Power(Data.GetX(i),k);

               SLAU.Data[k,m+1] := RE;

          end;


  end; end;
end;
destructor TMNKAlg.Destroy;
begin
end;
destructor TInteprolAlg.Destroy;
begin

end;
end.
