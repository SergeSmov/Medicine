inherited FrameDiagnoses: TFrameDiagnoses
  inherited gbPanel: TGroupBox
    Top = 410
    Height = 91
    ExplicitTop = 410
    ExplicitHeight = 91
    inherited btnPanel: TPanel
      Top = 64
      TabOrder = 1
      ExplicitTop = 64
    end
    object leCode: TLabeledEdit
      Left = 90
      Top = 6
      Width = 175
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1086#1076
      LabelPosition = lpLeft
      TabOrder = 0
      OnExit = EditExit
    end
    object leName: TLabeledEdit
      Left = 90
      Top = 33
      Width = 711
      Height = 21
      EditLabel.Width = 73
      EditLabel.Height = 13
      EditLabel.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      LabelPosition = lpLeft
      TabOrder = 2
      OnExit = EditExit
    end
  end
  inherited GridPanel: TPanel
    Height = 370
    ExplicitHeight = 370
    inherited Grid: TStringGrid
      Height = 360
      ExplicitHeight = 360
    end
  end
  inherited ToolBar: TToolBar
    object tbSelect: TToolButton
      Left = 421
      Top = 0
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ImageIndex = 146
      OnClick = tbSelectClick
    end
  end
end
