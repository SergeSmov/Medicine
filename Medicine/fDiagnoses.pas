unit fDiagnoses;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Common, uData;

type
  TFrameDiagnoses = class(TTemplateFrame)
    leCode: TLabeledEdit;
    tbSelect: TToolButton;
    leName: TLabeledEdit;
    procedure tbSelectClick(Sender: TObject);
  private
    { Private declarations }
    FDiagnosesOf : integer;
    iItem : integer;
  public
    { Public declarations }
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
    procedure InitN(aItem : integer = -1); virtual;
    property DiagnosesOf : integer read FDiagnosesOf write FDiagnosesOf;
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
    (Width:  200;         Align: 0;      Name: 'Код';               Descr: 'Код'),
    (Width:  600;         Align: 0;      Name: 'Наименование';      Descr: 'Наименование')
    );

  GridInitArray : Array [0..agLast] Of Integer = (
    agRow,
    agSelect,
    agOrdinal,
    agCode,
    agName
    );

function TFrameDiagnoses.GetItemSize: integer;
begin
  Result := SizeOf(TDiagnoses);
end;

procedure TFrameDiagnoses.RefreshListOfItems;
var
  List   : TBegList;
  TDS    : TDiagnosesSelect;
  P 		 : PBegId;
  I			 : Integer;
begin
  List := nil;

  TDS.Prepare;
  GetDiagnosesDetail(TDS, List);

  FreeListOfItems := List.Count > 0;

  ListOfItems := List;

  inherited;

  if iItem > 0 then
  begin
    for I := 0 to ListOfItems.Count - 1 do
    begin
      P := ListOfItems[i];
      if P.Id = iItem then
      begin
        Grid.Row := i + 1;
        Break;
      end;
    end;
  end;
end;

procedure TFrameDiagnoses.ShowInsertOrUpdatePanel;
begin
  inherited;
  if leCode.CanFocus then leCode.SetFocus;
end;

procedure TFrameDiagnoses.tbSelectClick(Sender: TObject);
var
  P : PDiagnoses;
begin
  P := PDiagnoses(CurItem);
  if P <> nil then
  begin
    FDiagnosesOf := P.Id;
    ((Self.Owner) as TForm).Close;
  end;
end;

procedure TFrameDiagnoses.InitializeFields(aItem: PBegId);
var
  P     : PDiagnoses;
begin
  P := PDiagnoses(aItem);

  leCode.Text := String(P.Code);
  leName.Text := String(P.Name);
end;

function TFrameDiagnoses.GetItemValue(aItem: PBegId; aCol, aRow: integer): string;
var
  A      : PDiagnoses;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  A := PDiagnoses(aItem);
  case aCol Of
      agRow               : Result := IntToStr(ARow);
      agSelect            : If Sels[ARow - 1] then Result := '*';
      agOrdinal           : Result := IntToStr(A.Id);
      agCode              : Result := String(A.Code);
      agName              : Result := String(A.Name);
   else Result := '*' + IntToStr(aCol);
  end;

end;

procedure TFrameDiagnoses.ItemInsertOrUpdate(aItem: PBegId);
var
  P   : PDiagnoses;

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

  P := PDiagnoses(aItem);
  if isExit(leCode) then Exit;
  if isExit(leName) then Exit;

  ExecDiagnosesPutOrUpdate(P^);
  RefreshListOfItems;
end;

function TFrameDiagnoses.GetGridInitItem(Index: integer): integer;
begin
  Result := GridInitArray[Index];
end;

function TFrameDiagnoses.GridInitCount: integer;
begin
  Result := agLast + 1;
end;

function TFrameDiagnoses.GetGridColumnDescr(Index: integer): PMyGridColumnDescr;
begin
  Result := @GridDescr[Index];
end;

procedure TFrameDiagnoses.UpdateCurItem(aWinControl: TWinControl; aItem: PBegId);
var
  P            : PDiagnoses;
  TLE          : TLabeledEdit;
begin
  P := PDiagnoses(aItem);

  if aWinControl is TLabeledEdit then
  begin
    TLE := aWinControl as TLabeledEdit;
    if TLE = leCode then P.Code := ShortString(Trim(TLE.Text)) else
    if TLE = leName then P.Name := WideString(Trim(TLE.Text));
  end;
end;

function TFrameDiagnoses.GetDeleteMessage(aItem: PBegId): string;
var
  P  : PDiagnoses;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  P := PDiagnoses(aItem);
  Result := Format('Удалить "%s"?', [IntToStr(P.Id)]);
end;

function TFrameDiagnoses.DeleteItem(aItem: PBegId): boolean;
begin
  Result := False;

  if not Assigned(aItem) then Exit;

  if aItem.Id <> 0
    then ExecDiagnosesDelete(aItem.Id);
   Result := True;
end;

procedure TFrameDiagnoses.InitN(aItem : integer = -1);
begin
  CanInsert := false;
  CanKill := False;
  sbNew.Enabled := false;
  tbSelect.Visible := aItem <> -1;
  iItem := aItem;

  inherited Init;

  if FreeListOfItems then
  	if Assigned(ListOfItems) then ListOfItems.MyFreeAll;

  RefreshListOfItems;

	if Parent.Visible then
    if gbPanel.Visible then
      HideInsertOrUpdatePanel;
end;

end.
