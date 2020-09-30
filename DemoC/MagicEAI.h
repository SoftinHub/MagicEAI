/*
 * (c)2018 Softin Systèmes
 *
 * Author Paul TOTH <paul@softin.fr>
 *
 * v1 12/04/2018
 * v2.0.10 18/12/2018
 */
 
#include <windows.h>

#pragma pack(push, 4)

#define byte unsigned char

#define VERSION_MAGICDMP 210

#define ERR_OK              0x0000

#define ERR_FIRST           0x1000
#define ERR_CRYPTOLIB_FIRST 0x2000
#define ERR_API_LEC_FIRST   0x3000
#define ERR_SOAP_FIRST      0x4000
#define ERR_DMP_FIRST       0x5000
#define ERR_XDS_FIRST       0x6000
#define ERR_XOP_FIRST       0x7000
#define ERR_GENERAL_FIRST   0x8000

#define ERR_VERSION_MISMATCH (ERR_FIRST + 0)
#define ERR_CARD_CHANGED     (ERR_FIRST + 1)
#define ERR_SESSION_CLOSED   (ERR_FIRST + 2)
#define ERR_INVALID_INDEX    (ERR_FIRST + 3)
#define ERR_EMPTY_RESULT     (ERR_FIRST + 4)
#define ERR_INVALID_INS      (ERR_FIRST + 5)
#define ERR_NO_LICENCE       (ERR_FIRST + 6)
#define ERR_NO_CONNECT       (ERR_FIRST + 7)

#define ERR_CRYPTOLIB_NOT_FOUND  (ERR_CRYPTOLIB_FIRST + 0)
#define ERR_CRYPTOLIB_ERROR      (ERR_CRYPTOLIB_FIRST + 1)
#define ERR_READER_NOT_FOUND     (ERR_CRYPTOLIB_FIRST + 2)
#define ERR_CARD_NOT_FOUND       (ERR_CRYPTOLIB_FIRST + 3)
#define ERR_OPEN_SESSION         (ERR_CRYPTOLIB_FIRST + 4)
#define ERR_CERTIFICAT_NOT_FOUND (ERR_CRYPTOLIB_FIRST + 5)
#define ERR_READ_CARD            (ERR_CRYPTOLIB_FIRST + 6)
#define ERR_READ_NAME            (ERR_CRYPTOLIB_FIRST + 7)
#define ERR_READ_INFO            (ERR_CRYPTOLIB_FIRST + 8)
#define ERR_PIN_LOCKED           (ERR_CRYPTOLIB_FIRST + 9)
#define ERR_PIN_INVALID          (ERR_CRYPTOLIB_FIRST + 10)
#define ERR_EXPIRED_CARD         (ERR_CRYPTOLIB_FIRST + 11)
#define ERR_TEST_CARD            (ERR_CRYPTOLIB_FIRST + 12)
#define ERR_REAL_CARD            (ERR_CRYPTOLIB_FIRST + 13)

#define ERR_API_LEC_NOT_FOUND    (ERR_API_LEC_FIRST + 0)
#define ERR_API_LEC_INIT         (ERR_API_LEC_FIRST + 1)
#define ERR_CSV_NOT_FOUND        (ERR_API_LEC_FIRST + 2)
#define ERR_CSV_READ_ERROR       (ERR_API_LEC_FIRST + 3)
#define ERR_CSV_DATA_ERROR       (ERR_API_LEC_FIRST + 4)
#define ERR_CSV_INSC_UNKNOWN     (ERR_API_LEC_FIRST + 5)
#define ERR_CSV_TEST_CARD        (ERR_API_LEC_FIRST + 6)
#define ERR_CSV_REAL_CARD        (ERR_API_LEC_FIRST + 7)

#define ERR_SOAP_FAIL            (ERR_SOAP_FIRST + 0)
#define ERR_SOAP_ERROR           (ERR_SOAP_FIRST + 1)

