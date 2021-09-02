unit SLAU;

interface
uses classes,SysUtils;

type
TSLAU=class(TObject)
  private
    _A:array of array of real;
    _sA:array of array of real;
    _Size:integer;
    _Solved:boolean;
    _X:array of real;
    procedure SetSize(NewSize:integer);
    function GetData(i,j:integer):real;
    procedure SetData(i,j:integer; z:real);
    function GetSolution(i: integer): real;
    function CalcError: real;
    function ProvColl: boolean;
  public
    constructor Create(NewSize:integer);
    property Size:integer read _Size write SetSize;
    property Data[i,j:integer]:real read GetData write SetData; default;
    procedure Save(FName:string);
    function Load(FName:string): boolean;
    function Solve:real;
    property Solved:boolean read _Solved;
    property Solution[i:integer]:real read GetSolution;
    property Error: real read CalcError;
    destructor Destroy;
    
end;

implementation
//------------------------------------------------------------------------------
constructor TSLAU.Create(NewSize:integer);
  var n:integer;
begin
   inherited Create;
   SetSize(NewSize);
   _Solved := false;
end;
//------------------------------------------------------------------------------
destructor TSLAU.Destroy;
begin
   Finalize(_A);
   Finalize(_sA);
   Finalize(_X);
   inherited destroy;
end;
//------------------------------------------------------------------------------
procedure TSLAU.SetSize(NewSize:integer);
var
  i: integer;
begin
  if NewSize = _Size then exit;
  setlength(_A, NewSize);
  for i:=0 to NewSize-1 do
    SetLength(_A[i], NewSize+1);


  setlength(_sA, NewSize);
  for i:=0 to NewSize-1 do
    SetLength(_sA[i], NewSize+1);

  setlength(_X, NewSize);
  _Size := NewSize;
  _Solved := false;
end;
//------------------------------------------------------------------------------
function TSLAU.GetData(i,j:integer):real;
begin
  GetData := 0;
  if (i >= _Size) or (j > _size) or (i < 0) or (j < 0) then exit;
  GetData := _A[i,j];
end;
//------------------------------------------------------------------------------
procedure TSLAU.SetData(i,j:integer; z:real);
begin
  if (i >= _Size) or (j > _size) or (i < 0) or (j < 0) then exit;
  _A[i,j] := z;
end;
//------------------------------------------------------------------------------
function TSLAU.GetSolution(i: integer): real;
begin
  GetSolution := 0;
  if (i >= _Size) or (i < 0)then exit;
  GetSolution := _X[i];
end;
//------------------------------------------------------------------------------
function TSLAU.Solve:real;
var
  i,j,k: integer;
begin
  Solve := -1;
  _Solved:=False;
  for i := 0 to _size-1 do
    for j := 0 to _size do _sA[i,j] := _A[i,j];

  for i := 0 to _size-1 do
  begin
    If _sA[i,i]=0 then exit;
    for j := _size downto 0 do _sA[i,j] := _sA[i,j]/_sA[i,i];

    for j := i+1 to _size-1 do
      for k := _size downto i do _sA[j,k] := _sA[j,k]-_sA[i,k]*_sA[j,i];
  end;


  for i := _size-2 downto 0 do
    for j := i+1 to _size-1 do _sA[i,_size] := _sA[i,_size] - _sA[i,j]*_sA[j,_size];


  for i := 0 to _size-1 do _X[i] := _sA[i,_size];

  _solved := true;
  Solve := Error;
end;

//------------------------------------------------------------------------------
function TSLAU.CalcError: real;
var i,j:integer;
b, res: real;
max:real;
begin
 CalcError:=-1;
 if   _solved =false then exit;
 max:=0;
 res:=0;
 For i:=0 to size-1 do
  begin
  b:=-_A[i,size];
  For j:=0 to size-1 do
  b:=b + _X[j]*_A[i,j];
  res := abs(b);
  if max<res then max:=res;
  end;
 CalcError:=max;
end;
//------------------------------------------------------------------
procedure TSLAU.Save(FName:string);
var
  fstream: TFileStream;
  buf: byte;
  tStr: string;
  tNum: integer;
  i,j: integer;
begin
  fstream := TFileStream.Create(FName,fmCreate);
  fstream.Write(_size, sizeof(_size));

  for i := 0 to _Size-1 do
    for j:= 0 to _Size do
      fstream.Write(_A[i,j], sizeof(_A[i,j]));

//  for i := 0 to _Size-1 do fstream.Write(_X[i], sizeof(_X[i]));
  fstream.Free;
end;
//-------------------------------------------------------------
function TSLAU.Load(FName:string): boolean;
var
  fstream: TFileStream;
  _size: integer;
  i,j: integer;
  flag: boolean;
Begin
  Load := false;
  fstream := TFileStream.Create(FName,fmOpenRead);
  if fstream.Size < sizeof(integer) then exit;
  fstream.Read(_size,sizeof(integer));
  if sizeof(_size)+(_size*(_size+1))*sizeOf(real) <> fstream.Size then exit;
  SetSize(_size);
  for i := 0 to _Size-1 do
    for j:= 0 to _Size do
      fstream.Read(_A[i,j],sizeOf(real));
  fstream.Free;
  flag := false;
  //проверим диагональ
  for i := 0 to _size-1 do
    if (_A[i,i] <> 0) then flag := true;
  if not flag then exit;
  //проверим уравнения на коллинеарность
  if not ProvColl then Exit;
  Load := true;
end;
//---------------------------------------------------------------
function TSLAU.ProvColl: boolean;
var
  i,j,k: integer;
  coeff: real;
  flag: boolean;
Begin
  //Если станет true, все пропало.
  ProvColl := false;
  for i := 0 to _size - 2 do
    for j := i + 1 to _size -1 do
    Begin
      flag := false;
      coeff := _A[i,0] / _A[j,0];
      for k := 1 to _size do
        //Если значения коэффициентов хотя бы в одном в столбце не совпадают
        if (_A[i,k]<> _A[j,k]*coeff) then flag := true;
      if not flag then exit;
    End;
  ProvColl := true;
End;
//---------------------------------------------------------------




//------------------------------------------------------------------
end.



