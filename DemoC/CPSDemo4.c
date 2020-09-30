#include <locale.h>
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

 int showDocuments(IDocumentList List) {
	int Count = (*List)->Count(List);
	for (int i = 0; i < Count; i++) {
	  PDocumentInfo Info = (*List)->Info(List, i);
	  printf("\
Document %d :\n\
  Nom           %ls\n\
  Auteur        %ls\n\
  DateCreation  %ls\n\
  Categorie     %ls\n\
  Extension     %ls\n\
  Commentaire   %ls\n\
  Taille        %d\n\
  CadreExercice %ls\n\
  DateDebut     %ls\n\
  DateFin       %ls\n\
  UniqueID      %ls\n\
  Visibilite    %d\n\
  Statut        %ls\n",
       i,
	   Info->Nom,
	   Info->Auteur,
	   Info->DateCreation,
	   Info->Categorie,
	   Info->Extension,
	   Info->Commentaire,
	   Info->Taille,
	   Info->CadreExercice,
	   Info->DateDebut,
	   Info->DateFin,
	   Info->UniqueID,
	   Info->Visibilite,
	   Info->Statut
	  );
	}
	return Count;
}


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
  
// bind Logger
  (*DMP)->SetLogger(DMP, (IMagicLOG)&pLOG);

// get Slot count    
  rc = (*DMP)->GetSlotCount(DMP, &Slots);
  if (rc) return;
  if (!Slots) return;
  
// read first CPS
  rc = (*DMP)->GetCPS(DMP, 0, &CPS);
  if (rc) return;  
  
// check card type
  Carte = (*CPS)->CNX.GetCarte(CPS);
  if (Carte->Categorie < 0x80) {
	printf("TEST card only please (Category = %d)!\n", Carte->Categorie);
	return;
  }

 int PinCount = (*CPS)->PinCount(CPS);
 if (PinCount < 3) return;
 
 rc = (*CPS)->SetCode(CPS, L"1234");
 if (rc) return;
 
 wchar_t *OID;
 rc = (*CPS)->CNX.Register(CPS, NULL, &OID);
 if (rc) return;
 
 int Count; 
 rc = (*CPS)->GetActivites(CPS, &Count);
 if (rc) return;
 
 IDossierMedical Dossier = 0;
 // INS-NIR TEST
 rc = (*CPS)->CNX.DossierExiste(CPS, L"173082622170111", L'T', &Dossier);
 printf("DossierExiste returns 0x%x (%ls)\n", rc, (*DMP)->GetErrMsg(DMP, rc));
 if (rc) return;
 
 PDossierInfo Info = (*Dossier)->GetInfo(Dossier);
 
 if (Info->Autorisation[0] == L'N') { // NON_EXISTE
   rc = (*Dossier)->OuvrirAcces(Dossier, FALSE, NULL);
   printf("OuvrirAcces returns 0x%x (%ls)\n%ls\n", rc, (*DMP)->GetErrMsg(DMP, rc), (*DMP)->GetErrDetail(DMP));
   if (rc) return;
 }
 
 TQueryDocuments Query;
 IDocumentList Documents = 0;
 
 Query.Flags = Query_Approuve | Query_Archive;
 Query.TypeDoc = NULL;
 Query.After = NULL;
 Query.Before = NULL;
 rc = (*Dossier)->QueryDocuments(Dossier, &Query, &Documents);
 printf("QueryDocuments returns 0x%x (%ls)\n%ls\n", rc, (*DMP)->GetErrMsg(DMP, rc), (*DMP)->GetErrDetail(DMP));
 if (rc) return;
 Count = showDocuments(Documents);
 
 if (Count > 0) {
   IDocument Document;
   rc = (*Documents)->GetDocument(Documents, Count - 1, &Document);
   printf("GetDocument returns 0x%x (%ls)\n", rc, (*DMP)->GetErrMsg(DMP, rc));
   if (rc) return;
   char *Text;
   int Len;
   (*Document)->GetDocument(Document, &Text, &Len);
   printf("---(%d bytes)---\n%.*s\n---\n", Len, Len, Text);
 }
 
// release Interfaces (if you care)
  (*Dossier)->unknown.Release(Dossier);
  (*CPS)->CNX.unknown.Release(CPS);
  (*DMP)->unknown.Release(DMP);
  
// done
  printf("Done\n");
}