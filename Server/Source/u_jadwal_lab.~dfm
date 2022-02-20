object f_jadwal_lab: Tf_jadwal_lab
  Left = 77
  Top = 168
  BorderStyle = bsDialog
  Caption = 'Data Jadwal Laboratorium'
  ClientHeight = 313
  ClientWidth = 902
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
    Width = 369
    Height = 313
    Align = alLeft
    Caption = ' Form Input Jadwal Laboratorium '
    TabOrder = 0
    object lbTA: TLabel
      Left = 50
      Top = 52
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tahun Ajar'
    end
    object lbHari: TLabel
      Left = 83
      Top = 196
      Width = 19
      Height = 13
      Alignment = taRightJustify
      Caption = 'Hari'
    end
    object lbMulai: TLabel
      Left = 55
      Top = 220
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'Jam Mulai'
    end
    object lbSelesai: TLabel
      Left = 196
      Top = 220
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Jam Selesai'
    end
    object Panel1: TPanel
      Left = 112
      Top = 270
      Width = 233
      Height = 33
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 6
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
    object DTPTahun: TDateTimePicker
      Left = 112
      Top = 48
      Width = 65
      Height = 21
      Date = 0.820786504627903900
      Format = 'yyyy'
      Time = 0.820786504627903900
      DateMode = dmUpDown
      TabOrder = 0
      OnChange = DTPTahunChange
      OnKeyPress = edKodeKeyPress
    end
    object GroupBox3: TGroupBox
      Left = 16
      Top = 80
      Width = 329
      Height = 105
      Caption = ' Laboratorium dan Mata Pelajaran '
      TabOrder = 2
      object lbLab: TLabel
        Left = 25
        Top = 36
        Width = 61
        Height = 13
        Alignment = taRightJustify
        Caption = 'Laboratorium'
      end
      object lbMapel: TLabel
        Left = 15
        Top = 68
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'Mata Pelajaran'
      end
      object cbLab: TComboBox
        Left = 96
        Top = 32
        Width = 217
        Height = 19
        Style = csOwnerDrawFixed
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = '- Pilih Laboratorium'
        OnKeyPress = edKodeKeyPress
        Items.Strings = (
          '- Pilih Laboratorium')
      end
      object cbMapel: TComboBox
        Left = 96
        Top = 64
        Width = 217
        Height = 19
        Style = csOwnerDrawFixed
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = '- Pilih Mata Pelajaran'
        OnKeyPress = edKodeKeyPress
        Items.Strings = (
          '- Pilih Mata Pelajaran')
      end
    end
    object edKode: TLabeledEdit
      Left = 112
      Top = 24
      Width = 233
      Height = 21
      EditLabel.Width = 82
      EditLabel.Height = 13
      EditLabel.Caption = 'Kode Jadwal Lab'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 1
      Visible = False
      OnExit = edKodeExit
      OnKeyPress = edKodeKeyPress
    end
    object cbHari: TComboBox
      Left = 112
      Top = 192
      Width = 105
      Height = 22
      Style = csOwnerDrawFixed
      ItemHeight = 16
      ItemIndex = 0
      TabOrder = 3
      Text = '- Pilih Hari'
      OnChange = cbHariChange
      OnKeyPress = edKodeKeyPress
      Items.Strings = (
        '- Pilih Hari')
    end
    object DTPMulai: TDateTimePicker
      Left = 112
      Top = 216
      Width = 73
      Height = 21
      Date = 43537.000000000000000000
      Format = 'H:mm:ss'
      Time = 43537.000000000000000000
      Kind = dtkTime
      TabOrder = 4
      OnKeyPress = edKodeKeyPress
    end
    object DTPSelesai: TDateTimePicker
      Left = 264
      Top = 216
      Width = 73
      Height = 21
      Date = 43537.000000000000000000
      Format = 'H:mm:ss'
      Time = 43537.000000000000000000
      Kind = dtkTime
      TabOrder = 5
      OnKeyPress = edKodeKeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 369
    Top = 0
    Width = 533
    Height = 313
    Align = alClient
    Caption = ' Daftar Data Jadwal Laboratorium '
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 931
      Height = 296
      Align = alLeft
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
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TAHUN_AJAR'
          Title.Alignment = taCenter
          Title.Caption = 'TAHUN'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'JADWAL'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MAPEL'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 204
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RUANG'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 121
          Visible = True
        end>
    end
  end
end
