inherited FrameDoctors: TFrameDoctors
  inherited gbPanel: TGroupBox
    ExplicitTop = 345
    object lPost: TLabel [0]
      Left = 53
      Top = 46
      Width = 57
      Height = 13
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
    end
    object leCabinet: TLabeledEdit
      Left = 112
      Top = 16
      Width = 121
      Height = 21
      EditLabel.Width = 43
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1072#1073#1080#1085#1077#1090
      LabelPosition = lpLeft
      TabOrder = 1
      OnExit = EditExit
    end
    object cbPost: TComboBox
      Left = 112
      Top = 43
      Width = 649
      Height = 21
      TabOrder = 2
      OnExit = ComboBoxExit
    end
  end
end
