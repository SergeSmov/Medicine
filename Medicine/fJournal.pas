unit fJournal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Common, uData, uPeoples, fSelect;

type
  TFrameJournal = class(TTemplateFrame)
    tbSelect: TToolButton;
    gbSelect: TGroupBox;
    lDateTimeSelect: TLabel;
    PanelSelectButton: TPanel;
    btnCancelSelect: TBitBtn;
    btnSelect: TBitBtn;
    DateTimePickerSelect: TDateTimePicker;
    PanelSelectSelect: TPanel;
    lDateTime: TLabel;
    leNumber: TLabeledEdit;
    DateTime: TDateTimePicker;
    PanelSelect: TPanel;
    FrameSelectPatiens: TFrameSelect;
    FrameSelectDoctor: TFrameSelect;
    FrameSelectDiagnoses: TFrameSelect;
    FrameSelectDiagnosesSelect: TFrameSelect;
    FrameSelectDoctorSelect: TFrameSelect;
    FrameSelectPatiensSelect: TFrameSelect;
    PanelParents: TPanel;
    procedure tbSelectClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnCancelSelectClick(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FrameSelectPatiensleNumberDblClick(Sender: TObject);
    procedure FrameSelectDoctorleNumberDblClick(Sender: TObject);
    procedure FrameSelectDiagnosesleNumberDblClick(Sender: TObject);
    procedure FrameSelectPatiensSelectleNumberDblClick(Sender: TObject);
    procedure FrameSelectDoctorSelectleNumberDblClick(Sender: TObject);
    procedure FrameSelectDiagnosesSelectleNumberDblClick(Sender: TObject);
    procedure FrameSelectDiagnosessbStartClick(Sender: TObject);
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
    iPeopleOf : integer;
    iDoctorOf : integer;
    iDiagnosesOf : integer;
    sPeopleOf : integer;
    sDoctorOf : integer;
    sDiagnosesOf : integer;
    procedure InitN; virtual;
  end;

implementation

{$R *.dfm}

const
  agRow              =   0;
  agSelect           =   1;
  agDateTime         =   2;
  agPeopleOfName     =   3;
  agDoctorOfName     =   4;
  agDiagnosesOfName  =   5;
  agId               =   6;
  agLast             =   6;

  GridDescr : Array [ 0 .. agLast ] Of TMyGridColumnDescr = (
    (Width:   30;         Align: 2;      Name: '№';                 Descr: 'Номер строки'),
    (Width:   10;         Align: 1;      Name: '*';          				Descr: 'Выделение'),
    (Width:  150;         Align: 0;      Name: 'Дата и время';      Descr: 'Дата и время'),
    (Width:  400;         Align: 0;      Name: 'Пациент';           Descr: 'Пациент'),
    (Width:  400;         Align: 0;      Name: 'Врач';              Descr: 'Врач'),
    (Width:  400;         Align: 1;      Name: 'Диагноз';           Descr: 'Диагноз'),
    (Width:   20;         Align: 0;      Name: 'Id';                Descr: 'Id')
    );

  GridInitArray : Array [0..agLast] Of Integer = (
    agRow,
    agSelect,
    agDateTime,
    agPeopleOfName,
    agDoctorOfName,
    agDiagnosesOfName,
    agId
    );

function TFrameJournal.GetItemSize: integer;
begin
  Result := SizeOf(TJournal);
end;

procedure TFrameJournal.RefreshListOfItems;
var
  List   : TBegList;
  TDS	   : TJournalSelect;
begin
  List := nil;
  TDS.Prepare;
  TDS.DATETIME := Trunc(DateTimePickerSelect.DateTime);
  TDS.PeopleOf := sPeopleOf;
  TDS.DoctorOf := sDoctorOf;
  TDS.DiagnosesOf := sDiagnosesOf;
  GetJournalDetail(TDS, List);

  FreeListOfItems := List.Count > 0;

  ListOfItems := List;
  inherited;
end;

procedure TFrameJournal.ShowInsertOrUpdatePanel;
begin
  inherited;
  if DateTime.CanFocus then DateTime.SetFocus;
end;

procedure TFrameJournal.tbSelectClick(Sender: TObject);
begin
  FrameSelectPatiensSelect.Init(cPatients, 0);
  FrameSelectDoctorSelect.Init(cDoctor, 0);
  FrameSelectDiagnosesSelect.Init(cDiagnoses, 0);
  gbSelect.Visible := true;
end;

procedure TFrameJournal.InitializeFields(aItem: PBegId);
var
  P     : PJournal;
  Lst	  : TBegList;
  DT    : PPeople;
  TPS	  : TPeopleSelect;
  DD    : PDiagnoses;
begin
  P := PJournal(aItem);
  iPeopleOf := P.PeopleOf;
  iDoctorOf := P.DoctorOf;
  iDiagnosesOf := P.DiagnosesOf;

  DateTime.DateTime := now;
  leNumber.Text := String(P.NUMBER);
  FrameSelectPatiens.Init(cPatients, P.PeopleOf);
  FrameSelectDoctor.Init(cDoctor, P.DoctorOf);
  FrameSelectDiagnoses.Init(cDiagnoses, P.DiagnosesOf);
  if P.Id <> 0 then
  begin
    DateTime.DateTime := P.DATETIME;
  end;

end;

function TFrameJournal.GetItemValue(aItem: PBegId; aCol, aRow: integer): string;
var
  A      : PJournal;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  A := PJournal(aItem);
  case aCol Of
      agRow               : Result := IntToStr(ARow);
      agSelect            : If Sels[ARow - 1] then Result := '*';
      agDateTime          : Result := DateTimeToStr(A.DATETIME);
      agPeopleOfName	    : Result := A.PeopleOfName;
      agDoctorOfName      : Result := A.DoctorOfName;
      agDiagnosesOfName   : Result := A.DiagnosesOfName;
      agId      	        : Result := IntToStr(A.Id);
   else Result := '*' + IntToStr(aCol);
  end;

end;

procedure TFrameJournal.ItemInsertOrUpdate(aItem: PBegId);
var
  P   : PJournal;

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
      if (TD.DateTime = null) or (aDefault = true) then
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

  P := PJournal(aItem);
  if isExit(FrameSelectPatiens.leNumber) then Exit;
  if isExit(FrameSelectDoctor.leNumber) then Exit;
  if isExit(FrameSelectDiagnoses.leNumber) then Exit;
  P.PeopleOf := iPeopleOf;
  P.DoctorOf := iDoctorOf;
  P.DiagnosesOf := iDiagnosesOf;
  if P.PeopleOf = 0
    then if isExit(FrameSelectPatiens.leNumber, true) then Exit;
  if P.DoctorOf = 0
    then if isExit(FrameSelectDoctor.leNumber, true) then Exit;
  if P.DiagnosesOf = 0
    then if isExit(FrameSelectDiagnoses.leNumber, true) then Exit;

  ExecJournalPutOrUpdate(P^);
  RefreshListOfItems;
end;

function TFrameJournal.GetGridInitItem(Index: integer): integer;
begin
  Result := GridInitArray[Index];
end;

function TFrameJournal.GridInitCount: integer;
begin
  Result := agLast + 1;
end;

procedure TFrameJournal.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  P : PJournal;
begin
  inherited;
  P := PJournal(CurItem);
  tbSelect.Enabled := (Assigned(P) and not gbPanel.Visible) or (SelsCount > 0);
end;

function TFrameJournal.GetGridColumnDescr(Index: integer): PMyGridColumnDescr;
begin
  Result := @GridDescr[Index];
end;

procedure TFrameJournal.UpdateCurItem(aWinControl: TWinControl; aItem: PBegId);
var
  P            : PJournal;
  TLE          : TLabeledEdit;
  TDT	         : TDateTimePicker;
begin
  P := PJournal(aItem);

  if aWinControl is TLabeledEdit then
  begin
    TLE := aWinControl as TLabeledEdit;
    if TLE = leNumber then P.NUMBER := shortString(Trim(TLE.Text));
    if TLE = FrameSelectPatiens.leNumber then P.PeopleOf := iPeopleOf;
    if TLE = FrameSelectDoctor.leNumber then P.DoctorOf := iDoctorOf;
    if TLE = FrameSelectDiagnoses.leNumber then P.DiagnosesOf := iDiagnosesOf;
  end;

  if aWinControl is TDateTimePicker then
  begin
    TDT := aWinControl as TDateTimePicker;
    if TDT = DateTime then P.DATETIME := TDT.DateTime;
  end;
end;

function TFrameJournal.GetDeleteMessage(aItem: PBegId): string;
var
  P  : PJournal;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  P := PJournal(aItem);
  Result := Format('Удалить "%s"?', [IntToStr(P.Id)]);
end;

procedure TFrameJournal.btnCancelSelectClick(Sender: TObject);
begin
  gbSelect.Visible := false;
end;

procedure TFrameJournal.btnSelectClick(Sender: TObject);
begin
  gbSelect.Visible := false;
  if (Trim(FrameSelectPatiensSelect.leNumber.Text) = '')
    then sPeopleOf := 0;
  if (Trim(FrameSelectDoctorSelect.leNumber.Text) = '')
    then sDoctorOf := 0;
  if (Trim(FrameSelectDiagnosesSelect.leNumber.Text) = '')
    then sDiagnosesOf := 0;

  RefreshListOfItems;
end;

function TFrameJournal.DeleteItem(aItem: PBegId): boolean;
begin
  Result := False;

  if not Assigned(aItem) then Exit;

  if aItem.Id <> 0
    then ExecJournalDelete(aItem.Id);
   Result := True;
end;

procedure TFrameJournal.FrameSelectDiagnosesleNumberDblClick(Sender: TObject);
begin
  inherited;
  FrameSelectDiagnoses.sbStartClick(Sender);
end;

procedure TFrameJournal.FrameSelectDiagnosessbStartClick(Sender: TObject);
begin
  inherited;
  FrameSelectDiagnoses.sbStartClick(Sender);

end;

procedure TFrameJournal.FrameSelectDiagnosesSelectleNumberDblClick(
  Sender: TObject);
begin
  FrameSelectDiagnosesSelect.sbStartClick(Sender);
end;

procedure TFrameJournal.FrameSelectDoctorleNumberDblClick(Sender: TObject);
begin
  FrameSelectDoctor.sbStartClick(Sender);
end;

procedure TFrameJournal.FrameSelectDoctorSelectleNumberDblClick(
  Sender: TObject);
begin
  FrameSelectDoctorSelect.sbStartClick(Sender);
end;

procedure TFrameJournal.FrameSelectPatiensleNumberDblClick(Sender: TObject);
begin
  FrameSelectPatiens.sbStartClick(Sender);
end;

procedure TFrameJournal.FrameSelectPatiensSelectleNumberDblClick(
  Sender: TObject);
begin
  FrameSelectPatiensSelect.sbStartClick(Sender);
end;

procedure TFrameJournal.InitN;
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
