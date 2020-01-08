object FormCommunicationType: TFormCommunicationType
  Left = 0
  Top = 0
  Caption = #1058#1080#1087#1099' '#1082#1086#1084#1084#1091#1085#1080#1082#1072#1094#1080#1081
  ClientHeight = 480
  ClientWidth = 930
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
  inline FrameCommunicationType1: TFrameCommunicationType
    Left = 0
    Top = 0
    Width = 930
    Height = 480
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 930
    ExplicitHeight = 480
    inherited gbPanel: TGroupBox
      Top = 373
      Width = 930
      ExplicitTop = 373
      ExplicitWidth = 930
      inherited btnPanel: TPanel
        Width = 926
        ExplicitWidth = 926
      end
    end
    inherited GridPanel: TPanel
      Width = 930
      Height = 333
      ExplicitWidth = 930
      ExplicitHeight = 333
      inherited Grid: TStringGrid
        Width = 920
        Height = 323
        ExplicitWidth = 920
        ExplicitHeight = 323
      end
    end
    inherited ToolBar: TToolBar
      Width = 930
      ExplicitWidth = 930
      inherited sbNew: TToolButton
        ExplicitWidth = 61
      end
    end
  end
end
