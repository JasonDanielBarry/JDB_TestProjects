unit TestGenericDrawingCanvasMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages,
    System.SysUtils, System.Variants, System.Classes, system.Types, System.UITypes,
    Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,

    GenericLTEntityCanvasClass,
    Direct2DXYEntityCanvasClass
    ;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabSheetDirect2DLT: TTabSheet;
    PaintBoxD2D_LT: TPaintBox;
    procedure PaintBoxD2D_LTPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

    procedure drawGraphic(const genericLTCanvasIn : TGenericLTEntityCanvas);
        begin
            //arc entity
                var arcCentrePoint : TPointF := PointF( 80, 75 );

                genericLTCanvasIn.setBrushFillProperties( True, TColors.Blueviolet );
                genericLTCanvasIn.setPenLineProperties( 3, clBlack, TPenStyle.psDash );
                genericLTCanvasIn.drawLTArcF( True, True, 60, 300, 75, 50, arcCentrePoint );

                arcCentrePoint := PointF( 90, 75 );
                genericLTCanvasIn.setBrushFillProperties( True, TColors.Blueviolet );
                genericLTCanvasIn.setPenLineProperties( 3, clBlack, TPenStyle.psDash );
                genericLTCanvasIn.drawLTArcF( True, False, -60, 60, 75, 50, arcCentrePoint );

                arcCentrePoint := PointF( 100, 75 );
                genericLTCanvasIn.setBrushFillProperties( True, TColors.Blueviolet );
                genericLTCanvasIn.setPenLineProperties( 3, clBlack, TPenStyle.psDash );
                genericLTCanvasIn.drawLTArcF( False, True, -60, 60, 75, 50, arcCentrePoint );

            //ellipse entity
                var ellipseHandlePoint : TPointF := PointF( 175, 300 );

                genericLTCanvasIn.setPenLineProperties( 5, clBlue, TPenStyle.psSolid );
                genericLTCanvasIn.setBrushFillProperties( False, TColors.Null );
                genericLTCanvasIn.setBrushFillProperties( True, TColors.Cyan );

                genericLTCanvasIn.rotateCanvasLT( -45, ellipseHandlePoint );
                genericLTCanvasIn.drawLTEllipseF( True, True, 50, 75, ellipseHandlePoint, THorzRectAlign.Center, TVertRectAlign.Center );
                genericLTCanvasIn.resetCanvasRotation();

                genericLTCanvasIn.setBrushFillProperties( True, TColors.Indianred );
                genericLTCanvasIn.drawLTEllipseF( True, True, 150, 100, ellipseHandlePoint, THorzRectAlign.Right, TVertRectAlign.Bottom );
                genericLTCanvasIn.drawLTEllipseF( True, True, 150, 100, ellipseHandlePoint, THorzRectAlign.Left, TVertRectAlign.Top );

            //rectangle entity
                var rectangleHandPoint : TPointF := PointF( 175, 600 );

                genericLTCanvasIn.setPenLineProperties( 7, clGray, TPenStyle.psSolid );

                genericLTCanvasIn.setBrushFillProperties( True, TColors.Blueviolet );
                genericLTCanvasIn.drawLTRectangleF( True, True, 225, 350, 50, 50, rectangleHandPoint, THorzRectAlign.Center, TVertRectAlign.Center );

                genericLTCanvasIn.setBrushFillProperties( True, TColors.Darkorange );
                genericLTCanvasIn.drawLTRectangleF( True, True, 100, 150, 10, 10, rectangleHandPoint, THorzRectAlign.Right, TVertRectAlign.Bottom );
                genericLTCanvasIn.drawLTRectangleF( True, True, 100, 150, 30, 30, rectangleHandPoint, THorzRectAlign.Left, TVertRectAlign.Top );

            //text
                var textHandlePoint : TPointF := PointF( 450, 50 );
                genericLTCanvasIn.printLTTextF( 30, 'Centre-Centre, Size 30', textHandlePoint, True, clMaroon, [fsBold], THorzRectAlign.Center, TVertRectAlign.Center );
                genericLTCanvasIn.printLTTextF( 15, 'Right-Bottom, Size 15', textHandlePoint, False, clWindowText, [fsBold, fsItalic, fsUnderline], THorzRectAlign.Right, TVertRectAlign.Bottom );
                genericLTCanvasIn.printLTTextF( 20, 'Left-Top, Size 20', textHandlePoint, False, clHighlight, [fsBold, fsUnderline], THorzRectAlign.Left, TVertRectAlign.Top );
        end;

    procedure TMainForm.PaintBoxD2D_LTPaint(Sender: TObject);
        var
            canvasRect      : TRect;
            renderBitmap    : TBitmap;
            D2DCanvas       : TDirect2DXYEntityCanvas;
        begin
            canvasRect := PaintBoxD2D_LT.ClientRect;

            renderBitmap := TBitmap.Create( canvasRect.Width, canvasRect.Height );

            D2DCanvas := TDirect2DXYEntityCanvas.Create();

            D2DCanvas.beginDrawing( renderBitmap );

            drawGraphic( D2DCanvas );

            D2DCanvas.endDrawing();

            FreeAndNil( D2DCanvas );

            PaintBoxD2D_LT.Canvas.Draw( 0, 0, renderBitmap );

            FreeAndNil( renderBitmap );
        end;

end.
