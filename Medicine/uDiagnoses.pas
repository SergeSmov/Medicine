unit uDiagnoses;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fTemplate, fDiagnoses, Common;

type
  TFormDiagnoses = class(TForm)
    FrameDiagnoses1: TFrameDiagnoses;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseEvent(Sender : TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DiagnosesOf : integer;
    constructor MyCreate(aOwner : TComponent; aItem : integer = -1);
  end;

var
  FormDiagnoses: TFormDiagnoses;

implementation

{$R *.dfm}

procedure TFormDiagnoses.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DiagnosesOf := FrameDiagnoses1.DiagnosesOf;
  Action := caFree;
end;

constructor TFormDiagnoses.MyCreate(aOwner : TComponent; aItem : integer = -1);
begin
  inherited Create(aOwner);

  FrameDiagnoses1.InitN(aItem);
  FrameDiagnoses1.OnCloseFrameEvent := CloseEvent;
end;

procedure TFormDiagnoses.CloseEvent(Sender : TObject);
begin
  Close;
end;

end.
