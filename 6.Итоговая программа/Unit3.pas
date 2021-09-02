unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
   function GetAproxType:string;
   function GetMNKPOwer:Integer;
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

 function Tform3.GetAproxType:string;
 begin
  result:= ComboBox1.Text;
 end;

 function Tform3.GetMNKPOwer:Integer;
begin
 Result:=StrToInt(edit1.text);
end;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
close;
end;

end.
 