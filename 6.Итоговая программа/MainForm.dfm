object Form1: TForm1
  Left = 204
  Top = 222
  Width = 760
  Height = 655
  Caption = 'Graph Editor'
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
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 329
    Top = 0
    Width = 423
    Height = 601
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Splitter1: TSplitter
    Left = 321
    Top = 0
    Width = 8
    Height = 601
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 601
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
  end
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
    object Document1: TMenuItem
      Caption = 'Document'
      object AddPoint1: TMenuItem
        Caption = 'Add Point'
        OnClick = AddPoint1Click
      end
      object DeletePoint1: TMenuItem
        Caption = 'Delete Point'
        OnClick = DeletePoint1Click
      end
      object Clear1: TMenuItem
        Caption = 'Clear'
        OnClick = Clear1Click
      end
      object BuildLine1: TMenuItem
        Caption = 'Build Line'
        OnClick = BuildLine1Click
      end
      object Approx1: TMenuItem
        Caption = 'Approx'
        OnClick = Approx1Click
      end
    end
    object AproxSettings1: TMenuItem
      Caption = 'AproxSettings'
      OnClick = AproxSettings1Click
    end
    object settings: TMenuItem
      Caption = 'Line Settings'
      OnClick = settingsClick
      object AproxSettings: TMenuItem
        Caption = 'Aprox'
        OnClick = AproxSettingsClick
      end
      object Settings1: TMenuItem
        Caption = 'Main Line'
        OnClick = Settings1Click
      end
    end
  end
end
