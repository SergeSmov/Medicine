unit uPosts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, fPost;

type
  TFormPosts = class(TForm)
    FramePost1: TFramePost;
    procedure CloseEvent(Sender : TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor MyCreate(aOwner :TComponent);
  end;

var
  FormPosts: TFormPosts;

implementation

{$R *.dfm}
procedure TFormPosts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

constructor TFormPosts.MyCreate(aOwner :TComponent);
begin
  inherited Create(aOwner);

  FramePost1.InitN();
  FramePost1.OnCloseFrameEvent := CloseEvent;
end;

procedure TFormPosts.CloseEvent(Sender : TObject);
begin
  Close;
end;

end.