#define ERR_DMP_NOT_EXISTS       (ERR_DMP_FIRST + 0)
#define ERR_DMP_UNKNOWN_REPLY    (ERR_DMP_FIRST + 1)
#define ERR_DMP_TOO_MANY_RESULT  (ERR_DMP_FIRST + 2)
#define ERR_DMP_INVALID_REQUEST  (ERR_DMP_FIRST + 3)
#define ERR_DMP_AUTHORIZATION    (ERR_DMP_FIRST + 4)
#define ERR_DMP_CIVILITE         (ERR_DMP_FIRST + 5)
#define ERR_DMP_NAME             (ERR_DMP_FIRST + 6)
#define ERR_DMP_GIVEN            (ERR_DMP_FIRST + 7)
#define ERR_DMP_BIRTHTIME        (ERR_DMP_FIRST + 8)
#define ERR_DMP_MOTIF            (ERR_DMP_FIRST + 9)
#define ERR_DMP_CANAL            (ERR_DMP_FIRST + 10)
#define ERR_DMP_ACCESS_EXISTS    (ERR_DMP_FIRST + 11)
#define ERR_DMP_CANAL_EXISTS     (ERR_DMP_FIRST + 12)
#define ERR_DMP_CERTIFICAT       (ERR_DMP_FIRST + 13)
#define ERR_DMP_GENDER           (ERR_DMP_FIRST + 14)
#define ERR_DMP_UNIQUEID         (ERR_DMP_FIRST + 15)
#define ERR_DMP_CRYPTOLIB        (ERR_DMP_FIRST + 16)

#define ERR_XDS_DOCTYPE          (ERR_XDS_FIRST + 0)
#define ERR_XDS_PATIENTID        (ERR_XDS_FIRST + 1)
#define ERR_XDS_CLASSE           (ERR_XDS_FIRST + 2)
#define ERR_XDS_PRACTICE         (ERR_XDS_FIRST + 3)
#define ERR_XDS_EMPTYDOC         (ERR_XDS_FIRST + 4)
#define ERR_XDS_REPLACEFAILED    (ERR_XDS_FIRST + 5)

#define ERR_XOP_ERROR            (ERR_XOP_FIRST + 0)
#define ERR_XOP_NOT_FOUND        (ERR_XOP_FIRST + 1)

#define ERR_NOT_SUPPORTED        (ERR_GENERAL_FIRST + 0)
#define ERR_DEPRECATED           (ERR_GENERAL_FIRST + 1)

// Structures

#define CARTE_CPS 0
#define CARTE_CPE 2
#define CARTE_CPA 3

#define VISIBLE           0
#define MASQUE_PS         1
#define INVISIBLE_PATIENT 2

#define CIVILITE_SANS 0
#define CIVILITE_M    1
#define CIVILITE_MME  2
#define CIVILITE_MLLE 3

typedef struct {
  byte     Code;
  wchar_t *Nom;
} TCivilite;
  
typedef struct {
  wchar_t *Code;
  wchar_t *Nom;
  wchar_t *OID;
} TEntite;

typedef struct {
  wchar_t *Code;
  wchar_t *Nom;
  wchar_t *OID;
} TRole;

typedef struct {
  wchar_t *Emetteur;
  wchar_t *IdCarte;
  byte     Categorie;
  wchar_t *DebutValidite;
  wchar_t *FinValidite;
} TCarte, *PCarte;

typedef struct {
  byte      TypeCarte;
  wchar_t  *IdNational;
  TCivilite Civilite;
  wchar_t  *Nom;
  wchar_t  *Prenom;
  TEntite   Entite;
  TRole     Profession;
  TRole     Specialite;
} TPorteur, *PPorteur;

typedef struct {
  byte     Numero;
  byte     Statut;
  TEntite  Entite;
  wchar_t *IdNational;
  wchar_t *RaisonSociale;
  TEntite  Pharmacien;
} TActivite, *PActivite;

typedef struct {
  wchar_t  *NomUsage;
  wchar_t  *NomNaissance;
  wchar_t  *Prenom;
  wchar_t  *DateEnCarte;
  wchar_t  *DateNaissance;
  wchar_t  *Nir;
  wchar_t  *NirCertifie;
  int       Qualite;
  wchar_t  *Adresse[5];
  int       RangDeNaissance;
  wchar_t  *MedecinTraitant;
  wchar_t  *INSC;
} TBeneficiaire, *PBeneficiaire;

