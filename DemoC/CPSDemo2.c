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
 if (!Count) return;
 
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
 if (!searchPatients(DMP, (IMagicCNX)CPS, &Criteres)) return;

 Criteres.Nom = L"INSFAMILLE";
 Criteres.Prenom = L"JEAN";
 Criteres.Naissance = NULL;
 Criteres.CodePostal = NULL;
 Criteres.Ville = NULL;
 Criteres.Sexe = Sexe_Tous;
 Criteres.NomPartiel = TRUE;
 Criteres.VillePartielle = FALSE;
 
 printf("Search for '%ls', '%ls', partial = %d\n", Criteres.Nom, Criteres.Prenom, Criteres.NomPartiel);
 if (!searchPatients(DMP, (IMagicCNX)CPS, &Criteres)) return;
 
// release Interfaces (if you care)
 (*CPS)->CNX.unknown.Release(CPS);
 (*DMP)->unknown.Release(DMP);
  
// done
  printf("Done\n");
}