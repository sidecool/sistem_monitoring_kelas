object f_config: Tf_config
  Left = 600
  Top = 273
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Konfigurasi Komputer Client'
  ClientHeight = 151
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edNomor: TLabeledEdit
    Left = 88
    Top = 16
    Width = 185
    Height = 21
    Hint = 'Default diisi dengan root'
    EditLabel.Width = 65
    EditLabel.Height = 13
    EditLabel.Caption = 'No. Komputer'
    LabelPosition = lpLeft
    LabelSpacing = 15
    TabOrder = 0
    OnKeyPress = edNomorKeyPress
  end
  object edServer: TLabeledEdit
    Left = 88
    Top = 48
    Width = 185
    Height = 21
    Hint = 'Kosongkan jika tidak menggunakan password'
    EditLabel.Width = 56
    EditLabel.Height = 13
    EditLabel.Caption = 'Server Host'
    LabelPosition = lpLeft
    LabelSpacing = 15
    TabOrder = 1
    OnKeyPress = edNomorKeyPress
  end
  object edLocal: TLabeledEdit
    Left = 88
    Top = 80
    Width = 185
    Height = 21
    EditLabel.Width = 51
    EditLabel.Height = 13
    EditLabel.Caption = 'Local Host'
    LabelPosition = lpLeft
    LabelSpacing = 15
    TabOrder = 2
    OnKeyPress = edNomorKeyPress
  end
  object btnSimpan: TBitBtn
    Left = 91
    Top = 110
    Width = 64
    Height = 25
    Caption = '&Simpan'
    TabOrder = 3
    OnClick = btnSimpanClick
  end
end