typedef struct {
  wchar_t *Nom;
  wchar_t *Auteur;
  wchar_t *DateCreation;
  wchar_t *Categorie;
  wchar_t *Extension;
  wchar_t *Commentaire;
  int      Taille;
  wchar_t *CadreExercice;
  wchar_t *DateDebut;
  wchar_t *DateFin;
  wchar_t *UniqueID;
  int      Visibilite;
  wchar_t *Statut;
  byte     DocumentPatient;
} TDocumentInfo, *PDocumentInfo;

typedef struct {
  wchar_t *Code; 
  wchar_t  Type;
  wchar_t *OID;
} TIdentifiantNationalDeSante;

typedef struct {
  int      Civilite;
  wchar_t *NomUsage;
  wchar_t *NomNaissance;
  wchar_t *Prenom;
  wchar_t *DateNaissance; // dd/mm/yyyy
  wchar_t  Sexe;
} TIdentite, *PIdentite;

typedef struct {
  TIdentifiantNationalDeSante INS;
  TIdentifiantNationalDeSante NIR;
  TIdentite Identite;
} TPatientInfo, *PPatientInfo;

typedef struct {
  wchar_t *Date;
  wchar_t *Code;
  wchar_t *Motif;
} TFermeture;

typedef struct {
  TPatientInfo Patient;
  byte         StatutMT;
  wchar_t     *Autorisation;
  TFermeture  *Fermeture;
  byte         AccesWeb;
  byte         Mineur;
  int          Secret;
} TDossierInfo, *PDossierInfo;

typedef struct {
  wchar_t *Adresse;
  wchar_t *Complement;
  wchar_t *CodePostal;
  wchar_t *Ville;
  wchar_t *Pays;
} TAdresse, *PAdresse;

typedef struct {
  byte Urgence;
  byte BrisDeGlace;
} TAutorisations, *PAutorisations;

typedef struct {
  wchar_t *Fixe;
  wchar_t *Mobile;
  wchar_t *EMail;
} TTelecom;

#define Relation_Aucune            0
#define Relation_Pere              1
#define Relation_Mere              2
#define Relation_BeauPere          3
#define Relation_BelleMere         4
#define Relation_GrandPere         5
#define Relation_GrandMere         6
#define Relation_ArriereGrandPere  7
#define Relation_ArriereGrandMere  8
#define Relation_Tante             9
#define Relation_Oncle            10
#define Relation_Frere            11
#define Relation_Soeur            12
#define Relation_Autre            13

typedef struct {
  int       Relation;
  int       Civilite;
  wchar_t  *Nom;
  wchar_t  *Prenom;
  TAdresse  Adresse;
  TTelecom  Telecom;
} TRepresentantLegal;

typedef struct {
  TIdentite          Identite;
  TAdresse           Adresse;
  TTelecom           Telecom;
  wchar_t           *PaysNaissance;
  TRepresentantLegal Representant;
} TVoletAdministratif, *PVoletAdministratif;

typedef struct {
  TPatientInfo Patient;
  byte         StatutMT;
  wchar_t     *DateModification;
  wchar_t     *DateDernierAcces;
  wchar_t     *DateDernierDocument;
} TDossierItem, *PDossierItem;

typedef struct {
  TPatientInfo Patient;
  wchar_t     *CodePostal;
  wchar_t     *Ville;
  byte         oppositionUrgence;
} TPatientItem, *PPatientItem;

typedef struct {
  wchar_t *login;
  wchar_t *password;
} TAccesPatient, *PAccesPatient;

#define PRATICIEN_ACTIVE    0
#define PRATICIEN_INTERDITE 1
#define PRATICIEN_TOUTE     2

typedef struct {
  wchar_t *IdNational;
  wchar_t *TypeId;
  wchar_t *Prenom;
  wchar_t *Nom;
  wchar_t *DateAction;
  wchar_t *Mode;
  wchar_t *DateDebut;
  TEntite  Entite;
  byte     StatutMT;
} TPraticien, *PPraticien;

typedef struct {
  TAutorisations      Autorisations;
  TVoletAdministratif VoletAdministratif;
} TCreationDossier, *PCreationDossier;

#define ToutLeMonde                1 << 0
#define PatientUniquement          1 << 1
#define PraticiensUniquement       1 << 2
#define InvisibleRepresentantLegal 1 << 3

