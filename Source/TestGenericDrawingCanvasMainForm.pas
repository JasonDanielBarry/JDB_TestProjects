unit TestGenericDrawingCanvasMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages,
    System.SysUtils, System.Variants, System.Classes, system.Types, System.UITypes, System.Math,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
    ES.BaseControls, ES.PaintBox,

    GeometryTypes, GeomBox,
    DrawingAxisConversionClass,
    CanvasHelperClass,
    GenericLTEntityCanvasClass,
    GenericXYEntityCanvasClass,
    Direct2DXYEntityCanvasClass,
    MetafileXYEntityCanvasClass, Vcl.StdCtrls
    ;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabSheetGenericLTDrawing: TTabSheet;
    PaintBox_LT: TPaintBox;
    TabSheetGenericXYDrawing: TTabSheet;
    EsPaintBox_XY: TEsPaintBox;
    PanelLTButtons: TPanel;
    ButtonSaveLTMetafile: TButton;
    PanelXYOptions: TPanel;
    ButtonXYMetafile: TButton;
    procedure PaintBox_LTPaint(Sender: TObject);
    procedure EsPaintBox_XYPaint(Sender: TObject; Canvas: TCanvas; Rect: TRect);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSaveLTMetafileClick(Sender: TObject);
    procedure ButtonXYMetafileClick(Sender: TObject);
  private
    axisConverter   : TDrawingAxisConverter;
    renderBitmap    : TBitmap;
    D2DCanvas       : TDirect2DXYEntityCanvas;
    metafileCanvas  : TMetafileXYEntityCanvas;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

    procedure TMainForm.FormCreate(Sender: TObject);
        var
            boundingRegion : TGeomBox;
        begin
            axisConverter   := TDrawingAxisConverter.create();
            D2DCanvas       := TDirect2DXYEntityCanvas.Create();
            metafileCanvas  := TMetafileXYEntityCanvas.Create();
            renderBitmap    := TBitmap.Create();

            boundingRegion := TGeomBox.newBox( 1920, 1080 );
            axisConverter.setGraphicBoundary( boundingRegion );
            axisConverter.setDrawingRegion( 5, boundingRegion );
            axisConverter.setZoom( 100 );
        end;

    procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
        begin
            FreeAndNil( axisConverter );
            FreeAndNil( D2DCanvas );
            FreeAndNil( metafileCanvas );
            FreeAndNil( renderBitmap );

            Action := TCloseAction.caFree;
        end;

    //LT Drawing----------------------------------------------------------------------------
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

        procedure TMainForm.PaintBox_LTPaint(Sender: TObject);
            begin
                renderBitmap.SetSize( PaintBox_LT.Width, PaintBox_LT.Height );

                D2DCanvas.beginDrawing( renderBitmap );

                drawLTGraphic( D2DCanvas );

                D2DCanvas.endDrawing();

                PaintBox_LT.Canvas.Draw( 0, 0, renderBitmap );
            end;

    //XY Drawing----------------------------------------------------------------------------
        procedure drawXYArc(const axisConverterIn : TDrawingAxisConverter; const genericXYCanvasIn : TGenericXYEntityCanvas);
            var
                arcCentre : TGeomPoint;
            begin
                genericXYCanvasIn.setBrushFillProperties( True, clOlive );
                genericXYCanvasIn.setPenLineProperties( 3, clBlack, TPenStyle.psDash );

                arcCentre.setPoint( 150, 150 );

                genericXYCanvasIn.rotateCanvasXY( 20, arcCentre, axisConverterIn );

                genericXYCanvasIn.drawXYArc( True, True, 60, 300, 150, 100, arcCentre, axisConverterIn, EScaleType.scDrawing );

                arcCentre.shiftX( 20 );
                genericXYCanvasIn.drawXYArc( True, False, -60, 60, 150, 100, arcCentre, axisConverterIn, EScaleType.scDrawing );

                arcCentre.shiftX( 20 );
                genericXYCanvasIn.drawXYArc( False, True, -60, 60, 150, 100, arcCentre, axisConverterIn, EScaleType.scDrawing );

                genericXYCanvasIn.resetCanvasRotation();
            end;

        procedure drawXYEllipse(const axisConverterIn : TDrawingAxisConverter; const genericXYCanvasIn : TGenericXYEntityCanvas);
            var
                ellipseHandlePoint : TGeomPoint;
            begin
                genericXYCanvasIn.setBrushFillProperties( True, clTeal );
                genericXYCanvasIn.setPenLineProperties( 6, clWebMaroon, TPenStyle.psDashDot );

                ellipseHandlePoint.setPoint( 150, 600 );

                genericXYCanvasIn.drawXYEllipse( True, True, 100, 100, ellipseHandlePoint, axisConverterIn, THorzRectAlign.Center, TVertRectAlign.Center, EScaleType.scCanvas );
                genericXYCanvasIn.drawXYEllipse( True, True, 200, 300, ellipseHandlePoint, axisConverterIn, THorzRectAlign.Right, TVertRectAlign.Bottom, EScaleType.scDrawing );
                genericXYCanvasIn.drawXYEllipse( True, True, 200, 300, ellipseHandlePoint, axisConverterIn, THorzRectAlign.Left, TVertRectAlign.Top, EScaleType.scDrawing );
            end;

        procedure drawXYLine(const axisConverterIn : TDrawingAxisConverter; const genericXYCanvasIn : TGenericXYEntityCanvas);
            var
                arrPoints : TArray<TGeomPoint>;
            begin
                genericXYCanvasIn.setPenLineProperties( 10, clBlack, TPenStyle.psDashDotDot );

                SetLength( arrPoints, 2 );

                arrPoints[0].setPoint( 1250, 400 );
                arrPoints[1].setPoint( 1750, 650 );

                genericXYCanvasIn.drawXYLine( arrPoints, axisConverterIn );
            end;

        procedure drawXYPolyline(const axisConverterIn : TDrawingAxisConverter; const genericXYCanvasIn : TGenericXYEntityCanvas);
            var
                i           : integer;
                x, y, piVal : double;
                arrPoints   : TArray<TGeomPoint>;
            begin
                SetLength( arrPoints, 1001 );

                piVal := Pi();

                for i := 0 to 1000 do
                    begin
                        x := (4 * piVal) * i/1000;
                        y := sin( x );

                        arrPoints[i].setPoint( 1250 + 50 * x, 250 + 75 * y );
                    end;

                genericXYCanvasIn.setPenLineProperties( 5, clBlue, TPenStyle.psSolid );

                genericXYCanvasIn.drawXYPolyline( arrPoints, axisConverterIn );
            end;

        procedure drawXYPolygon(const axisConverterIn : TDrawingAxisConverter; const genericXYCanvasIn : TGenericXYEntityCanvas);
            var
                arrPoints : TArray<TGeomPoint>;
            begin
                genericXYCanvasIn.setBrushFillProperties( True, clRed );
                genericXYCanvasIn.setPenLineProperties( 7, clNavy, TPenStyle.psSolid );

                arrPoints := TGeomPoint.createPointArray( [100, 25, 0, -25, -100, -25, 0, 25], [0, 25, 100, 25, 0, -25, -100, -25] );

                TGeomPoint.shiftArrPointsByVector( TGeomPoint.create(0, 0), TGeomPoint.create( 1000, 225 ), arrPoints );

                TGeomPoint.scalePoints( 2, arrPoints );

                genericXYCanvasIn.drawXYPolygon( True, True, arrPoints, axisConverterIn );
            end;

        procedure drawXYRectangle(const axisConverterIn : TDrawingAxisConverter; const genericXYCanvasIn : TGenericXYEntityCanvas);
            var
                rectangleHandlePoint : TGeomPoint;
            begin
                genericXYCanvasIn.setBrushFillProperties( True, clSilver );
                genericXYCanvasIn.setPenLineProperties( 7, clNavy, TPenStyle.psSolid );

                rectangleHandlePoint.setPoint( 600, 600 );

                genericXYCanvasIn.drawXYRectangle( True, True, 450, 650, 60, rectangleHandlePoint, axisConverterIn, THorzRectAlign.Center, TVertRectAlign.Center, EScaleType.scDrawing );
                genericXYCanvasIn.drawXYRectangle( True, True, 100, 100, 0, rectangleHandlePoint, axisConverterIn, THorzRectAlign.Center, TVertRectAlign.Center, EScaleType.scCanvas );
                genericXYCanvasIn.drawXYRectangle( True, True, 200, 300, 15, rectangleHandlePoint, axisConverterIn, THorzRectAlign.Right, TVertRectAlign.Bottom, EScaleType.scDrawing );
                genericXYCanvasIn.drawXYRectangle( True, True, 200, 300, 30, rectangleHandlePoint, axisConverterIn, THorzRectAlign.Left, TVertRectAlign.Top, EScaleType.scDrawing );
            end;

        procedure drawXYText(const axisConverterIn : TDrawingAxisConverter; const genericXYCanvasIn : TGenericXYEntityCanvas);
            var
                textHandlePoint : TGeomPoint;
            begin
                textHandlePoint.setPoint( 750, 750 );

                genericXYCanvasIn.printXYText(  'centre-centre' + sLineBreak + 'Size 12' + sLineBreak + 'Canvas Scale' + sLineBreak + 'With Underlay',
                                                textHandlePoint,
                                                axisConverterIn,
                                                True,
                                                12,
                                                THorzRectAlign.Right,
                                                TVertRectAlign.Bottom,
                                                EScaleType.scCanvas,
                                                clBlue,
                                                [fsBold],
                                                'Segoe UI'                                                              );

                textHandlePoint.setPoint( 1250, 750 );

                genericXYCanvasIn.printXYText(  'right-bottom' + sLineBreak + 'Size 40' + sLineBreak + 'Drawing Scale',
                                                textHandlePoint,
                                                axisConverterIn,
                                                False,
                                                40,
                                                THorzRectAlign.Right,
                                                TVertRectAlign.Bottom,
                                                EScaleType.scDrawing,
                                                clBlack,
                                                [fsBold, fsItalic, fsUnderline],
                                                'Segoe UI'                                                              );

                genericXYCanvasIn.printXYText(  'left-Top' + sLineBreak + 'Size 30' + sLineBreak + 'Drawing Scale',
                                                textHandlePoint,
                                                axisConverterIn,
                                                False,
                                                30,
                                                THorzRectAlign.Left,
                                                TVertRectAlign.Top,
                                                EScaleType.scDrawing,
                                                clGrayText,
                                                [fsBold, fsItalic, fsUnderline],
                                                'Segoe UI'                                                              );
            end;

        procedure drawXYGraphic(const canvasWidthIn, canvasHeightIn : integer; const axisConverterIn : TDrawingAxisConverter; const genericXYCanvasIn : TGenericXYEntityCanvas);
            begin
                axisConverterIn.setCanvasDimensions( canvasWidthIn, canvasHeightIn );
                axisConverterIn.setDrawingSpaceRatio( 1 );

                //arc entity
                    drawXYArc( axisConverterIn, genericXYCanvasIn );

                //ellipse entity
                    drawXYEllipse( axisConverterIn, genericXYCanvasIn );

                //line entity
                    drawXYLine( axisConverterIn, genericXYCanvasIn );

                //polyline entity
                    drawXYPolyline( axisConverterIn, genericXYCanvasIn );

                //polygon entity
                    drawXYPolygon( axisConverterIn, genericXYCanvasIn );

                //rectangle entity
                    drawXYRectangle( axisConverterIn, genericXYCanvasIn );

                //text entity
                    drawXYText( axisConverterIn, genericXYCanvasIn );
            end;

        procedure TMainForm.EsPaintBox_XYPaint(Sender: TObject; Canvas: TCanvas; Rect: TRect);
            begin
                renderBitmap.SetSize( Rect.Width, Rect.Height );

                D2DCanvas.beginDrawing( renderBitmap );

                drawXYGraphic( Rect.Width, Rect.Height, axisConverter, D2DCanvas );

                D2DCanvas.endDrawing();

                Canvas.Draw( 0, 0, renderBitmap );
            end;

    //metafile
        procedure TMainForm.ButtonSaveLTMetafileClick(Sender: TObject);
            begin
                metafileCanvas.beginDrawing( PaintBox_LT.Width, PaintBox_LT.Height );

                drawLTGraphic( metafileCanvas );

                metafileCanvas.saveToFile('../MetafileLTTest.emf');
            end;

        procedure TMainForm.ButtonXYMetafileClick(Sender: TObject);
            begin
                metafileCanvas.beginDrawing( EsPaintBox_XY.Width, EsPaintBox_XY.Height );

                drawXYGraphic( EsPaintBox_XY.Width, EsPaintBox_XY.Height, axisConverter, metafileCanvas );

                metafileCanvas.saveToFile('../MetafileXYTest.emf');
            end;

end.
