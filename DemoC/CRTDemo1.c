#include <windows.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include "MagicEAI.h"
#include "DMPUtils.h"

/*
 * Sample application for MagicEAI 2.1, provided without warranty
 *
 *  Author: Paul TOTH <paul@softin.fr>
 *
 * v1.0 12/04/2018
 * v1.1 25/09/2019
 */
 
 void* file_get_contents(char *name, int *psize) {
    FILE *f = fopen(name, "rb");
    fseek(f, 0, SEEK_END);
    int size = ftell(f);
    fseek(f, 0, SEEK_SET);
    void *data = malloc(size);
    fread(data, 1, size, f);
    fclose(f);
    (*psize) = size;
    return data;
 }

/*
 * Entry point
 */
void main(int argc, char* argv[]) {
// fix accents on Windows console
  setlocale(LC_ALL, "");

// Initialization
  IMagicDMP DMP = 0;
  int Slots;
  IMagicCRT CRT = 0;
  PPorteur Porteur;
  PCarte Carte;  
  int rc;
  
  MagicLOG LOG, *pLOG = &LOG;
  LOG.QueryInterface = MagicLOG_QueryInterface;
  LOG.AddRef = MagicLOG_Dummy;
  LOG.Release = MagicLOG_Dummy;
  LOG.OnLog = MagicLOG_OnLog;  
  
// Get MagicDMP first interface IMagicDMP
  rc = GetInterface(VERSION_MAGICDMP, &DMP);
  if (rc) return;
  
// request Version
  rc = (*DMP)->GetVersion(DMP);  
  if (rc != VERSION_MAGICDMP) return;
  
// bind Logger
  (*DMP)->SetLogger(DMP, (IMagicLOG)&pLOG);

// read AUTH certificat (*.P12)
  if (argc != 4) {
    printf("need 3 parameters, AUTH.p12, SIGN.p12 and password\n");
    return;
  }
  void *data;
  int size;
  
  wchar_t pwd[100];
  mbstowcs(pwd, argv[3], strlen(argv[3]) + 1);
  
  if (!(data = file_get_contents(argv[1], &size))) {
    printf("can't read AUTH.p12 file\n");
    return;
  }
  rc = (*DMP)->LoadCertificat(DMP, data, size, pwd, &CRT);
  free(data);
  printf("LoadCertificate returns 0x%x (%ls)\n", rc, (*DMP)->GetErrMsg(DMP, rc));
  if (rc) return;
  
  if (!(data = file_get_contents(argv[2], &size))) {
    printf("can't read SIGN.p12 file\n");
    return;
  }
  rc = (*CRT)->LoadSignature(CRT, data, size, pwd);
  free(data);
  printf("LoadSignature returns 0x%x (%ls)\n", rc, (*DMP)->GetErrMsg(DMP, rc));
  if (rc) return;

// check card type
  Carte = (*CRT)->CNX.GetCarte(CRT);
  if (Carte->Categorie < 0x80) {
    printf("TEST card only please (Category = %d)!\n", Carte->Categorie);
    return;
  }
  printf("\
Carte :\n\
 Emetteur      %ls\n\
 IdCarte       %ls\n\
 Categorie     0x%x\n\
 DebutValidite %ls\n\
 FinValidite   %ls\n",
  Carte->Emetteur,
  Carte->IdCarte,
  Carte->Categorie,
  Carte->DebutValidite,
  Carte->FinValidite);
 
 
 PActivite activite = (*CRT)->GetStructure(CRT);
 printf("GetStructure returns 0x%x (%ls)\n", rc, (*DMP)->GetErrMsg(DMP, rc)); 
 if (activite) {
        printf("\
  Activite:\n\
    Numero          %d\n\
    Statut          %d\n\
    Entite.Code     %ls\n\
    Entite.Nom      %ls\n\
    Entite.OID      %ls\n\
    IdNational      %ls\n\
    RaisonSociale   %ls\n\
    Pharmacien.Code %ls\n\
    Pharmacien.Nom  %ls\n\
    Pharmacien.OID  %ls\n",
    activite->Numero,
    activite->Statut,
    activite->Entite.Code,
    activite->Entite.Nom,
    activite->Entite.OID,
    activite->IdNational,
    activite->RaisonSociale,
    activite->Pharmacien.Code,
    activite->Pharmacien.Nom,
    activite->Pharmacien.OID 
         );
  };
  
// identify user
  (*CRT)->SetPraticien(CRT, 
  // 8 + RPPS
    L"899700064159", 
  // NOM PRENOM
 	L"CARDIOCH0006415", L"CHARLES", 
  // Médecin	
	L"10", 
  // Cardiologie
	L"SM04", 
  // Pharmacie
	NULL ,
  // Etablissement public de santé
	L"SA01");
  Porteur = (*CRT)->CNX.GetPorteur(CRT);
  printf("\
Porteur :\n\
 TypeCarte       %d\n\
 IdNational      %ls\n\
 Civilite.Code   %d\n\
 Civilite.Nom    %ls\n\
 Nom             %ls\n\
 Prenom          %ls\n\
 Entite.Code     %ls\n\
 Entite.Nom      %ls\n\
 Entite.OID      %ls\n\
 Profession.Code %ls\n\
 Profession.Nom  %ls\n\
 Profession.OID  %ls\n\
 Specialite.Code %ls\n\
 Specialite.Nom  %ls\n\
 Specialite.OID  %ls\n",
 Porteur->TypeCarte,
 Porteur->IdNational,
 Porteur->Civilite.Code,
 Porteur->Civilite.Nom, 
 Porteur->Nom, 
 Porteur->Prenom, 
 Porteur->Entite.Code,
 Porteur->Entite.Nom,
 Porteur->Entite.OID,
 Porteur->Profession.Code,
 Porteur->Profession.Nom,
 Porteur->Profession.OID,
 Porteur->Specialite.Code,
 Porteur->Specialite.Nom,
 Porteur->Specialite.OID
 );  
 
 wchar_t *OID;
 rc = (*CRT)->CNX.Register(CRT, NULL, &OID);
 if (rc) return;
 
 TRecherchePatients Criteres;
 
 Criteres.Nom = L"INS-FAMILLE-UN";
 Criteres.Prenom = L"JEAN-MICHEL";
 Criteres.Naissance = NULL;
 Criteres.CodePostal = NULL;
 Criteres.Ville = NULL;
 Criteres.Sexe = Sexe_Tous;
 Criteres.NomPartiel = FALSE;
 Criteres.VillePartielle = FALSE;
 
 printf("Search for '%ls', '%ls', partial = %d\n", Criteres.Nom, Criteres.Prenom, Criteres.NomPartiel);
 if (!searchPatients(DMP, (IMagicCNX)CRT, &Criteres)) return;
 
 
// release Interfaces (if you care)
  (*CRT)->CNX.unknown.Release(CRT);
  (*DMP)->unknown.Release(DMP);
  
// done
  printf("Done\n");
}