#define TextPlain      0
#define TextRTF        1
#define ApplicationPDF 2
#define ImageJPEG      3
#define ImageTIFF      4

typedef struct {
  int   Taille;
  void *Contenu;
  int   TypeMime;
} TDocument;

typedef struct {
  wchar_t *UniqueID;
  wchar_t *UUID;
} TDocumentReference;

typedef struct {
  wchar_t           *Titre;
  TDocument          Document;
  wchar_t           *Commentaire;
  wchar_t           *PatientId;
  wchar_t           *TypeDocument;
  wchar_t           *DateDocument;
  wchar_t           *CadreExercice;
  wchar_t           *DateDebut;
  wchar_t           *DateFin;
  int                Visibilite;
  TDocumentReference Remplacer;
} TProprietesDocument;

#define DateAutorisation    0
#define DateDernierDocument 1

#define Sexe_Tous   0
#define Sexe_Homme  1
#define Sexe_Femme  2
#define Sexe_Iconnu 3

typedef struct {
  wchar_t *Nom;
  wchar_t *Prenom;
  wchar_t *Naissance;
  wchar_t *CodePostal;
  wchar_t *Ville;
  byte     Sexe;
  byte     NomPartiel;
  byte     VillePartielle;
} TRecherchePatients;

#define Query_Approuve                   1
#define Query_Archive                    2
#define Query_MasquePS                   4
#define Query_InvisiblePatient           8
#define Query_InvisibleRepresentantLegal 16
#define Query_Obsolete                   32

typedef struct {
  int      Flags;
  wchar_t *TypeDoc;
  wchar_t *After;
  wchar_t *Before;
} TQueryDocuments;

#define URL_TableauDeBord    0
#define URL_DossierPatient   1
#define URL_GestionDMP       2
#define URL_Documents        3
#define URL_ParcoursDeSoins  4
#define URL_HistoriqueAcces  5
#define URL_Parametrages     6
#define URL_VolontesEtDroits 7
#define URL_CreationDMP      8

#define Canal_Ajout        0
#define Canal_Modification 1
#define Canal_Suppression  2

typedef struct {
  byte GestionMineurs;
  int AgeMajoritee;
  byte CumulVisibilite;
} TParametres, *PParametres;

// Interfaces

typedef struct {
  int (__stdcall *QueryInterface)(void *this, void *riid, void*);
  int (__stdcall *AddRef)(void *this);
  int (__stdcall *Release)(void *this);
} TUnknown, **IUnknown;

typedef struct {
  TUnknown unknown;

  PDocumentInfo (__stdcall *GetInfo)(void *this);
  void (__stdcall *SaveToFile)(void *this, wchar_t *AFileName);
  int (__stdcall *GetDescription)(void *this, void *Source, int *Len);
  int (__stdcall *GetDocument)(void *this, void *Source, int *Len);
  int (__stdcall *GetImage)(void *this, wchar_t *Name, void *Image, int *Len);
  wchar_t* (__stdcall *MimeType)(void *this);
  byte (__stdcall *IsUTF8)(void *this);
  int (__stdcall *SetVisibilite)(void *this, int Visibilite);
  int (__stdcall *SetArchive)(void *this, int Archive);
  int (__stdcall *Supprimer)(void *this);
  int (__stdcall *Remplacer)(void *this, TProprietesDocument *Props, wchar_t * UniqueID);
} **IDocument;

typedef struct {
  TUnknown unknown;

  int (__stdcall *Count)(void *this);
  PDocumentInfo (__stdcall *Info)(void *this, int Index);
  int (__stdcall *Sort)(void *this, int Column);
  int (__stdcall *CategoryCount)(void *this, wchar_t *Categorie);
  int (__stdcall *Filter)(void *this, wchar_t *Categorie);
  int (__stdcall *GetDocument)(void *this, int Index, IDocument *Doc);
  int (__stdcall *GetSortIndex)(void *this);
  void(__stdcall *SetSortIndex)(void *this, int Value);
} **IDocumentList;

