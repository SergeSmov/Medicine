unit fPeoples;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, uData, Common,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.ToolWin, Vcl.Grids, Vcl.Buttons, uDoctor, uDocument, uCommunication,
  uAddress;

type
  TFramePeoples = class(TTemplateFrame)
    leI: TLabeledEdit;
    cbSex: TComboBox;
    BirthDate: TDateTimePicker;
    leO: TLabeledEdit;
    leF: TLabeledEdit;
    lSex: TLabel;
    lBirthDate: TLabel;
    leId: TLabeledEdit;
    ToolButton2: TToolButton;
    tbDoc: TToolButton;
    tbDoctor: TToolButton;
    tbComm: TToolButton;
    tbAddress: TToolButton;
    ToolButton4: TToolButton;
    tbSelect: TToolButton;
    procedure tbDoctorClick(Sender: TObject);
    procedure tbDocClick(Sender: TObject);
    procedure tbCommClick(Sender: TObject);
    procedure tbAddressClick(Sender: TObject);
    procedure tbSelectClick(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    iType : smallint;
    iItem : integer;
    FPeopleOf : integer;
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
    procedure InitN(aType : smallint; aItem : integer = -1); virtual;
    property PeopleOf: integer read FPeopleOf write FPeopleOf;
  end;

implementation

{$R *.dfm}

const
  agRow              =   0;
  agSelect           =   1;
  agF                =   2;
  agI                =   3;
  agO                =   4;
  agSex              =   5;
  agBirthDate        =   6;
  agPeopleId         =   7;
  agLast             =   7;

  GridDescr : Array [0 .. agLast] Of TMyGridColumnDescr = (
    (Width:   30;         Align: 2;      Name: '№';                 Descr: 'Номер строки'),
    (Width:   10;         Align: 1;      Name: '*';          				Descr: 'Выделение'),
    (Width:  120;         Align: 0;      Name: 'Фамилия';           Descr: 'Фамилия'),
    (Width:  120;         Align: 0;      Name: 'Имя';               Descr: 'Имя'),
    (Width:  120;         Align: 0;      Name: 'Отчество';          Descr: 'Отчество'),
    (Width:   60;         Align: 1;      Name: 'Пол';               Descr: 'Пол'),
    (Width:  120;         Align: 1;      Name: 'Дата рождения';     Descr: 'Дата рождения'),
    (Width:   20;         Align: 1;      Name: 'Id';                Descr: 'Id')
    );

  GridInitArray : Array [0..agLast] Of Integer = (
    agRow,
    agSelect,
    agF,
    agI,
    agO,
    agSex,
    agBirthDate,
    agPeopleId
    );


function TFramePeoples.GetItemSize: integer;
begin
  Result := SizeOf(TPeople);
end;

procedure TFramePeoples.RefreshListOfItems;
var
  List   : TBegList;
  TCS    : TPeopleSelect;
  I      : Integer;
  Cur    : PBegId;
begin
  List := nil;

  TCS.Prepare;
  TCS.PeopleOf := iType;
  GetPeopleDetail(TCS, List);

  FreeListOfItems := List.Count > 0;

  ListOfItems := List;

  inherited;

  if iItem > 0 then
  begin
    for I := 0 to ListOfItems.Count - 1 do
    begin
      Cur := ListOfItems[i];
      if Cur.Id = iItem then
      begin
        Grid.Row := i + 1;
        Break;
      end;
    end;
  end;
end;

procedure TFramePeoples.ShowInsertOrUpdatePanel;
begin
  inherited;
  if leF.CanFocus then leF.SetFocus;
end;

procedure TFramePeoples.tbAddressClick(Sender: TObject);
var
  P : PPeople;
begin
  P := PPeople(CurItem);
  if P <> nil
    then TFormAddress.MyCreate(Self, P.Id);
end;

procedure TFramePeoples.tbCommClick(Sender: TObject);
var
  P : PPeople;
begin
  P := PPeople(CurItem);
  if P <> nil
    then TFormCommunication.MyCreate(Self, P.Id);
end;

procedure TFramePeoples.tbDocClick(Sender: TObject);
var
  P : PPeople;
begin
  P := PPeople(CurItem);
  if P <> nil
    then TFormDocument.MyCreate(Self, P.Id);
end;

procedure TFramePeoples.tbDoctorClick(Sender: TObject);
var
  P : PPeople;
begin
  P := PPeople(CurItem);
  if P <> nil
    then TFormDoctor.MyCreate(Self, P.Id);
end;

procedure TFramePeoples.tbSelectClick(Sender: TObject);
var
  P : PPeople;
begin
  P := PPeople(CurItem);
  if P <> nil then
  begin
    FPeopleOf := P.Id;
    ((Self.Owner) as TForm).Close;
  end;
end;

procedure TFramePeoples.InitializeFields(aItem: PBegId);
var
  P     : PPeople;
begin
  P := PPeople(aItem);
  P.PeopleOf := iType;

  leId.Text := IntToStr(P.Id);
  leF.Text := String(P.F);
  leI.Text := String(P.I);
  leO.Text := String(P.O);
  BirthDate.Date := now;
  cbSex.Text := 'М';

  if P.Id <> 0 then
  begin
    BirthDate.Date := P.BIRTHDATE;
    cbSex.Text := String(P.SEX);
  end;
end;

function TFramePeoples.GetItemValue(aItem: PBegId; aCol, aRow: integer): string;
var
  A      : PPeople;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  A := PPeople(aItem);
  case aCol Of
      agRow               : Result := IntToStr(ARow);
      agSelect            : If Sels[ARow - 1] then Result := '*';
      agPeopleId          : Result := IntToStr(A.Id);
      agF                 : Result := String(A.F);
      agI                 : Result := String(A.I);
      agO                 : Result := String(A.O);
      agSEX               : Result := String(A.SEX);
      agBirthDate         : Result := DateToStr(A.BIRTHDATE);
   else Result := '*' + IntToStr(aCol);
  end;

end;

procedure TFramePeoples.ItemInsertOrUpdate(aItem: PBegId);
var
  P   : PPeople;

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

  P := PPeople(aItem);
  if isExit(leF) then Exit;
  if isExit(leI) then Exit;
  if isExit(cbSex) then Exit;
  if isExit(BirthDate) then Exit;

  ExecPeoplePutOrUpdate(P^);
  RefreshListOfItems;
end;

function TFramePeoples.GetGridInitItem(Index: integer): integer;
begin
  Result := GridInitArray[Index];
end;

function TFramePeoples.GridInitCount: integer;
begin
  Result := agLast + 1;
end;

procedure TFramePeoples.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  P : PPeople;

  function isEnabled : boolean;
  begin
    Result := (Assigned(P) and not gbPanel.Visible) or (SelsCount > 0);
  end;

begin
  inherited;
  P := PPeople(CurItem);
  tbDoc.Enabled := isEnabled;
  tbAddress.Enabled := isEnabled;
  tbComm.Enabled := isEnabled;
  if tbDoctor.Visible
    then tbDoctor.Enabled := isEnabled;
end;

function TFramePeoples.GetGridColumnDescr(Index: integer): PMyGridColumnDescr;
begin
  Result := @GridDescr[Index];
end;

procedure TFramePeoples.UpdateCurItem(aWinControl: TWinControl; aItem: PBegId);
var
  P            : PPeople;
  TLE          : TLabeledEdit;
  TDT          : TDateTimePicker;
  TCB          : TComboBox;
begin
  P := PPeople(aItem);

  if aWinControl is TLabeledEdit then
  begin
    TLE := aWinControl as TLabeledEdit;
    if TLE = leF then P.F := ShortString(Trim(TLE.Text)) else
    if TLE = leI then P.I := ShortString(Trim(TLE.Text)) else
    if TLE = leO then P.O := ShortString(Trim(TLE.Text));
  end;

  if aWinControl is TDateTimePicker then
  begin
    TDT := aWinControl as TDateTimePicker;
    if TDT = BirthDate then P.BIRTHDATE := TDT.Date;
  end;

  if aWinControl is TComboBox then
  begin
    TCB := aWinControl as TComboBox;
    if TCB = cbSex then P.SEX := ShortString(TCB.Text);
  end;
end;

function TFramePeoples.GetDeleteMessage(aItem: PBegId): string;
var
  P  : PPeople;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  P := PPeople(aItem);
  Result := Format('Удалить "%s"?', [IntToStr(P.Id)]);
end;

function TFramePeoples.DeleteItem(aItem: PBegId): boolean;
begin
  Result := False;

  if not Assigned(aItem) then Exit;

  if aItem.Id <> 0
    then ExecPeopleDelete(aItem.Id);
   Result := True;
end;

procedure TFramePeoples.InitN(aType : smallint; aItem : integer = -1);
begin
  CanInsert := false;
  CanKill := False;
  sbNew.Enabled := false;
  iType := aType;
  tbDoctor.Visible := iType = cDoctor;
  iItem := aItem;
  tbSelect.Visible := iItem <> -1;

  inherited Init;

  if FreeListOfItems then
  	if Assigned(ListOfItems) then ListOfItems.MyFreeAll;

  RefreshListOfItems;

	if Parent.Visible then
    if gbPanel.Visible then
      HideInsertOrUpdatePanel;
end;

end.

