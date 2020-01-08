unit uData;

interface

uses Common, uDM, Variants, FireDAC.Stan.Param;

Procedure GetPeopleDetail(Const TPS : TPeopleSelect; Var ADList : TBegList; isNewList : Boolean = True);
procedure ExecPeoplePutOrUpdate(var P : TPeople);
procedure ExecPeopleDelete(aId : TID);

Procedure GetCommunicationTypeDetail(Var ADList : TBegList; isNewList : Boolean = True);
procedure ExecCommunicationTypePutOrUpdate(var P : TCommunicationType);
procedure ExecCommunicationTypeDelete(aOrdinal : TID);

Procedure GetCommunicationDetail(Const TCS : TCommunicationSelect; Var ADList : TBegList; isNewList : Boolean = True);
procedure ExecCommunicationPutOrUpdate(var P : TCommunication);
procedure ExecCommunicationDelete(aId : TID);

Procedure GetDoctorDetail(Const TPS : TDoctorSelect; Var ADList : TBegList; isNewList : Boolean = True);
procedure ExecDoctorPutOrUpdate(var P : TDoctor);
procedure ExecDoctorDelete(aId : TID);

Procedure GetPostsDetail(Var ADList : TBegList; isNewList : Boolean = True);
procedure ExecPostsPutOrUpdate(var P : TPosts);
procedure ExecPostsDelete(aOrdinal : TID);

Procedure GetDiagnosesDetail(TDS : TDiagnosesSelect; Var ADList : TBegList; isNewList : Boolean = True);
procedure ExecDiagnosesPutOrUpdate(var P : TDiagnoses);
procedure ExecDiagnosesDelete(aOrdinal : TID);

Procedure GetDocumentTypeDetail(Var ADList : TBegList; isNewList : Boolean = True);
procedure ExecDocumentTypePutOrUpdate(var P : TDocumentType);
procedure ExecDocumentTypeDelete(aOrdinal : TID);

Procedure GetDocumentDetail(Const TPS : TDocumentSelect; Var ADList : TBegList; isNewList : Boolean = True);
procedure ExecDocumentPutOrUpdate(var P : TDocument);
procedure ExecDocumentDelete(aId : TID);

Procedure GetAddressTypeDetail(Var ADList : TBegList; isNewList : Boolean = True);
procedure ExecAddressTypePutOrUpdate(var P : TAddressType);
procedure ExecAddressTypeDelete(aId : TID);

Procedure GetAddressDetail(Const TPS : TAddressSelect; Var ADList : TBegList; isNewList : Boolean = True);
procedure ExecAddressPutOrUpdate(var P : TAddress);
procedure ExecAddressDelete(aId : TID);

Procedure GetJournalDetail(Const TPS : TJournalSelect; Var ADList : TBegList; isNewList : Boolean = True);
procedure ExecJournalPutOrUpdate(var P : TJournal);
procedure ExecJournalDelete(aId : TID);

implementation

Procedure GetPeopleDetail(Const TPS : TPeopleSelect; Var ADList : TBegList; isNewList : Boolean = True);
var
  PC : PPeople;
  I  : integer;
begin
  uDm.DataModule1.FDConnection1.Connected := true;
  uDM.DataModule1.FDQ.SQL.Clear;
  uDM.DataModule1.FDQ.SQL.Add('select * from PEOPLE_SEL(:aPeopleId, :aF, :aI, :aO, :aPeopleOf)');

  if TPS.ID <> 0
    then uDM.DataModule1.FDQ.ParamByName('aPeopleId').AsInteger := TPS.Id
      else uDM.DataModule1.FDQ.ParamByName('aPeopleId').Value := null;
  if TPS.F <> ''
    then uDM.DataModule1.FDQ.ParamByName('aF').AsString := String(TPS.F)
      else uDM.DataModule1.FDQ.ParamByName('aF').Value := null;
  if TPS.I <> ''
    then uDM.DataModule1.FDQ.ParamByName('aI').AsString := String(TPS.I)
      else uDM.DataModule1.FDQ.ParamByName('aI').Value := null;
  if TPS.O <> ''
    then uDM.DataModule1.FDQ.ParamByName('aO').AsString := String(TPS.O)
      else uDM.DataModule1.FDQ.ParamByName('aO').Value := null;
  if TPS.PeopleOf <> 0
    then uDM.DataModule1.FDQ.ParamByName('aPeopleOf').AsInteger := TPS.PeopleOf
      else uDM.DataModule1.FDQ.ParamByName('aPeopleOf').Value := null;

  if Assigned(ADList) Then Begin
    If (isNewList) Then
    Begin
      For I := ADList.Count-1 DownTo 0 Do
        FreeMem(ADList[I]);
      ADList.Clear;
    End;
  End Else ADList := TBegList.MyCreate(Nil, SizeOf(TPeople), False, False);
  uDM.DataModule1.FDQ.Open;
  while not uDM.DataModule1.FDQ.Eof do
  begin
    New(PC);
    FillChar(PC^,SizeOf(PC^),0);
    PC.Id  := uDM.DataModule1.FDQ.FieldByName('Peopleid').AsInteger;
    PC.F  := ShortString(uDM.DataModule1.FDQ.FieldByName('F').AsString);
    PC.I  := ShortString(uDM.DataModule1.FDQ.FieldByName('I').AsString);
    PC.O  := ShortString(uDM.DataModule1.FDQ.FieldByName('O').AsString);
    PC.SEX := ShortString(uDM.DataModule1.FDQ.FieldByName('SEX').AsString);
