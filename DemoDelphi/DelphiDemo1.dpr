program DelphiDemo1;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  MagicEAI;

type
  TMagicLog = class(TInterfacedObject, IMagicLOG)
    procedure OnLog(DMP: IMagicDMP; Msg: PChar); stdcall;
  end;

procedure TMagicLOG.OnLog(DMP: IMagicDMP; Msg: PChar);
begin
  WriteLn('[LOG] ', Msg);
end;

var
  DMP: IMagicDMP;
  Slots: Integer;
  CPS: IMagicCPS;
  Porteur: PPorteur;
  Carte: PCarte;
  rc: Integer;

function GetInterface(Version: Integer; out DMP: IMagicDMP): Integer; stdcall; external 'MagicEAI.dll';

procedure showPatient(const patient: TPatientInfo);
begin
  WriteLn;
  WriteLn('  INS-C                  ', Patient.INS.Code, ' - ', Patient.INS.&Type, ' (', Patient.INS.OID,')');
  WriteLn('  INS-NIR                ', Patient.NIR.Code, ' - ', Patient.NIR.&Type, ' (', Patient.NIR.OID,')');
  WriteLn('  Identite.Civilite      ', Patient.Identite.Civilite);
  WriteLn('  Identite.NomUsage      ', Patient.Identite.NomUsage);
  WriteLn('  Identite.NomNaissance  ', Patient.Identite.NomNaissance);
  WriteLn('  Identite.Prenom        ', Patient.Identite.Prenom);
  WriteLn('  Identite.DateNaissance ', Patient.Identite.DateNaissance);
  WriteLn('  Identite.Sexe          ', Patient.Identite.Sexe);
end;

function searchPatients(DMP: IMagicDMP; CNX: IMagicCNX; const Criteres: TRecherchePatients): Boolean;
var
  Patients: IPatientList;
  Count: Integer;
  i: Integer;
  patient: PPatientItem;
begin
 rc := CNX.GetPatients(Criteres, Patients);
 WriteLn('GetPatients returns ', rc, ' (',DMP.GetErrMsg(rc),')');
 WriteLn('(', DMP.GetErrDetail(),')');
 if (rc <> 0) then Exit(False);

 Count := Patients.GetCount();
 WriteLn(Count, ' patients found');
 for i := 0 to Count - 1 do
 begin
   patient := Patients.GetItem(i);
   WriteLn('Patient ', i, ':');
   showPatient(patient.Patient);
   WriteLn;
   WriteLn('  CodePostal             ', patient.CodePostal);
   WriteLn('  Ville                  ', patient.Ville);
   WriteLn('  oppositionUrgence      ', patient.oppositionUrgence);
 end;

 Result := True;
end;

function ShowDocuments(const List: IDocumentList): Integer;
var
  i: Integer;
  Info: PDocumentInfo;
begin
  Result := List.Count;
  for i := 0 to Result - 1 do
  begin
    Info := List.Info(i);
    WriteLn('Document ', i, ' :');
    WriteLn('  Nom           ', Info.Nom);
    WriteLn('  Auteur        ', Info.Auteur);
    WriteLn('  DateCreation  ', Info.DateCreation);
    WriteLn('  Categorie     ', Info.Categorie);
    WriteLn('  Extension     ', Info.Extension);
    WriteLn('  Commentaire   ', Info.Commentaire);
    WriteLn('  Taille        ', Info.Taille);
    WriteLn('  CadreExercice ', Info.CadreExercice);
    WriteLn('  DateDebut     ', Info.DateDebut);
    WriteLn('  DateFin       ', Info.DateFin);
    WriteLn('  UniqueID      ', Info.UniqueID);
    WriteLn('  Visiblite     ', Info.Visibilite);
    WriteLn('  Statut        ', Info.Statut);
  end;
end;

procedure Demo4(Dossier: IDossierMedical);
var
  Query: TQueryDocuments;
  Documents: IDocumentList;
  Count: Integer;
  Document: IDocument;
  Text: PAnsiChar;
  Len: Integer;
  Str: string;
