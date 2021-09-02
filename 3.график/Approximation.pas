unit Approximation;

interface

 uses  DiscretSet, Data, Chart,SLAU;

 type

 TApproximation= class (TDiscretSet)
 private
   Actual : boolean;
   Data : TData;
 public
   Constructor Create (Data : TData; Chart:TChart);
   Destructor Destroy; override;
   Procedure Approximate;
   procedure BuildLine; override;
 end;
  Tappalgoritm= class (TdescretSet)
  private
  public
    procedure approximate;
    constructor Create;
    destructor destroy;
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

 Procedure TApproximation.Approximate;
 Begin
 end;

procedure TApproximation.BuildLine;
var x,y:array of real;
      i, N:integer;
begin
     if (Not self.Plotted)
     then begin
      N := 10;
      self.plottedField := true;

        max:=Data.maxX;
        min:=Data.minX ;
        h := (max-min) / (N-1);
        for i := 0 to N-1 do
          begin
            x[i] := a + h * i;
            y[i] := 0;
            StX := 1;
            for j := 0 to ACoefCount-1 do   ///n-1 do
            begin
              y[i] := y[i] + ACoefs[j] * p;
        //РАЗБИТЬ ЭТО ВСЕ НА 2 КЛАССА  АПП АЛГОРИТМЕ будут находится коофиценты уравнения В ИНтерполяции будет заполнятся матрица по Х Acoefcount=кол-во  уравнений
              p :=p  * x[i];
            end;
          end;
      self.id := ChartInstance.AddLine(x,y);
      ChartInstance.Invalidate;
      x := nil;
      y := nil;
     end;
end;

end.