//    PC.PHOTO  := uDM.DataModule1.FDQ.FieldByName[5].AsBlob;
    PC.BIRTHDATE := uDM.DataModule1.FDQ.FieldByName('BIRTHDATE').AsDateTime;
    PC.PeopleOf := uDM.DataModule1.FDQ.FieldByName('PeopleOf').AsInteger;
    ADList.MyAdd(PC);
    uDM.DataModule1.FDQ.Next;
  end;
  uDM.DataModule1.FDQ.Close;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecPeoplePutOrUpdate(var P : TPeople);
var
  SpName : string;
begin
  udm.DataModule1.FDConnection1.Connected := true;
  if P.Id = 0 then
  begin
    udm.DataModule1.FDStoredProc1.ExecProc('SP_GEN_PEOPLE_ID');
    udm.DataModule1.FDStoredProc1.Open;
    P.Id := udm.DataModule1.FDStoredProc1.FieldByName('ID').AsInteger;

    SpName := 'PEOPLE_INS';
  end else SpName := 'PEOPLE_UPD';

  udm.DataModule1.FDStoredProc1.StoredProcName := SpName;
  udm.DataModule1.FDStoredProc1.Prepare;
  udm.DataModule1.FDStoredProc1.ParamByName('PEOPLEID').AsInteger := P.Id;
  udm.DataModule1.FDStoredProc1.ParamByName('F').AsString := String(P.F);
  udm.DataModule1.FDStoredProc1.ParamByName('I').AsString := String(P.I);
  udm.DataModule1.FDStoredProc1.ParamByName('O').AsString := String(P.O);
  udm.DataModule1.FDStoredProc1.ParamByName('SEX').AsString := String(P.SEX);
  udm.DataModule1.FDStoredProc1.ParamByName('BIRTHDATE').AsDate := P.BIRTHDATE;
  udm.DataModule1.FDStoredProc1.ParamByName('PEOPLEOF').AsInteger := P.PeopleOf;
  udm.DataModule1.FDStoredProc1.ExecProc;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecPeopleDelete(aId : TID);
begin
  udm.DataModule1.FDConnection1.Connected := true;
  udm.DataModule1.FDStoredProc1.ExecProc('PEOPLE_DEL', [aId]);
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

Procedure GetCommunicationDetail(Const TCS : TCommunicationSelect; Var ADList : TBegList; isNewList : Boolean = True);
var
  PC : PCommunication;
  I  : integer;
begin
  uDm.DataModule1.FDConnection1.Connected := true;
  uDM.DataModule1.FDQ.SQL.Clear;
  uDM.DataModule1.FDQ.SQL.Add('select * from COMMUNICATION_SEL(:aPeopleOf)');

  if TCS.PEOPLEOF <> 0
    then uDM.DataModule1.FDQ.ParamByName('aPeopleOf').AsInteger := TCS.PEOPLEOF
      else uDM.DataModule1.FDQ.ParamByName('aPeopleOf').Value := null;

  if Assigned(ADList) Then Begin
    If (isNewList) Then
    Begin
      For I := ADList.Count-1 DownTo 0 Do
        FreeMem(ADList[I]);
      ADList.Clear;
    End;
  End Else ADList := TBegList.MyCreate(Nil, SizeOf(TCommunication), False, False);
  uDM.DataModule1.FDQ.Open;
  while not uDM.DataModule1.FDQ.Eof do
  begin
    New(PC);
    FillChar(PC^,SizeOf(PC^),0);
    PC.Id  := uDM.DataModule1.FDQ.FieldByName('COMMUNICATIONID').AsInteger;
    PC.PHONE  := ShortString(uDM.DataModule1.FDQ.FieldByName('PHONE').AsString);
    PC.COMMUNICATIONTYPENAME  := ShortString(uDM.DataModule1.FDQ.FieldByName('COMMUNICATIONTYPENAME').AsString);
    PC.PEOPLEOF  := uDM.DataModule1.FDQ.FieldByName('PEOPLEOF').AsInteger;
    ADList.MyAdd(PC);
    uDM.DataModule1.FDQ.Next;
  end;
  uDM.DataModule1.FDQ.Close;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecCommunicationPutOrUpdate(var P : TCommunication);
var
  SpName : string;
