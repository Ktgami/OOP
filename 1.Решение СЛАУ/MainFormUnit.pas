unit MainFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GetSolutionUnit, StdCtrls, Menus, Grids, SizeFormUnit;

type
  TFormSLAU = class(TForm)
    CoeffTable: TStringGrid;
    MainMenu: TMainMenu;
    LabelError: TLabel;
    LabelErrorValue: TLabel;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Exit1: TMenuItem;
    System2: TMenuItem;
    Size1: TMenuItem;
    Random1: TMenuItem;
    Zeroing1: TMenuItem;
    Solve1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    XTable: TStringGrid;
    procedure Exit1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Save1Click(Sender: TObject);
    procedure Size1Click(Sender: TObject);
    procedure SlauToGrid;
    procedure GridToSlau;
    procedure Random1Click(Sender: TObject);
    procedure FillCoef(z:boolean);
    procedure Zeroing1Click(Sender: TObject);
    procedure Solve1Click(Sender: TObject);
    function  MyExceptSave:boolean;
    function  MyExceptOpen:boolean;
  private
    n: integer;
    S : TSLAU;
    procedure FillGrid( n:integer);
  public
    { Public declarations }
  end;

var
  FormSLAU: TFormSLAU;

implementation

{$R *.dfm}

procedure TFormSLAU.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormSLAU.FormCreate(Sender: TObject);
begin
  N := 1;
  S := TSLAU.Create(n);
  coeffTable.Visible := false;
  xtable.Visible := false;
  labelerror.Visible := false;
end;

procedure TFormSLAU.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  S.Destroy;
end;

procedure TFormSLAU.New1Click(Sender: TObject);
begin
  if SizeForm.Execute(n) then
    begin
      FillGrid(n);
      coeffTable.Visible := true;
      S.Size := n;
    end;
end;

procedure TFormSLAU.FillGrid(n:integer);
var i: integer;
begin
    CoeffTable.colcount := n+2;
    CoeffTable.rowcount := n+1;
    for I := 1 to n do
    begin
      CoeffTable.Cells[I,0] := IntToStr(i);
      CoeffTable.Cells[0,i] := IntToStr(i);
    end;
    CoeffTable.Cells[n+1,0] := IntToStr(n+1);
end;

procedure TFormSLAU.GridToSlau;
var i, j: integer;
begin
  for i := 1 to n+1 do
    for j := 1 to n do
      S[j-1,i-1] := StrToFloat(CoeffTable.Cells[i,j]);
end;

procedure TFormSLAU.SlauToGrid;
var i, j: integer;
begin
  for i := 1 to n+1 do
    for j := 1 to n do
      CoeffTable.Cells[i,j] := FloatToStr(S[j-1,i-1]);
end;

procedure TFormSLAU.Open1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    begin
      s.Loadfromtext(OpenDialog1.FileName);
      if not MyExceptOpen then
        begin
          showmessage('невозможно загрузить файл: недопустимые элементы');
          exit;
        end;
      
      coeffTable.Visible := true;
      n := S.Size;
      FillGrid(n);
      SlauToGrid;

    end;
end;

procedure TFormSLAU.Save1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
   begin
      if not MyExceptSave then
        begin
          showmessage('невозможно сохранить файл: недопустимые элементы');
          exit;
        end;
      GridToSlau;
      s.Save(SaveDialog1.FileName);
     end;


end;

procedure TFormSLAU.Size1Click(Sender: TObject);
begin
  if SizeForm.Execute(n) then
    begin
      s.Size := n;
      FillGrid(n);
    end;
end;

procedure TFormSLAU.Random1Click(Sender: TObject);
var z : boolean;
begin
  z := true;
  FillCoef(z);
  slautogrid;
end;

procedure TFormSLAU.FillCoef(z:boolean);
var i,j:integer;
begin
  randomize;
  if z then
   begin
     for i := 0 to n-1 do
        for j:=0 to n do
          s[i,j] := random(201)-100;
   end
  else
   for i := 0 to n-1 do
        for j:=0 to n do
          s[i,j] := 0;
end;

procedure TFormSLAU.Zeroing1Click(Sender: TObject);
var z : boolean;
begin
  z := false;
  FillCoef(z);
  slautogrid;
end;

procedure TFormSLAU.Solve1Click(Sender: TObject);
var i:integer;
begin
   xtable.RowCount := n+1;
      if not MyExceptSave then
        begin
          showmessage('невозможно решить систему: недопустимые элементы');
          exit;
        end;
   s.Gauss;
   if s.Solved then
   begin
     for i:=1 to n do xtable.Cells[0,i] := floattostr(s.solution[i-1]);
     Label1.Visible := false;
     xtable.Visible := true;
     labelerror.Visible := true;
     labelerrorvalue.Visible := true;
     labelerrorvalue.Caption := floattostr(s.gauss);
   end
   else
     begin
       label1.Visible := true;
       Label1.Caption := 'решение не найдено';
       labelerror.Visible := false;
       labelerrorvalue.visible := false;
       xtable.Visible := false;
     end;
end;

function TFormSLAU.MyExceptSave:boolean;
begin
  result := true;
  try
    gridtoslau;
  except
    result := false;
  end;
end;

function TFormSLAU.MyExceptOpen:boolean;
begin
  result := true;
  try
    slautogrid;
  except
    result := false;
  end;
end;

end.
