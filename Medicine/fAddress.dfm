inherited FrameAddress: TFrameAddress
  inherited gbPanel: TGroupBox
    Top = 394
    Height = 107
    ExplicitTop = 394
    ExplicitHeight = 107
    object lAddressType: TLabel [0]
      Left = 76
      Top = 36
      Width = 57
      Height = 13
      Caption = #1058#1080#1087' '#1072#1076#1088#1077#1089#1072
    end
    inherited btnPanel: TPanel
      Top = 80
      Anchors = [akLeft, akRight]
      ExplicitTop = 80
    end
    object leAddress: TLabeledEdit
      Left = 139
      Top = 6
      Width = 359
      Height = 21
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = #1040#1076#1088#1077#1089
      LabelPosition = lpLeft
      TabOrder = 1
      OnExit = EditExit
    end
    object cbAddressType: TComboBox
      Left = 139
      Top = 33
      Width = 359
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