begin
  udm.DataModule1.FDConnection1.Connected := true;
  if P.Id = 0 then
  begin
    udm.DataModule1.FDStoredProc1.ExecProc('SP_GEN_COMMUNICATION_ID');
    udm.DataModule1.FDStoredProc1.Open;
    P.Id := udm.DataModule1.FDStoredProc1.FieldByName('ID').AsInteger;

    SpName := 'COMMUNICATION_INS';
  end else SpName := 'COMMUNICATION_UPD';

  udm.DataModule1.FDStoredProc1.StoredProcName := SpName;
  udm.DataModule1.FDStoredProc1.Prepare;
  udm.DataModule1.FDStoredProc1.ParamByName('COMMUNICATIONID').AsInteger := P.Id;
  udm.DataModule1.FDStoredProc1.ParamByName('PHONE').AsString := String(P.PHONE);
  udm.DataModule1.FDStoredProc1.ParamByName('COMMUNICATIONTYPENAME').AsString := String(P.COMMUNICATIONTYPENAME);
  udm.DataModule1.FDStoredProc1.ParamByName('PEOPLEOF').AsInteger := P.PEOPLEOF;
  udm.DataModule1.FDStoredProc1.ExecProc;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecCommunicationDelete(aId : TID);
begin
  udm.DataModule1.FDConnection1.Connected := true;
  udm.DataModule1.FDStoredProc1.ExecProc('COMMUNICATION_DEL', [aId]);
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

Procedure GetCommunicationTypeDetail(Var ADList : TBegList; isNewList : Boolean = True);
var
  PCT : PCommunicationType;
  I  : integer;
begin
  uDm.DataModule1.FDConnection1.Connected := true;
  uDM.DataModule1.FDQ.SQL.Clear;
  uDM.DataModule1.FDQ.SQL.Add('select * from COMMUNICATIONTYPE_SEL');

  if Assigned(ADList) Then Begin
    If (isNewList) Then
    Begin
      For I := ADList.Count-1 DownTo 0 Do
        FreeMem(ADList[I]);
      ADList.Clear;
    End;
  End Else ADList := TBegList.MyCreate(Nil, SizeOf(TCommunicationType), False, False);
  uDM.DataModule1.FDQ.Open;
  while not uDM.DataModule1.FDQ.Eof do
  begin
    New(PCT);
    FillChar(PCT^,SizeOf(PCT^),0);
    PCT.Id := uDM.DataModule1.FDQ.FieldByName('ORDINAL').AsInteger;
    PCT.Name  := ShortString(uDM.DataModule1.FDQ.FieldByName('NAME').AsString);
    ADList.MyAdd(PCT);
    uDM.DataModule1.FDQ.Next;
  end;
  uDM.DataModule1.FDQ.Close;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecCommunicationTypePutOrUpdate(var P : TCommunicationType);
var
  SpName : string;
begin
  udm.DataModule1.FDConnection1.Connected := true;
  if P.Id = 0 then
  begin
    udm.DataModule1.FDStoredProc1.ExecProc('SP_GEN_COMMUNICATIONTYPE_ID');
    udm.DataModule1.FDStoredProc1.Open;
    P.Id := udm.DataModule1.FDStoredProc1.FieldByName('ID').AsInteger;

    SpName := 'COMMUNICATIONTYPE_INS';
  end else SpName := 'COMMUNICATIONTYPE_UPD';

  udm.DataModule1.FDStoredProc1.StoredProcName := SpName;
  udm.DataModule1.FDStoredProc1.Prepare;
  udm.DataModule1.FDStoredProc1.ParamByName('ORDINAL').AsInteger := P.Id;
  udm.DataModule1.FDStoredProc1.ParamByName('NAME').AsString := String(P.Name);
  udm.DataModule1.FDStoredProc1.ExecProc;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecCommunicationTypeDelete(aOrdinal : TID);
begin
  udm.DataModule1.FDConnection1.Connected := true;
  udm.DataModule1.FDStoredProc1.ExecProc('COMMUNICATIONTYPE_DEL', [aOrdinal]);
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

Procedure GetDoctorDetail(Const TPS : TDoctorSelect; Var ADList : TBegList; isNewList : Boolean = True);
var
  PC : PDoctor;
  I  : integer;
begin
  uDm.DataModule1.FDConnection1.Connected := true;
  uDM.DataModule1.FDQ.SQL.Clear;
  uDM.DataModule1.FDQ.SQL.Add('select * from DOCTOR_SEL(:aPeople)');

  if TPS.PeopleOf <> 0
    then uDM.DataModule1.FDQ.ParamByName('aPeople').AsInteger := TPS.PeopleOf
      else uDM.DataModule1.FDQ.ParamByName('aPeople').Value := null;

  if Assigned(ADList) Then Begin
    If (isNewList) Then
    Begin
      For I := ADList.Count-1 DownTo 0 Do
        FreeMem(ADList[I]);
      ADList.Clear;
    End;
  End Else ADList := TBegList.MyCreate(Nil, SizeOf(TDoctor), False, False);
  uDM.DataModule1.FDQ.Open;
  while not uDM.DataModule1.FDQ.Eof do
  begin
    New(PC);
    FillChar(PC^,SizeOf(PC^),0);
    PC.Cabinet  := ShortString(uDM.DataModule1.FDQ.FieldByName('CABINET').AsString);
    PC.PostOf  := uDM.DataModule1.FDQ.FieldByName('POSTOF').AsInteger;
    PC.Post := ShortString(uDM.DataModule1.FDQ.FieldByName('Post').AsString);
    PC.PeopleOf  := uDM.DataModule1.FDQ.FieldByName('peopleof').AsInteger;
    PC.Id  := uDM.DataModule1.FDQ.FieldByName('doctorid').AsInteger;
    ADList.MyAdd(PC);
    uDM.DataModule1.FDQ.Next;
  end;
  uDM.DataModule1.FDQ.Close;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecDoctorPutOrUpdate(var P : TDoctor);
