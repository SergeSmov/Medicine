inherited FrameCommunication: TFrameCommunication
  inherited gbPanel: TGroupBox
    Top = 394
    Height = 107
    ExplicitTop = 394
    ExplicitHeight = 107
    object lDocumentType: TLabel [0]
      Left = 42
      Top = 36
      Width = 93
      Height = 13
      Caption = #1058#1080#1087' '#1082#1086#1084#1084#1091#1085#1080#1082#1072#1094#1080#1080
    end
    inherited btnPanel: TPanel
      Top = 80
      ExplicitTop = 80
    end
    object leNumber: TLabeledEdit
      Left = 139
      Top = 6
      Width = 79
      Height = 21
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = #1053#1086#1084#1077#1088
      LabelPosition = lpLeft
      TabOrder = 1
      OnExit = EditExit
    end
    object cbCommunicationType: TComboBox
      Left = 139
      Top = 33
      Width = 320
      Height = 21
      MaxLength = 1
      TabOrder = 2
      OnExit = ComboBoxExit
    end
  end
  inherited GridPanel: TPanel
    Height = 354
    ExplicitHeight = 354
    inherited Grid: TStringGrid
      Height = 344
      ExplicitHeight = 344
    end
  end
end
