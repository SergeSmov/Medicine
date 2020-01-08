object FormPosts: TFormPosts
  Left = 0
  Top = 0
  Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1080
  ClientHeight = 397
  ClientWidth = 646
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
  inline FramePost1: TFramePost
    Left = 0
    Top = 0
    Width = 646
    Height = 397
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -89
    ExplicitTop = 42
    inherited gbPanel: TGroupBox
      Top = 282
      Width = 646
      inherited btnPanel: TPanel
        Width = 642
      end
    end
    inherited GridPanel: TPanel
      Width = 646
      Height = 242
      inherited Grid: TStringGrid
        Width = 636
        Height = 232
      end
    end
    inherited ToolBar: TToolBar
      Width = 646
      ExplicitWidth = 646
      inherited sbNew: TToolButton
        ExplicitWidth = 61
      end
    end
  end
end
