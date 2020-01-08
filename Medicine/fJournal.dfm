inherited FrameJournal: TFrameJournal
  Width = 981
  Height = 539
  ExplicitWidth = 981
  ExplicitHeight = 539
  inherited gbPanel: TGroupBox
    Top = 328
    Width = 981
    Height = 211
    ExplicitTop = 328
    ExplicitWidth = 981
    ExplicitHeight = 211
    inherited btnPanel: TPanel
      Top = 184
      Width = 977
      ExplicitTop = 184
      ExplicitWidth = 977
    end
    object PanelParents: TPanel
      Left = 2
      Top = 15
      Width = 977
      Height = 169
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object lDateTime: TLabel
        Left = 121
        Top = 9
        Width = 31
        Height = 13
        Caption = #1055#1088#1080#1077#1084
      end
      object PanelSelect: TPanel
        Left = 0
        Top = 69
        Width = 977
        Height = 100
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        inline FrameSelectPatiens: TFrameSelect
          Left = 0
          Top = 0
          Width = 977
          Height = 28
          Align = alTop
          TabOrder = 0
          ExplicitWidth = 977
          inherited Panel: TPanel
            Width = 977
            ExplicitWidth = 977
            inherited sbStart: TSpeedButton
              Top = 5
              ExplicitTop = 5
            end
            inherited leNumber: TLabeledEdit
              Top = 5
              EditLabel.ExplicitTop = 9
              OnDblClick = FrameSelectPatiensleNumberDblClick
              OnExit = EditExit
              ExplicitTop = 5
            end
          end
        end
        inline FrameSelectDoctor: TFrameSelect
          Left = 0
          Top = 28
          Width = 977
          Height = 28
          Align = alTop
          TabOrder = 1
          ExplicitTop = 28
          ExplicitWidth = 977
          inherited Panel: TPanel
            Width = 977
            ExplicitWidth = 977
            inherited leNumber: TLabeledEdit
              OnDblClick = FrameSelectDoctorleNumberDblClick
              OnExit = EditExit
            end
          end
        end
        inline FrameSelectDiagnoses: TFrameSelect
          Left = 0
          Top = 56
          Width = 977
          Height = 28
          Align = alTop
          TabOrder = 2
          ExplicitTop = 56
          ExplicitWidth = 977
          inherited Panel: TPanel
            Width = 977
            ExplicitWidth = 977
            inherited sbStart: TSpeedButton
              OnClick = FrameSelectDiagnosessbStartClick
            end
            inherited leNumber: TLabeledEdit
              OnDblClick = FrameSelectDiagnosesleNumberDblClick
              OnExit = EditExit
            end
          end
        end
      end
      object DateTime: TDateTimePicker
        Left = 158
        Top = 3
        Width = 186
        Height = 21
        Date = 43828.000000000000000000
        Format = 'dd:MM:yyyy HH:mm:ss'
        Time = 43828.000000000000000000
        DateFormat = dfLong
        TabOrder = 1
        OnExit = DateTimePickerExit
      end
      object leNumber: TLabeledEdit
        Left = 158
        Top = 28
        Width = 359
        Height = 21
        EditLabel.Width = 31
        EditLabel.Height = 13
        EditLabel.Caption = #1053#1086#1084#1077#1088
        LabelPosition = lpLeft
        TabOrder = 2
        OnExit = EditExit
      end
    end
  end
  inherited GridPanel: TPanel
    Top = 192
    Width = 981
    Height = 136
    ExplicitTop = 192
    ExplicitWidth = 981
    ExplicitHeight = 136
    inherited Grid: TStringGrid
      Width = 971
      Height = 126
      ExplicitWidth = 971
      ExplicitHeight = 126
    end
  end
  inherited ToolBar: TToolBar
    Width = 981
    ExplicitWidth = 981
    object tbSelect: TToolButton
      Left = 421
      Top = 0
      Caption = #1054#1090#1073#1086#1088
      ImageIndex = 138
      OnClick = tbSelectClick
    end
  end
  object gbSelect: TGroupBox [3]
    Left = 0
    Top = 40
    Width = 981
    Height = 152
    Align = alTop
    TabOrder = 3
    Visible = False
    object lDateTimeSelect: TLabel
      Left = 120
      Top = 9
      Width = 31
      Height = 13
      Caption = #1055#1088#1080#1077#1084
    end
    object PanelSelectButton: TPanel
      Left = 2
      Top = 125
      Width = 977
      Height = 25
      Align = alBottom
      TabOrder = 0
      object btnCancelSelect: TBitBtn
        Left = 101
        Top = 1
        Width = 100
        Height = 23
        Align = alLeft
        Caption = #1054#1090#1082#1072#1079#1072#1090#1100#1089#1103
        Kind = bkCancel
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnCancelSelectClick
      end
      object btnSelect: TBitBtn
        Left = 1
        Top = 1
        Width = 100
        Height = 23
        Align = alLeft
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100
        Kind = bkOK
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnSelectClick
      end
    end
    object DateTimePickerSelect: TDateTimePicker
      Left = 157
      Top = 6
      Width = 186
      Height = 21
      Date = 43833.000000000000000000
      Time = 0.991909930555266300
      TabOrder = 1
    end
    object PanelSelectSelect: TPanel
      Left = 2
      Top = 31
      Width = 977
      Height = 94
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      inline FrameSelectPatiensSelect: TFrameSelect
        Left = 0
        Top = 0
        Width = 977
        Height = 28
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 977
        inherited Panel: TPanel
          Width = 977
          ExplicitWidth = 977
          inherited sbStart: TSpeedButton
            Top = 5
            ExplicitTop = 5
          end
          inherited leNumber: TLabeledEdit
            Top = 5
            EditLabel.ExplicitTop = 9
            OnDblClick = FrameSelectPatiensSelectleNumberDblClick
            ExplicitTop = 5
          end
        end
      end
      inline FrameSelectDoctorSelect: TFrameSelect
        Left = 0
        Top = 28
        Width = 977
        Height = 28
        Align = alTop
        TabOrder = 1
        ExplicitTop = 28
        ExplicitWidth = 977
        inherited Panel: TPanel
          Width = 977
          ExplicitWidth = 977
          inherited leNumber: TLabeledEdit
            OnDblClick = FrameSelectDoctorSelectleNumberDblClick
          end
        end
      end
      inline FrameSelectDiagnosesSelect: TFrameSelect
        Left = 0
        Top = 56
        Width = 977
        Height = 28
        Align = alTop
        TabOrder = 2
        ExplicitTop = 56
        ExplicitWidth = 977
        inherited Panel: TPanel
          Width = 977
          ExplicitWidth = 977
          inherited leNumber: TLabeledEdit
            OnDblClick = FrameSelectDiagnosesSelectleNumberDblClick
          end
        end
      end
    end
  end
end
