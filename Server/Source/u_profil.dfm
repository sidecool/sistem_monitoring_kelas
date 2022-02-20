object f_profil: Tf_profil
  Left = 308
  Top = 220
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Konfigurasi Profil dan Klien'
  ClientHeight = 273
  ClientWidth = 586
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
  object GroupBoxProfil1: TGroupBox
    Left = 0
    Top = 0
    Width = 586
    Height = 273
    Align = alClient
    TabOrder = 0
    object lbLab: TLabel
      Left = 41
      Top = 188
      Width = 61
      Height = 13
      Alignment = taRightJustify
      Caption = 'Laboratorium'
    end
    object edNama: TLabeledEdit
      Left = 112
      Top = 24
      Width = 249
      Height = 21
      EditLabel.Width = 80
      EditLabel.Height = 13
      EditLabel.Caption = 'Nama Pengguna'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 0
      OnKeyPress = edNamaKeyPress
    end
    object edAlamat: TLabeledEdit
      Left = 112
      Top = 56
      Width = 465
      Height = 21
      EditLabel.Width = 32
      EditLabel.Height = 13
      EditLabel.Caption = 'Alamat'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 1
      OnKeyPress = edNamaKeyPress
    end
    object edKota: TLabeledEdit
      Left = 112
      Top = 88
      Width = 185
      Height = 21
      EditLabel.Width = 85
      EditLabel.Height = 13
      EditLabel.Caption = 'Kota / Kabupaten'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 2
      OnKeyPress = edNamaKeyPress
    end
    object edProvinsi: TLabeledEdit
      Left = 360
      Top = 88
      Width = 217
      Height = 21
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'Provinsi'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 3
      OnKeyPress = edNamaKeyPress
    end
    object edTelepon: TLabeledEdit
      Left = 112
      Top = 120
      Width = 185
      Height = 21
      EditLabel.Width = 85
      EditLabel.Height = 13
      EditLabel.Caption = 'No. Telepon / HP'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 4
      OnKeyPress = edNamaKeyPress
    end
    object edEmail: TLabeledEdit
      Left = 112
      Top = 152
      Width = 185
      Height = 21
      EditLabel.Width = 25
      EditLabel.Height = 13
      EditLabel.Caption = 'Email'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 5
      OnKeyPress = edNamaKeyPress
    end
    object edWebsite: TLabeledEdit
      Left = 360
      Top = 152
      Width = 185
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = 'Website'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 6
      OnKeyPress = edNamaKeyPress
    end
    object edKomputer: TLabeledEdit
      Left = 403
      Top = 184
      Width = 41
      Height = 21
      EditLabel.Width = 81
      EditLabel.Height = 13
      EditLabel.Caption = 'Jumlah Komputer'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 8
      OnKeyPress = edNamaKeyPress
    end
    object btnSimpan: TBitBtn
      Left = 112
      Top = 224
      Width = 457
      Height = 33
      Caption = '&Simpan'
      TabOrder = 9
      OnClick = btnSimpanClick
    end
    object StaticText1: TStaticText
      Left = 451
      Top = 188
      Width = 23
      Height = 17
      Caption = 'Unit'
      TabOrder = 10
    end
    object cbLab: TComboBox
      Left = 112
      Top = 184
      Width = 193
      Height = 19
      Style = csOwnerDrawFixed
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 7
      Text = '- Pilih Laboratorium'
      OnKeyPress = edNamaKeyPress
      Items.Strings = (
        '- Pilih Laboratorium')
    end
  end
end
