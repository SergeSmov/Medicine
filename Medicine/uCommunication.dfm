object FormCommunication: TFormCommunication
  Left = 0
  Top = 0
  Caption = #1050#1086#1084#1084#1091#1085#1080#1082#1072#1094#1080#1080
  ClientHeight = 416
  ClientWidth = 805
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
  inline FrameCommunication1: TFrameCommunication
    Left = 0
    Top = 0
    Width = 805
    Height = 416
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 70
    ExplicitTop = 61
    inherited gbPanel: TGroupBox
      Top = 309
      Width = 805
      inherited btnPanel: TPanel
        Width = 801
        inherited btnCancel: TBitBtn
          ExplicitLeft = 101
        end
      end
      inherited leNumber: TLabeledEdit
        EditLabel.ExplicitLeft = 0
        EditLabel.ExplicitTop = -16
        EditLabel.ExplicitWidth = 45
      end
    end
    inherited GridPanel: TPanel
      Width = 805
      Height = 269
      inherited Grid: TStringGrid
        Width = 795
        Height = 259
      end
    end
    inherited ToolBar: TToolBar
      Width = 805
      ExplicitWidth = 805
    end
  end
end