begin
  Query.Flags := [TQueryFlag.Aprouve, TQueryFlag.Archive];
  Query.TypeDoc := nil;
  Query.After := nil;
  Query.Before := nil;
  rc := Dossier.QueryDocuments(Query, Documents);
  WriteLn('QueryDocuments returns ', rc, ' (',DMP.GetErrMsg(rc),')');
  if rc <> 0 then Exit;
  Count := showDocuments(Documents);

  if Count > 0 then
  begin
    rc := Documents.Getdocument(Count - 1, Document);
    WriteLn('GetDocument returns ', rc, ' (', DMP.GetErrMsg(rc),')');
    if rc <> 0 then Exit;
    Document.GetDocument(Pointer(Text), Len);
    WriteLn('---(', Len, ' bytes)---');
    SetString(Str, Text, Len);
    WriteLn(Str);
    WriteLn('---');
  end;
end;

procedure Demo3;
var
  Dossier: IDossierMedical;
  Info: PDossierInfo;
begin
  rc := CPS.DossierExiste('173082622170111', 'T', Dossier);
  WriteLn('DossierExiste returns ', rc, ' (', DMP.GetErrMsg(rc), ')');
  if rc <> 0 then Exit;

  Info := Dossier.GetInfo();
  WriteLn('Dossier:');
  showPatient(Info.Patient);
  WriteLn('  StatutMT               ', Info.StatutMT);
  WriteLn('  Autorisation           ', Info.Autorisation);
  if Info.Fermeture <> nil then
  begin
    WriteLn('  Fermeture.Date         ', Info.Fermeture.Date);
    WriteLn('  Fermeture.Code         ', Info.Fermeture.Code);
    WriteLn('  Fermeture.Motif        ', Info.Fermeture.Motif);
  end;

  if Info.Autorisation = 'NON_EXISTE' then
  begin
    rc := Dossier.OuvrirAcces(False, nil);
    WriteLn('OuvrirAcces returns ', rc, ' (', DMP.GetErrMsg(rc), ')');
    if rc <> 0 then Exit;
  end;

  Demo4(Dossier);
end;

procedure Demo2;
var
  Criteres: TRecherchePatients;
begin
 Criteres.Nom := 'INS-FAMILLE-UN';
 Criteres.Prenom := 'JEAN-MICHEL';
 Criteres.Naissance := nil;
 Criteres.CodePostal := nil;
 Criteres.Ville := nil;
 Criteres.Sexe := TSexe.Tous;
 Criteres.NomPartiel := False;
 Criteres.VillePartielle := False;

 WriteLn('Search for ', Criteres.Nom,', ', Criteres.Prenom,', partial = ', Criteres.NomPartiel);
 if not searchPatients(DMP, CPS, Criteres) then Exit;

 Criteres.Nom := 'INSFAMILLE';
 Criteres.Prenom := 'JEAN';
 Criteres.Naissance := nil;
 Criteres.CodePostal := nil;
 Criteres.Ville := nil;
 Criteres.Sexe := TSexe.Tous;
 Criteres.NomPartiel := True;
 Criteres.VillePartielle := False;

 WriteLn('Search for ', Criteres.Nom,', ', Criteres.Prenom,', partial = ', Criteres.NomPartiel);
 if not searchPatients(DMP, CPS, Criteres) then Exit;

 Demo3;
end;

procedure Demo1;
var
  PinCount: Integer;
  Count: Integer;
  i: Integer;
  activite: PActivite;
  OID: PChar;
  parametres: PParametres;
