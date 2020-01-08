object FormPeoples: TFormPeoples
  Left = 0
  Top = 0
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
  inline FramePeoples1: TFramePeoples
    Left = 0
    Top = 0
    Width = 639
    Height = 448
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 639
    ExplicitHeight = 448
    inherited gbPanel: TGroupBox
      Top = 331
      Width = 639
      ExplicitTop = 331
      ExplicitWidth = 639
      inherited btnPanel: TPanel
        Width = 635
        ExplicitWidth = 635
      end
    end
    inherited GridPanel: TPanel
      Top = 84
      Width = 639
      Height = 247
      ExplicitTop = 84
      ExplicitWidth = 639
      ExplicitHeight = 247
      inherited Grid: TStringGrid
        Width = 629
        Height = 237
        ExplicitWidth = 629
        ExplicitHeight = 237
      end
    end
    inherited ToolBar: TToolBar
      Width = 639
      Height = 84
      ExplicitWidth = 639
      ExplicitHeight = 84
      inherited sbNew: TToolButton
        ExplicitWidth = 80
      end
      inherited sbEdit: TToolButton
        Left = 141
        ExplicitLeft = 141
      end
      inherited sbKill: TToolButton
        Left = 221
        ExplicitLeft = 221
      end
      inherited tbSep1: TToolButton
        Left = 301
        ExplicitLeft = 301
      end
      inherited sbRefresh: TToolButton
        Left = 309
        ExplicitLeft = 309
      end
      inherited tbSep: TToolButton
        Left = 0
        Wrap = True
        ExplicitLeft = 0
        ExplicitHeight = 44
      end
      inherited SelectAllButton: TToolButton
        Left = 0
        Top = 44
        ExplicitLeft = 0
        ExplicitTop = 44
      end
      inherited UnSelectAllButton: TToolButton
        Left = 80
        Top = 44
        ExplicitLeft = 80
        ExplicitTop = 44
      end
      inherited InvertSelectButton: TToolButton
        Left = 160
        Top = 44
        ExplicitLeft = 160
        ExplicitTop = 44
      end
      inherited tbDoc: TToolButton
        Left = 240
        Top = 44
        ExplicitLeft = 240
        ExplicitTop = 44
      end
      inherited tbAddress: TToolButton
        Left = 320
        Top = 44
        ExplicitLeft = 320
        ExplicitTop = 44
      end
      inherited tbComm: TToolButton
        Left = 400
        Top = 44
        ExplicitLeft = 400
        ExplicitTop = 44
      end
      inherited tbDoctor: TToolButton
        Left = 480
        Top = 44
        ExplicitLeft = 480
        ExplicitTop = 44
      end
      inherited ToolButton4: TToolButton
        Left = 560
        Top = 44
        ExplicitLeft = 560
        ExplicitTop = 44
      end
      inherited ToolButton2: TToolButton
        Left = 576
        Top = 44
        ExplicitLeft = 576
        ExplicitTop = 44
      end
      inherited tbSelect: TToolButton
        Left = 61
        ExplicitLeft = 61
      end
    end
  end
end
