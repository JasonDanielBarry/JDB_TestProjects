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
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1715
    Height = 811
    ActivePage = TabSheetDirect2DLT
    Align = alClient
    TabOrder = 0
    object TabSheetDirect2DLT: TTabSheet
      Caption = 'Direct2D-LT'
      object PaintBoxD2D_LT: TPaintBox
        Left = 0
        Top = 0
        Width = 1707
        Height = 781
        Align = alClient
        ExplicitLeft = 208
        ExplicitTop = 208
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
  end
end
