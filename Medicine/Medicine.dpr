program Medicine;

uses
  Vcl.Forms,
  MainMed in 'MainMed.pas' {FormMain},
  uDM in 'uDM.pas' {DataModule1: TDataModule},
  uData in 'uData.pas',
  Common in 'Common.pas',
  fTemplate in 'fTemplate.pas' {TemplateFrame: TFrame},
  fPeoples in 'fPeoples.pas' {FramePeoples: TFrame},
  uPeoples in 'uPeoples.pas' {FormPeoples},
  fPost in 'fPost.pas' {FramePost: TFrame},
  fDiagnoses in 'fDiagnoses.pas' {FrameDiagnoses: TFrame},
  uDiagnoses in 'uDiagnoses.pas' {FormDiagnoses},
  uDoctor in 'uDoctor.pas' {FormDoctor},
  uPosts in 'uPosts.pas' {FormPosts},
  fDocument in 'fDocument.pas' {FrameDocument: TFrame},
  fDocumentType in 'fDocumentType.pas' {FrameDocumentType: TFrame},
  uDocumentType in 'uDocumentType.pas' {FormDocumentType},
  fCommunicationType in 'fCommunicationType.pas' {FrameCommunicationType: TFrame},
  uCommunicationType in 'uCommunicationType.pas' {FormCommunicationType},
  fCommunication in 'fCommunication.pas' {FrameCommunication: TFrame},
  uCommunication in 'uCommunication.pas' {FormCommunication},
  uAddressType in 'uAddressType.pas' {FormAddressType},
  fAddressType in 'fAddressType.pas' {FrameAddressType: TFrame},
  uAddress in 'uAddress.pas' {FormAddress},
  fAddress in 'fAddress.pas' {FrameAddress: TFrame},
  uDocument in 'uDocument.pas' {FormDocument},
  fJournal in 'fJournal.pas' {FrameJournal: TFrame},
  uJournal in 'uJournal.pas' {FormJournal},
  fSelect in 'fSelect.pas' {FrameSelect: TFrame},
  fDoctors in 'fDoctors.pas' {FrameDoctors: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
