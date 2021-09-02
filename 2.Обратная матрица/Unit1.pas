unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, ExtCtrls,SLAU,Resizer,TransMatrixUnit;

type
  TFormSlau = class(TForm)
    Coeff: TStringGrid;
    Result: TStringGrid;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Exit1: TMenuItem;
    System1: TMenuItem;
    Random1: TMenuItem;
    Solve1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    dlgSave1: TSaveDialog;
    Size1: TMenuItem;
    button1: TButton;
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormToSlau;
    procedure SlauToForm;
    procedure SolutionToForm;
    procedure PrepareForm;
    procedure New1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Random1Click(Sender: TObject);
    procedure Solve1Click(Sender: TObject);
    procedure Size1Click(Sender: TObject);
    procedure button1Click(Sender: TObject);
  private
    b:TSLAU;
    size: integer;
  public
    { Public declarations }
  end;

var
  FormSlau: TFormSlau;

implementation

{$R *.dfm}

procedure TFormSlau.Exit1Click(Sender: TObject);
begin
Close;
end;

procedure TFormSlau.FormCreate(Sender: TObject);
begin
  size := 2;
  b:=Tslau.Create(size);
  prepareform;
end;

procedure TFormSlau.FormDestroy(Sender: TObject);
begin
  b.Destroy;
end;

procedure TFormSLAU.FormToSlau;
var i, j: integer;
begin
  for i := 1 to b.Size+1 do
    for j := 1 to b.Size do
      b.data[j-1,i-1] := StrToFloat(Coeff.Cells[i,j]);
end;

procedure TFormSLAU.SlauToForm;
var i, j: integer;
begin
  for i := 1 to b.Size+1 do
    for j := 1 to b.Size do
      Coeff.Cells[i,j] := FloatToStr(b.Data[j-1,i-1]);
end;

procedure TFormSLAU.SolutionToForm;
var i: integer;
begin
  for i := 1 to b.Size do
    Result.Cells[1,i] := FloatToStr(b[i-1]);
end;

procedure TFormSLAU.PrepareForm;
var
  i,j: integer;
begin
  Coeff.ColCount := b.Size + 2;
  Coeff.RowCount := b.Size + 1;
  Result.RowCount := b.Size + 1;

  for i := 1 to b.Size do
    Coeff.Cells[i,0] := 'X'+inttostr(i);

  Coeff.Cells[b.Size+1,0] := '-';
  Result.Cells[1,0] := 'X';

  for i := 1 to b.Size + 1 do
  Begin
    for j := 1 to b.Size  do
      Coeff.Cells[i,j] := '';
    Result.Cells[1,i] := '';
  End;
end;

procedure TFormSlau.New1Click(Sender: TObject);
begin
  b.Size := size;
  prepareform;
end;

procedure TFormSlau.Open1Click(Sender: TObject);
Var a:boolean;
  begin
  if (OpenDialog1.Execute) then
  try
    a:=b.Load(OpenDialog1.FileName);
  except
    on EFOpenError do begin showmessage('ошибка открытия файла'); exit;    end;
  end;
  prepareform;
  try
    SLAUToForm;
  except
    showmessage('не верные значения файла');
  end;
end;

procedure TFormSlau.Save1Click(Sender: TObject);
begin
  if (SaveDialog1.Execute) then
    try
      FormToSLAU;
      b.Save(SaveDialog1.FileName);
    except
      showmessage('недопустимые символы ');
    end;

end;


procedure TFormSlau.Random1Click(Sender: TObject);
var
  i,j: integer;
begin
      label1.caption := '';
  randomize;
  for i := 1 to b.Size + 1 do
    for j := 1 to b.Size  do
      Coeff.Cells[i,j] := inttostr(random(100));
  for i := 1 to b.size do Result.cells[1,i] := '0';
end;

procedure TFormSlau.Solve1Click(Sender: TObject);
var error : real;
begin



   try
     formtoslau;
     error := b.solve;
   except

     on EConvertError do showmessage('недопустимые символы ');
    // showmessage('недопустимые символы ');
   end;
   if  error = -1 then
   begin
    label1.caption := 'не решено';
    exit;
   end;
   Label1.Caption := floattostr(error);
   SolutionToForm;
 end;

procedure TFormSlau.Size1Click(Sender: TObject);
var LV_Temp_size:Integer;
begin
 TSizeForm.Create(Sizeform);
 LV_Temp_size:=b.size;
  if SizeForm.Execute(LV_Temp_size) then
    begin
      b.Size:=LV_Temp_size;
        prepareform;
    end;
end;

procedure TFormSlau.button1Click(Sender: TObject);
var LA_Temp_Mat:tMat; i,j:integer;
LA_Temp2_Mat:tmat;
begin
  setlength(LA_Temp2_Mat, b.size);
  for i:=0 to b.Size-1 do
    SetLength(LA_Temp2_Mat[i], b.Size+1);

  for i:=0 to b.size-1 do
    for j:=0 to b.size-1 do
     LA_Temp2_Mat[i,j]:=b.data[i,j];
   b.transMatrix(LA_Temp2_Mat,b.size,LA_Temp_Mat);

  //TForm2.create(LA_Temp_mat);
   FormTransMatrix.create(LA_Temp_mat);
    FormTransMatrix.ShowModal;



end;

end.