var
  SpName : string;
begin
  udm.DataModule1.FDConnection1.Connected := true;
  if P.Id = 0 then
  begin
    udm.DataModule1.FDStoredProc1.ExecProc('SP_GEN_DOCTOR_ID');
    udm.DataModule1.FDStoredProc1.Open;
    P.Id := udm.DataModule1.FDStoredProc1.FieldByName('ID').AsInteger;

    SpName := 'DOCTOR_INS';
  end else SpName := 'DOCTOR_UPD';

  udm.DataModule1.FDStoredProc1.StoredProcName := SpName;
  udm.DataModule1.FDStoredProc1.Prepare;
  udm.DataModule1.FDStoredProc1.ParamByName('DOCTORID').AsInteger := P.Id;
  udm.DataModule1.FDStoredProc1.ParamByName('CABINET').AsString := String(P.Cabinet);
  udm.DataModule1.FDStoredProc1.ParamByName('POSTNAME').AsString := String(P.Post);
  udm.DataModule1.FDStoredProc1.ParamByName('PEOPLEOF').AsInteger := P.PeopleOf;
  udm.DataModule1.FDStoredProc1.ExecProc;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecDoctorDelete(aId : TID);
begin
  udm.DataModule1.FDConnection1.Connected := true;
  udm.DataModule1.FDStoredProc1.ExecProc('DOCTOR_DEL', [aId]);
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

Procedure GetPostsDetail(Var ADList : TBegList; isNewList : Boolean = True);
var
  PC : PPosts;
  I  : integer;
begin
  uDm.DataModule1.FDConnection1.Connected := true;
  uDM.DataModule1.FDQ.SQL.Clear;
  uDM.DataModule1.FDQ.SQL.Add('select * from POSTS_SEL');

  if Assigned(ADList) Then Begin
    If (isNewList) Then
    Begin
      For I := ADList.Count-1 DownTo 0 Do
        FreeMem(ADList[I]);
      ADList.Clear;
    End;
  End Else ADList := TBegList.MyCreate(Nil, SizeOf(TPosts), False, False);
  uDM.DataModule1.FDQ.Open;
  while not uDM.DataModule1.FDQ.Eof do
  begin
    New(PC);
    FillChar(PC^,SizeOf(PC^),0);
    PC.Id  := uDM.DataModule1.FDQ.FieldByName('ORDINAL').AsInteger;
    PC.Name  := uDM.DataModule1.FDQ.FieldByName('NAME').AsString;
    ADList.MyAdd(PC);
    uDM.DataModule1.FDQ.Next;
  end;
  uDM.DataModule1.FDQ.Close;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecPostsPutOrUpdate(var P : TPosts);
var
  SpName : string;
begin
  udm.DataModule1.FDConnection1.Connected := true;
  if P.Id = 0 then
  begin
    udm.DataModule1.FDStoredProc1.ExecProc('SP_GEN_POSTS_ID');
    udm.DataModule1.FDStoredProc1.Open;
    P.Id := udm.DataModule1.FDStoredProc1.FieldByName('ID').AsInteger;

    SpName := 'POSTS_INS';
  end else SpName := 'POSTS_UPD';

  udm.DataModule1.FDStoredProc1.StoredProcName := SpName;
  udm.DataModule1.FDStoredProc1.Prepare;
  udm.DataModule1.FDStoredProc1.ParamByName('ORDINAL').AsInteger := P.Id;
  udm.DataModule1.FDStoredProc1.ParamByName('NAME').AsString := P.Name;
  udm.DataModule1.FDStoredProc1.ExecProc;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecPostsDelete(aOrdinal : TID);
begin
  udm.DataModule1.FDConnection1.Connected := true;
  udm.DataModule1.FDStoredProc1.ExecProc('POSTS_DEL', [aOrdinal]);
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

Procedure GetDiagnosesDetail(TDS : TDiagnosesSelect; Var ADList : TBegList; isNewList : Boolean = True);
var
  PC : PDiagnoses;
  I  : integer;