begin
  rc := GetInterface(VERSION_MAGICDMP, DMP);
  if (rc <> 0) then Exit;

  rc := DMP.GetVersion();
  WriteLn('GetVersion returns ', rc);
  if rc <> VERSION_MAGICDMP then
  begin
    Exit;
  end;

  DMP.SetLogger(TMagicLOG.Create);

  rc := DMP.GetSlotCount(Slots);
  WriteLn('GetSlotCount returns ', rc, '(', DMP.GetErrMsg(rc), ')');
  if (rc <> 0) then Exit;
  WriteLn('Slots = ', Slots);
  if (Slots = 0) then Exit;

  rc := DMP.GetCPS(0, CPS);
  WriteLn('GetCPS returns ', rc, ' (', DMP.GetErrMsg(rc), ')');
  if (rc <> 0) then Exit;

  Carte := CPS.GetCarte();
  if (Carte.Categorie < $80) then
  begin
	  WriteLn('TEST card only please (Category = ', Carte.Categorie, ')!');
	  Exit;
  end;

  WriteLn;
  WriteLn('Carte :');
  WriteLn('  Emetteur      ', Carte.Emetteur);
  WriteLn('  IdCarte       ', Carte.IdCarte);
  WriteLn('  Categorie     ', Carte.Categorie);
  WriteLn('  DebutValidite ', Carte.DebutValidite);
  WriteLn('  FinValidite   ', Carte.FinValidite);

  Porteur := CPS.GetPorteur();
  WriteLn;
  WriteLn('Porteur :');
  WriteLn('  TypeCarte       ', Porteur.TypeCarte);
  WriteLn('  IdNational      ', Porteur.IdNational);
  WriteLn('  Civilite.Code   ', Porteur.Civilite.Code);
  WriteLn('  Civilite.Nom    ', Porteur.Civilite.Nom);
  WriteLn('  Nom             ', Porteur.Nom);
  WriteLn('  Prenom          ', Porteur.Prenom);
  WriteLn('  Entite.Code     ', Porteur.Entite.Code);
  WriteLn('  Entite.Nom      ', Porteur.Entite.Nom);
  WriteLn('  Entite.OID      ', Porteur.Entite.OID);
  WriteLn('  Profession.Code ', Porteur.Profession.Code);
  WriteLn('  Profession.Nom  ', Porteur.Profession.Nom);
  WriteLn('  Profession.OID  ', Porteur.Profession.OID);
  WriteLn('  Specialite.Code ', Porteur.Specialite.Code);
  WriteLn('  Specialite.Nom  ', Porteur.Specialite.Nom);
  WriteLn('  Specialite.OID  ', Porteur.Specialite.OID);

  PinCount := CPS.PinCount();
  WriteLn('PinCount = ', PinCount);
  if (PinCount < 3) then Exit;

  rc := CPS.SetCode('1234');
  WriteLn('SetCode returns ', rc, ' (', DMP.GetErrMsg(rc), ')');
  if (rc <> 0) then Exit;

  rc := CPS.GetActivites(Count);
  WriteLn('GetActivites returns ', rc, ' (', DMP.GetErrMsg(rc),' )');
  if (rc <> 0) then Exit;
  WriteLn(Count, ' Activities found');
  if (Count = 0) then Exit;

  for i := 0 to Count - 1 do
  begin
	  activite := CPS.GetActivite(i);
	  WriteLn;
    WriteLn('Activite ', i, ':');
    WriteLn('  Numero          ', activite.Numero);
    WriteLn('  Statut          ', activite.Statut);
    WriteLn('  Entite.Code     ', activite.Entite.Code);
    WriteLn('  Entite.Nom      ', activite.Entite.Nom);
    WriteLn('  Entite.OID      ', activite.Entite.OID);
    WriteLn('  IdNational      ', activite.IdNational);
    WriteLn('  RaisonSociale   ', activite.RaisonSociale);
    WriteLn('  Pharmacien.Code ', activite.Pharmacien.Code);
    WriteLn('  Pharmacien.Nom  ', activite.Pharmacien.Nom);
    WriteLn('  Pharmacien.OID  ', activite.Pharmacien.OID);
  end;

  rc := CPS.Register(nil, OID);
  WriteLn('Register returns ', rc, ' (', DMP.GetErrMsg(rc), ')');
  if (rc <> 0) then Exit;
  WriteLn('OID licence : ', OID);

  WriteLn('DMP Server used : ', CPS.GetServer());

  parametres := DMP.GetParametres();
  WriteLn('Paramètres:');
  WriteLn('  GestionMineurs  ', parametres.GestionMineurs);
  WriteLn('  AgeMajoritee    ', parametres.AgeMajoritee);
  WriteLn('  CumulVisibilite ', parametres.CumulVisibilite);

  Demo2;
end;


begin
  Demo1;
  WriteLn('DONE');
  ReadLn;
end.