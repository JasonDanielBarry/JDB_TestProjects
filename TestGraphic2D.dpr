program TestGraphic2D;

uses
  Vcl.Forms,
  Graphic2DTest in 'Source\Graphic2DTest.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
