object FormSLAU: TFormSLAU
  Left = 192
  Top = 114
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelError: TLabel
    Left = 160
    Top = 448
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
    Top = 448
    Width = 89
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object CoeffTable: TStringGrid
    Left = 144
    Top = 208
    Width = 305
    Height = 193
    ColCount = 4
    RowCount = 4
    TabOrder = 0
    ColWidths = (
      64
      70
      76
      73)
    RowHeights = (
      24
      50
      52
      52)
  end
  object SolutionTable: TStringGrid
    Left = 520
    Top = 208
    Width = 153
    Height = 193
    ColCount = 2
    RowCount = 4
    TabOrder = 1
    RowHeights = (
      24
      48
      54
      55)
  end
  object MainMenu: TMainMenu
    Left = 144
    Top = 40
    object ffff1: TMenuItem
      Caption = 'File'
      object New1: TMenuItem
        Caption = 'New'
        OnClick = New1Click
      end
      object Open1: TMenuItem
        Caption = 'Open'
      end
      object Save1: TMenuItem
        Caption = 'Save'
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
      end
      object Random1: TMenuItem
        Caption = 'Random'
      end
      object Zeroing1: TMenuItem
        Caption = 'Zeroing'
      end
      object Solve1: TMenuItem
        Caption = 'Solve'
      end
    end
  end
end
