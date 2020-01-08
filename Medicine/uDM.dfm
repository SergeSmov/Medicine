object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Database=MEDICINE.FDB'
      'CharacterSet=WIN1251'
      'DriverID=FB')
    Left = 16
    Top = 104
  end
  object FDQ: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select *'
      'from people')
    Left = 16
    Top = 8
  end
  object FDStoredProc1: TFDStoredProc
    Connection = FDConnection1
    Left = 80
    Top = 24
    ParamData = <
      item
      end>
  end
end
