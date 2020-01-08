object FormDoctor: TFormDoctor
  Left = 0
  Top = 0
  Caption = #1042#1088#1072#1095
  ClientHeight = 394
  ClientWidth = 860
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
  inline FrameDoctors1: TFrameDoctors
    Left = 0
    Top = 0
    Width = 860
    Height = 394
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -2
    ExplicitTop = -107
    ExplicitWidth = 860
    ExplicitHeight = 394
    inherited gbPanel: TGroupBox
      Top = 237
      Width = 860
      ExplicitTop = 237
      ExplicitWidth = 860
      inherited btnPanel: TPanel
        Width = 856
        ExplicitWidth = 856
      end
    end
    inherited GridPanel: TPanel
      Width = 860
      Height = 197
      ExplicitWidth = 860
      ExplicitHeight = 197
      inherited Grid: TStringGrid
        Width = 850
        Height = 187
        ExplicitWidth = 850
        ExplicitHeight = 187
      end
    end
    inherited ToolBar: TToolBar
      Width = 860
      ExplicitWidth = 860
    end
  end
end
