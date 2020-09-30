unit MagicEAI;

{
   Interface MagicDMP (c)2017-2020 Softin Systèmes - Tous droits réservés
}

interface
{$ALIGN 4}
const
  VERSION_MAGICDMP         = 210;   // version actuelle de l'API 2.10

  // Interfaces errors
  ERR_OK                   = $0000;
  MSG_OK                   = 'Aucune erreur';

  ERR_FIRST                = $1000;
  ERR_CRYPTOLIB_FIRST      = $2000;
  ERR_API_LEC_FIRST        = $3000;
  ERR_SOAP_FIRST           = $4000;
  ERR_DMP_FIRST            = $5000;
  ERR_XDS_FIRST            = $6000;
  ERR_XOP_FIRST            = $7000;
  ERR_GENERAL_FIRST        = $8000;

  ERR_VERSION_MISMATCH     = ERR_FIRST + 0;
  MSG_VERSION_MISMATCH     = 'La version demandée n''est pas supportée';

  ERR_CARD_CHANGED         = ERR_FIRST + 1;
  MSG_CARD_CHANGED         = 'Un changement de carte a détecté';

  ERR_SESSION_CLOSED       = ERR_FIRST + 2;
  MSG_SESSION_CLOSED       = 'La session n''est plus valide';

  ERR_INVALID_INDEX        = ERR_FIRST + 3;
  MSG_INVALID_INDEX        = 'Index non valide';

  ERR_EMPTY_RESULT         = ERR_FIRST + 4;
  MSG_EMPTY_RESULT         = 'L''ensemble de données est vide';

  ERR_INVALID_INS          = ERR_FIRST + 5;
  MSG_INVALID_INS          = 'L''INS spécifié est invalide';

  ERR_NO_LICENCE           = ERR_FIRST + 6;
  MSG_NO_LICENCE           = 'Vous n''avez pas de licence valide';

  ERR_NO_CONNECT           = ERR_FIRST + 7;
  MSG_NO_CONNECT           = 'Impossible de se connecter au serveur de licences';

  ERR_NO_CERTIFICAT        = ERR_FIRST + 8;
  MSG_NO_CERTIFICAT        = 'Impossible de charger le certificat';

  ERR_PATIENT_MINEUR       = ERR_FIRST + 9;
  MSG_PATIENT_MINEUR       = 'Le patient est mineur, vous devez définir le mode d''accès à son dossier';

  ERR_PATIENT_MAJEUR       = ERR_FIRST + 10;
  MSG_PATIENT_MAJEUR       = 'Le patient est majeur';

  ERR_NO_PRODUCT           = ERR_FIRST + 11;
  MSG_NO_PRODUCT           = 'Produit non enregistré';

  // CRYPTOLIB
  ERR_CRYPTOLIB_NOT_FOUND  = ERR_CRYPTOLIB_FIRST + 0;
  MSG_CRYPTOLIB_NOT_FOUND  = 'Problème d''initialisation de la Cryptolib CPS';

  ERR_CRYPTOLIB_ERROR      = ERR_CRYPTOLIB_FIRST + 1;
  MSG_CRYPTOLIB_ERROR      = 'La Cryptolib a retourné une erreur inattendue';

  ERR_READER_NOT_FOUND     = ERR_CRYPTOLIB_FIRST + 2;
  MSG_READER_NOT_FOUND     = 'Lecteur de carte non détecté';

  ERR_CARD_NOT_FOUND       = ERR_CRYPTOLIB_FIRST + 3;
  MSG_CARD_NOT_FOUND       = 'Carte non détectée';

  ERR_OPEN_SESSION         = ERR_CRYPTOLIB_FIRST + 4;
  MSG_OPEN_SESSION         = 'Impossible d''ouvrir le session CPS';

  ERR_CERTIFICAT_NOT_FOUND = ERR_CRYPTOLIB_FIRST + 5;
  MSG_CERTIFICAT_NOT_FOUND = 'Impossible de lire le certificat CPS';

  ERR_READ_CARD            = ERR_CRYPTOLIB_FIRST + 6;
  MSG_READ_CARD            = 'Impossible de lire les informations sur la carte PS';

  ERR_READ_NAME            = ERR_CRYPTOLIB_FIRST + 7;
  MSG_READ_NAME            = 'Impossible de lire le nom sur la carte PS';

  ERR_READ_INFO            = ERR_CRYPTOLIB_FIRST + 8;
  MSG_READ_INFO            = 'Impossible de lire les informations de la carte PS';

  ERR_PIN_LOCKED           = ERR_CRYPTOLIB_FIRST + 9;
  MSG_PIN_LOCKED           = 'La carte est vérouillée suite à trois la saisie de 3 codes invalides';

  ERR_PIN_INVALID          = ERR_CRYPTOLIB_FIRST + 10;
  MSG_PIN_INVALID          = 'Code de sécurité invalide';

  ERR_EXPIRED_CARD         = ERR_CRYPTOLIB_FIRST + 11;
  MSG_EXPIRED_CARD         = 'Carte CPS expirée';

  ERR_TEST_CARD            = ERR_CRYPTOLIB_FIRST + 12;
  MSG_TEST_CARD            = 'Une carte CPS de TEST ne doit pas être utilisée en environnement réel';

  ERR_REAL_CARD            = ERR_CRYPTOLIB_FIRST + 13;
  MSG_REAL_CARD            = 'Une carte CPS réelle ne doit pas être utilisée en environnement de TEST';

  // API_LEC
  ERR_API_LEC_NOT_FOUND    = ERR_API_LEC_FIRST + 0;
  MSG_API_LEC_NOT_FOUND    = 'Impossible de charger l''API de lecture des cartes SESAM Vitale';

  ERR_API_LEC_INIT         = ERR_API_LEC_FIRST + 1;
  MSG_API_LEC_INIT         = 'Erreur d''initialisation de l''API de lecture';

  ERR_CSV_NOT_FOUND        = ERR_API_LEC_FIRST + 2;
  MSG_CSV_NOT_FOUND        = 'Carte Vitale non détectée';

  ERR_CSV_READ_ERROR       = ERR_API_LEC_FIRST + 3;
  MSG_CSV_READ_ERROR       = 'Impossible de lire la carte Vitale';

  ERR_CSV_DATA_ERROR       = ERR_API_LEC_FIRST + 4;
  MSG_CSV_DATA_ERROR       = 'Erreur lors du traitement du contenu de la carte Vitale';

  ERR_CSV_INSC_UNKNOWN     = ERR_API_LEC_FIRST + 5;
  MSG_CSV_INSC_UNKNOWN     = 'Impossible de déterminer l''INS du patient';

  ERR_CSV_TEST_CARD        = ERR_API_LEC_FIRST + 6;
  MSG_CSV_TEST_CARD        = 'Carte Vitale de test non acceptée en environnement de production';

  ERR_CSV_REAL_CARD        = ERR_API_LEC_FIRST + 7;
  MSG_CSV_REAL_CARD        = 'Carte Vitale réelle non acceptée en environnement de test';

  ERR_CSV_REQUIRED         = ERR_API_LEC_FIRST + 8;
  MSG_CSV_REQUIRED         = 'Vous devez utiliser la carte Vitale pour cette fonctionalité';

  // DMP Service
  ERR_SOAP_FAIL            = ERR_SOAP_FIRST + 0;
  MSG_SOAP_FAIL            = 'Erreur de connexion au serveur DMP';
  ERR_SOAP_ERROR           = ERR_SOAP_FIRST + 1;
  MSG_SOAP_ERROR           = 'Requête refusée par le service DMP';

  // Dossier médical
  ERR_DMP_NOT_EXISTS       = ERR_DMP_FIRST + 0;
  MSG_DMP_NOT_EXISTS       = 'Le dossier est introuvable';

  ERR_DMP_UNKNOWN_REPLY    = ERR_DMP_FIRST + 1;
  MSG_DMP_UNKNOWN_REPLY    = 'Traitement de la réponse impossible';

  ERR_DMP_TOO_MANY_RESULT  = ERR_DMP_FIRST + 2;
  MSG_DMP_TOO_MANY_RESULT  = 'Nombre maximum de résultats dépassé. Veuillez restreindre vos critères de recherche.';

  ERR_DMP_INVALID_REQUEST  = ERR_DMP_FIRST + 3;
  MSG_DMP_INVALID_REQUEST  = 'Requête invalide.';

  ERR_DMP_AUTHORIZATION    = ERR_DMP_FIRST + 4;
  MSG_DMP_AUTHORIZATION    = 'Vous n''êtes pas autorisés à accéder à ce DMP.';

  ERR_DMP_CIVILITE         = ERR_DMP_FIRST + 5;
  MSG_DMP_CIVILITE         = 'Code civilité invalide.';

  ERR_DMP_NAME             = ERR_DMP_FIRST + 6;
  MSG_DMP_NAME             = 'Nom d''usage obligatoire.';

  ERR_DMP_GIVEN            = ERR_DMP_FIRST + 7;
  MSG_DMP_GIVEN            = 'Prénom obligatoire.';

  ERR_DMP_BIRTHTIME        = ERR_DMP_FIRST + 8;
  MSG_DMP_BIRTHTIME        = 'Date de naissance obligatoire.';

  ERR_DMP_MOTIF            = ERR_DMP_FIRST + 9;
  MSG_DMP_MOTIF            = 'Motif obligatoire.';

  ERR_DMP_CANAL            = ERR_DMP_FIRST + 10;
  MSG_DMP_CANAL            = 'Vous devez indiquer une adresse email ou un numéro de mobile';

  ERR_DMP_ACCESS_EXISTS    = ERR_DMP_FIRST + 11;
  MSG_DMP_ACCESS_EXISTS    = 'L''accès patient existe déjà pour ce DMP.';

  ERR_DMP_CANAL_EXISTS     = ERR_DMP_FIRST + 12;
  MSG_DMP_CANAL_EXISTS     = 'Ce canal existe déjà pour ce DMP.';

  ERR_DMP_CERTIFICAT       = ERR_DMP_FIRST + 13;
  MSG_DMP_CERTIFICAT       = 'Le certificat du serveur DMP est invalide';

  ERR_DMP_GENDER           = ERR_DMP_FIRST + 14;
  MSG_DMP_GENDER           = 'Le sexe est obligatoire';

  ERR_DMP_UNIQUEID         = ERR_DMP_FIRST + 15;
  MSG_DMP_UNIQUEID         = 'Document introuvable';

  ERR_DMP_CRYPTOLIB        = ERR_DMP_FIRST + 16;
  MSG_DMP_CRYPTOLIB        = 'Assurez vous que le "Gestionnaire de certificats CPS" (CCM.exe) de l''ASIP Santé est actif.';

  ERR_DMP_NIR_NOT_FOUND    = ERR_DMP_FIRST + 17;
  MSG_DMP_NIR_NOT_FOUND    = 'Le NIR indiqué ne permet pas d''identifier le patient.';

  ERR_XDS_DOCTYPE          = ERR_XDS_FIRST + 0;
  MSG_XDS_DOCTYPE          = 'Type de document invalide';

  ERR_XDS_PATIENTID        = ERR_XDS_FIRST + 1;
  MSG_XDS_PATIENTID        = 'Identifiant du patient requis';

  ERR_XDS_CLASSE           = ERR_XDS_FIRST + 2;
  MSG_XDS_CLASSE           = 'Classe de document invalide';

  ERR_XDS_PRACTICE         = ERR_XDS_FIRST + 3;
  MSG_XDS_PRACTICE         = 'Cadre d''exercice invalide';

  ERR_XDS_EMPTYDOC         = ERR_XDS_FIRST + 4;
  MSG_XDS_EMPTYDOC         = 'Le document est vide';

  ERR_XDS_REPLACEFAILED    = ERR_XDS_FIRST + 5;
  MSG_XDS_REPLACEFAILED    = 'Impossible de remplacer ce document';

  ERR_XOP_ERROR            = ERR_XOP_FIRST + 0;
  MSG_XOP_ERROR            = 'Erreur de décodage du document xop/xml';

  ERR_XOP_NOT_FOUND        = ERR_XOP_FIRST + 1;
  MSG_XOP_NOT_FOUND        = 'Document introuvable';

  // GENERAL PURPOSE
  ERR_NOT_SUPPORTED        = ERR_GENERAL_FIRST + 0;
  MSG_NOT_SUPPORTED        = 'Un appel non conforme ou non encore développé';

  ERR_DEPRECATED           = ERR_GENERAL_FIRST + 1;
  MSG_DEPRECATED           = 'Cette fonction n''est plus supportée';

  // Type de carte PS
  CARTE_CPS = 0;
  CARTE_CPE = 2;
  CARTE_CPA = 3;

  // Document invisible (bits)
  VISIBLE                        = 0;
  MASQUE_PS                      = 1;
  INVISIBLE_PATIENT              = 2;
  INVISIBLE_REPRESENTANTS_LEGAUX = 4;

  // OID INS et NIR
  OID_INS_A    = '1.2.250.1.213.1.4.1';
  OID_INS_C    = '1.2.250.1.213.1.4.2';
  OID_NIR_Reel = '1.2.250.1.213.1.4.8';
  OID_NIR_Test = '1.2.250.1.213.1.4.10';
  OID_NIR_Demo = '1.2.250.1.213.1.4.11';

  // Creation de DMP
  CIVILITE_SANS = 0;
  CIVILITE_M    = 1;
  CIVILITE_MME  = 2;
  CIVILITE_MLLE = 3;

  CIVILITES: array[CIVILITE_SANS..CIVILITE_MLLE] of PChar = (
    nil,
    'M',
    'Mme',
    'Mlle'
  );

  CIVILITES_LONG: array[CIVILITE_SANS..CIVILITE_MLLE] of PChar = (
    nil,
    'Monsieur',
    'Madame',
    'Mademoiselle'
  );

