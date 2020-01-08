object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = #1052#1077#1076#1080#1094#1080#1085#1072
  ClientHeight = 478
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 240
    Top = 24
    object ReferenceBooksItems: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      object PatientsItem: TMenuItem
        Caption = #1055#1072#1094#1080#1077#1085#1090#1099
        OnClick = PatientsItemClick
      end
      object DoctorsItems: TMenuItem
        Caption = #1042#1088#1072#1095#1080
        object PostsItem: TMenuItem
          Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1080
          OnClick = PostsItemClick
        end
        object DoctorsItem: TMenuItem
          Caption = #1042#1088#1072#1095#1080
          OnClick = DoctorsItemClick
        end
      end
      object DiagnosesItem: TMenuItem
        Caption = #1044#1080#1072#1075#1085#1086#1079#1099' '#1087#1086' '#1052#1050#1041'-10'
        OnClick = DiagnosesItemClick
      end
      object PatientCaseLogItem: TMenuItem
        Caption = #1046#1091#1088#1085#1072#1083' '#1086#1073#1088#1072#1097#1077#1085#1080#1081' '#1087#1072#1094#1080#1077#1085#1090#1086#1074
        OnClick = PatientCaseLogItemClick
      end
      object DocumentTypeItem: TMenuItem
        Caption = #1058#1080#1087#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
        OnClick = DocumentTypeItemClick
      end
      object CommunicationTypeItem: TMenuItem
        Caption = #1058#1080#1087#1099' '#1082#1086#1084#1084#1091#1085#1080#1082#1072#1094#1080#1081
        OnClick = CommunicationTypeItemClick
      end
      object AddressTypeItem: TMenuItem
        Caption = #1058#1080#1087' '#1072#1076#1088#1077#1089#1072
        OnClick = AddressTypeItemClick
      end
    end
    object AboutItem: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    end
  end
end