typedef struct {
  TUnknown unknown;

  int (__stdcall *AddDocument)(void *this, TProprietesDocument *Props);
  int (__stdcall *Submit)(void *this);
  wchar_t (__stdcall *GetUniqueID)(void *this, int Index);
} **ILotDocuments;

typedef struct {
  TUnknown unknown;

  void* (__stdcall *MagicDMP)(void *this);
  PDossierInfo (__stdcall *GetInfo)(void *this);
  int (__stdcall *GetVoletAdministratif)(void *this, PVoletAdministratif *volet);
  int (__stdcall *SetVoletAdministratif)(void *this, TVoletAdministratif *volet);
  int (__stdcall *QueryDocuments)(void *this, TQueryDocuments *Query, IDocumentList *List);
  int (__stdcall *Query2Documents)(void *this, wchar_t *TypeDoc1, wchar_t *TypeDoc2, IDocumentList *List);
  int (__stdcall *QuerySubmissions)(void *this, TQueryDocuments *Query, IDocumentList *List);
  int (__stdcall *QuerySubmissions2)(void *this, TQueryDocuments *Query, IDocumentList *List);
  int (__stdcall *Autorisation)(void *this, byte Autoriser, byte DevenirMedecinTraitant, wchar_t *BrisDeGlace);
  int (__stdcall *Reactiver)(void *this, TAutorisations *Autorisations);
  int (__stdcall *OuvrirAcces)(void *this, byte DevenirMedecinTraitant, wchar_t *BrisDeGlace); 
  int (__stdcall *EtreMedecinTraitant)(void *this, byte Value);
  int (__stdcall *FermerAcces)(void *this);
  int (__stdcall *FermerDossier)(void *this, wchar_t *Code, wchar_t *Motif);
  int (__stdcall *CreerAccesPatient)(void *this, wchar_t *Canal, PAccesPatient *Acces);
  int (__stdcall *NouvelAccesPatient)(void *this, PAccesPatient *Acces);
  int (__stdcall *ModifierCanal)(void *this, wchar_t *Canal, int Action);
  int (__stdcall *GetPraticiens)(void *this, int Mode, int *Count, PPraticien *Praticiens);
  int (__stdcall *AddDocument)(void *this, TProprietesDocument *Props, wchar_t *UniqueID);
  int (__stdcall *GetDocument)(void *this, wchar_t *UniqueID, IDocument *Doc);
  int (__stdcall *GetDocumentUUID)(void *this, wchar_t *UniqueID, wchar_t *UUID);
  int (__stdcall *SupprimerDocument)(void *this, wchar_t *UniqueID);
  int (__stdcall *SupprimerDocumentUUID)(void *this, wchar_t *UUID);
  int (__stdcall *SetAccesSecert)(void *this, byte Secret);
  int (__stdcall *CreerLotDocuments)(void *this, ILotDocuments Lot);
} **IDossierMedical;

typedef struct {
  TUnknown unknown;

  int (__stdcall *GetCount)(void *this);
  PDossierItem (__stdcall *GetItem)(void *this, int Index);
  int (__stdcall *GetDossier)(void *this, int Index, IDossierMedical *Dossier);
} **IDossierList;

typedef struct {
  TUnknown unknown;

  int (__stdcall *GetCount)(void *this);
  PPatientItem (__stdcall *GetItem)(void *this, int Index);
  int (__stdcall *GetDossier)(void *this, int Index, IDossierMedical *Dossier);
} **IPatientList;

typedef struct {
  TUnknown unknown;

  int (__stdcall *GetXML)(void *this, char *XML);
  int (__stdcall *GetBeneficiaires)(void *this);
  PBeneficiaire (__stdcall *GetBeneficiaire)(void *this, int Index);
  int (__stdcall *SelectionBeneficiare)(void *this, int Index);
  int (__stdcall *SelectedBeneficiaire)(void *this);
  wchar_t *(__stdcall *GetINS)(void *this);
  PAdresse (__stdcall *GetAdresse)(void *this);
  int (__stdcall *DossierExiste)(void *this, IDossierMedical *Dossier);
  int (__stdcall *CreationDossier)(void *this, TCreationDossier *Param, IDossierMedical *Dossier);
  short (__stdcall *GetCardType)(void *this);
} **IMagicCSV;