type

// Structures utilisées pour extraire les informations de la carte CPx

  TCivilite = record
    Code: Byte;        // 22
    Nom : PChar;       // MME
  end;

  TEntite = record
    Code: PChar;       // G15_10/SM36
    Nom : PChar;       // Médecin - Oncologie, opt médicale (SM)
    OID : PChar;
  end;

  TRole = record
    Code    : PChar;   // 10
    Nom     : PChar;   // Médecin
    OID     : PChar;
  end;

  TCarte = record
    Emetteur     : PChar;
    IdCarte      : PChar;
    Categorie    : Byte;    //  TRE_G01-CategorieProduit.tabs ; $00, $02, $03 / $80, $82, $83 pour les TEST
    DebutValidite: PChar;   // YYYYMMDD
    FinValidite  : PChar;   // YYYYMMDD
  end;
  PCarte = ^TCarte;

  TPorteur = record   // CPS de test                                          CPE de test
    TypeCarte : Byte;       // 0                                                    2
    IdNational: PChar;      // 899700024450                                         30B0037750/CPET0001
    Civilite  : TCivilite;  // 31, M                                                22, MME
    Nom       : PChar;      // MAXIMAXIMAXIMAXIMAXI0002445                          RAMIN037750001
    Prenom    : PChar;      // MUMUMUMUMUMUMUMUMUMUMUMUMUM                          JULIE
    Entite    : TEntite;    // G15_10/SM36, Médecin - Oncologie, opt médicale (SM)
    Profession: TRole;      // 10, Médecin                                          SECRETARIAT_MEDICAL, Secrétariat médical
    Specialite: TRole;      // SM36, Oncologie option médicale (SM)
  end;
  PPorteur = ^TPorteur;

  TActivite = record
    Numero       : Byte;        // 2
    Statut       : Byte;        // 1
    Entite       : TEntite;     // SA07, Cabinet individuel
    IdNational   : PChar;       // 499700024450014
    RaisonSociale: PChar;       // CABINET DE M. MAXIMAXIMAXIMAXIM0002445
    Pharmacien   : TEntite;     // (nil, nil)
  end;
  PActivite = ^TActivite;

