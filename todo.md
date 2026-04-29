# Todo

## Base

-   Table :
    - Utilisateur
      - id
      - nom
      - motDePasse
    - Etudiant:
      - Id
      - etu
      - nom
      - prenom
      - dtnaissance
    - Semestre:
      - Id
      - Libelle(s1,s2,s3,s4,s5,s6)
      - IdAnnee
    - Inscription:
      - IdEtudiant
      - IdSemestre
      - dtInscription
    - parcours:
      - id
      - libelle
    - Matiere:
      - id
      - libelle
    - Matiere_parcours:
      - Id
      - Idmatiere
      - Idparcours
    - matiere_semestre:
      - Id
      - coefficients
      - Id_Ensemble_UE(ensemble unite d'enseignement)
      - IdMatiere_parcours
      - idSemestre
    - Note:
      - id
      - IdInscription
      - IdMatiere_semestre
    - Annee:
      - Id
      - libelle(l1,l2,l3)
    - Ensemble-UE
      - id
  
  ## controller
    - UserController(fana)
    - NoteController(fana)
    - EtudiantController(Olivier)
      - listeEtudiant
      - liteSemestre && annee+parcours
      - lsite
    - 