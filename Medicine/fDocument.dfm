inherited FrameDocument: TFrameDocument
  inherited gbPanel: TGroupBox
    Top = 394
    Height = 107
    ExplicitTop = 394
    ExplicitHeight = 107
    object lDocumentType: TLabel [0]
      Left = 57
      Top = 36
      Width = 76
      Height = 13
      Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    inherited btnPanel: TPanel
      Top = 80
      ExplicitTop = 80
    end
    object leNumber: TLabeledEdit
      Left = 280
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
    object leSeries: TLabeledEdit
      Left = 139
      Top = 6
      Width = 79
      Height = 21
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = #1057#1077#1088#1080#1103
      LabelPosition = lpLeft
      TabOrder = 2
      OnExit = EditExit
    end
    object cbDocumentType: TComboBox
      Left = 139
      Top = 33
      Width = 359
      Height = 21
      MaxLength = 1
      TabOrder = 3
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
