unit SizeFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TSizeForm = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    CountSpin: TSpinEdit;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure CountSpinKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    OK: boolean;
  public
    Function Execute(var n:integer):boolean;
  end;

var
  SizeForm: TSizeForm;

implementation

{$R *.dfm}

Function TSizeForm.Execute(var n:integer):boolean;
begin
  OK := false;
  CountSpin.Value := n;
  ShowModal;
  IF ok then
    begin
      n :=  CountSpin.Value;
      result := true;
    end
  else
    result := false;
end;


procedure TSizeForm.OKBtnClick(Sender: TObject);
begin
  OK := true;
  close;
end;

procedure TSizeForm.CancelBtnClick(Sender: TObject);
begin
  ok := false;
  close;
end;

procedure TSizeForm.CountSpinKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    begin
      OK := true;
      close;
    end;
end;

end.
