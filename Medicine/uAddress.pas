unit uAddress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, fAddress, Common;

type
  TFormAddress = class(TForm)
    FrameAddress1: TFrameAddress;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseEvent(Sender : TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor MyCreate(aOwner : TComponent; aPeopleOf : TId);
  end;

var
  FormAddress: TFormAddress;

implementation

{$R *.dfm}

constructor TFormAddress.MyCreate(aOwner : TComponent; aPeopleOf : TId);
begin
  inherited Create(aOwner);

  FrameAddress1.InitN(aPeopleOf);
  FrameAddress1.OnCloseFrameEvent := CloseEvent;
end;

procedure TFormAddress.CloseEvent(Sender : TObject);
begin
  Close;
end;

procedure TFormAddress.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