begin
  uDm.DataModule1.FDConnection1.Connected := true;
  uDM.DataModule1.FDQ.SQL.Clear;
  uDM.DataModule1.FDQ.SQL.Add('select * from DIAGNOSES_SEL(:aDiagnoses)');

  if TDS.ID <> 0
    then uDM.DataModule1.FDQ.ParamByName('aDiagnoses').AsInteger := TDS.ID
      else uDM.DataModule1.FDQ.ParamByName('aDiagnoses').Value := null;

  if Assigned(ADList) Then Begin
    If (isNewList) Then
    Begin
      For I := ADList.Count-1 DownTo 0 Do
        FreeMem(ADList[I]);
      ADList.Clear;
    End;
  End Else ADList := TBegList.MyCreate(Nil, SizeOf(TDiagnoses), False, False);
  uDM.DataModule1.FDQ.Open;
  while not uDM.DataModule1.FDQ.Eof do
  begin
    New(PC);
    FillChar(PC^,SizeOf(PC^),0);
    PC.Id  := uDM.DataModule1.FDQ.FieldByName('ORDINAL').AsInteger;
    PC.Code  := ShortString(uDM.DataModule1.FDQ.FieldByName('CODE').AsString);
    PC.Name  := uDM.DataModule1.FDQ.FieldByName('NAME').AsString;
    ADList.MyAdd(PC);
    uDM.DataModule1.FDQ.Next;
  end;
  uDM.DataModule1.FDQ.Close;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecDiagnosesPutOrUpdate(var P : TDiagnoses);
var
  SpName : string;
begin
  udm.DataModule1.FDConnection1.Connected := true;
  if P.Id = 0 then
  begin
    udm.DataModule1.FDStoredProc1.ExecProc('SP_GEN_DIAGNOSES_ID');
    udm.DataModule1.FDStoredProc1.Open;
    P.Id := udm.DataModule1.FDStoredProc1.FieldByName('ID').AsInteger;

    SpName := 'DIAGNOSES_INS';
  end else SpName := 'DIAGNOSES_UPD';

  udm.DataModule1.FDStoredProc1.StoredProcName := SpName;
  udm.DataModule1.FDStoredProc1.Prepare;
  udm.DataModule1.FDStoredProc1.ParamByName('ORDINAL').AsInteger := P.Id;
  udm.DataModule1.FDStoredProc1.ParamByName('CODE').AsString := String(P.Code);
  udm.DataModule1.FDStoredProc1.ParamByName('NAME').AsString := String(P.Name);
  udm.DataModule1.FDStoredProc1.ExecProc;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecDiagnosesDelete(aOrdinal : TID);
begin
  udm.DataModule1.FDConnection1.Connected := true;
  udm.DataModule1.FDStoredProc1.ExecProc('DIAGNOSES_DEL', [aOrdinal]);
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

Procedure GetDocumentTypeDetail(Var ADList : TBegList; isNewList : Boolean = True);
var
  PC : PDocumentType;
  I  : integer;
begin
  uDm.DataModule1.FDConnection1.Connected := true;
  uDM.DataModule1.FDQ.SQL.Clear;
  uDM.DataModule1.FDQ.SQL.Add('select * from DOCUMENTTYPE_SEL');

  if Assigned(ADList) Then Begin
    If (isNewList) Then
    Begin
      For I := ADList.Count-1 DownTo 0 Do
        FreeMem(ADList[I]);
      ADList.Clear;
    End;
  End Else ADList := TBegList.MyCreate(Nil, SizeOf(TDocumentType), False, False);
  uDM.DataModule1.FDQ.Open;
  while not uDM.DataModule1.FDQ.Eof do
  begin
    New(PC);
    FillChar(PC^,SizeOf(PC^),0);
    PC.Id  := uDM.DataModule1.FDQ.FieldByName('ORDINAL').AsInteger;
    PC.Code  := ShortString(uDM.DataModule1.FDQ.FieldByName('CODE').AsString);
    PC.Name  := ShortString(uDM.DataModule1.FDQ.FieldByName('NAME').AsString);
    ADList.MyAdd(PC);
    uDM.DataModule1.FDQ.Next;
  end;
  uDM.DataModule1.FDQ.Close;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecDocumentTypePutOrUpdate(var P : TDocumentType);
var
  SpName : string;
begin
  udm.DataModule1.FDConnection1.Connected := true;
  if P.Id = 0 then
  begin
    udm.DataModule1.FDStoredProc1.ExecProc('SP_GEN_DOCUMENTTYPE_ID');
    udm.DataModule1.FDStoredProc1.Open;
    P.Id := udm.DataModule1.FDStoredProc1.FieldByName('ID').AsInteger;

    SpName := 'DOCUMENTTYPE_INS';
  end else SpName := 'DOCUMENTTYPE_UPD';

  udm.DataModule1.FDStoredProc1.StoredProcName := SpName;
  udm.DataModule1.FDStoredProc1.Prepare;
  udm.DataModule1.FDStoredProc1.ParamByName('ORDINAL').AsInteger := P.Id;
  udm.DataModule1.FDStoredProc1.ParamByName('NAME').AsString := String(P.Name);
  udm.DataModule1.FDStoredProc1.ParamByName('CODE').AsString := String(P.Code);
  udm.DataModule1.FDStoredProc1.ExecProc;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecDocumentTypeDelete(aOrdinal : TID);
