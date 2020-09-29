object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 368
  ClientWidth = 354
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 55
    Width = 46
    Height = 13
    Caption = 'Id Cliente'
  end
  object Memo1: TMemo
    Left = 135
    Top = 24
    Width = 193
    Height = 337
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button2: TButton
    Left = 8
    Top = 101
    Width = 121
    Height = 25
    Caption = 'Altas'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 74
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Button3: TButton
    Left = 8
    Top = 132
    Width = 121
    Height = 25
    Caption = 'Salir'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 24
    Width = 121
    Height = 25
    Caption = 'Busqueda'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button1: TButton
    Left = 8
    Top = 272
    Width = 121
    Height = 25
    Caption = 'Muesta '
    TabOrder = 5
    OnClick = Button1Click
  end
end
