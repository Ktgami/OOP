unit PointRec;

interface

type

TPointRec=class(TObject)
private
   xCoord:real;
   yCoord:real;
   function GetX:real;
   function GetY:real;
   procedure SetX(value:real);
   procedure SetY(value:real);
public
   constructor Create(x:real; y:real);
   property X: real read GetX write SetX;
   property Y: real read GetY write SetY;
end;

TPointsList = array of TPointRec;

implementation

constructor TPointRec.Create(x:real; y:real);
begin
     self.xCoord := x;
     self.yCoord := y;
end;
function TPointRec.GetX:real;
begin
     GetX := self.XCoord;
end;

function TPointRec.GetY:real;
begin
     GetY := self.YCoord;
end;

procedure TPointRec.SetX(value:real);
begin
     XCoord := value;
end;

procedure TPointRec.SetY(value:real);
begin
     YCoord := value;
end;

end.
