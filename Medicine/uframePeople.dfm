object FramePeople: TFramePeople
  Left = 0
  Top = 0
  Width = 739
  Height = 474
  TabOrder = 0
  object MainPanel: TPanel
    Left = 0
    Top = 21
    Width = 739
    Height = 432
    TabOrder = 0
    object lBirthDate: TLabel
      Left = 24
      Top = 35
      Width = 80
      Height = 13
      Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
    end
    object lSex: TLabel
      Left = 236
      Top = 38
      Width = 19
      Height = 13
      Caption = #1055#1086#1083
    end
    object leF: TLabeledEdit
      Left = 110
      Top = 8
      Width = 121
      Height = 21
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Caption = #1060#1072#1084#1080#1083#1080#1103
      LabelPosition = lpLeft
      TabOrder = 0
      OnExit = leFExit
    end
    object leI: TLabeledEdit
      Left = 261
      Top = 8
      Width = 121
      Height = 21
      EditLabel.Width = 19
      EditLabel.Height = 13
      EditLabel.Caption = #1048#1084#1103
      LabelPosition = lpLeft
      TabOrder = 1
      OnExit = leIExit
    end
    object leO: TLabeledEdit
      Left = 439
      Top = 8
      Width = 121
      Height = 21
      EditLabel.Width = 49
      EditLabel.Height = 13
      EditLabel.Caption = #1054#1090#1095#1077#1089#1090#1074#1086
      LabelPosition = lpLeft
      TabOrder = 2
    end
    object BirthDate: TDateTimePicker
      Left = 110
      Top = 35
      Width = 121
      Height = 21
      Date = 43820.000000000000000000
      Time = 0.810382430558092900
      TabOrder = 3
    end
    object cbSex: TComboBox
      Left = 261
      Top = 35
      Width = 64
      Height = 21
      CharCase = ecUpperCase
      ItemIndex = 0
      MaxLength = 1
      TabOrder = 4
      Text = #1052
      OnExit = cbSexExit
      Items.Strings = (
        #1052
        #1046)
    end
    object GroupBox1: TGroupBox
      Left = 504
      Top = 35
      Width = 209
      Height = 134
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090' '#1083#1080#1095#1085#1086#1089#1090#1080
      TabOrder = 5
      object leSeries: TLabeledEdit
        Left = 70
        Top = 24
        Width = 121
        Height = 21
        EditLabel.Width = 29
        EditLabel.Height = 13
        EditLabel.Caption = #1089#1077#1088#1080#1103
        LabelPosition = lpLeft
        TabOrder = 0
      end
      object leNumber: TLabeledEdit
        Left = 70
        Top = 51
        Width = 121
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = #1085#1086#1084#1077#1088
        LabelPosition = lpLeft
        TabOrder = 1
      end
    end
    object leAddress: TLabeledEdit
      Left = 110
      Top = 62
      Width = 267
      Height = 21
      EditLabel.Width = 81
      EditLabel.Height = 13
      EditLabel.Caption = #1040#1076#1088#1077#1089' '#1087#1088#1086#1087#1080#1089#1082#1080
      LabelPosition = lpLeft
      TabOrder = 6
    end
    object LabeledEdit1: TLabeledEdit
      Left = 110
      Top = 89
      Width = 267
      Height = 21
      EditLabel.Width = 96
      EditLabel.Height = 13
      EditLabel.Caption = #1040#1076#1088#1077#1089' '#1087#1088#1086#1078#1080#1074#1072#1085#1080#1103
      LabelPosition = lpLeft
      TabOrder = 7
    end
    object gbPhone: TGroupBox
      Left = 16
      Top = 116
      Width = 201
      Height = 77
      Caption = #1050#1086#1084#1084#1091#1085#1080#1082#1072#1094#1080#1103
      TabOrder = 8
      object lPhoneType: TLabel
        Left = 8
        Top = 22
        Width = 49
        Height = 13
        Caption = #1058#1080#1087' '#1089#1074#1103#1079#1080
      end
      object cbComType: TComboBox
        Left = 63
        Top = 19
        Width = 114
        Height = 21
        MaxLength = 1
        TabOrder = 0
        Items.Strings = (
          #1052
          #1046)
      end
      object lePhoneNumber: TLabeledEdit
        Left = 63
        Top = 46
        Width = 114
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = #1085#1086#1084#1077#1088
        LabelPosition = lpLeft
        TabOrder = 1
      end
    end
  end
  object tbBottom: TToolBar
    Left = 0
    Top = 453
    Width = 739
    Height = 21
    Align = alBottom
    AutoSize = True
    ButtonHeight = 21
    ButtonWidth = 62
    Caption = 'tbBottom'
    ShowCaptions = True
    TabOrder = 1
    object tbSave: TToolButton
      Left = 0
      Top = 0
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 0
      OnClick = tbSaveClick
    end
    object tbCancel: TToolButton
      Left = 62
      Top = 0
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 1
      OnClick = tbCancelClick
    end
  end
  object tbTop: TToolBar
    Left = 0
    Top = 0
    Width = 739
    Height = 21
    AutoSize = True
    ButtonHeight = 21
    ButtonWidth = 80
    Caption = 'tbTop'
    ShowCaptions = True
    TabOrder = 2
    object tbCom: TToolButton
      Left = 0
      Top = 0
      Caption = #1050#1086#1084#1084#1091#1085#1080#1082#1072#1094#1080#1080
      ImageIndex = 0
      OnClick = tbComClick
    end
  end
end
