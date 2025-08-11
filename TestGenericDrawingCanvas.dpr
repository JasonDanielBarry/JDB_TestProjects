program TestGenericDrawingCanvas;

uses
  Vcl.Forms,
  TestGenericDrawingCanvasMainForm in 'Source\TestGenericDrawingCanvasMainForm.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
