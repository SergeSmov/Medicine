unit uDocumentType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, fDocumentType;

type
  TFormDocumentType = class(TForm)
    FrameDocumentType1: TFrameDocumentType;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CloseEvent(Sender : TObject);
  public
    { Public declarations }
    constructor MyCreate(aOwner : TComponent);
  end;

var
  FormDocumentType: TFormDocumentType;

implementation

{$R *.dfm}

procedure TFormDocumentType.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

constructor TFormDocumentType.MyCreate(aOwner : TComponent);
begin
  inherited Create(aOwner);

  FrameDocumentType1.InitN();
  FrameDocumentType1.OnCloseFrameEvent := CloseEvent;
end;

procedure TFormDocumentType.CloseEvent(Sender : TObject);
begin
  Close;
end;

end.
