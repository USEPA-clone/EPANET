{====================================================================
 Project:      EPANET Graphical User Interface
 Version:      2.3
 Module:       mapoptions
 Description:  a dialog form used to set network map display options
 Authors:      see AUTHORS
 Copyright:    see AUTHORS
 License:      see LICENSE
 Last Updated: 02/16/2025
=====================================================================}
unit mapoptions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin,
  ColorBox, ExtCtrls, lclIntf;

type
  TMapOptions = record
    NodeSize       : Integer;
    ShowNodesBySize: Boolean;
    ShowNodeBorder : Boolean;
    ShowNodes      : Boolean;
    ShowJunctions  : Boolean;
    ShowTanks      : Boolean;
    LinkSize       : Integer;
    ShowLinksBySize: Boolean;
    ShowLinkBorder : Boolean;
    ShowLinkArrows : Boolean;
    ArrowSize      : Integer;
    ArrowZoom      : Integer;
    ShowNodeIDs    : Boolean;
    ShowNodeValues : Boolean;
    ShowLinkIDs    : Boolean;
    ShowLinkValues : Boolean;
    NotationOpaque : Boolean;
    NotationSize   : Integer;
    NotationZoom   : Integer;
    ShowLinks      : Boolean;
    ShowPumps      : Boolean;
    ShowValves     : Boolean;
    ShowLabels     : Boolean;
    ShowBackdrop   : Boolean;
    BackColor      : TColor;
    EditorPage     : Integer;
  end;

const
  DarkColor = $004C4641;
  BackColors: array [0..7] of TColor =
    (clWhite, $00F0FBFF, $00E1FFFF, $00F0FFE0, $00FFFFF0, $00F8F8F8, $00FDEEE3,
     DarkColor);
  ColorNames: array [0..7] of String =
    ('White','Cream','Yellow','Green','Cyan','Gray','Blue','Black');

  DefaultOptions : TMapOptions =
    (NodeSize        : 4;
     ShowNodesBySize : false;
     ShowNodeBorder  : true;
     ShowNodes       : true;
     ShowJunctions   : true;
     ShowTanks       : true;
     LinkSize        : 1;
     ShowLinksBySize : false;
     ShowLinkBorder  : false;
     ShowLinkArrows  : false;
     ArrowSize       : 4;
     ArrowZoom       : 0;
     ShowNodeIDs     : false;
     ShowNodeValues  : false;
     ShowLinkIDs     : false;
     ShowLinkValues  : false;
     NotationOpaque  : false;
     NotationSize    : 8;
     NotationZoom    : 0;
     ShowLinks       : true;
     ShowPumps       : true;
     ShowValves      : true;
     ShowLabels      : true;
     ShowBackdrop    : true;
     BackColor       : clWhite;
     EditorPage      : 0);

type

  { TMapOptionsForm }

  TMapOptionsForm = class(TForm)
    Annotations: TPage;
    AntiAliasingChk: TCheckBox;
    ResetExtentsChk: TCheckBox;
    Label8: TLabel;
    OtherPage: TPage;
    Background: TPage;
    OkBtn: TButton;
    CancelBtn: TButton;
    ArrowsChk: TCheckBox;
    LinkBorderChk: TCheckBox;
    LinksBySizeChk: TCheckBox;
    NodeBorderChk: TCheckBox;
    NodesBySizeChk: TCheckBox;
    ShowNodeIDsChk: TCheckBox;
    ShowNodeValuesChk: TCheckBox;
    ShowLinkIDsChk: TCheckBox;
    ShowLinkValuesChk: TCheckBox;
    OpaqueTextChk: TCheckBox;
    AutoLengthChk: TCheckBox;
    BackColorClb: TColorListBox;
    FlowArrows: TPage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Links: TPage;
    LinkShape: TShape;
    ListBox1: TListBox;
    Nodes: TPage;
    NodeShape: TShape;
    Notebook1: TNotebook;
    BtnPanel: TPanel;
    Panel2: TPanel;
    ArrowSizeEdit: TSpinEdit;
    LinkSizeEdit: TSpinEdit;
    NotationSizeEdit: TSpinEdit;
    NodeSizeEdit: TSpinEdit;
    NotationZoomEdit: TSpinEdit;
    ArrowZoomEdit: TSpinEdit;
    procedure btnOkClick(Sender: TObject);
    procedure LinkBorderChkChange(Sender: TObject);
    procedure NodeBorderChkChange(Sender: TObject);
    procedure BackColorClbGetColors(Sender: TCustomColorListBox;
      Items: TStrings);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure LinkSizeEditChange(Sender: TObject);
    procedure NodeSizeEditChange(Sender: TObject);
  private
    Options: TMapOptions;
    procedure SetNodeShape;
    procedure SetLinkShape;

  public

  end;

var
  MapOptionsForm: TMapOptionsForm;

function Edit(var theOptions: TMapOptions): Boolean;

implementation

{$R *.lfm}

uses
  main, config, project, mapcoords;

function Edit(var theOptions: TMapOptions): Boolean;
var
  OptionsForm: TMapOptionsForm;
