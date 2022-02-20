object f_guru: Tf_guru
  Left = 326
  Top = 117
  BorderStyle = bsDialog
  Caption = 'Data Guru'
  ClientHeight = 554
  ClientWidth = 633
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
    Width = 633
    Height = 249
    Align = alTop
    Caption = ' Form Input Guru '
    TabOrder = 0
    object lbJenisKelamin: TLabel
      Left = 38
      Top = 84
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Jenis Kelamin'
    end
    object lbTglLahir: TLabel
      Left = 357
      Top = 108
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tanggal Lahir'
    end
    object lbAgama: TLabel
      Left = 69
      Top = 132
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Agama'
    end
    object Panel1: TPanel
      Left = 112
      Top = 206
      Width = 233
      Height = 33
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 8
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
      Left = 112
      Top = 32
      Width = 177
      Height = 21
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Caption = 'NIP Guru'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 0
      OnExit = edKodeExit
      OnKeyPress = edKodeKeyPress
    end
    object edNama: TLabeledEdit
      Left = 112
      Top = 56
      Width = 233
      Height = 21
      EditLabel.Width = 54
      EditLabel.Height = 13
      EditLabel.Caption = 'Nama Guru'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 1
      OnKeyPress = edKodeKeyPress
    end
    object cbJenisKelamin: TComboBox
      Left = 112
      Top = 80
      Width = 145
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = '- Pilih Jenis Kelamin'
      OnKeyPress = edKodeKeyPress
      Items.Strings = (
        '- Pilih Jenis Kelamin'
        'Laki-laki'
        'Perempuan')
    end
    object edTempatLahir: TLabeledEdit
      Left = 112
      Top = 104
      Width = 233
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'Tempat Lahir'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 3
      OnKeyPress = edKodeKeyPress
    end
    object cbAgama: TComboBox
      Left = 112
      Top = 128
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 5
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
      Left = 112
      Top = 152
      Width = 505
      Height = 21
      EditLabel.Width = 32
      EditLabel.Height = 13
      EditLabel.Caption = 'Alamat'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 6
      OnKeyPress = edKodeKeyPress
    end
    object edTelp: TLabeledEdit
      Left = 112
      Top = 176
      Width = 121
      Height = 21
      EditLabel.Width = 85
      EditLabel.Height = 13
      EditLabel.Caption = 'No. Telepon / HP'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 7
      OnKeyPress = edKodeKeyPress
    end
    object DTPTglLahir: TDateTimePicker
      Left = 432
      Top = 104
      Width = 137
      Height = 21
      Date = 0.820786504627903900
      Format = 'dd/MMMM/yyyy'
      Time = 0.820786504627903900
      TabOrder = 4
      OnKeyPress = edKodeKeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 249
    Width = 633
    Height = 305
    Align = alClient
    Caption = ' Daftar Data Guru '
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 629
      Height = 288
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
          Title.Caption = 'NIP'
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
          Title.Caption = 'Nama Guru'
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
