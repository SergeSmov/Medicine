unit fDocumentType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, uData, Common;

type
  TFrameDocumentType = class(TTemplateFrame)
    leCode: TLabeledEdit;
    leName: TLabeledEdit;
  private
    { Private declarations }
  protected
    function GetItemSize: integer; override;
    procedure RefreshListOfItems; override;
    procedure ShowInsertOrUpdatePanel; override;
    procedure InitializeFields(aItem: PBegId); override;
    function GetItemValue(aItem: PBegId; aCol, aRow: integer): string; override;
    procedure ItemInsertOrUpdate(aItem: PBegId); override;
    function GetGridInitItem(Index: integer): integer; override;
    function GridInitCount: integer; override;
    function GetGridColumnDescr(Index: integer): PMyGridColumnDescr; override;
    procedure UpdateCurItem(aWinControl: TWinControl; aItem: PBegId); override;
    function GetDeleteMessage(aItem: PBegId): string; override;
    function DeleteItem(aItem: PBegId): boolean; override;
  public
    { Public declarations }
    procedure InitN; virtual;
  end;

implementation

{$R *.dfm}

const
  agRow              =   0;
  agSelect           =   1;
  agOrdinal          =   2;
  agCode             =   3;
  agName             =   4;
  agLast             =   4;

  GridDescr : Array [ 0 .. agLast ] Of TMyGridColumnDescr = (
    (Width:   30;         Align: 2;      Name: '№';                 Descr: 'Номер строки'),
    (Width:   10;         Align: 1;      Name: '*';          				Descr: 'Выделение'),
    (Width:  120;         Align: 0;      Name: 'Номер';             Descr: 'Номер'),
    (Width:  120;         Align: 1;      Name: 'Код';               Descr: 'Код'),
    (Width:  600;         Align: 0;      Name: 'Наименование';      Descr: 'Наименование')
    );

  GridInitArray : Array [0..agLast] Of Integer = (
    agRow,
    agSelect,
    agOrdinal,
    agCode,
    agName
    );

function TFrameDocumentType.GetItemSize: integer;
begin
  Result := SizeOf(TDocumentType);
end;

procedure TFrameDocumentType.RefreshListOfItems;
var
  List   : TBegList;
begin
  List := nil;

  GetDocumentTypeDetail(List);

  FreeListOfItems := List.Count > 0;

  ListOfItems := List;
  inherited;
end;

procedure TFrameDocumentType.ShowInsertOrUpdatePanel;
begin
  inherited;
  if leCode.CanFocus then leCode.SetFocus;
end;

procedure TFrameDocumentType.InitializeFields(aItem: PBegId);
var
  P     : PDocumentType;
begin
  P := PDocumentType(aItem);
  leCode.Text := String(P.Code);
  leName.Text := String(P.Name);
end;

function TFrameDocumentType.GetItemValue(aItem: PBegId; aCol, aRow: integer): string;
var
  A      : PDocumentType;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  A := PDocumentType(aItem);
  case aCol Of
      agRow               : Result := IntToStr(ARow);
      agSelect            : If Sels[ARow - 1] then Result := '*';
      agOrdinal           : Result := IntToStr(A.Id);
      agCode              : Result := String(A.Code);
      agName              : Result := String(A.Name);
   else Result := '*' + IntToStr(aCol);
  end;

end;

procedure TFrameDocumentType.ItemInsertOrUpdate(aItem: PBegId);
var
  P   : PDocumentType;

  function isExit(Sender : TObject; aDefault : boolean = false) : boolean;
  var
    Ed : TCustomEdit;
    CB : TComboBox;
    TD : TDateTimePicker;
  begin
    Result := aDefault;
    if Sender is TDateTimePicker then
    begin
      TD := Sender as TDateTimePicker;
      if (TD.Date = null) or (aDefault = true) then
      begin
        CheckError(TD);
        Result := true;
      end else CheckError(TD, false);
    end else
    if Sender is TComboBox then
    begin
      CB := Sender as TComboBox;
      if (Trim(CB.Text) = '') or (aDefault = true) then
      begin
        CheckError(CB);
        Result := true;
      end else CheckError(CB, false);
    end else
    if Sender is TCustomEdit then
    begin
      Ed := Sender as TCustomEdit;
      if (Trim(Ed.Text) = '') or (aDefault = true) then
      begin
        CheckError(Ed);
        Result := true;
      end else CheckError(Ed, false);
    end;
  end;

begin
  if not Assigned(aItem) then Exit;

  P := PDocumentType(aItem);
  if isExit(leCode) then Exit;
  if isExit(leName) then Exit;

  ExecDocumentTypePutOrUpdate(P^);
  RefreshListOfItems;
end;

function TFrameDocumentType.GetGridInitItem(Index: integer): integer;
begin
  Result := GridInitArray[Index];
end;

function TFrameDocumentType.GridInitCount: integer;
begin
  Result := agLast + 1;
end;

function TFrameDocumentType.GetGridColumnDescr(Index: integer): PMyGridColumnDescr;
begin
  Result := @GridDescr[Index];
end;

procedure TFrameDocumentType.UpdateCurItem(aWinControl: TWinControl; aItem: PBegId);
var
  P            : PDocumentType;
  TLE          : TLabeledEdit;
begin
  P := PDocumentType(aItem);

  if aWinControl is TLabeledEdit then
  begin
    TLE := aWinControl as TLabeledEdit;
    if TLE = leCode then P.Code := ShortString(Trim(TLE.Text));
    if TLE = leName then P.Name := ShortString(Trim(TLE.Text));
  end;
end;

function TFrameDocumentType.GetDeleteMessage(aItem: PBegId): string;
var
  P  : PDocumentType;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  P := PDocumentType(aItem);
  Result := Format('Удалить "%s"?', [IntToStr(P.Id)]);
end;

function TFrameDocumentType.DeleteItem(aItem: PBegId): boolean;
begin
  Result := False;

  if not Assigned(aItem) then Exit;

  if aItem.Id <> 0
    then ExecDocumentTypeDelete(aItem.Id);
   Result := True;
end;

procedure TFrameDocumentType.InitN;
begin
  CanInsert := false;
  CanKill := False;
  sbNew.Enabled := false;

  inherited Init;

  if FreeListOfItems then
  	if Assigned(ListOfItems) then ListOfItems.MyFreeAll;

  RefreshListOfItems;

	if Parent.Visible then
    if gbPanel.Visible then
      HideInsertOrUpdatePanel;
end;

end.
