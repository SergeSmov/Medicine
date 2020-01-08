unit fCommunication;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Common, uData;

type
  TFrameCommunication = class(TTemplateFrame)
    leNumber: TLabeledEdit;
    cbCommunicationType: TComboBox;
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
  agNumber           =   2;
  agComType          =   3;
  agPeopleOf	       =   4;
  agId               =   5;
  agLast             =   5;

  GridDescr : Array [ 0 .. agLast ] Of TMyGridColumnDescr = (
    (Width:   30;         Align: 2;      Name: '№';                 Descr: 'Номер строки'),
    (Width:   10;         Align: 1;      Name: '*';          				Descr: 'Выделение'),
    (Width:  120;         Align: 0;      Name: 'Номер';             Descr: 'Номер'),
    (Width:  600;         Align: 1;      Name: 'Тип коммуникации';  Descr: 'Тип коммуникации'),
    (Width:   20;         Align: 0;      Name: 'PeopleOf';          Descr: 'PeopleOf'),
    (Width:   20;         Align: 0;      Name: 'Id';                Descr: 'Id')
    );

  GridInitArray : Array [0..agLast] Of Integer = (
    agRow,
    agSelect,
    agNumber,
    agComType,
    agPeopleOf,
    agId
    );

function TFrameCommunication.GetItemSize: integer;
begin
  Result := SizeOf(TCommunication);
end;

procedure TFrameCommunication.RefreshListOfItems;
var
  List   : TBegList;
  TDS	   : TCommunicationSelect;
begin
  List := nil;

  TDS.Prepare;
  TDS.PeopleOf := iPeopleOf;
  GetCommunicationDetail(TDS, List);

  FreeListOfItems := List.Count > 0;

  ListOfItems := List;
  inherited;
end;

procedure TFrameCommunication.ShowInsertOrUpdatePanel;
begin
  inherited;
  if leNumber.CanFocus then leNumber.SetFocus;
end;

procedure TFrameCommunication.InitializeFields(aItem: PBegId);
var
  P     : PCommunication;
  Lst	  : TBegList;
  DT    : PCommunicationType;
begin
  P := PCommunication(aItem);

  cbCommunicationType.Clear;
  leNumber.Text := String(P.PHONE);
  cbCommunicationType.Text := String(P.COMMUNICATIONTYPENAME);

  Lst := nil;
  GetCommunicationTypeDetail(Lst);
  for DT in Lst
    do cbCommunicationType.Items.Add(String(DT.Name));
  Lst.MyFreeAll;

end;

function TFrameCommunication.GetItemValue(aItem: PBegId; aCol, aRow: integer): string;
var
  A      : PCommunication;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  A := PCommunication(aItem);
  case aCol Of
      agRow               : Result := IntToStr(ARow);
      agSelect            : If Sels[ARow - 1] then Result := '*';
      agNumber            : Result := String(A.PHONE);
      agComType           : Result := String(A.COMMUNICATIONTYPENAME);
      agPeopleOf	        : Result := IntToStr(A.PeopleOf);
      agId      	        : Result := IntToStr(A.Id);
   else Result := '*' + IntToStr(aCol);
  end;

end;

procedure TFrameCommunication.ItemInsertOrUpdate(aItem: PBegId);
var
  P   : PCommunication;

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

  P := PCommunication(aItem);
  if isExit(leNumber) then Exit;
  if isExit(cbCommunicationType) then Exit;

  P.PeopleOf := iPeopleOf;
  ExecCommunicationPutOrUpdate(P^);
  RefreshListOfItems;
end;

function TFrameCommunication.GetGridInitItem(Index: integer): integer;
begin
  Result := GridInitArray[Index];
end;

function TFrameCommunication.GridInitCount: integer;
begin
  Result := agLast + 1;
end;

function TFrameCommunication.GetGridColumnDescr(Index: integer): PMyGridColumnDescr;
begin
  Result := @GridDescr[Index];
end;

procedure TFrameCommunication.UpdateCurItem(aWinControl: TWinControl; aItem: PBegId);
var
  P            : PCommunication;
  TLE          : TLabeledEdit;
  TCB	         : TComboBox;
begin
  P := PCommunication(aItem);

  if aWinControl is TLabeledEdit then
  begin
    TLE := aWinControl as TLabeledEdit;
    if TLE = leNumber then P.PHONE := ShortString(Trim(TLE.Text));
  end;

  if aWinControl is TComboBox then
  begin
    TCB := aWinControl as TComboBox;
    if TCB = cbCommunicationType then P.COMMUNICATIONTYPENAME := ShortString(Trim(TCB.Text));
  end;
end;

function TFrameCommunication.GetDeleteMessage(aItem: PBegId): string;
var
  P  : PCommunication;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  P := PCommunication(aItem);
  Result := Format('Удалить "%s"?', [IntToStr(P.Id)]);
end;

function TFrameCommunication.DeleteItem(aItem: PBegId): boolean;
begin
  Result := False;

  if not Assigned(aItem) then Exit;

  if aItem.Id <> 0
    then ExecCommunicationDelete(aItem.Id);
   Result := True;
end;

procedure TFrameCommunication.InitN(aPeopleOf : TId);
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
