object f_login: Tf_login
  Left = 377
  Top = 206
  BorderStyle = bsDialog
  Caption = 'Form Login'
  ClientHeight = 96
  ClientWidth = 252
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object edUser: TLabeledEdit
    Left = 88
    Top = 8
    Width = 153
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'USERNAME'
    LabelPosition = lpLeft
    LabelSpacing = 10
    TabOrder = 0
    OnKeyPress = edUserKeyPress
  end
  object edPass: TLabeledEdit
    Left = 88
    Top = 32
    Width = 153
    Height = 25
    CharCase = ecUpperCase
    EditLabel.Width = 63
    EditLabel.Height = 13
    EditLabel.Caption = 'PASSWORD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Webdings'
    Font.Style = []
    LabelPosition = lpLeft
    LabelSpacing = 10
    ParentFont = False
    PasswordChar = 'd'
    TabOrder = 1
    OnKeyPress = edPassKeyPress
  end
  object btnLogin: TBitBtn
    Left = 88
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 2
    OnClick = btnLoginClick
  end
  object btnBatal: TBitBtn
    Left = 168
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Batal'
    TabOrder = 3
    OnClick = btnBatalClick
  end
end