// Structure utilisée pour lire les informations de la carte Vitale

  TAdresse5 = array[1..5] of PChar;

  TBeneficiaire = record
    NomUsage         : PChar;      // TOUTES ZONES
    NomNaissance     : PChar;      //
    Prenom           : PChar;      // JEAN
    dateEnCarte      : PChar;      // 550101
    DateNaissance    : PChar;      // 01/01/1955
    Nir              : PChar;      // 1550672000101 59
    NirCertifie      : PChar;      // 1680172181372 43
    Qualite          : Integer;    // 0
    Adresse          : TAdresse5;
    RangDeNaissance  : Integer;    // 1
    MedecinTraitant  : PChar;      // Déclaré
    INSC             : PChar;
  end;
  PBeneficiaire = ^TBeneficiaire;

// Informations d'un document du DMP

  TDocumentInfo = record
  // tri
    Nom            : PChar;     // Nom du document
    Auteur         : PChar;     // Auteur du document
    DateCreation   : PChar;     // date de création du document
    Categorie      : PChar;     // Type de document
    Extension      : PChar;     // TXT, XML, PDF, JPG, TIF
    Commentaire    : PChar;     // Commentaire attaché au document
    Taille         : Integer;   // Taille du document encodé, pas du document final
  // autres valeurs
    CadreExercice  : PChar;     // Cadre d'exercice
    DateDebut      : PChar;
    DateFin        : PChar;
    UniqueID       : PChar;     // Identifiant unique du document
    Visibilite     : Integer;   // 0 = Pesonne, 1 = MASQUE_PS, 2 = INVISIBLE_PATIENT, 4 = INVISIBLE_REPRESENTANT_LEGAL
    Statut         : PChar;     // Approved, Archived, Deleted, Deprecated
    DocumentPatient: Boolean;   // Si le document est l'expression du titulaire
