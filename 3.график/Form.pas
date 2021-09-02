unit Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    New1: TMenuItem;
    Save1: TMenuItem;
    Save2: TMenuItem;
    Saveas1: TMenuItem;
    Close1: TMenuItem;
    Close2: TMenuItem;
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
