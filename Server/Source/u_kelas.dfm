object f_kelas: Tf_kelas
  Left = 476
  Top = 167
  BorderStyle = bsDialog
  Caption = 'Data Kelas'
  ClientHeight = 453
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 321
    Height = 153
    Align = alTop
    Caption = ' Form Input Kelas '
    TabOrder = 0
    object edKode: TLabeledEdit
      Left = 80
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 54
      EditLabel.Height = 13
      EditLabel.Caption = 'Kode Kelas'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 0
      OnExit = edKodeExit
      OnKeyPress = edKodeKeyPress
    end
    object edNama: TLabeledEdit
      Left = 80
      Top = 64
      Width = 233
      Height = 21
      EditLabel.Width = 57
      EditLabel.Height = 13
      EditLabel.Caption = 'Nama Kelas'
      LabelPosition = lpLeft
      LabelSpacing = 10
      TabOrder = 1
      OnKeyPress = edKodeKeyPress
    end
    object Panel1: TPanel
      Left = 80
      Top = 96
      Width = 233
      Height = 33
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 2
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
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 153
    Width = 321
    Height = 300
    Align = alClient
    Caption = ' Daftar Data Kelas '
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 317
      Height = 283
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
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAMA'
          Title.Alignment = taCenter
          Title.Caption = 'Nama Kelas'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 212
          Visible = True
        end>
    end
  end
end