//    UserData      : Pointer;  // usage libre
  end;
  PDocumentInfo = ^TDocumentInfo;

// Structures utiliées pour récupérer les informations DMP

  TIdentifiantNationalDeSante = record
     Code: PChar;  // 15 ou 22 chiffres
    &Type: Char;   // A ou C, R T ou D
     OID : PChar;  // OID_INS_C, OID_NIR_Reel, OID_NIR_Test, OID_NIR_Demo
  end;

// Structure normalisée de l'identité d'un patient (selon le contexte, certains champs ne sont jamais renseignés)

  TIdentite = record
    Civilite      : Integer; // 0..3
    NomUsage      : PChar;   // Obligatoire
    NomNaissance  : PChar;
    Prenom        : PChar;   // Obligatoire
    DateNaissance : PChar;   // Obligatoire : jj/mm/aaaaa
    Sexe          : Char;    // Obligatoire : M F U
  end;
  PIdentite = ^TIdentite;

  TPatientInfo = record
    INS            : TIdentifiantNationalDeSante;  // (0803027695502382121519, C, 1.2.250.1.213.1.4.2)
    NIR            : TIdentifiantNationalDeSante;  // (NIR, T, 1.2.250.1.213.1.4.10)
    Identite       : TIdentite;
  end;
  PPatientInfo = ^TPatientInfo;

  TFermeture = record
    Date  : PChar; // jj/mm/aaaaa
    Code  : PChar; // FERMETURE_DEMANDE_PATIENT
    Motif : PChar;
  end;
  PFermeture = ^TFermeture;

  TDossierInfo = record
    Patient      : TPatientInfo;
    StatutMT     : Boolean;      // false
    Autorisation : PChar;        // NON_EXISTE (Pas d'autorisation existante), INTERDIT, EXPIRE, VALIDE
    Fermeture    : PFermeture;   // si fermé
    AccesWeb     : Boolean;      // indique si ouvert
    Mineur       : Boolean;      // indique si le patient est mineur
    Secret       : Integer;      // indique si le mode secret est activité (0 = non défini, 1 = normal, 2 = secret)
  end;
  PDossierInfo = ^TDossierInfo;

// Structure normalisée de l'adresse du patient (selon le contexte, certains champs ne sont jamais renseignés)
// NB: l'extraction de l'adresse depuis la carte Vitale n'est pas forcément fidèle puisque les champs n'y sont pas identifiés

  TAdresse = record
    Adresse   : PChar;
    Complement: PChar;
    CodePostal: PChar;
    Ville     : PChar;
    Pays      : PChar;
  end;
  PAdresse = ^TAdresse;

// Autorisation d'accès au DMP décidées par le patient

  TAutorisations = record
    Urgence     : Boolean; // Autorise, en cas d'appel au SAMU ou de tout centre 15, le médecin régulateur à accéder à son DMP
    BrisDeGlace : Boolean; // Autorise, s'il est dans un état comportant un risque immédiat pour sa santé, tout professionel de santé à accéder à son DMP
  end;
  PAutorisations = ^TAutorisations;

// Volet administratif du DMP

  TTelecom = record
    Fixe   : PChar;
    Mobile : PChar;
    EMail  : PChar;
  end;

{
					<personalRelationship classCode="PRS">
										<code code="UNCLE" codeSystem="2.16.840.1.113883.1.11.19579"/>
										<addr>
											<streetAddressLine>làbas</streetAddressLine>
											<postalCode>13100</postalCode>
											<city>AIX EN PROVENCE</city>
										</addr>
										<telecom use="HP" value="tel:0123456789"/>
										<telecom use="MC" value="tel:0606060606"/>
										<telecom value="mailto:"/>
										<relationshipHolder1 classCode="PSN" determinerCode="INSTANCE">
											<name>
												<prefix>M</prefix>
												<given>Paul</given>
												<family>TEST</family>
											</name>
										</relationshipHolder1>
									</personalRelationship>
}
  TRelation = (
    Aucune,           // pas de représentant légal
    Pere,             // FTH
    Mere,             // MTH
    BeauPere,         // STPFTH - époux de la mère du patient
    BelleMere,        // STPMTH - épouse du père du patient
    GrandPere,        // GRFTH
    GrandMere,        // GRMTH
    ArriereGrandPere, // GGRFTH
    ArriereGrandMere, // GGRMTH
    Tante,            // AUNT
    Oncle,            // UNCLE
    Frere,            // BRO
    Soeur,            // SIS
    Autre             // RESPRSN - Autre réprésentant légal
  );

  TRepresentantLegal = record
    Relation     : TRelation;
    Civilite     : Integer; // 0..3
    Nom          : PChar;
    Prenom       : PChar;
    Adresse  : TAdresse;  // le Pays est ignoré
    Telecom      : TTelecom;
  end;

  TVoletAdministratif = record
    Identite       : TIdentite;
    Adresse        : TAdresse;
    Telecom        : TTelecom;
    PaysNaissance  : PChar;
    Representant   : TRepresentantLegal;
  end;
  PVoletAdministratif = ^TVoletAdministratif;