begin
  Result := false;
  OptionsForm := TMapOptionsForm.Create(MainForm);
  try
    OptionsForm.BackColorClb.Selected := clBlack;
    OptionsForm.Options := theOptions;
    OptionsForm.ShowModal;
    if OptionsForm.ModalResult = mrOK then
    begin
      theOptions := OptionsForm.Options;
      Result := true;
    end;
  finally
    OptionsForm.Free;
  end;
end;

procedure TMapOptionsForm.FormCreate(Sender: TObject);
begin
  Color := config.ThemeColor;
  Font.Size := config.FontSize;
end;

procedure TMapOptionsForm.FormShow(Sender: TObject);
begin
  with Options do
  begin
    NodeSizeEdit.Value         := NodeSize;
    NodesBySizeChk.Checked    := ShowNodesBySize;
    NodeBorderChk.Checked     := ShowNodeBorder;
    LinkSizeEdit.Value         := LinkSize;
    LinksBySizeChk.Checked    := ShowLinksBySize;
    LinkBorderChk.Checked     := ShowLinkBorder;
    ShowNodeIDsChk.Checked    := ShowNodeIDs;
    ShowNodeValuesChk.Checked := ShowNodeValues;
    ShowLinkIDsChk.Checked    := ShowLinkIDs;
    ShowLinkValuesChk.Checked := ShowLinkValues;
    OpaqueTextChk.Checked     := NotationOpaque;
    NotationSizeEdit.Value     := NotationSize;
    NotationZoomEdit.Value     := NotationZoom;
    ArrowsChk.Checked         := ShowLinkArrows;
    ArrowSizeEdit.Value        := ArrowSize;
    ArrowZoomEdit.Value        := ArrowZoom;
    BackColorClb.Selected    := BackColor;
    Notebook1.PageIndex      := EditorPage;
    ListBox1.ItemIndex       := EditorPage;
  end;
  AutoLengthChk.Checked := Project.AutoLength;
end;

procedure TMapOptionsForm.btnOkClick(Sender: TObject);
begin
  with Options do
  begin
    NodeSize        := NodeSizeEdit.Value;
    ShowNodesBySize := NodesBySizeChk.Checked;
    ShowNodeBorder  := NodeBorderChk.Checked;
    LinkSize        := LinkSizeEdit.Value;
    ShowLinksBySize := LinksBySizeChk.Checked;
    ShowLinkBorder  := LinkBorderChk.Checked;
    ShowNodeIDs     := ShowNodeIDsChk.Checked;
    ShowNodeValues  := ShowNodeValuesChk.Checked;
    ShowLinkIDs     := ShowLinkIDsChk.Checked;
    ShowLinkValues  := ShowLinkValuesChk.Checked;
    NotationOpaque  := OpaqueTextChk.Checked;
    NotationSize    := NotationSizeEdit.Value;
    NotationZoom    := NotationZoomEdit.Value;
    ShowLinkArrows  := ArrowsChk.Checked;
    ArrowSize       := ArrowSizeEdit.Value;
    ArrowZoom       := ArrowZoomEdit.Value;
    BackColor       := BackColorClb.Selected;
    EditorPage      := Notebook1.PageIndex;
  end;
  project.AutoLength := AutoLengthChk.Checked;
  MainForm.UpdateStatusBar(sbAutoLength, '');
  MainForm.MapPanel.Color := Options.BackColor;
  if ResetExtentsChk.Checked then
    MainForm.MapFrame.Map.Extent := MapCoords.GetBounds(MainForm.MapFrame.GetExtent);
end;

procedure TMapOptionsForm.BackColorClbGetColors(Sender: TCustomColorListBox;
  Items: TStrings);
var
  I: Integer;
begin
  Items.Clear;
  for I := 0 to High(BackColors) do
    Items.AddObject(ColorNames[I], TObject(PtrInt(BackColors[I])));
end;

procedure TMapOptionsForm.LinkBorderChkChange(Sender: TObject);
begin
  SetLinkShape;
end;

procedure TMapOptionsForm.NodeBorderChkChange(Sender: TObject);
begin
  SetNodeShape;
end;

procedure TMapOptionsForm.ListBox1SelectionChange(Sender: TObject; User: boolean
  );
begin
  Notebook1.PageIndex := ListBox1.ItemIndex;
  if ListBox1.ItemIndex = 4 then
    BackColorClb.Selected := Options.BackColor;
end;

procedure TMapOptionsForm.LinkSizeEditChange(Sender: TObject);
begin
  SetLinkShape;
end;

procedure TMapOptionsForm.NodeSizeEditChange(Sender: TObject);
begin
  SetNodeShape;
end;

procedure TMapOptionsForm.SetNodeShape;
var
  H: Integer;
begin
  H:= 2 * NodeSizeEdit.Value;
  if NodeBorderChk.Checked then
  begin
    NodeShape.Pen.Color := clBlack
  end
  else
    NodeShape.Pen.Color := clred;
  NodeShape.Height := H;
  NodeShape.Width := H;
end;

procedure TMapOptionsForm.SetLinkShape;
var
  H: Integer;
begin
  H:= LinkSizeEdit.Value;
  if LinkBorderChk.Checked then
  begin
    Inc(H, 2);
    LinkShape.Pen.Color := clBlack
  end
  else
    LinkShape.Pen.Color := clred;
  LinkShape.Height := H;
end;

end.

