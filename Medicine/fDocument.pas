unit fDocument;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Common, uData;

type
  TFrameDocument = class(TTemplateFrame)
    leNumber: TLabeledEdit;
    leSeries: TLabeledEdit;
    cbDocumentType: TComboBox;
    lDocumentType: TLabel;
  private
    { Private declarations }
    iPeopleOf : integer;
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
    procedure InitN(aPeopleOf : TId); virtual;
  end;

implementation

{$R *.dfm}

const
  agRow              =   0;
  agSelect           =   1;
  agSeries           =   2;
  agNumber           =   3;
  agDocumentType     =   4;
  agPeopleOf	       =   5;
  agId               =   6;
  agLast             =   6;

  GridDescr : Array [ 0 .. agLast ] Of TMyGridColumnDescr = (
    (Width:   30;         Align: 2;      Name: '№';                 Descr: 'Номер строки'),
    (Width:   10;         Align: 1;      Name: '*';          				Descr: 'Выделение'),
    (Width:  120;         Align: 0;      Name: 'Серия';             Descr: 'Серия'),
    (Width:  120;         Align: 0;      Name: 'Номер';             Descr: 'Номер'),
    (Width:  600;         Align: 1;      Name: 'Тип документа';     Descr: 'Тип документа'),
    (Width:   20;         Align: 0;      Name: 'PeopleOf';          Descr: 'PeopleOf'),
    (Width:   20;         Align: 0;      Name: 'Id';                Descr: 'Id')
    );

  GridInitArray : Array [0..agLast] Of Integer = (
    agRow,
    agSelect,
    agSeries,
    agNumber,
    agDocumentType,
    agPeopleOf,
    agId
    );

function TFrameDocument.GetItemSize: integer;
begin
  Result := SizeOf(TDocument);
end;

procedure TFrameDocument.RefreshListOfItems;
var
  List   : TBegList;
  TDS	   : TDocumentSelect;
begin
  List := nil;

  TDS.Prepare;
  TDS.PeopleOf := iPeopleOf;
  GetDocumentDetail(TDS, List);

  FreeListOfItems := List.Count > 0;

  ListOfItems := List;
  inherited;
end;

procedure TFrameDocument.ShowInsertOrUpdatePanel;
begin
  inherited;
  if leSeries.CanFocus then leSeries.SetFocus;
end;

procedure TFrameDocument.InitializeFields(aItem: PBegId);
var
  P     : PDocument;
  Lst	  : TBegList;
  DT    : PDocumentType;
begin
  cbDocumentType.Clear;
  Lst := nil;
  GetDocumentTypeDetail(Lst);
  for DT in Lst
    do cbDocumentType.Items.Add(String(DT.Name));
  Lst.MyFreeAll;

  P := PDocument(aItem);
  leSeries.Text := String(P.SERIES);
  leNumber.Text := String(P.NUMBER);
  cbDocumentType.Text := String(P.DOCUMENT);
end;

function TFrameDocument.GetItemValue(aItem: PBegId; aCol, aRow: integer): string;
var
  A      : PDocument;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  A := PDocument(aItem);
  case aCol Of
      agRow               : Result := IntToStr(ARow);
      agSelect            : If Sels[ARow - 1] then Result := '*';
      agSeries            : Result := String(A.SERIES);
      agNumber            : Result := String(A.NUMBER);
      agDocumentType      : Result := String(A.DOCUMENT);
      agPeopleOf	        : Result := IntToStr(A.PeopleOf);
      agId      	        : Result := IntToStr(A.Id);
   else Result := '*' + IntToStr(aCol);
  end;

end;

procedure TFrameDocument.ItemInsertOrUpdate(aItem: PBegId);
var
  P   : PDocument;

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

  P := PDocument(aItem);
  if isExit(leSeries) then Exit;
  if isExit(leNumber) then Exit;
  if isExit(cbDocumentType) then Exit;

  P.DOCUMENTTYPE := 0;
  P.PeopleOf := iPeopleOf;
  ExecDocumentPutOrUpdate(P^);
  RefreshListOfItems;
end;

function TFrameDocument.GetGridInitItem(Index: integer): integer;
begin
  Result := GridInitArray[Index];
end;

function TFrameDocument.GridInitCount: integer;
begin
  Result := agLast + 1;
end;

function TFrameDocument.GetGridColumnDescr(Index: integer): PMyGridColumnDescr;
begin
  Result := @GridDescr[Index];
end;

procedure TFrameDocument.UpdateCurItem(aWinControl: TWinControl; aItem: PBegId);
var
  P            : PDocument;
  TLE          : TLabeledEdit;
  TCB	         : TComboBox;
begin
  P := PDocument(aItem);

  if aWinControl is TLabeledEdit then
  begin
    TLE := aWinControl as TLabeledEdit;
    if TLE = leSeries then P.SERIES := ShortString(Trim(TLE.Text));
    if TLE = leNumber then P.NUMBER := ShortString(Trim(TLE.Text));
  end;

  if aWinControl is TComboBox then
  begin
    TCB := aWinControl as TComboBox;
    if TCB = cbDocumentType then P.DOCUMENT := ShortString(Trim(TCB.Text));
  end;
end;

function TFrameDocument.GetDeleteMessage(aItem: PBegId): string;
var
  P  : PDocument;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  P := PDocument(aItem);
  Result := Format('Удалить "%s"?', [IntToStr(P.DOCUMENTID)]);
end;

function TFrameDocument.DeleteItem(aItem: PBegId): boolean;
begin
  Result := False;

  if not Assigned(aItem) then Exit;

  if aItem.Id <> 0
    then ExecDocumentDelete(aItem.Id);
   Result := True;
end;

procedure TFrameDocument.InitN(aPeopleOf : TId);
begin
  CanInsert := false;
  CanKill := False;
  sbNew.Enabled := false;
  iPeopleOf := aPeopleOf;

  inherited Init;

  if FreeListOfItems then
  	if Assigned(ListOfItems) then ListOfItems.MyFreeAll;

  RefreshListOfItems;

	if Parent.Visible then
    if gbPanel.Visible then
      HideInsertOrUpdatePanel;
end;

end.
