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
        Top = 35
        Width = 1707
        Height = 746
        Align = alClient
        OnPaint = PaintBox_LTPaint
        ExplicitTop = 3
        ExplicitHeight = 781
      end
      object PanelLTButtons: TPanel
        Left = 0
        Top = 0
        Width = 1707
        Height = 35
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object ButtonSaveLTMetafile: TButton
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 100
          Height = 25
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alLeft
          Caption = 'Save To Metafile'
          TabOrder = 0
          OnClick = ButtonSaveLTMetafileClick
        end
      end
    end
    object TabSheetGenericXYDrawing: TTabSheet
      Caption = 'Generic XY Drawing'
      ImageIndex = 1
      object EsPaintBox_XY: TEsPaintBox
        Left = 0
        Top = 35
        Width = 1707
        Height = 746
        Align = alClient
        TabOrder = 0
        OnPaint = EsPaintBox_XYPaint
        IsCachedBuffer = True
        ExplicitTop = 0
        ExplicitHeight = 781
      end
      object PanelXYOptions: TPanel
        Left = 0
        Top = 0
        Width = 1707
        Height = 35
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object ButtonXYMetafile: TButton
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 100
          Height = 25
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alLeft
          Caption = 'Save To Metafile'
          TabOrder = 0
          OnClick = ButtonXYMetafileClick
          ExplicitLeft = 0
          ExplicitTop = 2
        end
      end
    end
  end
end
