unit fDoctors;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, uData, Common;

type
  TFrameDoctors = class(TTemplateFrame)
    leCabinet: TLabeledEdit;
    cbPost: TComboBox;
    lPost: TLabel;
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
    procedure InitN(aPeopleOf : integer); virtual;
  end;

implementation

{$R *.dfm}

const
  agRow              =   0;
  agSelect           =   1;
  agCabinet          =   2;
  agPosts            =   3;
  agPeopleOf         =   4;
  agId               =   5;
  agLast             =   5;

  GridDescr : Array [ 0 .. agLast ] Of TMyGridColumnDescr = (
    (Width:   30;         Align: 2;      Name: '№';                 Descr: 'Номер строки'),
    (Width:   10;         Align: 1;      Name: '*';          				Descr: 'Выделение'),
    (Width:  120;         Align: 0;      Name: 'Кабинет';           Descr: 'Кабинет'),
    (Width:  500;         Align: 0;      Name: 'Должность';         Descr: 'Должность'),
    (Width:   20;         Align: 1;      Name: 'PeopleOf';          Descr: 'PeopleOf'),
    (Width:   20;         Align: 1;      Name: 'Id';                Descr: 'Id')
    );

  GridInitArray : Array [0..agLast] Of Integer = (
    agRow,
    agSelect,
    agCabinet,
    agPosts,
    agPeopleOf,
    agId
    );

function TFrameDoctors.GetItemSize: integer;
begin
  Result := SizeOf(TDoctor);
end;

procedure TFrameDoctors.RefreshListOfItems;
var
  List   : TBegList;
  TCS    : TDoctorSelect;
begin
  List := nil;

  TCS.Prepare;
  TCS.PeopleOf := iPeopleOf;
  GetDoctorDetail(TCS, List);

  FreeListOfItems := List.Count > 0;

  ListOfItems := List;
  inherited;
end;

procedure TFrameDoctors.ShowInsertOrUpdatePanel;
begin
  inherited;
  if leCabinet.CanFocus then leCabinet.SetFocus;
end;

procedure TFrameDoctors.InitializeFields(aItem: PBegId);
var
  D     : PDoctor;
  Lst   : TBegList;
  P     : PPosts;
begin
  cbPost.Clear;
  Lst := nil;
  GetPostsDetail(Lst);
  for P in Lst
    do cbPost.Items.Add(String(P.Name));
  Lst.MyFreeAll;

  D := PDoctor(aItem);

  leCabinet.Text := String(D.Cabinet);
  cbPost.Text := String(D.Post);
end;

function TFrameDoctors.GetItemValue(aItem: PBegId; aCol, aRow: integer): string;
var
  A      : PDoctor;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  A := PDoctor(aItem);
  case aCol Of
      agRow               : Result := IntToStr(ARow);
      agSelect            : If Sels[ARow - 1] then Result := '*';
      agCabinet           : Result := String(A.Cabinet);
      agPosts             : Result := String(A.Post);
      agPeopleOf          : Result := IntToStr(A.PeopleOf);
      agId                : Result := IntToStr(A.Id);
   else Result := '*' + IntToStr(aCol);
  end;

end;

procedure TFrameDoctors.ItemInsertOrUpdate(aItem: PBegId);
var
  P   : PDoctor;

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

  P := PDoctor(aItem);
  if isExit(leCabinet) then Exit;
  if isExit(cbPost) then Exit;
  P.PeopleOf := iPeopleOf;

  ExecDoctorPutOrUpdate(P^);
  RefreshListOfItems;

end;

function TFrameDoctors.GetGridInitItem(Index: integer): integer;
begin
  Result := GridInitArray[Index];
end;

function TFrameDoctors.GridInitCount: integer;
begin
  Result := agLast + 1;
end;

function TFrameDoctors.GetGridColumnDescr(Index: integer): PMyGridColumnDescr;
begin
  Result := @GridDescr[Index];
end;

procedure TFrameDoctors.UpdateCurItem(aWinControl: TWinControl; aItem: PBegId);
var
  P            : PDoctor;
  TLE          : TLabeledEdit;
  TCB          : TComboBox;
begin
  P := PDoctor(aItem);

  if aWinControl is TLabeledEdit then
  begin
    TLE := aWinControl as TLabeledEdit;
    if TLE = leCabinet then P.Cabinet := ShortString(Trim(TLE.Text));
  end;

  if aWinControl is TComboBox then
  begin
    TCB := aWinControl as TComboBox;
    if TCB = cbPost then P.Post := ShortString(Trim(TCB.Text));
  end;

end;

function TFrameDoctors.GetDeleteMessage(aItem: PBegId): string;
var
  P  : PDoctor;
begin
  Result := '';

  if not Assigned(aItem) then Exit;

  P := PDoctor(aItem);
  Result := Format('Удалить "%s"?', [IntToStr(P.Id)]);
end;

function TFrameDoctors.DeleteItem(aItem: PBegId): boolean;
begin
  Result := False;

  if not Assigned(aItem) then Exit;

  if aItem.Id <> 0
    then ExecDoctorDelete(aItem.Id);
   Result := True;
end;

procedure TFrameDoctors.InitN(aPeopleOf : integer);
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
