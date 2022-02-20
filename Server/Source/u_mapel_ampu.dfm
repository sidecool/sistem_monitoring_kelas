object f_mapel_ampu: Tf_mapel_ampu
  Left = 96
  Top = 263
  BorderStyle = bsDialog
  Caption = 'Data Mata Pelajaran'
  ClientHeight = 207
  ClientWidth = 895
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
    Width = 377
    Height = 207
    Align = alLeft
    Caption = ' Form Input Pengampu Mata Pelajaran '
    TabOrder = 0
    object lbGuru: TLabel
      Left = 87
      Top = 42
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Caption = 'Guru'
    end
    object lbMapel: TLabel
      Left = 39
      Top = 114
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = 'Mata Pelajaran'
    end
    object lbJurusan: TLabel
      Left = 73
      Top = 90
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Jurusan'
    end
    object lbKelas: TLabel
      Left = 84
      Top = 66
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'Kelas'
    end
    object Panel1: TPanel
      Left = 120
      Top = 158
      Width = 233
      Height = 33
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 4
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
    object cbGuru: TComboBox
      Left = 120
      Top = 40
      Width = 217
      Height = 19
      Style = csOwnerDrawFixed
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = '- Pilih Guru'
      OnChange = cbGuruChange
      OnKeyPress = cbGuruKeyPress
      Items.Strings = (
        '- Pilih Guru')
    end
    object cbMapel: TComboBox
      Left = 120
      Top = 112
      Width = 217
      Height = 19
      Style = csOwnerDrawFixed
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 3
      Text = '- Pilih Mata Pelajaran'
      OnKeyPress = cbGuruKeyPress
      Items.Strings = (
        '- Pilih Mata Pelajaran')
    end
    object cbKelas: TComboBox
      Left = 120
      Top = 64
      Width = 217
      Height = 19
      Style = csOwnerDrawFixed
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = '- Pilih Kelas'
      OnKeyPress = cbGuruKeyPress
      Items.Strings = (
        '- Pilih Kelas')
    end
    object cbJurusan: TComboBox
      Left = 120
      Top = 88
      Width = 217
      Height = 19
      Style = csOwnerDrawFixed
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = '- Pilih Jurusan'
      OnKeyPress = cbGuruKeyPress
      Items.Strings = (
        '- Pilih Jurusan')
    end
  end
  object GroupBox2: TGroupBox
    Left = 377
    Top = 0
    Width = 518
    Height = 207
    Align = alClient
    Caption = ' Daftar Data Pengampu Mata Pelajaran '
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 514
      Height = 190
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
          Title.Caption = 'Kode'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = -1
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'NM_GURU'
          Title.Alignment = taCenter
          Title.Caption = 'Pengampu / Guru'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KELAS_JURUSAN'
          Title.Alignment = taCenter
          Title.Caption = 'Kelas, Jurusan'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 101
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NM_MAPEL'
          Title.Alignment = taCenter
          Title.Caption = 'Mata Pelajaran'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 193
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NM_KELAS'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'NM_JURUSAN'
          Visible = False
        end>
    end
  end
end
