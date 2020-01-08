unit MainMed;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDM, Common, uCommunicationType,
  uAddressType, uJournal, FireDAC.Phys.IBDef, FireDAC.Phys.IBWrapper;

type
  TFormMain = class(TForm)
    MainMenu1: TMainMenu;
    ReferenceBooksItems: TMenuItem;
    PatientsItem: TMenuItem;
    DoctorsItems: TMenuItem;
    PostsItem: TMenuItem;
    DoctorsItem: TMenuItem;
    DiagnosesItem: TMenuItem;
    PatientCaseLogItem: TMenuItem;
    AboutItem: TMenuItem;
    DocumentTypeItem: TMenuItem;
    CommunicationTypeItem: TMenuItem;
    AddressTypeItem: TMenuItem;
    procedure PatientsItemClick(Sender: TObject);
    procedure PostsItemClick(Sender: TObject);
    procedure DiagnosesItemClick(Sender: TObject);
    procedure DoctorsItemClick(Sender: TObject);
    procedure DocumentTypeItemClick(Sender: TObject);
    procedure CommunicationTypeItemClick(Sender: TObject);
    procedure AddressTypeItemClick(Sender: TObject);
    procedure PatientCaseLogItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}
uses uPeoples, uPosts, uDiagnoses, uDocumentType;

procedure TFormMain.AddressTypeItemClick(Sender: TObject);
begin
  TFormAddressType.MyCreate(Self);
end;

procedure TFormMain.CommunicationTypeItemClick(Sender: TObject);
begin
  TFormCommunicationType.MyCreate(Self);
end;

procedure TFormMain.DiagnosesItemClick(Sender: TObject);
begin
  TFormDiagnoses.MyCreate(Self);
end;

procedure TFormMain.DoctorsItemClick(Sender: TObject);
begin
  TFormPeoples.MyCreate(Self, cDoctor);
end;

procedure TFormMain.DocumentTypeItemClick(Sender: TObject);
begin
  TFormDocumentType.MyCreate(Self);
end;

procedure TFormMain.PatientCaseLogItemClick(Sender: TObject);
begin
  TFormJournal.MyCreate(Self);
end;

procedure TFormMain.PatientsItemClick(Sender: TObject);
begin
  TFormPeoples.MyCreate(Self, cPatients);
end;

procedure TFormMain.PostsItemClick(Sender: TObject);
begin
  TFormPosts.MyCreate(Self);
end;

end.