// Informations sur les DMP

  TDossierItem = record
    Patient            : TPatientInfo;
    StatutMT           : Boolean;
    DateModification   : PChar;    // jj/mm/aaaa
    DateDernierAcces   : PChar;
    DateDernierDocument: PChar;
  end;
  PDossierItem = ^TDossierItem;

// Informations sur les patients (recherche sans INS)

  TPatientItem = record
    Patient          : TPatientInfo;
    CodePostal       : PChar;
    Ville            : PChar;
    oppositionUrgence: Boolean;
  end;
  PPatientItem = ^TPatientItem;

// Codes d'accès patient
  TAccesPatient = record
    login    : PChar;
    password : PChar;
  end;
  PAccesPatient = ^TAccesPatient;

// Praticien autorisé au DMP
  TModePraticien = (
    Active,
    Interdite,
    Toute
  );

  TPraticien = record
    IdNational: PChar;
    TypeId    : PChar;   // 1.2.250.1.71.4.2.1 = PS; 1.2.250.1.71.4.2 = Structure
    Prenom    : PChar;
    Nom       : PChar;
    DateAction: PChar;   // DD/MM/YYYY
    Mode      : PChar;   // ACTIVE / INTERDITE
    DateDebut : PChar;   // DD/MM/YYYY
    Entite    : TEntite; // (G15_10/SM25, Médecin - Qualifié en Médecine Générale (SM))
    StatutMT  : Boolean;
  end;
  PPraticien = ^TPraticien;

// paramètres de création d'un DMP

  TCreationDossier = record
    Autorisations         : TAutorisations;
    VoletAdministratif    : TVoletAdministratif;
  end;
  PCreationDossier = ^TCreationDossier;

  TVisibiliteDocument = (
  //ToutLeMonde,                // Normal = 0
    PatientUniquement,          // MASQUE_PS
    PraticiensUniquement,       // INVISIBLE_PATIENT
    InvisibleRepresentantLegal  // INVISIBILE_REPRENSENTANT_LEGEL
  );
  TVisibilitesDocument = set of TVisibiliteDocument;

  TTypeMime = (
    TextPlain,        // text/plain
    TextRTF,          // text/rtf
    ApplicationPDF,   // application/pdf
    ImageJPEG,        // image/jpeg
    ImageTIFF         // image/tiff
  );

  TDocument = record
    Taille  : Integer;   // taille de Contenu^
    Contenu : Pointer;   // Contenu brut du Document
    TypeMime: TTypeMime;
  end;
  PDocument = ^TDocument;

  TDocumentReference = record
    UniqueID: PChar; // obligatoire
    UUID    : PChar; // peut être vide
  end;

  TProprietesDocument = record
    Titre           : PChar;     // 255 chars
    Document        : TDocument; // le document
    Commentaire     : PChar;     // Commentaire du document
    PatientId       : PChar;     // identifiant du patient dans le LPS
    TypeDocument    : PChar;     // XdsTypeCode: SYNTH, 10213-7 ...
    DateDocument    : PChar;     // dd/mm/yyyy
    CadreExercice   : PChar;     // XdsPracticeSettingCode : EXP_PATIENT, SAD...
    DateDebut       : PChar;     // dd/mm/yyyy
    DateFin         : PChar;     // dd/mm/yyyy
    Visibilite      : TVisibilitesDocument;
    Remplacer       : TDocumentReference;
  end;

  TIdentitePatient = record
    nirIndividu    : PChar; // [1..1]
    prenom         : PChar; // [0..1]
    nomUsuel       : PChar; // [0..1]
    nomPatronymique: PChar; // [0..1]
    dateNaissance  : PChar; // [1..1] AAAA-MM-DD lunaire
  end;
  PIdentitePatient = ^TIdentitePatient;

// Paramètre de recherche des dossiers

  TDateMode = (
    DateAutorisation,
    DateDernierDocument
  );

// paramètre de recherche des patients

  TSexe = (
    Tous,
    Homme,
    Femme,
    Inconnu
  );

  TRecherchePatients = record
    Nom           : PChar;
    Prenom        : PChar;
    Naissance     : PChar;
    CodePostal    : PChar;
    Ville         : PChar;
    Sexe          : TSexe;
    NomPartiel    : Boolean;
    VillePartielle: Boolean;
  end;

// Paramètres de recherche de documents

  TQueryFlag = (
    Aprouve,           // documents approuvés
    Archive,           // documents archivés
    MasquePS,          // documents réservés au médecin traitant
    InvisiblePatient,  // documents non visibles au patient
    Invisible_RepresentantLegal, // V2
    Obsolete           // documents obsolètes
  );

  TQueryFlags = set of TQueryFlag;

  TQueryDocuments = record
    Flags   : TQueryFlags;
    TypeDoc : PChar;
    After   : PChar; // dd/mm/yyyy hh:nn
    Before  : PChar; // dd/mm/yyyy hh:nn
  end;

