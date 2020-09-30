#include <locale.h>
#include <stdio.h>
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

/*
 * Entry point
 */
void main() {
// fix accents on Windows console
  setlocale(LC_ALL, "");

// Initialization
  IMagicDMP DMP = 0;
  int Slots;
  IMagicCPS CPS = 0;
  IMagicCNX CNX = 0;
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
  printf("GetInterface returns %d\n", rc);  
  if (rc) return;
  
// request Version
  rc = (*DMP)->GetVersion(DMP);  
  printf("GetVersion returns %d\n", rc);
  if (rc != VERSION_MAGICDMP) return;
  
// bind Logger
  (*DMP)->SetLogger(DMP, (IMagicLOG)&pLOG);

// get Slot count    
  rc = (*DMP)->GetSlotCount(DMP, &Slots);
  printf("GetSlotCount returns 0x%x (%ls)\n", rc, (*DMP)->GetErrMsg(DMP, rc));  
  if (rc) return;
  printf("Slots = %d\n", Slots);
  if (!Slots) return;
  
// read first CPS
  rc = (*DMP)->GetCPS(DMP, 0, &CPS);
  printf("GetCPS returns 0x%x (%ls)\n", rc, (*DMP)->GetErrMsg(DMP, rc));
  if (rc) return;  
  
// check card type
  Carte = (*CPS)->CNX.GetCarte(CPS);
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
  
// identify user
  Porteur = (*CPS)->CNX.GetPorteur(CPS);
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
 
 int PinCount = (*CPS)->PinCount(CPS);
 printf("PinCount = %d\n", PinCount);
 if (PinCount < 3) return;
 
 rc = (*CPS)->SetCode(CPS, L"1234");
 printf("SetCode returns 0x%x (%ls)\n", rc, (*DMP)->GetErrMsg(DMP, rc)); 
 if (rc) return;
 
 int Count; 
 rc = (*CPS)->GetActivites(CPS, &Count);
 printf("GetActivites returns 0x%x (%ls)\n", rc, (*DMP)->GetErrMsg(DMP, rc)); 
 if (rc) return;
 printf("%d Activities found\n", Count);
 if (!Count) return;
 
 for (int i = 0; i < Count; i++) {
	PActivite activite = (*CPS)->GetActivite(CPS, i);
	printf("\
Activite %d:\n\
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
 i,
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
 }
 
 wchar_t *OID;
 rc = (*CPS)->CNX.Register(CPS, NULL, &OID);
 printf("Register returns 0x%x (%ls)\n", rc, (*DMP)->GetErrMsg(DMP, rc)); 
 if (rc) return;
 printf("OID licence : %ls\n", OID);
 
 printf("DMP Server used : %ls\n", (*CPS)->CNX.GetServer(CPS));
 
 PParametres parametres = (*DMP)->GetParametres(DMP);
 printf("Paramètres:\
 GestionMineurs  %d\n\
 AgeMajoritee    %d\n\
 CumulVisibilite %d\n",
   parametres->GestionMineurs,
   parametres->AgeMajoritee,
   parametres->CumulVisibilite
  );

// release Interfaces (if you care)
 (*CPS)->CNX.unknown.Release(CPS);
 (*DMP)->unknown.Release(DMP);
  
// done
  printf("Done\n");
}