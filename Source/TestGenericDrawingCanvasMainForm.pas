unit TestGenericDrawingCanvasMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages,
    System.SysUtils, System.Variants, System.Classes, system.Types, System.UITypes, System.Math,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,

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

    procedure drawLTArc(const genericLTCanvasIn : TGenericLTEntityCanvas);
        begin
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
        end;

    procedure drawLTEllipse(const genericLTCanvasIn : TGenericLTEntityCanvas);
        begin
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
        end;

    procedure drawLTLine(const genericLTCanvasIn : TGenericLTEntityCanvas);
        begin
            var startPoint, endPoint : TPointF;
            startPoint  := PointF( 450, 150 );
            endPoint    := PointF( 650, 200 );

            genericLTCanvasIn.setPenLineProperties( 5, TColors.Blue, TPenStyle.psSolid );
            genericLTCanvasIn.drawLTLineF( startPoint, endPoint );
        end;

    procedure drawLTPolyline(const genericLTCanvasIn : TGenericLTEntityCanvas);
        begin
            var x, y, PiVal : double;
            var polylinePoints : TArray<TPointF>;

            SetLength( polylinePoints, 1000+1 );

            PiVal := pi();

            for var i : integer := 0 to 1000 do
                begin
                    x := 400 * i / 1000;
                    y := 100 * cos( 4 * PiVal * (i/1000) );

                    polylinePoints[i] := PointF(x + 450, y + 300);
                end;

            genericLTCanvasIn.drawLTPolylineF( polylinePoints );
        end;

    procedure drawLTPolygon(const genericLTCanvasIn : TGenericLTEntityCanvas);
        begin
            var polygonCentre : TPointF := PointF( 650, 600 );
            var polygonPoints : TArray<TPointF>;
            SetLength( polygonPoints, 8 );

            polygonPoints[0] := PointF( polygonCentre.x + 150, polygonCentre.y );
            polygonPoints[1] := PointF( polygonCentre.x + 25, polygonCentre.y - 25 );
            polygonPoints[2] := PointF( polygonCentre.x, polygonCentre.y - 150 );
            polygonPoints[3] := PointF( polygonCentre.x - 25, polygonCentre.y - 25 );
            polygonPoints[4] := PointF( polygonCentre.x - 150, polygonCentre.y );
            polygonPoints[5] := PointF( polygonCentre.x - 25, polygonCentre.y + 25 );
            polygonPoints[6] := PointF( polygonCentre.x, polygonCentre.y + 150 );
            polygonPoints[7] := PointF( polygonCentre.x + 25, polygonCentre.y + 25 );

            genericLTCanvasIn.drawLTPolygonF( True, True, polygonPoints );
        end;

    procedure drawLTRectangle(const genericLTCanvasIn : TGenericLTEntityCanvas);
        begin
            var rectangleHandPoint : TPointF := PointF( 175, 600 );

            genericLTCanvasIn.setPenLineProperties( 7, clGray, TPenStyle.psSolid );

            genericLTCanvasIn.setBrushFillProperties( True, TColors.Blueviolet );
            genericLTCanvasIn.drawLTRectangleF( True, True, 225, 350, 50, 50, rectangleHandPoint, THorzRectAlign.Center, TVertRectAlign.Center );

            genericLTCanvasIn.setBrushFillProperties( True, TColors.Darkorange );
            genericLTCanvasIn.drawLTRectangleF( True, True, 100, 150, 10, 10, rectangleHandPoint, THorzRectAlign.Right, TVertRectAlign.Bottom );
            genericLTCanvasIn.drawLTRectangleF( True, True, 100, 150, 30, 30, rectangleHandPoint, THorzRectAlign.Left, TVertRectAlign.Top );
        end;

    procedure drawLTText(const genericLTCanvasIn : TGenericLTEntityCanvas);
        begin
            var textHandlePoint : TPointF := PointF( 500, 50 );
            genericLTCanvasIn.printLTTextF( 40, 'Centre-Centre, Size 40', textHandlePoint, True, clMaroon, [fsBold], THorzRectAlign.Center, TVertRectAlign.Center );
            genericLTCanvasIn.printLTTextF( 15, 'Right-Bottom, Size 15', textHandlePoint, False, clWindowText, [fsBold, fsItalic, fsUnderline], THorzRectAlign.Right, TVertRectAlign.Bottom );
            genericLTCanvasIn.printLTTextF( 20, 'Left-Top, Size 20', textHandlePoint, False, clHighlight, [fsBold, fsUnderline], THorzRectAlign.Left, TVertRectAlign.Top );
        end;

    procedure drawLTGraphic(const genericLTCanvasIn : TGenericLTEntityCanvas);
        begin
            //arc entity
                drawLTArc( genericLTCanvasIn );

            //ellipse entity
                drawLTEllipse( genericLTCanvasIn );

            //line
                drawLTLine( genericLTCanvasIn );

            //polyline
                drawLTPolyline( genericLTCanvasIn );

            //polygon
                drawLTPolygon( genericLTCanvasIn );

            //rectangle entity
                drawLTRectangle( genericLTCanvasIn );

            //text
                drawLTText( genericLTCanvasIn );
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

            drawLTGraphic( D2DCanvas );

            D2DCanvas.endDrawing();

            FreeAndNil( D2DCanvas );

            PaintBoxD2D_LT.Canvas.Draw( 0, 0, renderBitmap );

            FreeAndNil( renderBitmap );
        end;

end.
