unit stream;

interface

Type
  Tmas=array[1..1] of byte;

  TInStream = class(Tobject)
  private
    f : file;
    bsize : word;
    RSize : integer;
  public
    constructor Create(FileName : string);
    destructor Destroy; override;
    function GetByte(Var b : byte) : boolean;
  end;

  TOutStream = class(Tobject)
  private
    f : file;
    bsize,current : word;
    RSize : integer;
  public
    constructor create(FileName:string);
    destructor Destroy; override;
    procedure PutByte(b:byte);
  end;

Implementation

constructor TInStream.Create(FileName:string);
begin
  inherited create;
  assignfile(f,FileName);
  reset(f,1);
end;

destructor TInStream.Destroy;
begin
  closefile(f);
  inherited destroy;
end;

function TInStream.GetByte(var b : byte):boolean;
begin
  getbyte := false;
  blockread(f,b,1,RSize);
  If RSize = 0 then exit;
  getbyte := true;
end;


constructor TOutStream.Create(FileName:string);
begin
  inherited create;
  assignfile(f,FileName);
  rewrite(f,1);
end;

destructor TOutStream.Destroy;
begin
  closefile(f);
  inherited destroy;
end;

procedure TOutStream.PutByte(b : byte);
begin
  blockwrite(f,b,1,RSize);
 // if rsize = 0 then blockwrite(f,b,1,RSize);
end;

end.
