unit uDocument;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, fDocument;

type
  TFormDocument = class(TForm)
    FrameDocument1: TFrameDocument;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CloseEvent(Sender : TObject);
  public
    { Public declarations }
    constructor MyCreate(aOwner : TComponent; aPeopleOf : smallint);
  end;

var
  FormDocument: TFormDocument;

implementation

{$R *.dfm}

procedure TFormDocument.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

constructor TFormDocument.MyCreate(aOwner : TComponent; aPeopleOf : smallint);
begin
  inherited Create(aOwner);

  FrameDocument1.InitN(aPeopleOf);
  FrameDocument1.OnCloseFrameEvent := CloseEvent;
end;

procedure TFormDocument.CloseEvent(Sender : TObject);
begin
  Close;
end;

end.
