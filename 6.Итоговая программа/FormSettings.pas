unit FormSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Widht: TLabel;
    Color: TLabel;
    ComboBox2: TComboBox;
    style: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
  public
    { Public declarations }
   function GetAproxType:string;
   function GetMNKPOwer:integer;
   function getcolor:Tcolor;
   function GetWidht:integer;
   procedure setColor(Color_LV:Tcolor);
   procedure setwidht(widht_LV:integer);
   function getstyle:Tpenstyle;
   procedure SetStyle(Style_Lv:TPenStyle);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
function Tform2.getstyle:Tpenstyle;
begin
 if combobox2.text='psSolid' then result:=psSolid;
  if combobox2.text='psDash' then result:=psDash;
   if combobox2.text='psDot' then result:=psDot;
    if combobox2.text='psDashDot' then result:=psDashDot;
end;
procedure Tform2.SetStyle(Style_LV:Tpenstyle);
begin
 //  Gstyle:=  combobox2.text;
   if Style_LV=psSolid then  combobox2.text:='psSolid';
   if Style_LV=psDash then  combobox2.text:='psDash'  ;
    if Style_LV=psDot then  combobox2.text:='psDot' ;
     if Style_LV=psDashDot then  combobox2.text:='psDashDot' ;
end;
 function Tform2.GetAproxType:string;
 begin
//   result:=cbb1.Text;
 end;

function Tform2.GetMNKPOwer:Integer;
begin
 // Result:=StrToInt(edt1.text);
end;
function Tform2.Getcolor:Tcolor;
begin

 if combobox1.text='Красный' then result:=clred;
 if combobox1.text='зеленый' then result:=clgreen;
 if combobox1.text='черный' then result:=clblack;
 if combobox1.text='синий' then result:=clblue;
end;
function Tform2.GetWidht:integer;
begin
result:=strtoint(Edit1.text);
end;
 procedure Tform2.setColor(Color_LV:Tcolor);
 begin
 if Color_LV=clred  then combobox1.text:='Красный';
 if Color_LV=clgreen  then combobox1.text:='зеленый';
 if color_LV=clblack  then combobox1.text:='черный';
 if color_LV=clblue  then combobox1.text:='синий' ;
 end;
 procedure Tform2.setwidht(widht_LV:integer);
 begin
   edit1.Text:= inttostr(widht_LV);
 end;
procedure TForm2.Button1Click(Sender: TObject);
begin
close;
end;

end.
