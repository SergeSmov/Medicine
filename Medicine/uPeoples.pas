unit uPeoples;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, fPeoples, Common;

type
  TFormPeoples = class(TForm)
    FramePeoples1: TFramePeoples;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CloseEvent(Sender : TObject);
  public
    { Public declarations }
    PeopleOf : integer;
    constructor MyCreate(aOwner : TComponent; aType : smallint;
               aItem : integer = -1);
  end;

var
  FormPeoples: TFormPeoples;

implementation

{$R *.dfm}

procedure TFormPeoples.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PeopleOf := FramePeoples1.PeopleOf;
  Action := caFree;
end;

constructor TFormPeoples.MyCreate(aOwner : TComponent;
 aType : smallint; aItem : integer = -1);
begin
  inherited Create(aOwner);
  case aType of
    cPatients : Self.Caption := 'Пациенты';
    cDoctor   : Self.Caption := 'Врачи';
  end;
  FramePeoples1.InitN(aType, aItem);
  FramePeoples1.OnCloseFrameEvent := CloseEvent;
end;

procedure TFormPeoples.CloseEvent(Sender : TObject);
begin
  Close;
end;

end.
