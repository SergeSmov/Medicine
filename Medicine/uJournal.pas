unit uJournal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, fJournal, Common, uData,
  fSelect;

type
  TFormJournal = class(TForm)
    FrameJournal1: TFrameJournal;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseEvent(Sender : TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure GetValue;
  public
    { Public declarations }
    constructor MyCreate(aOwner : TComponent);
  end;

var
  FormJournal: TFormJournal;

implementation

{$R *.dfm}

constructor TFormJournal.MyCreate(aOwner : TComponent);
begin
  inherited Create(aOwner);

  FrameJournal1.InitN();
  FrameJournal1.OnCloseFrameEvent := CloseEvent;
end;

procedure TFormJournal.CloseEvent(Sender : TObject);
begin
  Close;
end;

procedure TFormJournal.GetValue;
var
  Lst   : TBegList;
  TPS	  : TPeopleSelect;
  DT    : PPeople;
  TDS	  : TDiagnosesSelect;
  PD	  : PDiagnoses;
  i	    : integer;
begin
  if (FrameJournal1.FrameSelectPatiens.TFP <> nil) then
  begin
    if FrameJournal1.FrameSelectPatiens.TFP.PeopleOf <> 0 then
    begin
      Lst := nil;
      TPS.Prepare;
      TPS.ID := FrameJournal1.FrameSelectPatiens.TFP.PeopleOf;
      GetPeopleDetail(TPS, Lst);
      for DT in Lst do
      begin
        FrameJournal1.FrameSelectPatiens.leNumber.Text := String(DT.F + ' ' + DT.I + ' ' + DT.O);
        FrameJournal1.iPeopleOf := DT.Id;
      end;
      Lst.MyFreeAll;
      FrameJournal1.FrameSelectPatiens.TFP := nil;
    end;
  end;
  if (FrameJournal1.FrameSelectDoctor.TFP <> nil) then
  begin
    if FrameJournal1.FrameSelectDoctor.TFP.PeopleOf <> 0 then
    begin
      Lst := nil;
      TPS.Prepare;
      TPS.ID := FrameJournal1.FrameSelectDoctor.TFP.PeopleOf;
      GetPeopleDetail(TPS, Lst);
      for DT in Lst do
      begin
        FrameJournal1.FrameSelectDoctor.leNumber.Text := String(DT.F + ' ' + DT.I + ' ' + DT.O);
        FrameJournal1.iDoctorOf := DT.Id;
      end;
      Lst.MyFreeAll;
    end;
    FrameJournal1.FrameSelectDoctor.TFP := nil;
  end;
  if (FrameJournal1.FrameSelectDiagnoses.TFD <> nil) then
  begin
    if FrameJournal1.FrameSelectDiagnoses.TFD.DiagnosesOf <> 0 then
    begin
      Lst := nil;
      TDS.Prepare;
      TDS.ID := FrameJournal1.FrameSelectDiagnoses.TFD.DiagnosesOf;
      GetDiagnosesDetail(TDS, Lst);
      for PD in Lst do
      begin
        FrameJournal1.FrameSelectDiagnoses.leNumber.Text := PD.Name;
        FrameJournal1.iDiagnosesOf := PD.Id;
      end;
      Lst.MyFreeAll;
    end;
    FrameJournal1.FrameSelectDiagnoses.TFD := nil;
  end;
  if (FrameJournal1.FrameSelectPatiensSelect.TFP <> nil) then
  begin
    if FrameJournal1.FrameSelectPatiensSelect.TFP.PeopleOf <> 0 then
    begin
      Lst := nil;
      TPS.Prepare;
      TPS.ID := FrameJournal1.FrameSelectPatiensSelect.TFP.PeopleOf;
      GetPeopleDetail(TPS, Lst);
      for DT in Lst do
      begin
        FrameJournal1.FrameSelectPatiensSelect.leNumber.Text := String(DT.F + ' ' + DT.I + ' ' + DT.O);
        FrameJournal1.sPeopleOf := DT.Id;
      end;
      Lst.MyFreeAll;
      FrameJournal1.FrameSelectPatiensSelect.TFP := nil;
    end;
  end;
  if (FrameJournal1.FrameSelectDoctorSelect.TFP <> nil) then
  begin
    if FrameJournal1.FrameSelectDoctorSelect.TFP.PeopleOf <> 0 then
    begin
      Lst := nil;
      TPS.Prepare;
      TPS.ID := FrameJournal1.FrameSelectDoctorSelect.TFP.PeopleOf;
      GetPeopleDetail(TPS, Lst);
      for DT in Lst do
      begin
        FrameJournal1.FrameSelectDoctorSelect.leNumber.Text := String(DT.F + ' ' + DT.I + ' ' + DT.O);
        FrameJournal1.sDoctorOf := DT.Id;
      end;
      Lst.MyFreeAll;
      FrameJournal1.FrameSelectDoctorSelect.TFP := nil;
    end;
  end;
  if (FrameJournal1.FrameSelectDiagnosesSelect.TFD <> nil) then
  begin
    if FrameJournal1.FrameSelectDiagnosesSelect.TFD.DiagnosesOf <> 0 then
    begin
      Lst := nil;
      TDS.Prepare;
      TDS.ID := FrameJournal1.FrameSelectDiagnosesSelect.TFD.DiagnosesOf;
      GetDiagnosesDetail(TDS, Lst);
      for i := 0 to Lst.Count - 1 do
      begin
        PD := PDiagnoses(Lst[i]);
        FrameJournal1.FrameSelectDiagnosesSelect.leNumber.Text := PD.Name;
        FrameJournal1.iDiagnosesOf := PD.Id;
      end;
      Lst.MyFreeAll;
    end;
    FrameJournal1.FrameSelectDiagnosesSelect.TFD := nil;
  end;
end;

procedure TFormJournal.FormActivate(Sender: TObject);
begin
  GetValue;
end;

procedure TFormJournal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
