object f_user: Tf_user
  Left = 326
  Top = 117
  BorderStyle = bsDialog
  Caption = 'Data User'
  ClientHeight = 554
  ClientWidth = 381
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
    Width = 381
    Height = 193
    Align = alTop
    Caption = ' Form Input User  '
    TabOrder = 0
    object lbGuru: TLabel
      Left = 77
      Top = 60
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Pegawai'
    end
    object Panel1: TPanel
      Left = 128
      Top = 134
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
    object edUser: TLabeledEdit
      Left = 128
      Top = 32
      Width = 177
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = 'Username'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 0
      OnExit = edUserExit
      OnKeyPress = edUserKeyPress
    end
    object edPass: TLabeledEdit
      Left = 128
      Top = 80
      Width = 177
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'Password'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 2
      OnKeyPress = edUserKeyPress
    end
    object cbGuru: TComboBox
      Left = 128
      Top = 56
      Width = 145
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = '- Pilih Data Pegawai'
      OnKeyPress = edUserKeyPress
      Items.Strings = (
        '- Pilih Data Pegawai')
    end
    object edPassKonf: TLabeledEdit
      Left = 128
      Top = 104
      Width = 177
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 97
      EditLabel.Height = 13
      EditLabel.Caption = 'Konfirmasi Password'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 3
      OnKeyPress = edUserKeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 193
    Width = 381
    Height = 361
    Align = alClient
    Caption = ' Daftar Data User '
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 377
      Height = 344
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
          FieldName = 'NO_INDUK_PEGAWAI'
          Title.Alignment = taCenter
          Title.Caption = 'NIP'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 166
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USERNAME'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 172
          Visible = True
        end>
    end
  end
end
