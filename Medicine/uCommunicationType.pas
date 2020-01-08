unit uCommunicationType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, fCommunicationType;

type
  TFormCommunicationType = class(TForm)
    FrameCommunicationType1: TFrameCommunicationType;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CloseEvent(Sender : TObject);
  public
    { Public declarations }
    constructor MyCreate(aOwner : TComponent);
  end;

var
  FormCommunicationType: TFormCommunicationType;

implementation

{$R *.dfm}

procedure TFormCommunicationType.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

constructor TFormCommunicationType.MyCreate(aOwner : TComponent);
begin
  inherited Create(aOwner);

  FrameCommunicationType1.InitN();
  FrameCommunicationType1.OnCloseFrameEvent := CloseEvent;
end;

procedure TFormCommunicationType.CloseEvent(Sender : TObject);
begin
  Close;
end;

end.
