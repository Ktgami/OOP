object FormSlau: TFormSlau
  Left = 460
  Top = 192
  Width = 872
  Height = 488
  BorderWidth = 1
  Caption = 'FormSlau'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 230
    Top = 400
    Width = 3
    Height = 13
  end
  object Label2: TLabel
    Left = 16
    Top = 400
    Width = 22
    Height = 13
    Caption = 'Error'
  end
  object Coeff: TStringGrid
    Left = 1
    Top = 0
    Width = 344
    Height = 209
    ColCount = 4
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
  end
  object result: TStringGrid
    Left = 352
    Top = 0
    Width = 137
    Height = 369
    ColCount = 2
    TabOrder = 1
  end
  object button1: TButton
    Left = 24
    Top = 224
    Width = 297
    Height = 113
    Caption = 'TransMatrix'
    TabOrder = 2
    OnClick = button1Click
  end
  object MainMenu1: TMainMenu
    Left = 776
    Top = 8
    object File1: TMenuItem
      Caption = 'File'
      object New1: TMenuItem
        Caption = 'New'
        OnClick = New1Click
      end
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = Open1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = Save1Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object System1: TMenuItem
      Caption = 'System'
      object Random1: TMenuItem
        Caption = 'Random'
        OnClick = Random1Click
      end
      object Solve1: TMenuItem
        Caption = 'Solve'
        OnClick = Solve1Click
      end
      object Size1: TMenuItem
        Caption = 'Size'
        OnClick = Size1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 800
    Top = 112
  end
  object SaveDialog1: TSaveDialog
    Left = 800
    Top = 64
  end
  object dlgSave1: TSaveDialog
    Left = 816
    Top = 192
  end
end
