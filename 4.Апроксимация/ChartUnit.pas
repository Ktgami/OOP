unit ChartUnit;

interface

 uses Graphics, Contnrs, LineUnit, Classes, SysUtils, Windows, Controls;

 type

    TLegend = class(Tobject)
     private
       Lx1,Ly1,Lx2,Ly2 : integer;
       LineList : TLineList;
     public
       constructor create(LineList : TLineList);
       destructor Destroy; override;
       procedure SetPosition(x1,y1,x2,y2 : integer);
       procedure Draw(Canvas : TCanvas);
       function GetLineID(x,y:integer):integer;
    end;

   TChart = class(Tobject)
     private
       LineList : TLineList;
       Scaler : TScaler;
       Legend : TLegend;
       Canvas : TCanvas;
       BitMap : Graphics.TBitMap;
       x1, y1, x2, y2 : integer;
       procedure Refresh;
     public
       constructor Create;
       destructor Destroy;  override;
       procedure SetOutPort(Canvas : TCanvas; x1,y1,x2,y2 : integer);
       procedure Draw;
       function AddLine(x,y:array of real):integer;
       procedure DelLine(ID : integer);
       procedure Scale(xe, coef : integer);
       function GetLine(LineID: integer) : TLine;
       function CGetLineID(x,y:integer):integer;
   end;



implementation
////////////////////////////////TLegend///////////////////////////////////////

constructor TLegend.create(LineList : TLineList);
begin
  inherited create;
  Lx1 := 0;
  Ly1 := 0;
  Lx2 := 0;
  Ly2 := 0;
  self.LineList := LineList;
end;

destructor TLegend.Destroy;
begin
  inherited destroy;
end;

procedure TLegend.SetPosition(x1,y1,x2,y2 : integer);
begin
  Lx1 := x1;
  Ly1 := y1;
  Lx2 := x2;
  Ly2 := y2;
end;

procedure TLegend.Draw(Canvas : TCanvas);
var i : integer;
    L : TLine;
begin
  Canvas.Pen.Color := clBlack;
  Canvas.Pen.Width := 1;
  Canvas.Pen.Style := psSolid;
  Canvas.Rectangle(Lx1, Ly1, Lx2, Ly2);
  for i := 0 to LineList.count-1 do
    begin
      L := TLine(LineList.Items[i]);
      Canvas.TextOut(LX1 + 10, LY1 + (i+1)*20, L.Name);
      Canvas.Pen.Color := L.Color;
      Canvas.Pen.Width := L.Width;
      Canvas.Pen.Style := L.Style;
      Canvas.LineTo(Lx1 + 100, LY1 + (i+1)*20);
    end;
end;

function TLegend.GetLineID(x,y:integer):integer;
  var i : integer;
      L : TLine;
begin
  GetLineID := -1;
  if ((x < Lx1) and (x > Lx2) and (y < Ly1) and (y > Ly2))
  then exit;
  i := round((y - Ly1 - 20) / 20);
  if ((i > LineList.Count) or (i<0)) then exit;
  L := TLine(LineList.Items[i]);
  GetLineID := L.ID;
end;

{---------------------TChart-------------------------}

constructor TChart.Create;
begin
  inherited create;
  BitMap := Graphics.TBitMap.Create;
  Scaler := TScaler.Create;
  LineList := TLineList.Create(Scaler, Refresh);
  //Legend := TLegend.Create(LineList);
end;

destructor TChart.Destroy;
begin
  Scaler.Destroy;
  LineList.Destroy;
  //Legend.Destroy;
  BitMap.Free;
  inherited destroy;
end;

procedure TChart.SetOutPort(Canvas : TCanvas; x1,y1,x2,y2 : integer);
begin
  self.Canvas := Canvas;
  self.X1 := x1;
  self.Y1 := Y1;
  self.X2 := x2;
  self.Y2 := Y2;
  BitMap.Width := abs(x2-x1);
  BitMap.Height := abs(y2-y1);
  Scaler.SetScreenBounds(X1+10, Y1+10, X2 - 10, Y2-10);
  //Scaler.SetScreenBounds(X1+10, Y1+10, X2 - 250, Y2-10);
  //Legend.SetPosition(x2 - 240, y1+10, x2-10, y2-10);
end;

procedure TChart.Draw;
begin
 try
  BitMap.Canvas.Brush.Color := clWhite;
  BitMap.Canvas.FillRect(Rect(x1,y1,x2,y2));
  Scaler.DrawField(BitMap.Canvas);
  Scaler.Net(BitMap.Canvas);
  //Legend.Draw(BitMap.Canvas);
  Scaler.FixClipRect(BitMap.Canvas);
  LineList.Plot(BitMap.Canvas);
  Scaler.FreeClipRect(BitMap.Canvas);
  Canvas.CopyRect(Rect(x1, y1, x2, y2), BitMap.Canvas, Rect(x1, y1, x2, y2));
 except
 end;
end;

function TChart.AddLine(x,y:array of real):integer;
begin
  AddLine := LineList.AddLine(x,y);
end;

procedure TChart.DelLine(ID : integer);
begin
  LineList.DelLine(ID);
  Draw;
end;

procedure TChart.Scale(xe, coef : integer);
begin
  Scaler.Scale(xe, coef);
  Draw;
end;

function TChart.GetLine(LineID: integer) : TLine;
begin
  GetLine := LineList.Get(LineID);
end;

procedure TChart.Refresh;
begin
  Draw;
end;

function TChart.CGetLineID(x,y:integer):integer;
begin
  CGetLineID := Legend.GetLineID(x,y);
end;

end.