// paramètre de l'accès Web

  TDMPUrl = (         // Paramètre:
    TableauDeBord,    //  INS optionel
    DossierPatient,   //  INS obligatoire
    GestionDMP,       //  INS obligatoire
    Documents,        //  INS obligatoire
    ParcoursDeSoins,  //  INS obligatoire
    HistoriqueAcces,  //  INS obligatoire
    Parametrages,     //  aucun
    VolontesEtDroits, //  INS obligatoire
    CreationDMP       //  optionel : getDMPParms()
  );

// Modification d'un canal
  TActionCanal = (
    Ajout,
    Modification,
    Suppression
  );

  TParametres = record
    GestionMineurs : Boolean;
    AgeMajoritee   : Integer;
    CumulVisibilite: Boolean;
  end;
  PParametres = ^TParametres;

//----------------------------/
// Déclaration des interfaces /
//----------------------------/

  IMagicDMP = interface;

// Un document stocké dans le DMP

  IDocument = interface
  // retourne les informations sur le document
    function GetInfo: PDocumentInfo; stdcall;
  // enregistre le document sous le nom indiqué
    procedure SaveToFile(AFileName: PChar); stdcall;
  // récupère les informations sur le fichier au format text/html UTF8
    function GetDescription(out Source: Pointer; out Len: Integer): Integer; stdcall;
  // recupère un pointeur sur le document lui-même
    function GetDocument(out Source: Pointer; out Len: Integer): Integer; stdcall;
  // retrouve une image intégrée dans le document s'il est au format HTML (<IMG SRC="Name">)
    function GetImage(Name: PChar; out Image: Pointer; out Len: Integer): Integer; stdcall;
  // retourne le type Mime du document
    function MimeType: PChar; stdcall;
  // pour une document text/plain, indique s'il est encodé en UTF8
    function IsUTF8: Boolean; stdcall;
  // changer sa visibilité
    function SetVisibilite(Visibilite: Integer): Integer; stdcall;
  // archiver le document
    function SetArchive(Archive: Boolean): Integer; stdcall;
  // supprimer le document
    function Supprimer(): Integer; stdcall;
  // remplacer un document
    function Remplacer(var Props: TProprietesDocument; out UniqueId: PChar): Integer; stdcall;
  // retourne l'instance DMP associée au Dossier
    function MagicDMP: IMagicDMP; stdcall;
  end;

// Liste de documents

  IDocumentList = interface
  // Nombre de documents dans la liste
    function Count: Integer; stdcall;
  // Informations sur le nième document (dans l'ordre de tri)
    function Info(Index: Integer): PDocumentInfo; stdcall;
  // Définir l'ordre de tri des documents :
  //   0: par nom
  //   1: par auteur
  //   2: par date
  //   3: par type
  //   4: par taille
  // NB: le premier appel crée un tri croissant, un second appel avec le même Index inverse l'ordre
    function Sort(Column: Integer): Integer; stdcall;
  // nombre d'élément pour une categorie
    function CategoryCount(Categorie: PChar): Integer; stdcall;
  // Sélection d'une catégorie de documents (TDocumentInfo.Categorie)
    function Filter(Categorie: PChar): Integer; stdcall;
  // récupère le nième document (dans l'ordre de tri)
    function GetDocument(Index: Integer; out Doc: IDocument): Integer; stdcall;
  // tri de -5..-1 et +1..+5
    function GetSortIndex: Integer; stdcall;
    procedure SetSortIndex(Value: Integer); stdcall;
  end;

// un lot de soumission de documents
  ILotDocuments = interface
    function AddDocument(const Props: TProprietesDocument): Integer; stdcall;
    function Submit(): Integer; stdcall;
    function GetUniqueID(Index: Integer): PChar; stdcall;
  end;

