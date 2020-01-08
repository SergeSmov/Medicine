unit Common;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDM, DB;


const
  SMyListUniqueError = 'Неуникальная сортировка пока не поддерживается!';
  SMyListSizeError   = 'Не задан размер элемента динамического списка!';
  SMyListExistError  = 'Элемент уже существует!';
  SMyListAbsentError = 'Элемент не найден!';
  cPatients = 1;
  cDoctor = 2;
  cDiagnoses = 3;
  cMax = 2000000000;

type
  TPointerDispose = procedure(P : Pointer);
  PId      = ^TId;
  TID      = Integer;

  PBeg = ^TBeg;
  TBeg = Object
  End;

  PBegId = ^TBegId;
  TBegId = Object(TBeg)
    Id:      TId;
  End;

  TBegList = Class(TList)
   protected
    FDispose:   TPointerDispose;
    FCmpFunc:   TListSortCompare;
    Procedure   SetCmpFunc(ACmpFunc: TListSortCompare);
   public
    isDynamic:  Boolean;
    isUnique:   Boolean;
    ElemSize:   Integer;
    Constructor MyCreate(ACmpFunc: TListSortCompare;
      AElemSize: Integer; AisDynamic, AisUnique: Boolean; Dispose: TPointerDispose = nil);
    Destructor  Destroy; Override;
    Function    MyAdd(Item: Pointer): Integer;
    Procedure   MyDelete(Index: Integer);
    Procedure   MyRemove(Item: Pointer);
    Function    MyIndexOf(Item: Pointer; Var Place: Integer): Integer;
    Procedure   QuickSort(L, R: Integer);
    Procedure   MyFreeAll;
    Procedure   MyFreeAllClasses;
    Procedure   MyFreeData;
    Procedure   MyFreeClassData;
    Procedure   MyClear;
    Property    CmpFunc: TListSortCompare read FCmpFunc write SetCmpFunc;
    Procedure   MyDisposeDelete(Index: Integer);
    property    MyDisposeProc : TPointerDispose read FDispose write FDispose;
  End;

  PMyGridColumnDescr = ^TMyGridColumnDescr;
  TMyGridColumnDescr = Record
    Width : Word;
    Align : Word;
    FtType : TFieldType;
    Name  : String;
    Descr : String;
  End;

  TBooleanArray = Array [0..cMax] Of Boolean;
  PBooleanArray = ^TBooleanArray;

  {$Region 'People'}
  PPeople = ^TPeople;
  TPeople = Object(TBegId)
    F                  : string[50];
    I                  : string[50];
    O            			 : string[50];
    SEX       	       : string[1];
