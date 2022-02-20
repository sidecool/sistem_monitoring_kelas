object f_pengaturan: Tf_pengaturan
  Left = 309
  Top = 299
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Pengaturan Database'
  ClientHeight = 195
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbStatus: TLabel
    Left = 142
    Top = 163
    Width = 39
    Height = 13
    Caption = 'Status : '
  end
  object edHost: TLabeledEdit
    Left = 104
    Top = 32
    Width = 129
    Height = 21
    EditLabel.Width = 56
    EditLabel.Height = 13
    EditLabel.Caption = 'Server Host'
    LabelPosition = lpLeft
    LabelSpacing = 15
    TabOrder = 0
    OnKeyPress = edHostKeyPress
  end
  object edPort: TLabeledEdit
    Left = 288
    Top = 32
    Width = 57
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'Port'
    LabelPosition = lpLeft
    LabelSpacing = 15
    TabOrder = 1
    OnKeyPress = edHostKeyPress
  end
  object edUser: TLabeledEdit
    Left = 104
    Top = 64
    Width = 185
    Height = 21
    Hint = 'Default diisi dengan root'
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = 'User'
    LabelPosition = lpLeft
    LabelSpacing = 15
    TabOrder = 2
    OnKeyPress = edHostKeyPress
  end
  object edPass: TLabeledEdit
    Left = 104
    Top = 96
    Width = 185
    Height = 21
    Hint = 'Kosongkan jika tidak menggunakan password'
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Password'
    LabelPosition = lpLeft
    LabelSpacing = 15
    TabOrder = 3
    OnKeyPress = edHostKeyPress
  end
  object edDatabase: TLabeledEdit
    Left = 104
    Top = 128
    Width = 185
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Database'
    LabelPosition = lpLeft
    LabelSpacing = 15
    TabOrder = 4
    OnKeyPress = edHostKeyPress
  end
  object btnConnect: TBitBtn
    Left = 104
    Top = 159
    Width = 75
    Height = 25
    Caption = 'Koneksikan'
    TabOrder = 5
    OnClick = btnConnectClick
  end
  object btnSimpan: TBitBtn
    Left = 296
    Top = 128
    Width = 64
    Height = 25
    Caption = '&Simpan'
    TabOrder = 6
    Visible = False
    OnClick = btnSimpanClick
  end
end