// Dossier médical d'un patient

  IDossierMedical = interface
  // retourne l'instance DMP associée au Dossier
    function MagicDMP: IMagicDMP; stdcall;
  // retourne les information sur le DMP
    function GetInfo: PDossierInfo; stdcall;
  // recupère le volet administratif
    function GetVoletAdministratif(out Volet: PVoletAdministratif): Integer; stdcall;
  // modifie le volet administratif
    function SetVoletAdministratif(Volet: PVoletAdministratif): Integer; stdcall;
  // obtient la liste des documents
    function QueryDocuments(const Query: TQueryDocuments; out List: IDocumentList): Integer; stdcall;
    function Query2Documents(TypeDoc1, TypeDoc2: PChar; out List: IDocumentList): Integer; stdcall;
  // obtient la liste des documents dans un interval de temps
    function QuerySubmissions(const Query: TQueryDocuments; out List: IDocumentList): Integer; stdcall;
    function QuerySubmissions2(const Query: TQueryDocuments; out List: IDocumentList): Integer; stdcall;
  // définir les autorisations:
  //    +-----------+------------------------+-------------------------------------------+
  //    | Autoriser | DevenirMedecinTraitent | Effet                                     |
  //    +-----------+------------------------+-------------------------------------------+
  //    |   True    | False                  | Autorise son accès au DMP                 |
  //    +-----------+------------------------+-------------------------------------------+
  //    |   True    | True                   | Autorire son accès au DMP en devenant MT  |
  //    +-----------+------------------------+-------------------------------------------+
  //    |   False   | False                  | Supprime son accès au DMP                 |
  //    +-----------+------------------------+-------------------------------------------+
  //    |   False   | True                   | Ne plus être MT mais conserver son accès  |
  //    +-----------+------------------------+-------------------------------------------+
  //     Le BrisDeGlace est nécessaire pour un dossier sur lequel vous n'avez pas de droit
  //     Le BrisDeGlace n'est possible que si le patient l'a autorisé
  //     La notion de Medecin Traitant est propre au DMP, plusieurs médecins peuvent être MT d'un même dossier
    function Autorisation(Autoriser, DevenirMedecinTraitant: Boolean; BrisDeGlace: PChar): Integer; stdcall;
  // Réactiver un dossier
    function Reactiver(const Autorisations: TAutorisations): Integer; stdcall;
  // identique à Autorisation(True, DevenirMedecinTraitant, BrisDeGlace)
    function OuvrirAcces(DevenirMedecinTraitant: Boolean; BrisDeGlace: PChar): Integer; stdcall;
  // identique à Autorisation(Value, True, nil)
    function EtreMedecinTraitant(Value: Boolean): Integer; stdcall;
  // identique à Autorisation(False, False, nil)
    function FermerAcces(): Integer; stdcall;
  // fermeture du Dossier à la demande du patient
    function FermerDossier(Code, Motif: PChar): Integer; stdcall;
  // création d'un acces patient
    function CreerAccesPatient(Canal: PChar; out Acces: PAccesPatient): Integer; stdcall;
  // recréer l'accès patient
    function NouvelAccesPatient(out acces: PAccesPatient): Integer; stdcall;
  // Modification d'un Canal d'accès patient
    function ModifierCanal(Canal: PChar; Action: TActionCanal): Integer; stdcall;
  // liste des praticiens autorisés au DMP
    function GetPraticiens(Mode: TModePraticien; out Count: Integer; out Praticiens: PPraticien): Integer; stdcall;
  // Ajoute un document et retourne son UniqueID
    function AddDocument(const Props: TProprietesDocument; out UniqueId: PChar): Integer; stdcall;
  // Ajout d'un dossier de synthèse
    function AddSynthese(const Props: TProprietesDocument; const VSM: UTF8String; out UniqueId: PChar): Integer; stdcall;
  // ouvrir un document par son UniqueID
    function GetDocument(UniqueID: PChar; out Document: IDocument): Integer; stdcall;
  // récupère l'UUID d'un document d'après son UniqueID (les CPE y ont accès)
    function GetDocumentUUID(UniqueID: PChar; out UUID: PChar): Integer; stdcall;
  // supprimer un document
    function SupprimerDocument(UniqueID: PChar): Integer; stdcall;
  // supprimer un document
    function SupprimerDocumentUUID(UUID: PChar): Integer; stdcall;
  // définir le mode d'accès pour les dossiers mineurs
    function SetAccesSecret(Secret: Boolean): Integer; stdcall;
  // création d'un lot de soumission
    function CreerLotDocuments(out Lot: ILotDocuments): Integer; stdcall;
  end;

// Liste de dossiers

  IDossierList = interface
  // Nombre de dossiers dans la liste
    function GetCount: Integer; stdcall;
  // Informations sur le nième dossier
    function GetItem(Index: Integer): PDossierItem; stdcall;
  // Ouvre le nième dossier
    function GetDossier(Index: Integer; out Dossier: IDossierMedical): Integer; stdcall;
  end;

// Liste de patients

  IPatientList = interface
  // Nombre de patients dans la liste
    function GetCount: Integer; stdcall;
  // Informations sur le nième patient
    function GetItem(Index: Integer): PPatientItem; stdcall;
  // Ouvre le dossier du nième patient
    function GetDossier(Index: Integer; out Dossier: IDossierMedical): Integer; stdcall;
  end;

// Carte SESAM Vitale

  IMagicCSV = interface
  // retourne le contenu complet de la carte Vitale
    function GetXML(out XML: PAnsiChar): Integer; stdcall;
  // retourne le nombre de bénéficaires
    function GetBeneficiaires: Integer; stdcall;
  // informations sur le nième bénéficiaire
    function GetBeneficiaire(Index: Integer): PBeneficiaire; stdcall;
  // sélectionne un bénéficaire (le premier est sélectionné par défaut)
    function SelectionBeneficiaire(Index: Integer): Integer; stdcall;
  // numéro de patient sélectionné
    function SelectedBeneficiaire: Integer; stdcall;
  // Retourne l'INS du patient sélectionné, ou NIL si indisponible
    function GetINS: PChar; stdcall;
  // Retourne l'adresse normalisée (empirique) du patient
    function GetAdresse: PAdresse; stdcall;
  // Retourne le DMP du patient s'il existe
    function DossierExiste(out Dossier: IDossierMedical): Integer; stdcall;
  // Crée le DMP du patient (la fonction ne vérifie pas son existance)
    function CreationDossier(const Param: TCreationDossier; out Dossier: IDossierMedical): Integer; stdcall;
  // Type de carte Vitale
    function GetCardType: Word; stdcall;
  end;

