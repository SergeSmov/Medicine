unit fSelect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, uPeoples, Common, uData, uDiagnoses;

type
  TFrameSelect = class(TFrame)
    Panel: TPanel;
    leNumber: TLabeledEdit;
    sbStart: TSpeedButton;
    procedure sbStartClick(Sender: TObject);
  private
    { Private declarations }
    FP : TFormPeoples;
    FD : TFormDiagnoses;
    FItem : integer;
    FPeopleOf : TId;
    FType : smallint;
    procedure OpenForm(Sender : TObject);
    procedure GetPeople;
    procedure GetDiagnoses;
    function CheckValue : boolean;
  public
    { Public declarations }
    procedure Init(aType : smallint; aItem : integer);
    property TFP : TFormPeoples read FP write FP;
    property TFD : TFormDiagnoses read FD write FD;
  end;

implementation

{$R *.dfm}
function TFrameSelect.CheckValue : boolean;
begin
  Result := false;
  case FType of
    cPatients  : leNumber.EditLabel.Caption := 'Пациент';
    cDoctor    : leNumber.EditLabel.Caption := 'Врач';
    cDiagnoses : leNumber.EditLabel.Caption := 'Диагноз';
  end;

  if FItem = 0 then
  begin
    leNumber.Text := '';
    Result := true;
  end;
end;

procedure TFrameSelect.Init(aType : smallint; aItem : integer);
begin
  FItem := aItem;
  FType := aType;

  case FType of
    cPatients : begin
       if CheckValue then Exit;
       GetPeople;
    end;
    cDoctor : begin
      if CheckValue then Exit;
      GetPeople;
    end;
    cDiagnoses : begin
      if CheckValue then Exit;
      GetDiagnoses;
    end;
  end;
end;

procedure TFrameSelect.GetPeople;
var
  Local_DT: PPeople;
  Lst: TBegList;
  TPS: TPeopleSelect;
begin
  Lst := nil;
  TPS.Prepare;
  TPS.ID := FItem;
  GetPeopleDetail(TPS, Lst);
  for Local_DT in Lst
    do leNumber.Text := string(Local_DT.F + ' ' + Local_DT.I + ' ' + Local_DT.O);
  Lst.MyFreeAll;
end;

procedure TFrameSelect.GetDiagnoses;
var
  Lst  : TBegList;
  PD   : PDiagnoses;
  TDS  : TDiagnosesSelect;
begin
  Lst := nil;
  TDS.Prepare;
  TDS.ID := FItem;
  GetDiagnosesDetail(TDS, Lst);
  for PD in Lst
    do leNumber.Text := PD.Name;
  Lst.MyFreeAll;
end;

procedure TFrameSelect.sbStartClick(Sender: TObject);
begin
  OpenForm(Self);
end;

procedure TFrameSelect.OpenForm(Sender : TObject);
begin
  case FType of
    cPatients : begin
      FP := TFormPeoples.MyCreate(Self, cPatients, FItem);
    end;
    cDoctor : begin
      FP := TFormPeoples.MyCreate(Self, cDoctor, FItem);
    end;
    cDiagnoses : begin
      FD := TFormDiagnoses.MyCreate(Self, FItem);
    end;
  end;
end;

end.
