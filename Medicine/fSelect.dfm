object FrameSelect: TFrameSelect
  Left = 0
  Top = 0
  Width = 1166
  Height = 28
  TabOrder = 0
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 1166
    Height = 28
    Align = alClient
    TabOrder = 0
    object sbStart: TSpeedButton
      Left = 519
      Top = 4
      Width = 138
      Height = 21
      Hint = #1042#1099#1073#1086#1088' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ParentShowHint = False
      ShowHint = True
      OnClick = sbStartClick
    end
    object leNumber: TLabeledEdit
      Left = 155
      Top = 4
      Width = 358
      Height = 21
      EditLabel.Width = 29
      EditLabel.Height = 13
      EditLabel.Caption = #1058#1077#1082#1089#1090
      LabelPosition = lpLeft
      TabOrder = 0
    end
  end
end
