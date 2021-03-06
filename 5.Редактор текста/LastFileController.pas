unit LastFileController;

interface
Uses Forms, SysUtils,Menus;
 type
 TLastFileController=class(TObject)
 private
  AddMenuItem : TMenuItem;
  ConfFilePath : string;
  lastIndex:Integer;
  FileList:array [0..2] of string;
  procedure Define_ConfFilePath;
  procedure AddClear;
 public
   Count : integer;
  Constructor Create(AddMenuItem : TMenuItem);
  Procedure AddItem(FileName:string);
  Destructor Destroy; override;
  procedure ChangeName(old:string; new:string);
 end;

implementation

Constructor TLastFileController.Create(AddMenuItem : TMenuItem);
 var F : TextFile;
Begin
  Inherited Create;
  self.AddMenuItem := AddMenuItem;
  Define_ConfFilePath;
  Count := -1;
  assignFile(F, ConfFilePath);
  reset(F);
  lastIndex:=2;
  while (not eof(F))and (Count < 3) do
  begin
    inc(Count);
    readln(F, FileList[Count]);
  end;
  closeFile(F);
  AddClear;
end;

procedure TLastFileController.Define_ConfFilePath();
Var i:integer; handler:Integer;
begin
  ConfFilePath := Application.ExeName;
  i:= length(ConfFilePath);
  while (i > 1) and (ConfFilePath[i] <> '\') do dec(i);
  Delete(ConfFilePath, i+1, length(ConfFilePath)-i);
  ConfFilePath := ConfFilePath + 'conf.dat';
  if not FileExists(ConfFilePath) then
  begin
    handler:=  FileCreate(ConfFilePath);
    FileClose(handler);
  end;
end;

Procedure TLastFileController.AddItem(FileName:string);
Var
  FoundedItem:integer;  i:Integer;
Begin
  FoundedItem:=-1;
  For i:=0 to Count-1 do
   If FileList[i]=FileName then
    Begin
     FoundedItem:=i;
     break;
    end;
  if FoundedItem <> -1 then
    begin
      for i:= FoundedItem to (Count-2) do FileList[i]:= FileList[i+1];
      FileList[Count-1]:= FileName;
    end;
  if (Count=3) and (FoundedItem=-1)  then
    begin
      for i:= 0 to Count-2 do FileList[i]:=FileList[i+1];
      FileList[Count-1]:= FileName;
    end;
     if (Count<3) and (FoundedItem=-1)  then
    begin
      FileList[Count]:= FileName;
      inc(count);
    end;
  AddClear;

end;

Destructor TLastFileController.Destroy;
 var F : TextFile;
     i : integer;
Begin
  assignFile(F, ConfFilePath);
  rewrite(F);
  for i := 0 to 2 do
      writeln(F, FileList[i]);
  closeFile(F);
  Inherited Destroy;
end;

procedure TLastFileController.ChangeName(old:string; new:string);
var i:Integer;
begin
  for i:=0 to 2 do begin
    if FileList[i]=old then FileList[i]:=new;
  end;
end;

procedure TLastFileController.AddClear;
var i:integer;
begin
  AddMenuItem.Clear;
  for i :=0 to count-1 do
    Begin
       AddMenuItem.Add(TMenuItem.Create(AddMenuItem));
       AddMenuItem.items[i].Caption :=FileList[i];
    end;
end;



end.
 