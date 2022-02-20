object f_kelas_lab: Tf_kelas_lab
  Left = 340
  Top = 393
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Kelas Laboratorium'
  ClientHeight = 147
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbKelas: TLabel
    Left = 68
    Top = 18
    Width = 26
    Height = 13
    Alignment = taRightJustify
    Caption = 'Kelas'
  end
  object lbJurusan: TLabel
    Left = 57
    Top = 50
    Width = 37
    Height = 13
    Alignment = taRightJustify
    Caption = 'Jurusan'
  end
  object lbMapel: TLabel
    Left = 23
    Top = 82
    Width = 71
    Height = 13
    Alignment = taRightJustify
    Caption = 'Mata Pelajaran'
  end
  object cbKelas: TComboBox
    Left = 104
    Top = 16
    Width = 217
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = '- Pilih Kelas'
    OnKeyPress = cbKelasKeyPress
    Items.Strings = (
      '- Pilih Kelas')
  end
  object cbJurusan: TComboBox
    Left = 104
    Top = 48
    Width = 217
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = '- Pilih Jurusan'
    OnKeyPress = cbKelasKeyPress
    Items.Strings = (
      '- Pilih Jurusan')
  end
  object cbMapel: TComboBox
    Left = 104
    Top = 80
    Width = 217
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = '- Pilih Mata Pelajaran'
    OnChange = cbMapelChange
    OnKeyPress = cbKelasKeyPress
    Items.Strings = (
      '- Pilih Mata Pelajaran')
  end
  object btnMasuk: TBitBtn
    Left = 104
    Top = 112
    Width = 75
    Height = 25
    Caption = '&Masuk'
    Enabled = False
    TabOrder = 3
    OnClick = btnMasukClick
  end
end
