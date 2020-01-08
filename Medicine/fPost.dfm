inherited FramePost: TFramePost
  inherited gbPanel: TGroupBox
    Top = 386
    Height = 115
    ExplicitTop = 386
    ExplicitHeight = 115
    inherited btnPanel: TPanel
      Top = 88
      TabOrder = 1
      ExplicitTop = 88
    end
    object leName: TLabeledEdit
      Left = 82
      Top = 45
      Width = 575
      Height = 21
      EditLabel.Width = 73
      EditLabel.Height = 13
      EditLabel.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      LabelPosition = lpLeft
      TabOrder = 0
      OnExit = EditExit
    end
  end
  inherited GridPanel: TPanel
    Height = 346
    ExplicitHeight = 346
    inherited Grid: TStringGrid
      Height = 336
      ExplicitHeight = 336
    end
  end
end
