unit Data;

interface

uses DiscretSet, Chart, PointRec, SysUtils, Classes,Graphics;

type

TData=class(TDiscretSet)
 private
   points : TPointsList;
   pointsetted:boolean;
   widht_LV:integer;
   Color_Lv:Tcolor;
   powerMNK:integer;
   function GetCount:integer;
   function GetPoints:TPointsList;
   function getpower:integer;
  // ID_LV:integer;
 //  function setID:integer;
 public
   property LineID : integer read GetLineID;
   constructor Create(chart:TChart);
   destructor Destroy; override;
   procedure AddPoint (x,y :real);
   property Count:integer read GetCount;
   property MNKPower:integer read getpower write powerMNK;
   procedure Clear;
   function maxX:real;
   function minX:real;
   function getcolor:Tcolor;
   procedure SetColor(Color_LV1:Tcolor);
   procedure setWidth(Width_lv1:integer);
   function getWidth:integer;
  // function getPOwerMNK:Integer;
   function CountPoints:Integer;
   function GetX(i:integer):real;
   function GetY(i:integer):real;
//   property PlottedAprox: boolean read plottedFieldAprox write SetPlotStateAprox;
   procedure Save(filePath:string); override;
   procedure Load(filePath:string); override;
   procedure BuildLine; override;
   property PointsList : TPointsList read GetPoints;
   property PointsSetted :boolean read  pointsetted;
 //  property ID_Dat:integer read ID_LV write setId;
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

function TData.GetX(i:integer):real;
begin
 result:=self.points[i].x
end;

function TData.CountPoints:integer;
begin
  result:=Length(self.points);
end;

function TData.GetY(i:integer):real;
begin
result:=self.points[i].Y;
end;

procedure TData.AddPoint (x,y :real);
begin
     SetLength(self.points, Length(self.points)+1);
     self.points[High(self.points)] := TPointRec.Create(x,y);

end;

function Tdata.minX;
var min:real;I:Integer;
begin
min:=self.points[0].x;
for i:=0 to Length(self.points)-1 do
begin
  if  self.points[i].X<min then min:= self.Points[i].x;
end;
result:=Min;
end;

function Tdata.maxX;
var min:real;i:Integer;
begin
min:=self.points[0].x;min:=Length(self.points);
for i:=0 to Length(self.points)-1 do
begin
  if  self.points[i].x>min then min:= self.Points[i].x;
end;
result:=Min;
end;

function TData.GetCount:integer;
var min:integer;
begin
 //min:=Length(self.points);
  result:= Length(self.points);
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
          pointsetted:=false;
          f.ReadBuffer(x, sizeof(real));
          f.ReadBuffer(y, sizeof(real));
          if (x<> 0)and (y <> 0) then pointsetted:=true;
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
function Tdata.getPOwer:integer;
begin
  result:=powerMNk;
end;
procedure Tdata.SetColor(Color_LV1:Tcolor);
begin
color_Lv:=Color_LV1;
end;
function Tdata.getcolor:Tcolor;
begin
result:=color_LV;
end;
procedure Tdata.setWidth(Width_lv1:integer);
begin
widht_LV:= Width_lv1;
end;
   function Tdata.getWidth:integer;
   begin
   result:= widht_LV;
   end;
end.
