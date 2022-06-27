object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1043#1077#1085#1077#1088#1072#1090#1086#1088' '#1079#1072#1076#1072#1095' '
  ClientHeight = 506
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = Form1Create
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 96
    Top = 151
    Width = 580
    Height = 23
    Caption = #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1087#1088#1077#1076#1085#1072#1079#1085#1072#1095#1077#1085#1072' '#1076#1083#1103' '#1075#1077#1085#1077#1088#1072#1094#1080#1080' '#1079#1072#1076#1072#1085#1080#1081' '#1087#1086' '#1090#1077#1084#1077' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 136
    Top = 197
    Width = 511
    Height = 23
    Caption = '"'#1052#1072#1090#1088#1080#1094#1099', '#1086#1087#1088#1077#1076#1077#1083#1080#1090#1077#1083#1080' '#1080' '#1089#1080#1089#1090#1077#1084#1099' '#1083#1080#1085#1077#1081#1085#1099#1093' '#1091#1088#1072#1074#1085#1077#1085#1080#1081'"'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 8
    Top = 304
    Width = 441
    Height = 194
    TabStop = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    Visible = False
  end
  object CheckListBox1: TCheckListBox
    Left = 8
    Top = 8
    Width = 441
    Height = 281
    Margins.Top = 10
    OnClickCheck = CheckListBox1ClickCheck
    AutoComplete = False
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 23
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    Visible = False
  end
  object Button1: TButton
    Left = 552
    Top = 377
    Width = 135
    Height = 45
    Caption = #1057#1086#1079#1076#1072#1090#1100
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Visible = False
    OnClick = Button1Click
  end
  object ScrollBox1: TScrollBox
    Left = 455
    Top = 8
    Width = 297
    Height = 281
    TabOrder = 3
    Visible = False
  end
  object Button2: TButton
    Left = 288
    Top = 279
    Width = 177
    Height = 45
    Caption = #1053#1072#1095#1072#1090#1100' '#1075#1077#1085#1077#1088#1072#1094#1080#1102
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = Button2Click
  end
end
