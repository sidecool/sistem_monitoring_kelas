object DMServer: TDMServer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 441
  Top = 194
  Height = 302
  Width = 478
  object ZConnection1: TZConnection
    ControlsCodePage = cGET_ACP
    AutoEncodeStrings = False
    HostName = 'localhost'
    Port = 3307
    Database = 'dbmonitoring'
    User = 'root'
    Protocol = 'mysql'
    Left = 40
    Top = 48
  end
  object ZQEksekusi1: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 40
    Top = 104
  end
  object ZQEksekusi2: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 40
    Top = 160
  end
  object ZQTampil1: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 112
    Top = 104
  end
  object ZQTampil2: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 112
    Top = 160
  end
  object DataSource1: TDataSource
    DataSet = ZQTampil1
    Left = 192
    Top = 104
  end
  object ZQLaporan1: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 280
    Top = 104
  end
  object ZQLaporan2: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 280
    Top = 160
  end
end
