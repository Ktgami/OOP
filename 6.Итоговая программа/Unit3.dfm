object Form3: TForm3
  Left = 869
  Top = 318
  Width = 312
  Height = 329
  Caption = 'Form3'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 40
    Top = 16
    Width = 161
    Height = 21
    TabOrder = 0
    Text = '2'
  end
  object ComboBox1: TComboBox
    Left = 40
    Top = 56
    Width = 161
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Items.Strings = (
      'MNK'
      'Interpol')
  end
  object Button1: TButton
    Left = 48
    Top = 96
    Width = 153
    Height = 33
    Caption = 'ok'
    TabOrder = 2
    OnClick = Button1Click
  end
end
