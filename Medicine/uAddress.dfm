object FormAddress: TFormAddress
  Left = 0
  Top = 0
  Caption = #1040#1076#1088#1077#1089
  ClientHeight = 323
  ClientWidth = 743
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
  inline FrameAddress1: TFrameAddress
    Left = 0
    Top = 0
    Width = 743
    Height = 323
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = -32
    inherited gbPanel: TGroupBox
      Top = 216
      Width = 743
      inherited btnPanel: TPanel
        Width = 739
      end
      inherited leAddress: TLabeledEdit
        EditLabel.ExplicitLeft = 0
        EditLabel.ExplicitTop = -16
        EditLabel.ExplicitWidth = 47
      end
    end
    inherited GridPanel: TPanel
      Width = 743
      Height = 176
      inherited Grid: TStringGrid
        Width = 733
        Height = 166
      end
    end
    inherited ToolBar: TToolBar
      Width = 743
      ExplicitWidth = 743
    end
  end
end
