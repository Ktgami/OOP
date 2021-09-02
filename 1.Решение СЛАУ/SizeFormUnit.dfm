object SizeForm: TSizeForm
  Left = 434
  Top = 336
  Width = 349
  Height = 219
  Caption = 'SizeForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 56
    Top = 136
    Width = 57
    Height = 33
    Caption = 'OK'
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 200
    Top = 136
    Width = 81
    Height = 33
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = CancelBtnClick
  end
  object CountSpin: TSpinEdit
    Left = 80
    Top = 24
    Width = 177
    Height = 22
    MaxValue = 1000
    MinValue = 1
    TabOrder = 2
    Value = 1
    OnKeyUp = CountSpinKeyUp
  end
end
