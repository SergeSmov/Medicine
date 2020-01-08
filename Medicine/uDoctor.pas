unit uDoctor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, Common, fDoctors;

type
  TFormDoctor = class(TForm)
    FrameDoctors1: TFrameDoctors;
    procedure CloseEvent(Sender : TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor MyCreate(aOwner : TComponent; aPeopleOf : TId);
  end;

var
  FormDoctor: TFormDoctor;

implementation

{$R *.dfm}

procedure TFormDoctor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

constructor TFormDoctor.MyCreate(aOwner : TComponent; aPeopleOf : TId);
begin
  inherited Create(aOwner);

  FrameDoctors1.InitN(aPeopleOf);
  FrameDoctors1.OnCloseFrameEvent := CloseEvent;
end;


procedure TFormDoctor.CloseEvent(Sender : TObject);
begin
  Close;
end;

end.
