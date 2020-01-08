object FormDiagnoses: TFormDiagnoses
  Left = 0
  Top = 0
  Caption = #1044#1080#1072#1075#1085#1086#1079#1099' '#1087#1086' '#1052#1050#1041'-10'
  ClientHeight = 424
  ClientWidth = 747
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
  inline FrameDiagnoses1: TFrameDiagnoses
    Left = 0
    Top = 0
    Width = 747
    Height = 424
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 747
    ExplicitHeight = 424
    inherited gbPanel: TGroupBox
      Top = 333
      Width = 747
      ExplicitTop = 333
      ExplicitWidth = 747
      inherited btnPanel: TPanel
        Width = 743
        ExplicitWidth = 743
      end
      inherited leName: TLabeledEdit
        OnExit = nil
      end
    end
    inherited GridPanel: TPanel
      Width = 747
      Height = 293
      ExplicitWidth = 747
      ExplicitHeight = 293
      inherited Grid: TStringGrid
        Width = 737
        Height = 283
        ExplicitWidth = 737
        ExplicitHeight = 283
      end
    end
    inherited ToolBar: TToolBar
      Width = 747
      ExplicitWidth = 747
      inherited sbNew: TToolButton
        ExplicitWidth = 57
      end
    end
  end
end
