unit fAddress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Common, uData;

type
  TFrameAddress = class(TTemplateFrame)
    leAddress: TLabeledEdit;
    cbAddressType: TComboBox;
    lAddressType: TLabel;
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
  agAddress          =   2;
  agAddressType      =   3;
  agPeopleOf	       =   4;
  agId               =   5;
  agLast             =   5;

  GridDescr : Array [ 0 .. agLast ] Of TMyGridColumnDescr = (
    (Width:   30;         Align: 2;      Name: '№';                 Descr: 'Номер строки'),
    (Width:   10;         Align: 1;      Name: '*';          				Descr: 'Выделение'),
    (Width:  600;         Align: 0;      Name: 'Адрес';             Descr: 'Адрес'),
    (Width:  600;         Align: 1;      Name: 'Тип адреса';        Descr: 'Тип адреса'),
    (Width:   20;         Align: 0;      Name: 'PeopleOf';          Descr: 'PeopleOf'),
    (Width:   20;         Align: 0;      Name: 'Id';                Descr: 'Id')
    );

  GridInitArray : Array [0..agLast] Of Integer = (
    agRow,
    agSelect,
    agAddress,
    agAddressType,
    agPeopleOf,
    agId
    );

function TFrameAddress.GetItemSize: integer;
begin
  Result := SizeOf(TAddress);
end;

procedure TFrameAddress.RefreshListOfItems;
var
  List   : TBegList;
  TDS	   : TAddressSelect;
begin
  List := nil;

  TDS.Prepare;
  TDS.PeopleOf := iPeopleOf;
  GetAddressDetail(TDS, List);

  FreeListOfItems := List.Count > 0;

  ListOfItems := List;
  inherited;
end;

procedure TFrameAddress.ShowInsertOrUpdatePanel;
begin
  inherited;
  if leAddress.CanFocus then leAddress.SetFocus;
end;

procedure TFrameAddress.InitializeFields(aItem: PBegId);
var
  P     : PAddress;
  Lst	  : TBegList;
  DT    : PAddressType;
begin
  cbAddressType.Clear;
  Lst := nil;
  GetAddressTypeDetail(Lst);
  for DT in Lst
    do cbAddressType.Items.Add(string(DT.Name));
  Lst.MyFreeAll;

  P := PAddress(aItem);
  leAddress.Text := String(P.ADDRESS);
  cbAddressType.Text := String(P.ADDRESSTYPENAME);
end;

function TFrameAddress.GetItemValue(aItem: PBegId; aCol, aRow: integer): string;
var
  A      : PAddress;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  A := PAddress(aItem);
  case aCol Of
      agRow               : Result := IntToStr(ARow);
      agSelect            : If Sels[ARow - 1] then Result := '*';
      agAddress           : Result := String(A.ADDRESS);
      agAddressType       : Result := String(A.ADDRESSTYPENAME);
      agPeopleOf	        : Result := IntToStr(A.PeopleOf);
      agId      	        : Result := IntToStr(A.Id);
   else Result := '*' + IntToStr(aCol);
  end;

end;

procedure TFrameAddress.ItemInsertOrUpdate(aItem: PBegId);
var
  P   : PAddress;

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

  P := PAddress(aItem);
  if isExit(leAddress) then Exit;
  if isExit(cbAddressType) then Exit;
  P.PeopleOf := iPeopleOf;
  ExecAddressPutOrUpdate(P^);
  RefreshListOfItems;
end;

function TFrameAddress.GetGridInitItem(Index: integer): integer;
begin
  Result := GridInitArray[Index];
end;

function TFrameAddress.GridInitCount: integer;
begin
  Result := agLast + 1;
end;

function TFrameAddress.GetGridColumnDescr(Index: integer): PMyGridColumnDescr;
begin
  Result := @GridDescr[Index];
end;

procedure TFrameAddress.UpdateCurItem(aWinControl: TWinControl; aItem: PBegId);
var
  P            : PAddress;
  TLE          : TLabeledEdit;
  TCB	         : TComboBox;
begin
  P := PAddress(aItem);

  if aWinControl is TLabeledEdit then
  begin
    TLE := aWinControl as TLabeledEdit;
    if TLE = leAddress then P.ADDRESS := WideString(Trim(TLE.Text));
  end;

  if aWinControl is TComboBox then
  begin
    TCB := aWinControl as TComboBox;
    if TCB = cbAddressType then P.ADDRESSTYPENAME := ShortString(Trim(TCB.Text));
  end;
end;

function TFrameAddress.GetDeleteMessage(aItem: PBegId): string;
var
  P  : PAddress;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  P := PAddress(aItem);
  Result := Format('Удалить "%s"?', [IntToStr(P.Id)]);
end;

function TFrameAddress.DeleteItem(aItem: PBegId): boolean;
begin
  Result := False;

  if not Assigned(aItem) then Exit;

  if aItem.Id <> 0
    then ExecAddressDelete(aItem.Id);
   Result := True;
end;

procedure TFrameAddress.InitN(aPeopleOf : TId);
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