begin
  udm.DataModule1.FDConnection1.Connected := true;
  udm.DataModule1.FDStoredProc1.ExecProc('DOCUMENTTYPE_DEL', [aOrdinal]);
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

Procedure GetDocumentDetail(Const TPS : TDocumentSelect; Var ADList : TBegList; isNewList : Boolean = True);
var
  PC : PDocument;
  I  : integer;
begin
  uDm.DataModule1.FDConnection1.Connected := true;
  uDM.DataModule1.FDQ.SQL.Clear;
  uDM.DataModule1.FDQ.SQL.Add('select * from DOCUMENT_SEL(:aPeople)');

  if TPS.PeopleOf <> 0
    then uDM.DataModule1.FDQ.ParamByName('aPeople').AsInteger := TPS.PeopleOf
      else uDM.DataModule1.FDQ.ParamByName('aPeople').Value := null;

  if Assigned(ADList) Then Begin
    If (isNewList) Then
    Begin
      For I := ADList.Count-1 DownTo 0 Do
        FreeMem(ADList[I]);
      ADList.Clear;
    End;
  End Else ADList := TBegList.MyCreate(Nil, SizeOf(TDocument), False, False);
  uDM.DataModule1.FDQ.Open;
  while not uDM.DataModule1.FDQ.Eof do
  begin
    New(PC);
    FillChar(PC^,SizeOf(PC^),0);
    PC.Series  := ShortString(uDM.DataModule1.FDQ.FieldByName('SERIES').AsString);
    PC.Number  := ShortString(uDM.DataModule1.FDQ.FieldByName('NUMBER').AsString);
    PC.DOCUMENT := ShortString(uDM.DataModule1.FDQ.FieldByName('DOCUMENTNAME').AsString);
    PC.PeopleOf  := uDM.DataModule1.FDQ.FieldByName('peopleof').AsInteger;
    PC.Id  := uDM.DataModule1.FDQ.FieldByName('DOCUMENTID').AsInteger;
    ADList.MyAdd(PC);
    uDM.DataModule1.FDQ.Next;
  end;
  uDM.DataModule1.FDQ.Close;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecDocumentPutOrUpdate(var P : TDocument);
var
  SpName : string;
begin
  udm.DataModule1.FDConnection1.Connected := true;
  if P.Id = 0 then
  begin
    udm.DataModule1.FDStoredProc1.ExecProc('SP_GEN_DOCUMENT_ID');
    udm.DataModule1.FDStoredProc1.Open;
    P.Id := udm.DataModule1.FDStoredProc1.FieldByName('ID').AsInteger;

    SpName := 'DOCUMENT_INS';
  end else SpName := 'DOCUMENT_UPD';

  udm.DataModule1.FDStoredProc1.StoredProcName := SpName;
  udm.DataModule1.FDStoredProc1.Prepare;
  udm.DataModule1.FDStoredProc1.ParamByName('DOCUMENTID').AsInteger := P.Id;
  udm.DataModule1.FDStoredProc1.ParamByName('SERIES').AsString := String(P.SERIES);
  udm.DataModule1.FDStoredProc1.ParamByName('NUMBER').AsString := String(P.NUMBER);
  udm.DataModule1.FDStoredProc1.ParamByName('PEOPLEOF').AsInteger := P.PeopleOf;
  udm.DataModule1.FDStoredProc1.ParamByName('DOCUMENTTYPENAME').AsString := String(P.DOCUMENT);
  udm.DataModule1.FDStoredProc1.ExecProc;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecDocumentDelete(aId : TID);
begin
  udm.DataModule1.FDConnection1.Connected := true;
  udm.DataModule1.FDStoredProc1.ExecProc('DOCUMENT_DEL', [aId]);
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

Procedure GetAddressTypeDetail(Var ADList : TBegList; isNewList : Boolean = True);
var
  PCT : PAddressType;
  I  : integer;
begin
  uDm.DataModule1.FDConnection1.Connected := true;
  uDM.DataModule1.FDQ.SQL.Clear;
  uDM.DataModule1.FDQ.SQL.Add('select * from ADDRESSTYPE_SEL');

  if Assigned(ADList) Then Begin
    If (isNewList) Then
    Begin
      For I := ADList.Count-1 DownTo 0 Do
        FreeMem(ADList[I]);
      ADList.Clear;
    End;
  End Else ADList := TBegList.MyCreate(Nil, SizeOf(TAddressType), False, False);
  uDM.DataModule1.FDQ.Open;
  while not uDM.DataModule1.FDQ.Eof do
  begin
    New(PCT);
    FillChar(PCT^,SizeOf(PCT^),0);
    PCT.Id := uDM.DataModule1.FDQ.FieldByName('ORDINAL').AsInteger;
    PCT.Name := shortstring(uDM.DataModule1.FDQ.FieldByName('NAME').AsString);
    ADList.MyAdd(PCT);
    uDM.DataModule1.FDQ.Next;
  end;
  uDM.DataModule1.FDQ.Close;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecAddressTypePutOrUpdate(var P : TAddressType);
