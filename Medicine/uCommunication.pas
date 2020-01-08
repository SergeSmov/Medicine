unit uCommunication;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, fCommunication, Common;

type
  TFormCommunication = class(TForm)
    FrameCommunication1: TFrameCommunication;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    procedure CloseEvent(Sender : TObject);
  public
    { Public declarations }
    constructor MyCreate(aOwner : TComponent; aPeopleOf : TId);
  end;

var
  FormCommunication: TFormCommunication;

implementation

{$R *.dfm}


procedure TFormCommunication.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

constructor TFormCommunication.MyCreate(aOwner : TComponent; aPeopleOf : TId);
begin
  inherited Create(aOwner);

  FrameCommunication1.InitN(aPeopleOf);
  FrameCommunication1.OnCloseFrameEvent := CloseEvent;
end;

procedure TFormCommunication.CloseEvent(Sender : TObject);
begin
  Close;
end;


end.
