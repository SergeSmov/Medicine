object FormDocument: TFormDocument
  Left = 0
  Top = 0
  Align = alTop
  Caption = #1055#1072#1094#1080#1077#1085#1090#1099
  ClientHeight = 448
  ClientWidth = 639
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
  inline FrameDocument1: TFrameDocument
    Left = 0
    Top = 0
    Width = 639
    Height = 448
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -96
    ExplicitTop = 72
    inherited gbPanel: TGroupBox
      Top = 341
      Width = 639
      inherited btnPanel: TPanel
        Width = 635
        ExplicitTop = 80
      end
      inherited leNumber: TLabeledEdit
        EditLabel.ExplicitLeft = 0
        EditLabel.ExplicitTop = -16
        EditLabel.ExplicitWidth = 45
      end
      inherited leSeries: TLabeledEdit
        EditLabel.ExplicitLeft = 0
        EditLabel.ExplicitTop = -16
        EditLabel.ExplicitWidth = 37
      end
    end
    inherited GridPanel: TPanel
      Width = 639
      Height = 301
      ExplicitHeight = 208
      inherited Grid: TStringGrid
        Width = 629
        Height = 291
        ExplicitHeight = 198
      end
    end
    inherited ToolBar: TToolBar
      Width = 639
      inherited sbNew: TToolButton
        ExplicitWidth = 61
      end
    end
  end
end
