object FormAddressType: TFormAddressType
  Left = 0
  Top = 0
  Caption = #1058#1080#1087' '#1072#1076#1088#1077#1089#1072
  ClientHeight = 326
  ClientWidth = 824
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
  inline FrameAddressType1: TFrameAddressType
    Left = 0
    Top = 0
    Width = 824
    Height = 326
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 824
    ExplicitHeight = 326
    inherited gbPanel: TGroupBox
      Top = 219
      Width = 824
      ExplicitTop = 219
      ExplicitWidth = 824
      inherited btnPanel: TPanel
        Width = 820
        ExplicitWidth = 820
      end
    end
    inherited GridPanel: TPanel
      Width = 824
      Height = 179
      ExplicitWidth = 824
      ExplicitHeight = 179
      inherited Grid: TStringGrid
        Width = 814
        Height = 169
        ExplicitWidth = 814
        ExplicitHeight = 169
      end
    end
    inherited ToolBar: TToolBar
      Width = 824
      ExplicitWidth = 824
      inherited sbNew: TToolButton
        ExplicitWidth = 57
      end
    end
  end
end
