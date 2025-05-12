
  /*-------------------------------------------------------------------------*/
  /*         TP 2 Khawarizm : Optimisation de la recherche des mots.         */
  /*                              Réalisé par:                               */
  /*                            Rayane Nait Saidi                            */
  /*                             Youcef Shaath                               */
  /*                      Section : B       Groupe : 05                      */
  /*                      Année Scolaire : 2024-2025                         */
  /*-------------------------------------------------------------------------*/
   SOIENT
       F : FICHIER DE CHAINE BUFFER S ;
       Root1 , Root2 , Root3 : ARB DE CHAINES ;
       C , Word , Chaine1 , Chaine2 : CHAINES ;
       X , Y , Z : CARACTERES ;
       Size1 , Size2 , Size3 , I : ENTIERS ;
       Res1 , Res2 , Res3 : BOOLEEN ;
       Rech , Insert , Inorder , Count_xyz_level , Create_file : ACTION ;
       Rechercher , One_word_search , Range_search , Interval_search : ACTION ;
       Count_xyz , Depth : FONCTION ( ENTIERS ) ;
   DEBUT
       X := 'Y' ;
       Y := 'Z' ;
       Z := 'a' ;
       APPEL Create_file ( F ) ;
      {craeting the first BST1}
       OUVRIR ( F , 'F.z' , 'A' ) ;
       TQ NON FINFICH ( F ) :
           LIRESEQ ( F , S ) ;
           APPEL Insert ( Root1 , S , Res1 )
       FTQ ;
       FERMER ( F ) ;
      {tests on BST1}
       ECRIRE ( 'Affichage de arbre 1: ' ) ;
       APPEL Inorder ( Root1 ) ;
       APPEL Count_xyz_level ( Root1 , X ) ;
       ECRIRE ( 'Profondeur de cet arbre : ' , Depth ( Root1 ) ) ;
       ECRIRE ( 'Les noms commencant avec X=(Y)  : ' , Count_xyz ( Root1 , X ) ) ;
      {craeting the second BST2}
       OUVRIR ( F , 'F.z' , 'A' ) ;
       TQ NON FINFICH ( F ) :
           LIRESEQ ( F , S ) ;
           APPEL Insert ( Root2 , S , Res2 )
       FTQ ;
       FERMER ( F ) ;
      {tests on BST2}
       ECRIRE ( 'Affichage de arbre 2: ' ) ;
       APPEL Inorder ( Root2 ) ;
       APPEL Count_xyz_level ( Root2 , Y ) ;
       ECRIRE ( 'Profondeur de cet arbre : ' , Depth ( Root2 ) ) ;
       ECRIRE ( 'Les noms commencant avec Y=(Z)  : ' , Count_xyz ( Root2 , Y ) ) ;
      {creating the third BST3}
       OUVRIR ( F , 'F.z' , 'A' ) ;
       TQ NON FINFICH ( F ) :
           LIRESEQ ( F , S ) ;
           APPEL Insert ( Root3 , S , Res3 )
       FTQ ;
       FERMER ( F ) ;
      {tests on BST3}
       ECRIRE ( 'Affichage de arbre 3: ' ) ;
       APPEL Inorder ( Root3 ) ;
       APPEL Count_xyz_level ( Root3 , Z ) ;
       ECRIRE ( 'Profondeur de cet arbre : ' , Depth ( Root3 ) ) ;
       ECRIRE ( 'Les noms commencant avec Z=(a)  : ' , Count_xyz ( Root3 , Z ) ) ;
       ECRIRE ( 'Rechercher une chaine dans les 3 arbres : ' ) ;
      {algorithms of search}
       LIRE ( Word ) ;
       APPEL One_word_search ( Word , X , Y , Z , Root1 , Root2 , Root3 ) ;
       ECRIRE ( 'Rechercher dans un interval :' ) ;
       LIRE ( Chaine1 ) ;
       LIRE ( Chaine2 ) ;
       APPEL Range_search ( Chaine1 , Chaine2 , Root1 , Root2 , Root3 ) ;
   FIN
   ACTION Create_file ( F ) ;
   SOIENT
       F : FICHIER DE CHAINE BUFFER S ;
       I , J : ENTIERS ;
   DEBUT
       OUVRIR ( F , 'F.z' , 'N' ) ;
       POUR J := 1 , 10
           I := ALEANOMBRE ( 10 ) ;
           SI I = 0
               S := 'Y' + ALEACHAINE ( ALEANOMBRE ( 5 ) + 3 ) ;
           FSI ;
           SI I = 1
               S := 'Z' + ALEACHAINE ( ALEANOMBRE ( 5 ) + 3 ) ;
           FSI ;
           SI I = 2
               S := 'a' + ALEACHAINE ( ALEANOMBRE ( 5 ) + 3 ) ;
           SINON
               S := ALEACHAINE ( ALEANOMBRE ( 5 ) + 1 ) ;
           FSI ;
           ECRIRESEQ ( F , S )
       FPOUR ;
       FERMER ( F )
   FIN
   ACTION Rech ( Root , V , P , Q )
  {returns the pointer that has the searched string in P and its parent in Q}
  {if v is not found , P is NIL , and Q points on the last visited node}
   SOIENT
       Root , P , Q : ARB DE CHAINE ;
       V : CHAINE ;
   DEBUT
       SI Root = NIL
           P := NIL ;
           Q := NIL ;
       SINON
           SI INFO ( Root ) = V
               P := Root ;
               Q := NIL ;
           SINON
               SI V < INFO ( Root )
                   APPEL Rech ( FG ( Root ) , V , P , Q ) ;
               SINON
                   APPEL Rech ( FD ( Root ) , V , P , Q ) ;
               FSI ;
               SI Q = NIL
                   Q := Root ;
               FSI ;
           FSI ;
       FSI ;
   FIN
   ACTION Insert ( Root , V , Res )
   SOIENT
       Root , P , Q , R : ARB DE CHAINE ;
       V : CHAINE ;
       Res : BOOLEEN ;
   DEBUT
       CREERNOEUD ( R ) ;
       AFF_INFO ( R , V ) ;
       SI Root = NIL
           Root := R ;
           Res := VRAI
       SINON
           APPEL Rech ( Root , V , P , Q ) ;
           SI P <> NIL
               Res := FAUX ;
           SINON
               Res := VRAI ;
               SI V < INFO ( Q )
                   AFF_FG ( Q , R ) ;
                   AFF_PERE ( R , Q ) ;
               SINON
                   AFF_FD ( Q , R ) ;
                   AFF_PERE ( R , Q ) ;
               FSI ;
           FSI ;
       FSI ;
   FIN
   ACTION Inorder ( Root ) ;
   SOIENT
       Root : ARB DE CHAINE ;
   DEBUT
       SI Root <> NIL
           APPEL Inorder ( FG ( Root ) ) ;
           ECRIRE ( INFO ( Root ) ) ;
           APPEL Inorder ( FD ( Root ) )
       FSI
   FIN
   FONCTION Count_xyz ( Root , C ) : ENTIERS ;
   SOIENT
       Root , P : ARB DE CHAINE ;
       C : CARACTERE ;
       Cpt : ENTIERS ;
       F : FILE DE ARB DE CHAINE ;
   DEBUT
       CREERFILE ( F ) ;
       Cpt := 0 ;
       ENFILER ( F , Root ) ;
       TQ FILEVIDE ( F ) = FAUX :
           DEFILER ( F , P ) ;
           SI CARACT ( INFO ( P ) , 1 ) = C
               Cpt := Cpt + 1
           FSI ;
           SI FG ( P ) <> NIL
               ENFILER ( F , FG ( P ) )
           FSI ;
           SI FD ( P ) <> NIL
               ENFILER ( F , FD ( P ) )
           FSI
       FTQ ;
       Count_xyz := Cpt
   FIN
   FONCTION Depth ( Root ) : ENTIERS ;
   SOIENT
       Root : ARB DE CHAINE ;
   DEBUT
       SI Root = NIL
           Depth := - 1
       SINON
           SI Depth ( FG ( Root ) ) > Depth ( FD ( Root ) )
               Depth := Depth ( FG ( Root ) ) + 1
           SINON
               Depth := Depth ( FD ( Root ) ) + 1
           FSI
       FSI
   FIN
   ACTION Count_xyz_level ( Root , C ) ;
   SOIENT
       Root , P , N : ARB DE CHAINE ;
       F : FILE DE ARB DE CHAINE ;
       C : CARACTERE ;
       Cpt , Level : ENTIERS ;
   DEBUT
       CREERFILE ( F ) ;
       ECRIRE ( 'Affichage du nombre des noeuds commencant avec le lettre au chaque niveau:' ) ;
       Level := 0 ;
       ENFILER ( F , Root ) ;
       N := NIL ;
       ENFILER ( F , N ) ;
       TQ FILEVIDE ( F ) = FAUX :
           Cpt := 0 ;
           ECRIRE ( 'Level:' ) ;
           ECRIRE ( Level ) ;
           ECRIRE ( 'Le nombre : ' ) ;
           DEFILER ( F , P ) ;
           TQ P <> N :
               SI CARACT ( INFO ( P ) , 1 ) = C
                   Cpt := Cpt + 1
               FSI ;
               SI FG ( P ) <> NIL
                   ENFILER ( F , FG ( P ) )
               FSI ;
               SI FD ( P ) <> NIL
                   ENFILER ( F , FD ( P ) )
               FSI ;
               DEFILER ( F , P ) ;
           FTQ ;
           ECRIRE ( Cpt ) ;
           ECRIRE ( '------------' ) ;
           SI FILEVIDE ( F ) = FAUX
               ENFILER ( F , N ) ;
           FSI ;
           Level := Level + 1 ;
       FTQ
   FIN
   ACTION Rechercher ( Root , V , P , Found )
   SOIENT
       Root , P : ARB DE CHAINE ;
       V : CHAINE ;
       Found : BOOLEEN ;
   DEBUT
       Found := FAUX ;
       SI Root = NIL
           P := NIL ;
       SINON
           SI INFO ( Root ) = V
               P := Root ;
               Found := VRAI ;
           SINON
               SI V < INFO ( Root )
                   APPEL Rechercher ( FG ( Root ) , V , P , Found ) ;
               SINON
                   APPEL Rechercher ( FD ( Root ) , V , P , Found ) ;
               FSI ;
               SI ( P = NIL ) ET ( Found = FAUX )
                   P := Root ;
               FSI ;
           FSI ;
       FSI ;
   FIN
   ACTION One_word_search ( Word , C1 , C2 , C3 , R1 , R2 , R3 ) ;
   SOIENT
       Word : CHAINE ;
       C1 , C2 , C3 : CARACTERES ;
       R1 , R2 , R3 , P , Q : ARB DE CHAINE ;
       Found : BOOLEEN ;
   DEBUT
       SI ( CARACT ( Word , 1 ) = C1 ) OU ( CARACT ( Word , 1 ) = C2 ) OU ( CARACT ( Word , 1 ) = C3 )
           APPEL Rechercher ( R1 , Word , P , Found ) ;
           SI Found = VRAI
               ECRIRE ( 'Chaine trouveé dans arbre 1 !!' )
           SINON
               ECRIRE ( 'Chaine non trouvée dans arbre 1 !!' )
           FSI
       FSI ;
       SI ( CARACT ( Word , 1 ) > C1 ) OU ( CARACT ( Word , 1 ) > C2 ) OU ( CARACT ( Word , 1 ) > C3 )
           APPEL Rechercher ( R2 , Word , P , Found ) ;
           SI Found = VRAI
               ECRIRE ( 'Chaine trouvée dans arbre 2 !!' )
           SINON
               ECRIRE ( 'Chaine non trouvée dans arbre 2 !!' )
           FSI
       FSI ;
       SI ( CARACT ( Word , 1 ) <= C1 ) ET ( CARACT ( Word , 1 ) <= C2 ) ET ( CARACT ( Word , 1 ) <= C3 )
           APPEL Rechercher ( R3 , Word , P , Found ) ;
           SI Found = VRAI
               ECRIRE ( 'Chaine trouvée dans arbre 3!!' )
           SINON
               ECRIRE ( 'Chaine non trouvée dans arbre 3 !!!' )
           FSI
       FSI
   FIN
   ACTION Interval_search ( Root , Word1 , Word2 ) ;
   SOIENT
       Root : ARB DE CHAINE ;
       Word1 , Word2 : CHAINES ;
   DEBUT
       SI Root <> NIL
           APPEL Interval_search ( FG ( Root ) , Word1 , Word2 ) ;
           SI ( INFO ( Root ) >= Word1 ) ET ( INFO ( Root ) <= Word2 )
               ECRIRE ( INFO ( Root ) )
           FSI ;
           APPEL Interval_search ( FD ( Root ) , Word1 , Word2 )
       FSI
   FIN
   ACTION Range_search ( Word1 , Word2 , R1 , R2 , R3 ) ;
   SOIENT
       Word1 , Word2 : CHAINES ;
       R1 , R2 , R3 : ARB DE CHAINE ;
   DEBUT
       APPEL Interval_search ( R1 , Word1 , Word2 ) ;
       APPEL Interval_search ( R2 , Word1 , Word2 ) ;
       APPEL Interval_search ( R3 , Word1 , Word2 )
   FIN
