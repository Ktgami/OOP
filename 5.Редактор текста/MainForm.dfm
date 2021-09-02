object Form1: TForm1
  Left = 427
  Top = 239
  Width = 1391
  Height = 758
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 80
    Top = 40
    object New1: TMenuItem
      Caption = 'File'
      object Save1: TMenuItem
        Caption = 'New'
        OnClick = Save1Click
      end
      object Save2: TMenuItem
        Caption = 'Save'
        OnClick = Save2Click
      end
      object Saveas1: TMenuItem
        Caption = 'Save as'
        OnClick = Saveas1Click
      end
      object Close1: TMenuItem
        Caption = 'Open'
        OnClick = Close1Click
      end
      object Last1: TMenuItem
        Caption = 'Last'
      end
      object Close2: TMenuItem
        Caption = 'Close'
        OnClick = Close2Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 112
    Top = 40
  end
  object SaveDialog1: TSaveDialog
    Left = 144
    Top = 40
  end
end
