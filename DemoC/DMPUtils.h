// Utils

 /*
  * Implement IMagicLOG to receive feedback from MagicEAI
  */
typedef struct {
  int (__stdcall *QueryInterface)(void *this, void *riid, void*);
  int (__stdcall *AddRef)(void *this);
  int (__stdcall *Release)(void *this);
  
  void (__stdcall *OnLog)(void *this, void *DMP, wchar_t* Msg);
} MagicLOG;

int __stdcall MagicLOG_QueryInterface(void *this, void *riid, void* obj) {
  return 0x80004001; // E_NOTIMPL
}

int __stdcall MagicLOG_Dummy(void *this) {
  return 0;
}

void __stdcall MagicLOG_OnLog(void *this, void *DMP, wchar_t* Msg) {
  printf("[LOG] %ls\n", Msg);
}

void showPatient(TPatientInfo *patient) {
   printf("\
  INS-C                  %ls - %lc (%ls)\n\
  INS-NIR                %ls - %lc (%ls)\n\
  Identite.Civilite      %d\n\
  Identite.NomUsage      %ls\n\
  Identite.NomNaissance  %ls\n\
  Identite.Prenom        %ls\n\
  Identite.DateNaissance %ls\n\
  Identite.Sexe          %lc\n",
	  patient->INS.Code,
	  patient->INS.Type,
	  patient->INS.OID,
	  patient->NIR.Code,
	  patient->NIR.Type,
	  patient->NIR.OID,
	  patient->Identite.Civilite,
	  patient->Identite.NomUsage,
	  patient->Identite.NomNaissance,
	  patient->Identite.Prenom,
	  patient->Identite.DateNaissance,
	  patient->Identite.Sexe
   );
}

int searchPatients(IMagicDMP DMP, IMagicCNX CNX, TRecherchePatients *Criteres) {
 IPatientList Patients = 0;
 
 int rc = (*CNX)->GetPatients(CNX, Criteres, &Patients);
 printf("GetPatients returns 0x%x (%ls)\n(%ls)\n", rc, (*DMP)->GetErrMsg(DMP, rc), (*DMP)->GetErrDetail(DMP));
 if (rc) return FALSE;
  
 int Count = (*Patients)->GetCount(Patients);
 printf("%d patients found\n", Count); 
 for (int i = 0; i < Count; i++) {
   
   PPatientItem patient = (*Patients)->GetItem(Patients, i);
   
   printf("Patient %d:\n", i);
   showPatient(&patient->Patient);
   printf("\
  CodePostal             %ls\n\
  Ville                  %ls\n\
  oppositionUrgence      %d\n",
	  patient->CodePostal,
	  patient->Ville,
	  patient->oppositionUrgence
   );   
 }
 
 (*Patients)->unknown.Release(Patients);
 return TRUE;
}