unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,SLAU;

type
  ttMat=array of array of real;
  TFormTransMatrix = class(TForm)
    stringgrid1: TStringGrid;
    procedure FormShow(Sender: TObject);

  private
    p2mat:Tmat;
    { Private declarations }
  public
    constructor create(ppMat:tMat);

    { Public declarations }
  end;

var
  FormTransMatrix: TFormTransMatrix;

implementation
constructor TFormTransMatrix.create(ppMat:tMat);
var i,j:Integer;
begin
setlength(p2Mat, High(ppMat)+1);
  for i:=0 to High(ppMat)+1-1 do
    SetLength(p2Mat[i], High(ppMat)+1+1);

    for i := 0 to High(ppMat) do
    for j := 0 to High(ppMat)+1 do

p2Mat[i,j]:=ppmat[i,j];



//  for i := 1 to High(ppMat)+2 do
  //  for j := 1 to High(ppMat)+1  do
//    stringgrid1.cells[i,j]:=FloatToStr(ppmat[i-1,j-1]);


end;

{$R *.dfm}

procedure TFormTransMatrix.FormShow(Sender: TObject);
var i,j:integer;
begin
  stringgrid1.ColCount := High(p2Mat) + 2;
  stringgrid1.RowCount := High(p2Mat) + 2;
  for i := 1 to High(p2Mat)+1 do
   for j := 1 to High(p2Mat)+1  do
       stringgrid1.cells[i,j]:=FloatToStr(p2mat[j-1,i-1]);

end;

end.


