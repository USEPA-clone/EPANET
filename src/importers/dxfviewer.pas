{====================================================================
 Project:      EPANET Graphical User Interface
 Version:      2.3
 Module:       dxviewer
 Description:  draws pipe network from a DXF file onto a bitmap.
 Authors:      see AUTHORS
 Copyright:    see AUTHORS
 License:      see LICENSE
 Last Updated: 02/16/2025
=====================================================================}

unit dxfviewer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

function  ViewDxfFile(DxfFileName: String; Layers: TStringList;
            var Bitmap: TBitmap): Boolean;

implementation

uses
  project, utils, dxfloader;

var
  Xmin, Xmax: Double;      // Horizontal world extent
  Ymin, Ymax: Double;      // Vertical world extent
  CenterP:    TPoint;      // Bitmap center point
  CenterWx:   Double;      // World center X point
  CenterWy:   Double;      // World center Y point
  WPP:        Double;      // World per pixel scaling

function GetPoint(const X: Double; const Y: Double):TPoint;
begin
  Result.X := CenterP.X + Round((X - CenterWx) / WPP);
  Result.Y := CenterP.Y - Round((Y - CenterWy) / WPP);
end;

procedure DrawLink(var Bitmap: TBitmap; var Vx: array of Double;
            var Vy: array of Double; Vcount: Integer);
// Draw a network link with vertices in Vx and Vy on the Bitmap;

var
  P: TPoint;
  I: Integer;
begin
  if Vcount < 2 then exit;
  P := GetPoint(Vx[0], Vy[0]);
  Bitmap.Canvas.MoveTo(P);
  for I := 1 to Vcount-1 do
  begin
    P := GetPoint(Vx[I], Vy[I]);
    Bitmap.Canvas.LineTo(P);
  end;
end;

procedure ScaleBitmap(var Bitmap: TBitmap);
var
  Dx, Dy, WPPx, WPPy: Double;
begin

  // Center of bounding rectangle
  Dx := Double(Xmax - Xmin);
  Dy := Double(Ymax - Ymin);
  CenterWx := Xmin + Dx/2.0;
  CenterWy := Ymin + Dy/2.0;
  CenterP := Point(Bitmap.Width div 2, Bitmap.Height div 2);

  // World distance units per pixel in the X & Y directions
  WPPx := Dx / Bitmap.Width;
  WPPy := Dy / Bitmap.Height;

  // Maintain a 1:1 aspect ratio
  if WPPy > WPPx then WPP := WPPy
  else WPP := WPPx;

end;

function ReadXY(var F: TextFile; var X: Double; var Y: Double): Boolean;
// Read X,Y coordinate values from the extents section of a DXF file.

var
  Code: Integer;
  S: String;
begin
  Result := False;
  ReadLn(F, Code);
  ReadLn(F, S);
  if not utils.Str2Float(S, X) then exit;
  ReadLn(F, Code);
  ReadLn(F, S);
  if not utils.Str2Float(S, Y) then exit;
  Result := True;
end;

function GetExtents(var F: TextFile): Boolean;
// Extract the extents of a drawing contained in a DXF file.

var
  ExtMinFound: Boolean = False;
  ExtMaxFound: Boolean = False;
  Code: Integer;
  Value: String;
begin
  Result := False;
  while not Eof(F) do
  begin
    ReadLn(F, Code);
    ReadLn(F, Value);
    if Code = 9 then
    begin
      if SameText(Value, '$EXTMIN') then
        ExtMinFound := ReadXY(F, Xmin, Ymin)
      else if SameText(Value, '$EXTMAX') then
        ExtMaxFound := ReadXY(F, Xmax, Ymax);
      if ExtMinFound and ExtMaxFound then
      begin
        Result := True;
        exit;
      end;
    end;
  end;
end;

function  ViewDxfFile(DxfFileName: String; Layers: TStringList;
  var Bitmap: TBitmap): Boolean;
// Draw the pipe network extracted from a DXF file onto a bitmap.

var
  F: TextFile;
  Vx: array[0..Project.MAX_VERTICES] of Double;
  Vy: array[0..Project.MAX_VERTICES] of Double;
  Vcount: Integer;
begin
  // Check for valid bitmap object
  Result := False;
  if Bitmap = nil then exit;
  if (Bitmap.Width = 0) or (Bitmap.Height = 0) then exit;

  // Process the DXF file
  AssignFile(F, DxfFileName);
  try
    // Get drawing extents
    Reset(F);
    if not GetExtents(F) then exit;
    if not dxfloader.FindEntitiesSection(F) then exit;

    // Scale Bitmap pixels to drawing extents
    ScaleBitmap(Bitmap);

    // Prepare Bitmap's canvas
    with Bitmap.Canvas do
    begin
      Pen.Color := clBlack;
      Brush.Color := clWhite;
      Brush.Style := bsSolid;
      Rectangle(0, 0, Bitmap.Width, Bitmap.Height);
    end;

    // Extract vertices of each network link and draw it on bitmap
    while not Eof(F) do
    begin
      dxfloader.GetLinkVertices(F, Layers, Vx, Vy, Vcount);
      DrawLink(Bitmap, Vx, Vy, Vcount);
    end;
    Result := True;
  finally
    CloseFile(F);
  end;
end;

end.
