inherited FramePeoples: TFramePeoples
  Width = 1142
  Height = 517
  ParentFont = False
  ExplicitWidth = 1142
  ExplicitHeight = 517
  inherited gbPanel: TGroupBox
    Top = 400
    Width = 1142
    Height = 117
    ExplicitTop = 400
    ExplicitWidth = 1142
    ExplicitHeight = 117
    object lSex: TLabel [0]
      Left = 247
      Top = 48
      Width = 19
      Height = 13
      Caption = #1055#1086#1083
    end
    object lBirthDate: TLabel [1]
      Left = 24
      Top = 48
      Width = 80
      Height = 13
      Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
    end
    inherited btnPanel: TPanel
      Top = 90
      Width = 1138
      TabOrder = 5
      ExplicitTop = 90
      ExplicitWidth = 1138
    end
    object leI: TLabeledEdit
      Left = 272
      Top = 18
      Width = 121
      Height = 21
      EditLabel.Width = 19
      EditLabel.Height = 13
      EditLabel.Caption = #1048#1084#1103
      LabelPosition = lpLeft
      TabOrder = 1
      OnExit = EditExit
    end
    object cbSex: TComboBox
      Left = 272
      Top = 45
      Width = 64
      Height = 21
      CharCase = ecUpperCase
      ItemIndex = 0
      MaxLength = 1
      TabOrder = 4
      Text = #1052
      OnExit = ComboBoxExit
      Items.Strings = (
        #1052
        #1046)
    end
    object BirthDate: TDateTimePicker
      Left = 110
      Top = 45
      Width = 121
      Height = 21
      Date = 43825.000000000000000000
      Time = 0.810382430558092900
      TabOrder = 3
      OnExit = DateTimePickerExit
    end
    object leO: TLabeledEdit
      Left = 458
      Top = 18
      Width = 121
      Height = 21
      EditLabel.Width = 49
      EditLabel.Height = 13
      EditLabel.Caption = #1054#1090#1095#1077#1089#1090#1074#1086
      LabelPosition = lpLeft
      TabOrder = 2
      OnExit = EditExit
    end
    object leF: TLabeledEdit
      Left = 110
      Top = 18
      Width = 121
      Height = 21
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Caption = #1060#1072#1084#1080#1083#1080#1103
      LabelPosition = lpLeft
      TabOrder = 0
      OnExit = EditExit
    end
    object leId: TLabeledEdit
      Left = 608
      Top = 18
      Width = 121
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'Id'
      LabelPosition = lpLeft
      TabOrder = 6
      OnExit = EditExit
    end
  end
  inherited GridPanel: TPanel
    Width = 1142
    Height = 360
    ExplicitWidth = 1142
    ExplicitHeight = 360
    inherited Grid: TStringGrid
      Width = 1132
      Height = 350
      DefaultColWidth = 70
      DefaultRowHeight = 20
      ExplicitWidth = 1132
      ExplicitHeight = 350
      ColWidths = (
        70
        70
        70
        70
        70)
      RowHeights = (
        20
        20
        20
        20
        20)
    end
  end
  inherited ToolBar: TToolBar
    Width = 1142
    ButtonWidth = 80
    ExplicitWidth = 1142
    inherited sbEdit: TToolButton
      ExplicitWidth = 80
    end
    inherited sbKill: TToolButton
      Left = 141
      ExplicitLeft = 141
      ExplicitWidth = 80
    end
    inherited tbSep1: TToolButton
      Left = 221
      Width = 8
      ExplicitLeft = 221
      ExplicitWidth = 8
    end
    inherited sbRefresh: TToolButton
      Left = 229
      ExplicitLeft = 229
      ExplicitWidth = 80
    end
    inherited tbSep: TToolButton
      Left = 309
      ExplicitLeft = 309
    end
    inherited SelectAllButton: TToolButton
      Left = 317
      ExplicitLeft = 317
      ExplicitWidth = 80
    end
    inherited UnSelectAllButton: TToolButton
      Left = 397
      ExplicitLeft = 397
      ExplicitWidth = 80
    end
    inherited InvertSelectButton: TToolButton
      Left = 477
      ExplicitLeft = 477
      ExplicitWidth = 80
    end
    object tbDoc: TToolButton
      Left = 557
      Top = 0
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
      ImageIndex = 89
      OnClick = tbDocClick
    end
    object tbAddress: TToolButton
      Left = 637
      Top = 0
      Caption = #1040#1076#1088#1077#1089
      ImageIndex = 92
      OnClick = tbAddressClick
    end
    object tbComm: TToolButton
      Left = 717
      Top = 0
      Caption = #1050#1086#1084#1084#1091#1085#1080#1082#1072#1094#1080#1080
      ImageIndex = 91
      OnClick = tbCommClick
    end
    object tbDoctor: TToolButton
      Left = 797
      Top = 0
      Caption = #1042#1088#1072#1095
      ImageIndex = 90
      OnClick = tbDoctorClick
    end
    object ToolButton4: TToolButton
      Left = 877
      Top = 0
      Width = 16
      Caption = 'ToolButton4'
      ImageIndex = 92
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 893
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 138
      Style = tbsSeparator
    end
    object tbSelect: TToolButton
      Left = 901
      Top = 0
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ImageIndex = 146
      OnClick = tbSelectClick
    end
  end
end
