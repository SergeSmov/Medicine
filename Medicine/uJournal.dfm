object FormJournal: TFormJournal
  Left = 0
  Top = 0
  Align = alTop
  Caption = #1046#1091#1088#1085#1072#1083
  ClientHeight = 405
  ClientWidth = 845
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inline FrameJournal1: TFrameJournal
    Left = 0
    Top = 0
    Width = 845
    Height = 405
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 845
    ExplicitHeight = 405
    inherited gbPanel: TGroupBox
      Top = 194
      Width = 845
      ExplicitTop = 194
      ExplicitWidth = 845
      inherited PanelParents: TPanel [0]
        Width = 841
        ExplicitWidth = 841
        inherited PanelSelect: TPanel
          Width = 841
          ExplicitTop = 69
          ExplicitWidth = 841
          inherited FrameSelectPatiens: TFrameSelect
            Width = 841
            ExplicitWidth = 841
            inherited Panel: TPanel
              Width = 841
              ExplicitWidth = 841
            end
          end
          inherited FrameSelectDoctor: TFrameSelect
            Width = 841
            ExplicitWidth = 841
            inherited Panel: TPanel
              Width = 841
              ExplicitWidth = 841
            end
          end
          inherited FrameSelectDiagnoses: TFrameSelect
            Width = 841
            ExplicitWidth = 841
            inherited Panel: TPanel
              Width = 841
              ExplicitWidth = 841
            end
          end
        end
        inherited leNumber: TLabeledEdit
          EditLabel.ExplicitLeft = 0
          EditLabel.ExplicitTop = -16
          EditLabel.ExplicitWidth = 45
        end
      end
      inherited btnPanel: TPanel [1]
        Width = 841
        ExplicitTop = 184
        ExplicitWidth = 841
      end
    end
    inherited GridPanel: TPanel
      Width = 845
      Height = 2
      ExplicitWidth = 845
      ExplicitHeight = 2
      inherited Grid: TStringGrid
        Width = 835
        Height = 16
        ExplicitWidth = 835
        ExplicitHeight = 16
      end
    end
    inherited ToolBar: TToolBar
      Width = 845
      ExplicitWidth = 845
    end
    inherited gbSelect: TGroupBox
      Width = 845
      ExplicitWidth = 845
      inherited PanelSelectButton: TPanel
        Width = 841
        ExplicitWidth = 841
      end
      inherited PanelSelectSelect: TPanel
        Width = 841
        ExplicitWidth = 841
        inherited FrameSelectPatiensSelect: TFrameSelect
          Width = 841
          ExplicitWidth = 841
          inherited Panel: TPanel
            Width = 841
            ExplicitWidth = 841
          end
        end
        inherited FrameSelectDoctorSelect: TFrameSelect
          Width = 841
          ExplicitWidth = 841
          inherited Panel: TPanel
            Width = 841
            ExplicitWidth = 841
          end
        end
        inherited FrameSelectDiagnosesSelect: TFrameSelect
          Width = 841
          ExplicitWidth = 841
          inherited Panel: TPanel
            Width = 841
            ExplicitWidth = 841
          end
        end
      end
    end
  end
end
