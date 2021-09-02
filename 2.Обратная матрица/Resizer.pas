unit Resizer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TSizeForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    edit1: TEdit;
  private
     Ok:boolean;
  public
    Function Execute(var n:integer):boolean;{ Public declarations }
     Procedure Button1Click(Sender: TObject);
      procedure Button2Click(Sender: TObject);
  end;

var
  SizeForm: TSizeForm;

implementation

{$R *.dfm}
 Function TSizeForm.Execute(var n:integer):boolean;
begin
  OK := true;
  Edit1.text :=IntToStr(n);
  ShowModal;
  IF ok then
    begin
      n := StrToInt(Edit1.text);
      Execute:= true;
    end
  else
    Execute:= false;
end;

Procedure TSizeForm.Button1Click(Sender: TObject);
begin
 OK := true;
  close;
end;

procedure TSizeForm.Button2Click(Sender: TObject);
begin
  ok := false;
  close;
end;

end.
