object FormSLAU: TFormSLAU
  Left = 240
  Top = 205
  Width = 870
  Height = 640
  Caption = #1056#1077#1096#1077#1085#1080#1077' '#1057#1051#1040#1059
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelError: TLabel
    Left = 160
    Top = 472
    Width = 206
    Height = 24
    Caption = #1055#1086#1075#1088#1077#1096#1085#1086#1089#1090#1100' '#1088#1077#1096#1077#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelErrorValue: TLabel
    Left = 408
    Top = 472
    Width = 5
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 160
    Top = 472
    Width = 4
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object CoeffTable: TStringGrid
    Left = 40
    Top = 104
    Width = 601
    Height = 329
    ColCount = 6
    RowCount = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ColWidths = (
      64
      70
      76
      73
      64
      64)
    RowHeights = (
      24
      25
      24
      26)
  end
  object XTable: TStringGrid
    Left = 664
    Top = 104
    Width = 153
    Height = 265
    ColCount = 1
    FixedCols = 0
    RowCount = 4
    TabOrder = 1
  end
  object MainMenu: TMainMenu
    Left = 8
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
    object System2: TMenuItem
      Caption = 'System'
      object Size1: TMenuItem
        Caption = 'Size'
        OnClick = Size1Click
      end
      object Random1: TMenuItem
        Caption = 'Random'
        OnClick = Random1Click
      end
      object Zeroing1: TMenuItem
        Caption = 'Zeroing'
        OnClick = Zeroing1Click
      end
      object Solve1: TMenuItem
        Caption = 'Solve'
        OnClick = Solve1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 80
    Top = 16
  end
  object SaveDialog1: TSaveDialog
    Left = 80
    Top = 72
  end
end
