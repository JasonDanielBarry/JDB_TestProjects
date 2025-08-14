object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Test Generic Drawing Canvas'
  ClientHeight = 811
  ClientWidth = 1715
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1715
    Height = 811
    ActivePage = TabSheetGenericXYDrawing
    Align = alClient
    TabOrder = 0
    object TabSheetGenericLTDrawing: TTabSheet
      Caption = 'Generic LT Drawing'
      object PaintBox_LT: TPaintBox
        Left = 0
        Top = 0
        Width = 1707
        Height = 781
        Align = alClient
        OnPaint = PaintBox_LTPaint
        ExplicitTop = 3
      end
    end
    object TabSheetGenericXYDrawing: TTabSheet
      Caption = 'Generic XY Drawing'
      ImageIndex = 1
      object EsPaintBox_XY: TEsPaintBox
        Left = 0
        Top = 0
        Width = 1707
        Height = 781
        Align = alClient
        TabOrder = 0
        OnPaint = EsPaintBox_XYPaint
        IsCachedBuffer = True
        ExplicitLeft = 472
        ExplicitTop = 392
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
  end
end
