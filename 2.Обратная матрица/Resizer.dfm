object SizeForm: TSizeForm
  Left = 1009
  Top = 354
  BorderStyle = bsDialog
  Caption = 'Size'
  ClientHeight = 221
  ClientWidth = 242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 40
    Width = 57
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 72
    Top = 40
    Width = 57
    Height = 25
    Cancel = True
    Caption = 'exit'
    ModalResult = 2
    TabOrder = 1
  end
  object edit1: TEdit
    Left = 16
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 2
  end
end
