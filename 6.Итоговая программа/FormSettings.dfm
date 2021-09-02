object Form2: TForm2
  Left = 746
  Top = 219
  Width = 455
  Height = 420
  Caption = 'FormSettings'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Widht: TLabel
    Left = 64
    Top = 200
    Width = 28
    Height = 13
    Caption = 'Widht'
  end
  object Color: TLabel
    Left = 64
    Top = 128
    Width = 25
    Height = 13
    Caption = 'Color'
  end
  object style: TLabel
    Left = 64
    Top = 248
    Width = 23
    Height = 13
    Caption = 'style'
  end
  object ComboBox1: TComboBox
    Left = 64
    Top = 160
    Width = 233
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      #1050#1088#1072#1089#1085#1099#1081
      #1095#1077#1088#1085#1099#1081
      #1079#1077#1083#1077#1085#1099#1081
      #1089#1080#1085#1080#1081)
  end
  object Edit1: TEdit
    Left = 64
    Top = 224
    Width = 217
    Height = 21
    TabOrder = 1
  end
  object ComboBox2: TComboBox
    Left = 64
    Top = 264
    Width = 217
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      'psSolid'
      'psDash'
      'psDot'
      'psDashDot')
  end
  object Button1: TButton
    Left = 64
    Top = 304
    Width = 113
    Height = 33
    Caption = 'ok'
    TabOrder = 3
    OnClick = Button1Click
  end
end