var
  SpName : string;
begin
  udm.DataModule1.FDConnection1.Connected := true;
  if P.Id = 0 then
  begin
    udm.DataModule1.FDStoredProc1.ExecProc('SP_GEN_ADDRESSTYPE_ID');
    udm.DataModule1.FDStoredProc1.Open;
    P.Id := udm.DataModule1.FDStoredProc1.FieldByName('ID').AsInteger;

    SpName := 'ADDRESSTYPE_INS';
  end else SpName := 'ADDRESSTYPE_UPD';

  udm.DataModule1.FDStoredProc1.StoredProcName := SpName;
  udm.DataModule1.FDStoredProc1.Prepare;
  udm.DataModule1.FDStoredProc1.ParamByName('ORDINAL').AsInteger := P.Id;
  udm.DataModule1.FDStoredProc1.ParamByName('NAME').AsString := string(P.Name);
  udm.DataModule1.FDStoredProc1.ExecProc;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecAddressTypeDelete(aId : TID);
begin
  udm.DataModule1.FDConnection1.Connected := true;
  udm.DataModule1.FDStoredProc1.ExecProc('ADDRESSTYPE_DEL', [aId]);
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

Procedure GetAddressDetail(Const TPS : TAddressSelect; Var ADList : TBegList; isNewList : Boolean = True);
var
  PC : PAddress;
  I  : integer;
begin
  uDm.DataModule1.FDConnection1.Connected := true;
  uDM.DataModule1.FDQ.SQL.Clear;
  uDM.DataModule1.FDQ.SQL.Add('select * from ADDRESS_SEL(:aPeople)');

  if TPS.PeopleOf <> 0
    then uDM.DataModule1.FDQ.ParamByName('aPeople').AsInteger := TPS.PeopleOf
      else uDM.DataModule1.FDQ.ParamByName('aPeople').Value := null;

  if Assigned(ADList) Then Begin
    If (isNewList) Then
    Begin
      For I := ADList.Count-1 DownTo 0 Do
        FreeMem(ADList[I]);
      ADList.Clear;
    End;
  End Else ADList := TBegList.MyCreate(Nil, SizeOf(TDocument), False, False);
  uDM.DataModule1.FDQ.Open;
  while not uDM.DataModule1.FDQ.Eof do
  begin
    New(PC);
    FillChar(PC^,SizeOf(PC^),0);
    PC.ADDRESS  := WideString(uDM.DataModule1.FDQ.FieldByName('Address').AsString);
    PC.ADDRESSTYPENAME := ShortString(uDM.DataModule1.FDQ.FieldByName('ADDRESSTYPENAME').AsString);
    PC.PeopleOf  := uDM.DataModule1.FDQ.FieldByName('peopleof').AsInteger;
    PC.Id  := uDM.DataModule1.FDQ.FieldByName('ADDRESSID').AsInteger;
    ADList.MyAdd(PC);
    uDM.DataModule1.FDQ.Next;
  end;
  uDM.DataModule1.FDQ.Close;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecAddressPutOrUpdate(var P : TAddress);
var
  SpName : string;
begin
  udm.DataModule1.FDConnection1.Connected := true;
  if P.Id = 0 then
  begin
    udm.DataModule1.FDStoredProc1.ExecProc('SP_GEN_ADDRESS_ID');
    udm.DataModule1.FDStoredProc1.Open;
    P.Id := udm.DataModule1.FDStoredProc1.FieldByName('ID').AsInteger;

    SpName := 'ADDRESS_INS';
  end else SpName := 'ADDRESS_UPD';

  udm.DataModule1.FDStoredProc1.StoredProcName := SpName;
  udm.DataModule1.FDStoredProc1.Prepare;
  udm.DataModule1.FDStoredProc1.ParamByName('ADDRESSID').AsInteger := P.Id;
  udm.DataModule1.FDStoredProc1.ParamByName('ADDRESS').AsString := String(P.ADDRESS);
  udm.DataModule1.FDStoredProc1.ParamByName('PEOPLEOF').AsInteger := P.PeopleOf;
  udm.DataModule1.FDStoredProc1.ParamByName('ADDRESSTYPENAME').AsString := String(P.ADDRESSTYPENAME);
  udm.DataModule1.FDStoredProc1.ExecProc;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecAddressDelete(aId : TID);
begin
  udm.DataModule1.FDConnection1.Connected := true;
  udm.DataModule1.FDStoredProc1.ExecProc('ADDRESSTYPE_DEL', [aId]);
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

Procedure GetJournalDetail(Const TPS : TJournalSelect; Var ADList : TBegList; isNewList : Boolean = True);
var
  PC : PJournal;
  I  : integer;
