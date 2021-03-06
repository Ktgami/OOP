unit DataUnit;

interface
uses Classes, SysUtils, DataSetUnit, ChartUnit, LineUnit;

type

TData = class(TDataSet) //? ????? ??????? ??? ? ? ????? ??? ?
  private
    _DataMas : array of array of real;
    _PairCount : integer;
//   _Plotted : boolean;
    DataFileName : string;
//    ID : integer;
    _Modified : boolean;
    function  GetMas(i,j:integer):real;
    procedure SetMas(i,j:integer; z:real);
    procedure SetPairCount(z : integer);
    procedure SetPlotted(z : boolean);
    procedure  BuildLine; override;
    function GetMinX : real;
    function GetMaxX : real;
  public
    constructor create(Chart : TChart);
    destructor Destroy;
    Procedure  DataToFile(DataFileName : string);
    procedure  FileToData(DataFileName : string);
    property   DataMas[i,j:integer] : real  read GetMas write SetMas; default;
    property   PairCount : integer read _PairCount write SetPairCount;
  //  property   Plotted : boolean read _Plotted write SetPlotted;
    procedure  Clear;
    property   Modified : boolean read _Modified;
    property MinX : real  read GetMinX;
    property MaxX : real  read GetMaxX;
end;

implementation

constructor TData.create(Chart : TChart);
begin
  inherited create(Chart);
  _DataMas := nil;
  _Plotted := false;
//  ID := -1;
  _Modified := false;
end;

destructor TData.Destroy;
begin
  Finalize(_DataMas);
  inherited destroy;
end;

procedure TData.Clear;
begin
  _PairCount := 0;
  SetLength(_DataMas, 0);
end;

function TData.GetMas(i,j:integer):real;
begin
  GetMas := 0;
  if (i > 1) or (j > _PairCount-1) or (i < 0) or (j < 0) then exit;
  GetMas := _DataMas[i,j];
end;

procedure TData.SetMas(i,j:integer; z:real);
begin
  if (i > 1) or (j > _PairCount-1) or (i < 0) or (j < 0) then exit;
  _DataMas[i,j] := z;
  _Modified := true;
end;

procedure TData.SetPlotted(z : boolean);
begin
  _Plotted := z;
end;

procedure TData.SetPairCount(z : integer);
var i:integer;
begin
  _PairCount := z;
  SetLength (_DataMas,2);
    for i:=0 to 1 do SetLength(_DataMas[i],_PairCount);
  _DataMas[0,_PairCount-1] := 0;
  _DataMas[1,_PairCount-1] := 0;
end;

procedure TData.FileToData(DataFileName : string);
  var i,j,PairCount:integer;
      Stream : TFileStream;
begin
  Stream := TFileStream.Create (DataFileName, fmOpenRead);
  Stream.Read(_PairCount, SizeOf(real));
  SetPairCount(_PairCount);
  for i:=0 to 1 do
    for j:=0 to _PairCount-1 do
      Stream.Read(_DataMas[i,j],SizeOf(real));
  Stream.Destroy;
end;


Procedure TData.DataToFile(DataFileName : string);
  var i, j :integer;
      Stream : TFileStream;
begin
  Stream := TFileStream.Create (DataFileName, fmCreate);
  Stream.Write(PairCount,SizeOf(real));
  for i := 0 to 1 do
      for j := 0 to PairCount - 1 do
         Stream.Write(_DataMas[i,j],SizeOf(real));
  Stream.Destroy;
  _Modified := false;
end;

procedure TData.BuildLine;
var x,y:array of real;
    i : integer;  
begin
 { if not _Plotted then
    begin
      Chart.DelLine(ID);
      exit;
    end;
  if (_Plotted)and(ID <>-1)
      then Chart.DelLine(ID);  }
  SetLength(x,_PairCount);
  SetLength(y,_PairCount);
  if _PairCount = 0 then exit;
  for i := 0 to _PairCount-1 do
    begin
      x[i] := _DataMas[0,i];
      y[i] := _DataMas[1,i];
    end;
  LineID := Chart.AddLine(x,y);    //
  (Chart.GetLine(LineID)).Dotted := true;
  Chart.Draw;
  x := nil;
  y := nil;
end;



function TData.GetMaxX: real;
var i:integer;
begin
  result := _DataMas[0,0];
  for i:=0 to paircount-1 do
      if _DataMas[0,i] > result then result := _dataMas[0,i];
end;

function TData.GetMinX: real;
var i:integer;
begin
  result := _DataMas[0,0];
  for i:=0 to paircount-1 do
      if _DataMas[0,i] < result then result := _dataMas[0,i];
end;

end.
