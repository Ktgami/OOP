unit Chart;

interface
  uses Line, LineList, Scaler, Graphics, Legend, Types, ExtCtrls, FormSettings;

  type

  TChart = class(TObject)
    protected
      FScaler : TScaler;
      FLineList : TLineList;
      FCanvas : TCanvas;
      FLegend : TLegend;
      FGridOn : boolean;
      width_Lv:integer;
      FLegendOn : boolean;
      FX1: integer;
      FX2: integer;
      FY1: integer;
      FY2: integer;
      Bitmap:TBitMap;
      pictureBox:TPaintBox;
      procedure SwitchLegend(_LegendOn:boolean);
    public
      constructor Create(paintBox:TPaintBox);
      destructor Destroy;
      procedure Settings(id:integer);
      procedure SetSettings(id:integer);
      procedure SetOutPort(canvas:TCanvas; x1, y1, x2, y2: integer);
      procedure Drow;

      procedure DelLine (id: integer);
      function AddLine(x, y: array of real): integer;
      property GridOn: boolean read FGridOn write FGridOn;
      property LegendOn: boolean read FLegendOn write SwitchLegend;
      Procedure Scale (xe :integer; coef :integer);
      procedure Invalidate;
    end;

implementation

constructor TChart.Create(paintBox:TPaintBox);
 begin
    FScaler := TScaler.Create;
    FLineList := TLineList.Create(FScaler);
    FGridOn := true;
    FLegendOn := true;
    FLegend:=TLegend.Create(FLineList);
    BitMap:=Graphics.TBitMap.Create;
    pictureBox := paintBox;
  end;

  procedure TChart.SetOutPort(canvas:TCanvas; x1, y1, x2, y2: integer);
  begin
    Fx1 := x1;
    Fx2 := x2;
    Fy1 := y1;
    Fy2 := y2;
    FCanvas := canvas;
    BitMap.Width:=abs(x2-x1);
    BitMap.Height:=abs(y2-y1);
    SwitchLegend(FLegendOn);
 end;

  procedure TChart.Drow;
    var i: integer;
        XMax, XMin, YMax, YMin: real;
        curLine : TLine;
    begin
    BitMap.Canvas.Brush.Color := clWhite;
    BitMap.Canvas.FillRect(Rect(Fx1,Fy1,Fx2,Fy2));

    if FGridOn then
      FScaler.DrowGrid(BitMap.Canvas);

    if FLegendOn then FLegend.Drow(BitMap.Canvas);
    FLineList.Plot(BitMap.Canvas);

    FScaler.FixClipRect(BitMap.Canvas);
    FLinelist.Plot(BitMap.Canvas);
    FScaler.ReleaseClipRect(BitMap.Canvas);
    FCanvas.CopyRect(Rect(Fx1,Fy1,Fx2,Fy2),BitMap.Canvas,Rect(Fx1,Fy1,Fx2,Fy2));
    FCanvas.Draw(0,0,BitMap);
  end;

 Procedure TChart.Scale (xe :integer; coef :integer);
 begin
   FScaler.Scale(xe,coef);
   Drow;
 end;



function TChart.AddLine(x, y: array of real): integer;
Var id:integer;
  Begin
 // width_Lv:=wid_LV;
  //FLineList := TLineList.Create(FScaler);
  ID:=Self.FLineList.addline(x,y);
  AddLine:=ID;
  end;
procedure Tchart.SetSettings(id:integer);
var
  Line_Lv:Tline;
begin
 line_lv:=flinelist.getline(id);


 line_LV.Color:=form2.getcolor;
  line_LV.widht:=form2.GetWidht;
  line_lv.Style:=form2.getstyle;
 drow;
end;

procedure Tchart.Settings(id:integer);
var
  Line_Lv:Tline;
begin
  line_lv:=flinelist.getline(id);
  form2.setColor(line_Lv.Color);
  form2.setwidht(line_Lv.widht);
  form2.SetStyle(line_LV.Style);

 // ...
  Form2.ShowModal;

  line_LV.Color:=form2.getcolor;
  line_LV.widht:=form2.GetWidht;
  line_lv.Style:=form2.getstyle;

 // ...

  Drow;
end;

  procedure TChart.DelLine (id: integer);
  begin
    FLineList.DelLine(id);
  end;

  destructor TChart.Destroy;
  Begin
  FLinelist.Destroy;
  FScaler.Destroy;
  end;

procedure TChart.SwitchLegend(_LegendOn:boolean);
Begin
If _LegendOn then
Begin
FScaler.SetScreenBounds(Fx1, Fx2-200, Fy1, Fy2);
FLegend.SetPosition(Fx2 - 190, Fx2, Fy1, Fy2);
end
else  FScaler.SetScreenBounds(Fx1, Fx2, Fy1, Fy2);
FLegendOn:=_LegendOn;
end;

procedure TChart.Invalidate;
begin
     pictureBox.Invalidate;
end;

end.