begin
  uDm.DataModule1.FDConnection1.Connected := true;
  uDM.DataModule1.FDQ.SQL.Clear;
  uDM.DataModule1.FDQ.SQL.Add('select * from JOURNAL_SEL(:aPeopleOf, :aDoctorOf, :aDiagnosesOf, :aDT)');

  if TPS.DATETIME <> 0
    then uDM.DataModule1.FDQ.ParamByName('aDT').AsDateTime := TPS.DATETIME
      else uDM.DataModule1.FDQ.ParamByName('aDT').Value := null;

  if TPS.PeopleOf <> 0
    then uDM.DataModule1.FDQ.ParamByName('aPeopleOf').AsInteger := TPS.PeopleOf
      else uDM.DataModule1.FDQ.ParamByName('aPeopleOf').Value := null;

  if TPS.DoctorOf <> 0
    then uDM.DataModule1.FDQ.ParamByName('aDoctorOf').AsInteger := TPS.DoctorOf
      else uDM.DataModule1.FDQ.ParamByName('aDoctorOf').Value := null;

  if TPS.DiagnosesOf <> 0
    then uDM.DataModule1.FDQ.ParamByName('aDiagnosesOf').AsInteger := TPS.DiagnosesOf
      else uDM.DataModule1.FDQ.ParamByName('aDiagnosesOf').Value := null;

  if Assigned(ADList) Then Begin
    If (isNewList) Then
    Begin
      For I := ADList.Count-1 DownTo 0 Do
        FreeMem(ADList[I]);
      ADList.Clear;
    End;
  End Else ADList := TBegList.MyCreate(Nil, SizeOf(TJournal), False, False);
  uDM.DataModule1.FDQ.Open;
  while not uDM.DataModule1.FDQ.Eof do
  begin
    New(PC);
    FillChar(PC^,SizeOf(PC^),0);
    PC.DATETIME  := uDM.DataModule1.FDQ.FieldByName('DATETIME').AsDateTime;
    PC.NUMBER := ShortString(uDM.DataModule1.FDQ.FieldByName('NUMBER').AsString);
    PC.PeopleOf  := uDM.DataModule1.FDQ.FieldByName('PEOPLEOF').AsInteger;
    PC.PeopleOfName := uDM.DataModule1.FDQ.FieldByName('PEOPLEOFNAME').AsString;
    PC.DoctorOf  := uDM.DataModule1.FDQ.FieldByName('DOCTOROF').AsInteger;
    PC.DoctorOfName := uDM.DataModule1.FDQ.FieldByName('DOCTOROFNAME').AsString;
    PC.DiagnosesOf  := uDM.DataModule1.FDQ.FieldByName('DIAGNOSESOF').AsInteger;
    PC.DiagnosesOfName := uDM.DataModule1.FDQ.FieldByName('DIAGNOSESOFNAME').AsString;
    PC.Id  := uDM.DataModule1.FDQ.FieldByName('JOURNALID').AsInteger;
    ADList.MyAdd(PC);
    uDM.DataModule1.FDQ.Next;
  end;
  uDM.DataModule1.FDQ.Close;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecJournalPutOrUpdate(var P : TJournal);
var
  SpName : string;
begin
  udm.DataModule1.FDConnection1.Connected := true;
  if P.Id = 0 then
  begin
    udm.DataModule1.FDStoredProc1.ExecProc('SP_GEN_JOURNAL_ID');
    udm.DataModule1.FDStoredProc1.Open;
    P.Id := udm.DataModule1.FDStoredProc1.FieldByName('ID').AsInteger;

    SpName := 'JOURNAL_INS';
  end else SpName := 'JOURNAL_UPD';

  udm.DataModule1.FDStoredProc1.StoredProcName := SpName;
  udm.DataModule1.FDStoredProc1.Prepare;
  udm.DataModule1.FDStoredProc1.ParamByName('JOURNALID').AsInteger := P.Id;
  udm.DataModule1.FDStoredProc1.ParamByName('DATETIME').Value := P.DATETIME;
  udm.DataModule1.FDStoredProc1.ParamByName('NUMBER').AsString := String(P.NUMBER);
  udm.DataModule1.FDStoredProc1.ParamByName('PEOPLEOF').AsInteger := P.PeopleOf;
  udm.DataModule1.FDStoredProc1.ParamByName('DOCTOROF').AsInteger := P.DoctorOf;
  udm.DataModule1.FDStoredProc1.ParamByName('DIAGNOSESOF').AsInteger := P.DiagnosesOf;
  udm.DataModule1.FDStoredProc1.ExecProc;
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

procedure ExecJournalDelete(aId : TID);
begin
  udm.DataModule1.FDConnection1.Connected := true;
  udm.DataModule1.FDStoredProc1.ExecProc('JOURNAL_DEL', [aId]);
  udm.DataModule1.FDConnection1.Commit;
  udm.DataModule1.FDStoredProc1.Close;
  udm.DataModule1.FDConnection1.Connected := false;
end;

end.
