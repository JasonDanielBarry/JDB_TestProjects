unit TestGenericDrawingCanvasMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabSheetDirect2DLT: TTabSheet;
    PaintBoxD2D_LT: TPaintBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

end.
