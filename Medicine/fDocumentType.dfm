inherited FrameDocumentType: TFrameDocumentType
  inherited gbPanel: TGroupBox
    Top = 394
    Height = 107
    ExplicitTop = 394
    ExplicitHeight = 107
    inherited btnPanel: TPanel
      Top = 80
      ExplicitTop = 80
    end
    object leCode: TLabeledEdit
      Left = 103
      Top = 6
      Width = 79
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1086#1076
      LabelPosition = lpLeft
      TabOrder = 1
      OnExit = EditExit
    end
    object leName: TLabeledEdit
      Left = 103
      Top = 33
      Width = 418
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
    Height = 354
    ExplicitHeight = 354
    inherited Grid: TStringGrid
      Height = 344
      ExplicitHeight = 344
    end
  end
end