typedef struct {
  TUnknown unknown;

  int (__stdcall *RegisterProduct)(void *this, wchar_t *LSP_NOM, wchar_t *LSP_VERSION, wchar_t *LPS_ID_HOMOLOGATION_DMP);
  int (__stdcall *Register)(void *this, wchar_t *CurrentID, wchar_t **NewID);
  PCarte (__stdcall *GetCarte)(void *this);
  PPorteur (__stdcall *GetPorteur)(void *this);  
  int (__stdcall *DossierExiste)(void *this, wchar_t *INSValue, wchar_t INSType, IDossierMedical *Dossier);
  int (__stdcall *GetDossiers)(void *this, wchar_t *DateUTC, int Mode, IDossierList *List);
  int (__stdcall *GetPatients)(void *this, TRecherchePatients *Criteres, IPatientList *List);
  wchar_t* (__stdcall *GetServer)(void *this);
  void (__stdcall *SetServer)(void *this, wchar_t *Server);
  int (__stdcall *SearchINS)(void *this, wchar_t *Nir, wchar_t *dateNaissance, int Rang, wchar_t *nirIndivivdu, PIdentite **identite);
} TMagicCNX, **IMagicCNX;

typedef struct {
  TMagicCNX CNX;
  
  int (__stdcall *LoadSignature)(void *this, void *Data, int Size, wchar_t *Password);
  PActivite (__stdcall *GetStructure)(void *this);
  void (__stdcall *SetStructure)(void *this, wchar_t *Code, wchar_t *IdNational, wchar_t *RaisonSociale);
  void (__stdcall *SetPraticien)(void *this, wchar_t *IdNational, wchar_t *Nom, wchar_t *Prenom, wchar_t *Profession, wchar_t *Specialite, wchar_t *Pharmacien, wchar_t *CodeStruct);
} **IMagicCRT;

typedef struct {
  TMagicCNX CNX;
  
  int (__stdcall *PinCount)(void *this);
  int (__stdcall *SetCode)(void *this, wchar_t *Code);
  int (__stdcall *GetActivites)(void *this, int *Count);
  PActivite (__stdcall *GetActivite)(void *this, int Index);
  int (__stdcall *SelectActivite)(void *this, int Index);
  int (__stdcall *SelectedActivite)(void *this);
} **IMagicCPS;

typedef struct {
  TUnknown unknown;

  void (__stdcall *OnLog)(void *this, void *DMP, wchar_t* Msg);
} **IMagicLOG;


typedef struct  {
  TUnknown unknown;

  int (__stdcall *GetVersion)(void *this);
  wchar_t* (__stdcall *GetErrMsg)(void *this, int ErrNo); 
  wchar_t* (__stdcall *GetErrDetail)(void *this);
  
  void (__stdcall *SetLogger)(void *this, IMagicLOG Logger);
  
  int (__stdcall *SetCryptoLib)(void *this, wchar_t *AFileName);
  int (__stdcall *SetApiLecture)(void *this, wchar_t *AFileName);
  
  int (__stdcall *GetSlotCount)(void *this, int *Count);
  int (__stdcall *GetCPS)(void *this, int Slot, IMagicCPS *CPS);
  IMagicCPS (__stdcall *GetActiveCPS)(void *this);
  int (__stdcall *GetCSV)(void *this, IMagicCSV *CSV);
  int (__stdcall *SetCSV)(void *this, char *XML, int Len, IMagicCSV *CSV);
  void (__stdcall *SetDMPUrl)(wchar_t *URL);
  int (__stdcall *GetDMPUrl)(void *this, int DMPUrl, wchar_t *Param, wchar_t *URL);
  int (__stdcall *GetDMPParams)(void *this, wchar_t *Mobile, wchar_t *EMail, wchar_t *Adresse, wchar_t *Complement, wchar_t *CodePostal, wchar_t *Ville, wchar_t *Pays);
  int (__stdcall *LoadCertificat)(void *this, void *Data, int Size, wchar_t *Password, IMagicCRT *CRT);
  PParametres (__stdcall *GetParametres)(void *this);
} **IMagicDMP;

// Entry point

__stdcall int GetInterface(int RequestedVersion, IMagicDMP *DMP);

#pragma pack(pop)