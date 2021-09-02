unit Legend;

interface

  uses Windows, LineList, Graphics, Line;

  type TLegend = class(TObject)
    private
      FLineList : TLineList;
      x1, x2, y1, y2 : integer;
      PosIsSet : boolean;
    public
      constructor Create (LineList : TLineList);
      procedure SetPosition(x1, x2, y1, y2: integer);
      procedure Drow (Canvas: TCanvas);
    end;
implementation

  {TLegend}

  constructor TLegend.Create(LineList : TLineList);
  begin
  Inherited Create;
  Flinelist:=Linelist;
  PosIsSet := false;
  end;

  procedure TLegend.SetPosition(x1, x2, y1, y2: integer);
    procedure Order(var x, y : integer);
      var Temp : integer;
    begin
     if x < y then exit;
      Temp := x;
      x := y;
      y := Temp;
    end;
  begin
  Order(x1, x2);
  Order(y1, y2);
  Self.x1:=x1;
  Self.y1:=y1;
  Self.x2:=x2;
  Self.y2:=y2;
  PosIsSet := true;
  end;

 procedure TLegend.Drow (Canvas: TCanvas);
 var
    Curline:TLine;
    i:integer;
    cntLine:integer;
    MyRgn: HRGN;
  Begin
   if not PosIsSet then exit;
   MyRgn := CreateRectRgn(x1,y1,x2,y2);
   SelectClipRgn(Canvas.Handle, MyRgn);
   Canvas.brush.color:=clgray;
   Canvas.Rectangle(x1,y1,x2,y2);
   cntLine:=FLineList.count;
   For i:=0 to cntLine-1 do
   begin
   CurLine:=TLine(FLineList.items[i]);
   Canvas.Pen.Color:= curline.Color;
   Canvas.TextOut(x1+50, y1+(i+1)*60, CurLine.Caption);
   Canvas.MoveTo(x1, y1+(i+1)*60);
   Canvas.LineTo(x1+25, y1+(i+1)*60);
   end;
   MyRgn := HRGN(nil);
   SelectClipRgn(Canvas.Handle, MyRgn);
   DeleteObject(MyRgn);
   
   end;



end.
