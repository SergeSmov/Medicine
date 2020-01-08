object FormDocumentType: TFormDocumentType
  Left = 0
  Top = 0
  Caption = #1058#1080#1087#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  ClientHeight = 397
  ClientWidth = 679
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
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inline FrameDocumentType1: TFrameDocumentType
    Left = 0
    Top = 0
    Width = 679
    Height = 397
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -56
    ExplicitTop = 42
    inherited gbPanel: TGroupBox
      Top = 290
      Width = 679
      inherited btnPanel: TPanel
        Width = 675
        ExplicitTop = 80
      end
      inherited leCode: TLabeledEdit
        EditLabel.ExplicitLeft = 0
        EditLabel.ExplicitTop = -16
        EditLabel.ExplicitWidth = 33
      end
      inherited leName: TLabeledEdit
        EditLabel.ExplicitLeft = 0
        EditLabel.ExplicitTop = -16
        EditLabel.ExplicitWidth = 35
      end
    end
    inherited GridPanel: TPanel
      Width = 679
      Height = 250
      ExplicitHeight = 208
      inherited Grid: TStringGrid
        Width = 669
        Height = 240
        ExplicitHeight = 198
      end
    end
    inherited ToolBar: TToolBar
      Width = 679
      inherited sbNew: TToolButton
        ExplicitWidth = 61
      end
    end
  end
end
