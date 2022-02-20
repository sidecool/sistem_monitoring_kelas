object f_siswa: Tf_siswa
  Left = 173
  Top = 23
  BorderStyle = bsDialog
  Caption = 'Data Siswa'
  ClientHeight = 619
  ClientWidth = 935
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 935
    Height = 249
    Align = alTop
    Caption = ' Form Input Siswa '
    TabOrder = 0
    object lbJenisKelamin: TLabel
      Left = 390
      Top = 84
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Jenis Kelamin'
    end
    object lbTglLahir: TLabel
      Left = 709
      Top = 108
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tanggal Lahir'
    end
    object lbAgama: TLabel
      Left = 421
      Top = 132
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Agama'
    end
    object Panel1: TPanel
      Left = 464
      Top = 206
      Width = 233
      Height = 33
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 9
      object btnSimpan: TBitBtn
        Left = 3
        Top = 3
        Width = 65
        Height = 28
        Caption = '&Simpan'
        TabOrder = 0
        OnClick = btnSimpanClick
      end
      object btnHapus: TBitBtn
        Left = 68
        Top = 3
        Width = 65
        Height = 28
        Caption = '&Hapus'
        TabOrder = 1
        OnClick = btnHapusClick
      end
      object btnTutup: TBitBtn
        Left = 166
        Top = 3
        Width = 65
        Height = 28
        Caption = '&Tutup'
        TabOrder = 2
        OnClick = btnTutupClick
      end
    end
    object edKode: TLabeledEdit
      Left = 464
      Top = 32
      Width = 177
      Height = 21
      EditLabel.Width = 49
      EditLabel.Height = 13
      EditLabel.Caption = 'NIS Siswa'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 1
      OnExit = edKodeExit
      OnKeyPress = edKodeKeyPress
    end
    object edNama: TLabeledEdit
      Left = 464
      Top = 56
      Width = 233
      Height = 21
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = 'Nama Siswa'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 2
      OnKeyPress = edKodeKeyPress
    end
    object cbJenisKelamin: TComboBox
      Left = 464
      Top = 80
      Width = 145
      Height = 19
      Style = csOwnerDrawFixed
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 3
      Text = '- Pilih Jenis Kelamin'
      OnKeyPress = edKodeKeyPress
      Items.Strings = (
        '- Pilih Jenis Kelamin'
        'Laki-laki'
        'Perempuan')
    end
    object edTempatLahir: TLabeledEdit
      Left = 464
      Top = 104
      Width = 233
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'Tempat Lahir'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 4
      OnKeyPress = edKodeKeyPress
    end
    object cbAgama: TComboBox
      Left = 464
      Top = 128
      Width = 145
      Height = 19
      Style = csOwnerDrawFixed
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 6
      Text = '- Pilih Agama'
      OnKeyPress = edKodeKeyPress
      Items.Strings = (
        '- Pilih Agama'
        'ISLAM'
        'KRISTEN'
        'KATHOLIK'
        'HINDU'
        'BUDDHA'
        'KONG HU CU'
        'Lainnya')
    end
    object edAlamat: TLabeledEdit
      Left = 464
      Top = 152
      Width = 457
      Height = 21
      EditLabel.Width = 32
      EditLabel.Height = 13
      EditLabel.Caption = 'Alamat'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 7
      OnKeyPress = edKodeKeyPress
    end
    object edTelp: TLabeledEdit
      Left = 464
      Top = 176
      Width = 121
      Height = 21
      EditLabel.Width = 85
      EditLabel.Height = 13
      EditLabel.Caption = 'No. Telepon / HP'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 8
      OnKeyPress = edKodeKeyPress
    end
    object DTPTglLahir: TDateTimePicker
      Left = 784
      Top = 104
      Width = 137
      Height = 21
      Date = 0.820786504627903900
      Format = 'dd/MMMM/yyyy'
      Time = 0.820786504627903900
      TabOrder = 5
      OnKeyPress = edKodeKeyPress
    end
    object GroupBox3: TGroupBox
      Left = 16
      Top = 24
      Width = 329
      Height = 113
      Caption = ' Kelas dan Jurusan '
      TabOrder = 0
      object lbKelas: TLabel
        Left = 60
        Top = 36
        Width = 26
        Height = 13
        Alignment = taRightJustify
        Caption = 'Kelas'
      end
      object lbJurusan: TLabel
        Left = 49
        Top = 68
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'Jurusan'
      end
      object cbKelas: TComboBox
        Left = 96
        Top = 32
        Width = 217
        Height = 19
        Style = csOwnerDrawFixed
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = '- Pilih Kelas'
        OnKeyPress = edKodeKeyPress
        Items.Strings = (
          '- Pilih Kelas')
      end
      object cbJurusan: TComboBox
        Left = 96
        Top = 64
        Width = 217
        Height = 19
        Style = csOwnerDrawFixed
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = '- Pilih Jurusan'
        OnChange = cbJurusanChange
        OnKeyPress = edKodeKeyPress
        Items.Strings = (
          '- Pilih Jurusan')
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 249
    Width = 935
    Height = 370
    Align = alClient
    Caption = ' Daftar Data Siswa '
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 931
      Height = 353
      Align = alClient
      DataSource = DMServer.DataSource1
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'KODE'
          Title.Alignment = taCenter
          Title.Caption = 'NIS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 155
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAMA'
          Title.Alignment = taCenter
          Title.Caption = 'Nama Siswa'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 187
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TEMPAT_LAHIR'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TGL_LAHIR'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TTL'
          Title.Alignment = taCenter
          Title.Caption = 'Tempat, Tgl Lahir'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 154
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'JENIS_KELAMIN'
          Title.Alignment = taCenter
          Title.Caption = 'JK'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 32
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AGAMA'
          Title.Alignment = taCenter
          Title.Caption = 'Agama'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NO_TELP'
          Title.Alignment = taCenter
          Title.Caption = 'Telp / HP'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ALAMAT'
          Title.Alignment = taCenter
          Title.Caption = 'Alamat'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 432
          Visible = True
        end>
    end
  end
end
