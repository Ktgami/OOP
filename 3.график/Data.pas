unit Data;

interface

uses DiscretSet, Chart, PointRec, SysUtils, Classes;

type

TData=class(TDiscretSet)
 private
   points : TPointsList;
   function minX;
   function maxX;
   function GetCount:integer;
   function GetPoints:TPointsList;
   function  GetMas(i,j:integer):real;
   procedure SetMas(i,j:integer; z:real);
 public
   constructor Create(chart:TChart);
   destructor Destroy; override;
   procedure AddPoint (x,y :real);
   property Count:integer read GetCount;
   procedure Clear;
   property   DataMas[i,j:integer] : real  read GetMas write SetMas; default;
   procedure Save(filePath:string); override;
   procedure Load(filePath:string); override;
   procedure BuildLine; override;
   property PointsList : TPointsList read GetPoints;
end;

implementation

constructor TData.Create(chart:TChart);
begin
     inherited Create(chart);
     SetLength(self.points,0);
     id := 0;
end;


destructor TData.Destroy;
begin
  inherited Destroy;
end;
function TData.GetMas(i,j:integer):real;
begin
  GetMas := 0;
  if (i > 1) or (j > _PairCount-1) or (i < 0) or (j < 0) then exit;
  GetMas := _DataMas[i,j]; Point.X;
end;

procedure TData.SetMas(i,j:integer; z:real);
begin
  if (i > 1) or (j > _PairCount-1) or (i < 0) or (j < 0) then exit;
  _DataMas[i,j] := z;
  _Modified := true;
end;

procedure TData.AddPoint (x,y :real);
begin
     SetLength(self.points, Length(self.points)+1);
     self.points[High(self.points)] := TPointRec.Create(x,y);
end;
function Tdata.minX;
var min:real;
begin
min:=Self.points[1].x;
  for i:= 0 to Length(self.points)-1 do
       begin
         if Self.points[i].x<min then min:= Self.points[i].x;
//        x[i] := self.points[i].X;
//        y[i] := self.points[i].Y;

       end;
  result:=min;
end;

function Tdata.maxX;
var max:Real;
begin
max:=Self.points[1].x;
  for i:= 0 to Length(self.points)-1 do
       begin
         if Self.points[i].x>max then max:= Self.points[i].x;
//        x[i] := self.points[i].X;
//        y[i] := self.points[i].Y;

       end;
  result:=max;
end;
function TData.GetCount:integer;
begin
  GetCount := Length(self.points);
end;


procedure TData.Clear;
begin
     SetLength(self.points,0);
end;


procedure TData.Save(filePath:string);
var f: TFileStream;
    i: integer;
    val : real;
begin
     f := TFileStream.Create(filePath, fmCreate);
     for i:=0 to Length(self.points)-1 do
      begin
           val := self.points[i].X;
           f.WriteBuffer(val, sizeof(real));
           val := self.points[i].Y;
           f.WriteBuffer(val, sizeof(real));
      end;
     f.Free;
end;


procedure TData.Load(filePath:string);
var f: TFileStream;
x,y:real;
begin
     f := TFileStream.Create(filePath, fmOpenRead);
     while f.Position < f.Size do
     begin
          f.ReadBuffer(x, sizeof(real));
          f.ReadBuffer(y, sizeof(real));
          AddPoint(x,y);
     end;
end;


procedure TData.BuildLine;
var x,y:array of real;
      i:integer;
begin
     if (Not self.Plotted)
     then begin
      self.plottedField := true;
      SetLength(x, Length(self.points));
      SetLength(y, Length(self.points));
      for i:= 0 to Length(self.points)-1 do
       begin
        x[i] := self.points[i].X;
        y[i] := self.points[i].Y;
       end;
      self.id := ChartInstance.AddLine(x,y);
      ChartInstance.Invalidate;
     end
end;

function TData.GetPoints:TPointsList;
begin
     GetPoints := points;
end;

end.
