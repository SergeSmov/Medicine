unit uAddressType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fAddressType, fTemplate;

type
  TFormAddressType = class(TForm)
    FrameAddressType1: TFrameAddressType;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CloseEvent(Sender : TObject);
  public
    { Public declarations }
    constructor MyCreate(aOwner : TComponent);
  end;

var
  FormAddressType: TFormAddressType;

implementation

{$R *.dfm}

procedure TFormAddressType.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

constructor TFormAddressType.MyCreate(aOwner : TComponent);
begin
  inherited Create(aOwner);

  FrameAddressType1.InitN;
  FrameAddressType1.OnCloseFrameEvent := CloseEvent;
end;

procedure TFormAddressType.CloseEvent(Sender : TObject);
begin
  Close;
  inherited;
end;

end.