//    PHOTO              : string;
    BIRTHDATE          : TDate;
    PeopleOf           : Smallint;
  End;

  PPeopleSelect  = ^TPeopleSelect;
  TPeopleSelect = Object
    ID            : TID;
    F             : string[50];
    I             : string[50];
    O             : string[50];
    PeopleOf      : integer;
    procedure Prepare;
  End;
  {$EndRegion}

  {$Region 'Doctor'}
  PDoctor = ^TDoctor;
  TDoctor = Object(TBegId)
    Cabinet            : string[50];
    PostOf             : smallint;
    Post               : string[150];
    PeopleOf           : integer;
  End;

  PDoctorSelect  = ^TDoctorSelect;
  TDoctorSelect = Object(TBegId)
    Cabinet            : string[50];
    PostOf             : smallint;
    PeopleOf           : integer;
    procedure Prepare;
  End;
  {$EndRegion}

  {$Region 'CommunicationType'}
  PCommunicationType = ^TCommunicationType;
  TCommunicationType = Object(TBegId)
    Name               : string[50];
  End;
  {$EndRegion}

  {$Region 'Communication'}
  PCommunication = ^TCommunication;
  TCommunication = Object(TBegId)
    PHONE                 : string[50];
    COMMUNICATIONTYPENAME : string[50];
    PeopleOf   	          : Integer;
  End;

  PCommunicationSelect  = ^TCommunicationSelect;
  TCommunicationSelect = Object
    PeopleOf   	       : Integer;
    procedure Prepare;
  End;
  {$EndRegion}

  {$Region 'Posts'}
  PPosts = ^TPosts;
  TPosts = Object(TBegId)
    Name               : widestring;
  End;
  {$EndRegion}

  {$Region 'Diagnoses'}
  PDiagnoses = ^TDiagnoses;
  TDiagnoses = Object(TBegId)
    Code               : string[50];
    Name               : widestring;
  End;

  PDiagnosesSelect  = ^TDiagnosesSelect;
  TDiagnosesSelect = Object
    ID            : TID;
    procedure Prepare;
  End;
  {$EndRegion}

  {$Region 'DocumentType'}
  PDocumentType = ^TDocumentType;
  TDocumentType = Object(TBegId)
    Code           		 : string[2];
    Name               : string[150];
  End;
  {$EndRegion}

  {$Region 'Document'}
  PDocument = ^TDocument;
  TDocument = Object(TBegId)
    DOCUMENTID          : Integer;
    SERIES              : string[30];
    NUMBER						  : string[50];
    DOCUMENTTYPE				: smallint;
    DOCUMENT	          : string[150];
    PeopleOf   	        : Integer;
  End;

  PDocumentSelect  = ^TDocumentSelect;
  TDocumentSelect = Object
    PeopleOf   	       : Integer;
    procedure Prepare;
  End;
  {$EndRegion}

  {$Region 'AddressType'}
  PAddressType = ^TAddressType;
  TAddressType = Object(TBegId)
    Name        : string[150];
  End;
  {$EndRegion}

  {$Region 'Address'}
  PAddress = ^TAddress;
  TAddress = Object(TBegId)
    ADDRESS             : widestring;
    ADDRESSTYPENAME 		: string[150];
    PeopleOf   	        : Integer;
  End;

  PAddressSelect  = ^TAddressSelect;
  TAddressSelect = Object
    PeopleOf   	       : Integer;
    procedure Prepare;
  End;
  {$EndRegion}

  {$Region 'Journal'}
  PJournal = ^TJournal;
  TJournal = Object(TBegId)
    DATETIME            : TDateTime;
    NUMBER 		          : string[50];
    PeopleOf   	        : Integer;
    PeopleOfName	      : string;
    DoctorOf   	        : Integer;
    DoctorOfName	      : string;
    DiagnosesOf	        : Integer;
    DiagnosesOfName     : string;
  End;

  PJournalSelect  = ^TJournalSelect;
  TJournalSelect = Object
    DATETIME           : TDateTime;
    PeopleOf   	       : Integer;
    DoctorOf	         : Integer;
    DiagnosesOf	       : Integer;
    procedure Prepare;
  End;
  {$EndRegion}

Procedure JustifyDraw(Canvas : TCanvas; Rect : TRect; Al : Integer; Const S: String);
Function  isExistsId(P: PBegId): Boolean;

implementation

Procedure TPeopleSelect.Prepare;
Begin
  FillChar(Self, Sizeof(TPeopleSelect), 0);
End;

Procedure TDiagnosesSelect.Prepare;
Begin
  FillChar(Self, Sizeof(TDiagnosesSelect), 0);
End;

Procedure TDoctorSelect.Prepare;
Begin
  FillChar(Self, Sizeof(TDoctorSelect), 0);
End;

Procedure TCommunicationSelect.Prepare;
Begin
  FillChar(Self, Sizeof(TCommunicationSelect), 0);
End;

Procedure TDocumentSelect.Prepare;
Begin
  FillChar(Self, Sizeof(TDocumentSelect), 0);
End;

Procedure TAddressSelect.Prepare;
Begin
  FillChar(Self, Sizeof(TAddressSelect), 0);
End;

Procedure TJournalSelect.Prepare;
Begin
  FillChar(Self, Sizeof(TJournalSelect), 0);
End;

Constructor TBegList.MyCreate(ACmpFunc: TListSortCompare;
  AElemSize: Integer; AisDynamic, AisUnique: Boolean; Dispose: TPointerDispose = nil);
Begin
  FDispose := Dispose;
  CmpFunc   := ACmpFunc;
  ElemSize  := AElemSize;
  isDynamic := AisDynamic;
  isUnique  := AisUnique;
  If isDynamic And (ElemSize = 0) Then
    Error(SMyListSizeError,0);
  If Assigned(CmpFunc) And Not isUnique Then
    Error(SMyListUniqueError,0);
End;


Destructor TBegList.Destroy;
Begin
  MyClear;
  Inherited Destroy;
End;

Procedure TBegList.MyClear;
Begin
  If isDynamic
    Then MyFreeData
    Else Clear;
End;

Procedure TBegList.MyFreeData;
Var
  i: Integer;
Begin
  For i:=0 To Count-1 Do
    if Assigned(FDispose)
      then FDispose(Self[i])
      else begin
        Dispose(Self[i]);
        Self[i] := Nil;
      end;
  Clear;
