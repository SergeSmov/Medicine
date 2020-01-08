unit uframePeople;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Common, Vcl.ToolWin;

type
  TFramePeople = class(TFrame)
    MainPanel: TPanel;
    leF: TLabeledEdit;
    leI: TLabeledEdit;
    leO: TLabeledEdit;
    BirthDate: TDateTimePicker;
    lBirthDate: TLabel;
    cbSex: TComboBox;
    lSex: TLabel;
    GroupBox1: TGroupBox;
    leSeries: TLabeledEdit;
    leNumber: TLabeledEdit;
    leAddress: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    gbPhone: TGroupBox;
    cbComType: TComboBox;
    lPhoneType: TLabel;
    tbBottom: TToolBar;
    tbSave: TToolButton;
    tbCancel: TToolButton;
    lePhoneNumber: TLabeledEdit;
    tbTop: TToolBar;
    tbCom: TToolButton;
    procedure tbSaveClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    function GetError(Sender : TObject) : boolean;
    procedure leFExit(Sender: TObject);
    procedure cbSexExit(Sender: TObject);
    procedure leIExit(Sender: TObject);
    procedure tbComClick(Sender: TObject);
  private
    { Private declarations }
    iType  : smallint;
    MainPP : PPeople;
    Communication : PCommunicationType;
    iPeopleType : smallint;
    ComLst : TBegList;
    procedure GetFullCommunicationType;
  public
    { Public declarations }
    constructor MyCreate(aOwner : TComponent; aPeopleType : smallint;
                         aType : smallint; PP : PPeople);
  end;

implementation

{$R *.dfm}

uses uData, uCommunication;

procedure TFramePeople.cbSexExit(Sender: TObject);
begin
  GetError(Sender);
end;

function TFramePeople.GetError(Sender : TObject) : boolean;
var
  le : TLabeledEdit;
  cb : TComboBox;
begin
  Result := false;
  if (Sender is TLabeledEdit) then
  begin
    le := Sender as TLabeledEdit;
    le.color := clWhite;
    if le.Text = '' then
    begin
      le.SetFocus;
      le.color := clRed;
      Result := true;
    end;
  end else
  if (Sender is TComboBox) then
  begin
    cb := Sender as TComboBox;
    cb.color := clWhite;
    if cb.Text = '' then
    begin
      cb.SetFocus;
      cb.Color := clRed;
      Result := true;
    end;
  end;
end;

procedure TFramePeople.leFExit(Sender: TObject);
begin
  GetError(Sender);
end;

procedure TFramePeople.leIExit(Sender: TObject);
begin
  GetError(Sender);
end;

procedure TFramePeople.GetFullCommunicationType;
var
  I: Integer;
begin
  cbComType.Items.Clear;
  ComLst := TBegList.MyCreate(nil, SizeOf(TCommunicationType), False, False);
  GetCommunicationTypeDetail(ComLst);
  for I := 0 to ComLst.Count - 1
    do cbComType.Items.Add(PCommunicationType(ComLst[i]).Name);
end;

constructor TFramePeople.MyCreate(aOwner: TComponent; aPeopleType : smallint; aType : smallint; PP : PPeople);
begin
  inherited;
  iType := aType;
  MainPP := PP;
  iPeopleType := aPeopleType;
  GetFullCommunicationType;


  case aType of
    0 : begin
          tbCom.Enabled := false;
          New(MainPP);
          leF.Text := '';
          leI.Text := '';
          leO.Text := '';
          BirthDate.Date := now;
          cbSex.Text := 'М';
    end;
    1 : begin
          tbCom.Enabled := true;
          leF.Text := PP.F;
          leI.Text := PP.I;
          leO.Text := PP.O;
          BirthDate.Date := PP.BIRTHDATE;
          cbSex.Text := PP.SEX;
    end;
  end;
end;

procedure TFramePeople.tbCancelClick(Sender: TObject);
begin
  ComLst.Free;
  (Self.Parent as TForm).Close;
end;

procedure TFramePeople.tbComClick(Sender: TObject);
begin
  TFormCommunication.MyCreate(Self, MainPP.Id);
end;

procedure TFramePeople.tbSaveClick(Sender: TObject);

  procedure SetValue;
  begin
   MainPP.F := Trim(leF.Text);
   MainPP.I := Trim(leI.Text);
   MainPP.O := Trim(leO.Text);
   MainPP.SEX := Trim(cbSex.Text);
   //MainPP.PHOTO
   MainPP.BIRTHDATE := BirthDate.Date;
   MainPP.PeopleOf := iPeopleType;
  end;

begin
  case iType of
    0 : begin
         SetValue;
         try
           ExecPeoplePutOrUpdate(MainPP^);
           ShowMessage('Клиент ' + MainPP.F + ' успешно добавлен.');
           tbCom.Enabled := true;
         except
           ShowMessage('Ошибка! Клиент ' + MainPP.F + ' не добавлен.');
           tbCom.Enabled := false;
         end;
    end;
    1 : begin
         SetValue;
         try
           ExecPeoplePutOrUpdate(MainPP^);
           ShowMessage('Клиент ' + MainPP.F + ' успешно изменен.');
         except
           ShowMessage('Ошибка! Клиент ' + MainPP.F + ' не изменен.');
         end;
    end;
  end;

end;

end.