// Connexion DMP
  IMagicCNX = interface
  // Définir l'environnement
    function RegisterProduct(LPS_NOM, LPS_VERSION, LPS_ID_HOMOLOGATION_DMP: PChar): Integer; stdcall;
  // Retourne le numéro de licence sous forme d'un OID
    function Register(CurrentID: PChar; out NewID: PChar): Integer; stdcall;
  // Information sur la carte
    function GetCarte: PCarte; stdcall;
  // Informations (publique) sur le porteur
    function GetPorteur: PPorteur; stdcall;
  // recherche un DMP d'après un INS A ou C
    function DossierExiste(INSValue: PChar; INSType: Char; out Dossier: IDossierMedical): Integer; stdcall;
  // retourne la liste des dossiers selon une date (YYYYMMDDhhmmss) et un mode de recherche
    function GetDossiers(DateUTC: PChar; Mode: TDateMode; out List: IDossierList): Integer; stdcall;
  // retourne une liste de patients selon les critères de recherche
  //   la fonction peut retourner au maximum 10 patients (limitation du DMP)
    function GetPatients(const Criteres: TRecherchePatients; out List: IPatientList): Integer; stdcall;
  // retourne le serveur utilisé
    function GetServer: PChar; stdcall;
  // détermine le serveur utilisé
    procedure SetServer(Server: PChar); stdcall;
  // recherche d'un INS sur le DMP V2
    function SearchINS(Nir, dateNaissance: PChar; Rang: Integer; NirIndividu: PChar; out Identite: PIdentitePatient): Integer; stdcall;
  end;

// Certificat logiciel
  IMagicCRT = interface(IMagicCNX)
  // Chargement du certificat de signature
    function LoadSignature(Data: Pointer; Size: Integer; Password: PChar): Integer; stdcall;
  // Structure
    function GetStructure: PActivite; stdcall;
    procedure SetStructure(Code, IdNational, RaisonSociale: PChar); stdcall;
    procedure SetPraticien(IdNational, Nom, Prenom, Profession, Specialite, Pharmacien, CodeStruct: PChar); stdcall;
  end;

// Carte du Professionnel de Santé

  IMagicCPS = interface(IMagicCNX)
  // nombre de saisie de code PIN autorisées : 3, 2, 1, -1 si le carte est vérouillée
    function PinCount: Integer; stdcall;
  // Ouvrir une session avec le code PIN du porteur
    function SetCode(Code: PChar): Integer; stdcall;
  // Nombre d'activités (information privée) du porteur
    function GetActivites(out Count: Integer): Integer; stdcall;
  // retourne la nième activité
    function GetActivite(Index: Integer): PActivite; stdcall;
  // sélectionne une activité (la première est sélectionnée par défaut)
    function SelectActivite(Index: Integer): Integer; stdcall;
  // retourne l'index de l'activité sélectionnée
    function SelectedActivite: Integer; stdcall;
  end;

// Interface IMagicLOG
  IMagicLOG = interface
    procedure OnLog(DMP: IMagicDMP; Msg: PChar); stdcall;
  end;

// Interface de MagicDMP

  IMagicDMP = interface
  // retourne la version de l'API
    function GetVersion: Integer; stdcall;
  // retourne la valeur MSG_xxx pour un ERR_xxx donné
    function GetErrMsg(ErrNo: Integer): PChar; stdcall;
  // message complémentaire de l'erreur, exemple message d'erreur HTTP
    function GetErrDetail: PChar; stdcall;

  // déclaration d'un logger
    procedure SetLogger(Logger: IMagicLOG); stdcall;

  // indique le chemin d'accès à la CryptoLibV5 (cps3_pkcs11_w32/64.dll)
    function SetCryptoLib(AFileName: PChar): Integer; stdcall;
  // indique le chemin d'accès à l'API de lecture (API_LEC.DLL)
    function SetApiLecture(AFileName: PChar): Integer; stdcall;

  // nombre de CPx détectées
    function GetSlotCount(var Count: Integer): Integer; stdcall;
  // lecture de la CPx dans le Slot x
    function GetCPS(Slot: Integer; out CPS: IMagicCPS): Integer; stdcall;
  // Retourne la CPS active (dernier appel à GetCPS)
    function GetActiveCPS: IMagicCPS; stdcall;

  // lecture de la CSV
    function GetCSV(out CSV: IMagicCSV): Integer; stdcall;
  // simule la lecture d'un CSV d'après un fichier XML
    function SetCSV(xml: PAnsiChar; Len: Integer; out CSV: IMagicCSV): Integer; stdcall;

  // fixe l'URL de base [EX_0.9-1030]
    procedure SetDMPUrl(URL: PChar); stdcall;
  // retourne l'URL d'accès à une fonction du DMP en ligne
    function GetDMPUrl(DMPUrl: TDMPUrl; Param: PChar; out URL: PChar): Integer; stdcall;
  // calcule les paramètres de l'URL de création d'un DMP
  //   DMP.GetDMPUrl(TDMPUrl.CreatDMP, DMP.GetDMPParams(...))
    function GetDMPParams(Mobile, EMail, Adresse, Complement, CodePostal, Ville, Pays: PChar): PChar; stdcall;

    function LoadCertificat(Data: Pointer; Size: Integer; Password: PChar; out CRT: IMagicCRT): Integer; stdcall;

    function GetParametres: PParametres; stdcall;
  end;

const
  EXTENSIONS: array[TTypeMime] of string = (
    'TXT', // text/plain
    'RTF', // text/rtf
    'PDF', // application/pdf
    'JPG', // image/jpeg
    'TIF'  // image/tiff
  );

  TYPEMIMES: array[TTypeMime] of string = (
    'text/plain',
    'text/rtf',
    'application/pdf',
    'image/jpeg',
    'image/tiff'
  );

  RELATIONS: array[TRelation] of string = (
    'Pas de répresentant légal',
    'Père',
    'Mère',
    'Beau-père - époux de la mère du patient',
    'Belle-mère - épouse du père du patient',
    'Grand-père',
    'Grand-mère',
    'Arrière-grand-père',
    'Arriere-grand-mère',
    'Tante',
    'Oncle',
    'Frère',
    'Soeur',
    'Autre réprésentant légal'
  );

implementation


end.

