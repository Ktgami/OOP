unit GetSolutionUnit;

interface
uses stream;

type

TSLAU = class(TObject)
  private
    A  : array of array of real;
    X : array of real;
    InStream : TInStream;
    OutStream : TOutStream;
    _Size  : integer;
    _solved : boolean;
    procedure SetSize(NewSize:integer);
    function  GetData(i,j:integer):real;
    procedure SetData(i,j:integer; z:real);
    function  CalcError:real;
    function GetSolution(i : integer) : real;
  public
    constructor Create(NewSize:integer);
    property    Size:integer read _Size write SetSize;
    property    Data[i,j:integer] : real read GetData write SetData; default;
    property    Solved:boolean read _Solved;
    function    Gauss:real;
    property    Solution[i:integer]:real read GetSolution;
    procedure   Save(FName:string);
    procedure   Loadfromtext(FName:string);
    destructor  Destroy;
end;

implementation


constructor TSLAU.Create(NewSize:integer);
begin
   inherited Create;
   SetSize(NewSize);
end;

destructor TSLAU.Destroy;
begin
   Finalize(A);
   Finalize(X);
   inherited destroy;
end;

procedure TSLAU.SetSize(NewSize:integer);
var
  i : integer;
begin
  //if NewSize = _Size then exit;
  setlength(A, NewSize);
  setlength(x, NewSize);
  for i:=0 to NewSize-1 do SetLength(A[i], NewSize+1);
  _Size := NewSize;
end;

function TSLAU.GetData(i,j:integer):real;
begin
  GetData := 0;
  if (i > _size-1) or (j > _size) or (i < 0) or (j < 0) then exit;
  GetData := A[i,j];
end;

procedure TSLAU.SetData(i,j:integer; z:real);
begin
  if (i > _size-1) or (j > _size) or (i < 0) or (j < 0) then exit;
  A[i,j] := z;
end;

function TSLAU.GetSolution(i : integer) : real;
begin
  if (i > _size-1) or (i < 0)   then exit;
  //gauss;
  GetSolution := x[i];
end;



//Запись/загрузка из файла
/////////////////////////////////
procedure TSLAU.Save(FName:string);
var
  f : textFile;
  i,j : integer;
  RSize : integer;
begin
  AssignFile(f, FName);
  Rewrite(f);
  
  writeln(f, _size);
    for i := 0 to _Size-1 do
     begin
      for j := 0 to _Size do
        write(f,' ',a[i,j]);
      writeln(f);
     end;
  {if gauss >=0 then
    begin
      for i := 0 to _Size-1 do
      begin
        write(f,X[i]:10:3);
        write(f,' ');
      end;
      writeln(f); write(f,gauss:10:3);
    end
   else writeln(f,'no solution');
  }
  closefile(f);
end;

procedure TSLAU.Loadfromtext(FName:string);
var
  f : textFile;
  i, j, k, k1 : integer;
begin
  AssignFile(f, FName);
  reset(f);

  readln(f,_size);
  SetSize(_size);
  for i := 0 to _Size-1 do
    for j := 0 to _Size do read(f,a[i,j]);
  closefile(f);
end;


function TSLAU.Gauss : real;
var
  dA : array of array of real;
  i, j, k : integer;
begin
  for i:=0 to _size-1 do
    if a[i,i] = 0 then
      begin
        _solved := false;
        exit;
      end;

  _solved := true;
  setlength(DA, _Size);
  for i:=0 to _Size-1 do SetLength(DA[i], _Size+1);
  for i := 0 to _size-1 do
    for j := 0 to _size do da[i,j] := a[i,j];

  
  //прямой ход
for i := 0 to _size-1 do
 begin
   for j := _size downto 0 do
    begin
     if da[i,i] = 0 then exit;
     dA[i,j] := dA[i,j]/dA[i,i];
    end;
   for j := i+1 to _size-1 do
     for k := _size downto i do
       dA[j,k] := dA[j,k]-dA[i,k]*dA[j,i];
 end;

  //обратный ход
for i := _size-2 downto 0 do
  for j := i+1 to _size-1 do
    dA[i,_size] := dA[i,_size]-dA[i,j]*dA[j,_size];

  //получили решение в последнем столбце dA
for i := 0 to _size-1 do  X[i] := dA[i,_size];

result := calcerror;

end;


function  TSLAU.CalcError:real;
var
  i, j : integer;
  b, dx, dx1 : real;
begin
  dx := 0;

  for i := 0 to _size-1 do
   begin
   b := 0;
    for j := 0 to _size-1 do
      b := b + a[i,j]*x[j];
    dx1 := abs(b-a[i,_size]);
    if dx1 > dx then dx := dx1;
   end;
  result := dx;

end;


end.
