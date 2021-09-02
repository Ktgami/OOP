object Form1: TForm1
  Left = 270
  Top = 265
  Width = 1305
  Height = 675
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 1200
    object New1: TMenuItem
      Caption = 'File'
      object Save1: TMenuItem
        Caption = 'New'
      end
      object Save2: TMenuItem
        Caption = 'Save'
      end
      object Saveas1: TMenuItem
        Caption = 'Save as'
      end
      object Close1: TMenuItem
        Caption = 'Open'
      end
      object Close2: TMenuItem
        Caption = 'Close'
      end
      object N1: TMenuItem
        Caption = '___________'
      end
      object N11: TMenuItem
        Caption = '1'
      end
      object N21: TMenuItem
        Caption = '2'
      end
      object N31: TMenuItem
        Caption = '3'
      end
      object N2: TMenuItem
        Caption = '____________'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 1232
  end
  object SaveDialog1: TSaveDialog
    Left = 1264
  end
end