End;

procedure TBegList.QuickSort(L, R: Integer);
var
  I, J: Integer;
  P, T: Pointer;
begin
  repeat
    I := L;
    J := R;
    P := Self[(L + R) shr 1];
    repeat
      while CmpFunc(Self[I], P) < 0 do Inc(I);
      while CmpFunc(Self[J], P) > 0 do Dec(J);
      if I <= J then
      begin
        T := Self[I];
        Self[I] := Self[J];
        Self[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J);
    L := I;
  until I >= R;
end;

Function TBegList.MyIndexOf(Item: Pointer; Var Place: Integer): Integer;
Var
  iLo, iHi : Integer;
  i : TID;
Begin
  Place := 0;
  If Count = 0 Then Begin
    Result := -1;
    Exit;
  End;
  If Assigned(CmpFunc) Then Begin
    iLo := 0;
    iHi := Count-1;
    Repeat
      Result := iLo + (iHi - iLo) Div 2;
      Place := Result;
      i := CmpFunc(Item, Self[Result]);
      If i = 0
        Then Break;
      If i < 0
        Then iHi := Result - 1
        Else iLo := Result + 1;
      If iLo > iHi Then Begin
        If Place < 0 Then Place := 0;
        If i > 0
          Then Inc(Place);
        Result := -1;
      End;
    Until iLo > iHi;
  End Else Begin
    Result := 0;
    While (Result < Count) And (Self[Result] <> Item) Do Inc(Result);
    If Result = Count Then Begin
      Place  := Result;
      Result := -1;
    End Else Place  := Result;
  End;
End;

Function TBegList.MyAdd(Item: Pointer): Integer;
Var
  P: Pointer;
  Place: Integer;
Begin
  Result := MyIndexOf(Item, Place);
  If (Result >= 0) And isUnique
    Then Error(SMyListExistError,0);
  If isDynamic Then Begin
    GetMem(P, ElemSize);
    System.Move(Item^, P^, ElemSize);
    Item := P;
  End;
  Insert(Place, Item);
  Result := Place;
End;

Procedure TBegList.MyDelete(Index: Integer);
Begin
  if Assigned(FDispose) then MyDisposeDelete(Index)
  else begin
    If (Index >= 0) And (Index < Count) And isDynamic
      Then FreeMem(Self[Index]);
    Delete(Index);
  end;
End;

procedure TBegList.MyDisposeDelete(Index: Integer);
begin
  If ((Index < 0) or (Index >= Count) or (not Assigned(FDispose)))
    then raise Exception.Create('Index error or dispose proc not assigned');
  FDispose(Self[Index]);
  Delete(Index);
end;


Procedure TBegList.MyRemove(Item: Pointer);
Var
  Place: Integer;
  I: Integer;
Begin
  I := MyIndexOf(Item, Place);
  If I < 0
    Then Error(SMyListAbsentError,0);
  MyDelete(I);
End;

Procedure TBegList.SetCmpFunc(ACmpFunc: TListSortCompare);
Begin
  FCmpFunc := ACmpFunc;
  If Assigned(ACmpFunc) And (Count > 1)
    Then QuickSort(0, Count-1);
End;

Procedure TBegList.MyFreeAll;
Begin
  If Not Assigned(Self) Then Exit;
  isDynamic := True;
  Destroy;
End;

procedure TBegList.MyFreeAllClasses;
begin
  If Not Assigned(Self) Then Exit;
  isDynamic := True;
  MyFreeClassData;
  Destroy;
end;

procedure TBegList.MyFreeClassData;
Var
  i: Integer;
Begin
  For i := 0 To Count - 1 Do
    begin
      TObject(Self[i]).Free;
      Self[i] := Nil;
    end;
  Clear;
End;

Procedure JustifyDraw(Canvas : TCanvas; Rect : TRect; Al : Integer; Const S: String);
Var
  TextW : Integer;
  RectW : Integer;
Begin
  If Al = 0 Then
    Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, S)
  Else Begin
    RectW := Rect.Right - Rect.Left + 1;
    TextW := Canvas.TextWidth(S);
    If Al = 1
      Then Canvas.TextRect(Rect, Rect.Left+(RectW - TextW) Div 2, Rect.Top + 2, S)
      Else Canvas.TextRect(Rect, Rect.Left+(RectW - 2 - TextW), Rect.Top + 2, S);
  end;
End;

Function isExistsId(P: PBegId): Boolean;
Begin
  Result := Assigned(P) And (P.Id <> 0);
End;

end.
