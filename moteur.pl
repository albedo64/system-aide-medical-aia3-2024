% R�gles
:- use_module(library(date)).
:- use_module(library(csv)).
demander_symptome(Symptome, N) :-
    write('Ressentez-vous le sympt�me suivant : '), write(Symptome), write(' ? (oui/non) '),
    read(Reponse),
    (   (Reponse = oui ; Reponse = o ; Reponse = 'Oui' ; Reponse = 'o')
    ->  poser_question_B(N)  % Si la r�ponse est oui, on r�cup�re les sympt�mes
    ;   (   (Reponse = non ; Reponse = n ; Reponse = 'Non' ; Reponse = 'n'),
            write('Sympt�me non pr�sent.'), write(N), nl
        );   writeln('R�ponse non valide. Veuillez r�pondre par "oui" ou "non".'),
            demander_symptome(Symptome, N) % Si la r�ponse n'est ni oui ni non, on redemande le sympt�me
    ).

demander_symptome_B(Symptome, N) :-
    write('Ressentez-vous aussi le sympt�me suivant : '), write(Symptome), write(' ? (oui/non) '),
    read(Reponse),
    (   (Reponse = oui ; Reponse = o ; Reponse = 'Oui' ; Reponse = 'o')
    ->  poser_question_C(N)  % Si la r�ponse est oui, on r�cup�re les sympt�mes
    ;   (   (Reponse = non ; Reponse = n ; Reponse = 'Non' ; Reponse = 'n'),
            write('Sympt�me non pr�sent.'), nl,
            writeln('Les symptomes que vous pr�sentez ne correspondent � aucune maladie dans notre base de donn�es.') % Si la r�ponse est non, on recherche les maladies
        );   writeln('R�ponse non valide. Veuillez r�pondre par "oui" ou "non".'),
            demander_symptome_B(Symptome, N) % Si la r�ponse n'est ni oui ni non, on redemande le sympt�me
    ).

demander_symptome_C(Symptome, N) :-
    write('Ressentez-vous aussi le sympt�me suivant : '), write(Symptome), write(' ? (oui/non) '),
    read(Reponse),
    (   (Reponse = oui ; Reponse = o ; Reponse = 'Oui' ; Reponse = 'o')
    ->  poser_question_D(N)  % Si la r�ponse est oui, on r�cup�re les sympt�mes
    ;   (   (Reponse = non ; Reponse = n ; Reponse = 'Non' ; Reponse = 'n'),
            write('Sympt�me non pr�sent.'), nl,
            writeln('Les symptomes que vous pr�sentez ne correspondent � aucune maladie dans notre base de donn�es.') % Si la r�ponse est non, on recherche les maladies
        );   writeln('R�ponse non valide. Veuillez r�pondre par "oui" ou "non".'),
            demander_symptome_C(Symptome, N) % Si la r�ponse n'est ni oui ni non, on redemande le sympt�me
    ).

demander_symptome_D(Symptome, N) :-
    write('Ressentez-vous aussi le sympt�me suivant : '), write(Symptome), write(' ? (oui/non) '),
    read(Reponse),
    (   (Reponse = oui ; Reponse = o ; Reponse = 'Oui' ; Reponse = 'o')
    ->  bilan(N)  % Si la r�ponse est oui, on va au bilan final
    ;   (   (Reponse = non ; Reponse = n ; Reponse = 'Non' ; Reponse = 'n'),
            write('Sympt�me non pr�sent.'), nl,
            writeln('Les symptomes que vous pr�sentez ne correspondent � aucune maladie dans notre base de donn�es.') % Si la r�ponse est non, on recherche les maladies
        );   writeln('R�ponse non valide. Veuillez r�pondre par "oui" ou "non".'),
            demander_symptome_D(Symptome, N) % Si la r�ponse n'est ni oui ni non, on redemande le sympt�me
    ).
    
info(N, M, Med) :-
    writeln('Veuillez entrer les informations suivantes pour qu\'on vous fasse un bilan de sant� : '),
    writeln('Votre nom (Ex : atangana): '),
    read(Nom),
    writeln('Votre Prenom (Ex : jean) : '),
    read(Prenom),
    writeln('Votre age (Ex : 21) : '),
    read(Age),
    verifie_entier(Age),
    writeln('Votre sexe (M/F) :'),
    read(Sex),
    (   (Sex = 'M' ; Sex = m ; Sex = 'F' ; Sex = f)
    ->  writeln('Vos informations ont �t� bien pris en compte.'),
        bilan_final(Med, Nom, Prenom, Age, Sex, M),
        writeln('Merci de toujours faire confiance � Docta.'), break
    );  (writeln('Veuillez choisir entre M(Masculin) et F(Feminin).'),
        info(N, M, Med)
    ).
    
verifie_entier(X) :-
    (   \+integer(X) ->
        write('Cet age n\'est pas correct. '),
        writeln('Veuillez entrer cette fois un age convenable.'),
        info(N, M, Med)
    );
    integer(X) -> !.

bilan_final(Med, Nom, Prenom, Age, Sex, M) :-
    open('Diagnostique.csv', append, Stream),
    writeln(Stream, 'INFORMATIONS SUR LE PATIENT'), nl(Stream),
    write(Stream, 'Nom : '), write(Stream, Nom), nl(Stream),
    write(Stream, 'Prenom : '), write(Stream, Prenom), nl(Stream),
    write(Stream, 'Age : '), write(Stream, Age), nl(Stream),
    write(Stream, 'Sexe : '), write(Stream, Sex), nl(Stream),
    write(Stream, 'Maladie : '), write(Stream, M), nl(Stream),
    write(Stream, 'Date de consultation : '), get_time(Timestamp), stamp_date_time(Timestamp, DateTime, 'local'), date_time_value(date, DateTime, Date), write(Stream, Date), nl(Stream),
    write(Stream, 'Nom du m�decin : '), write(Stream, Med), nl(Stream), nl(Stream),
    writeln(Stream, 'Merci de toujours faire confiance � Docta.'), nl(Stream),
    close(Stream),
    writeln('Votre bilan de sant� � �t� bien con�u.').

medecin(N, M) :-
    ((N = 0; N = 1; N = 2; N = 3; N = 4; N = 5; N = 6; N = 7)
    -> (writeln('Une maladie cardiovasculaire est une pathologie qui touche le c�ur et les vaisseaux sanguins. Il s\'agit de la premi�re cause de mortalit� au monde.'),nl,
        writeln('Nous vous recommendons ce cardiologue : '),
        writeln('Nom : DR. SEDE MBAKOP Prisca'), Med = "DR. SEDE MBAKOP Prisca",
        writeln('Cabinet : CENTRE MEDICAL TCHELA'),
        writeln('Adresse : Madagascar , Yaound�'),
        writeln('Consultation : 10000 FCFA'));
    (N = 8; N = 9; N = 10; N = 11)
    -> (writeln('Les maladies endocriniennes sont dues � un dysfonctionnement de la s�cr�tion d\'hormones par les glandes endocrines (thyro�de, hypothalamus, hypophyse, glandes surr�nales).'),nl,
        writeln('Nous vous recommendons cet endocrinologue : '),
        writeln('Nom : Dr. KAMGA fohom Olive'), Med = "Dr. KAMGA fohom Olive",
        writeln('Cabinet : POLYCLINIQUE DE POITIERS'),
        writeln('Adresse : Vall�e trois boutiques, deido , Douala'),
        writeln('Consultation : 15000 FCFA'));
    (N = 12; N = 13; N = 14; N = 15; N = 16; N = 17; N = 18)
    -> (writeln('Une maladie respiratoire est une maladie qui touche l\'appareil respiratoire ou qui provoque des troubles de la respiration.'),nl,
        writeln('Nous vous recommendons ce pneumologue : '),
        writeln('Nom : Dr. OUETHY Nguessie mireille'), Med = "Dr. OUETHY Nguessie mireille",
        writeln('Cabinet : ACTION CLINIQUE MOBILE INTERNATIONALE'),
        writeln('Adresse : Etoudi , Yaound�'),
        writeln('Consultation : 5000 FCFA'));
    (N = 19; N = 20; N = 21; N = 22; N = 23)
    -> (writeln('Les maladies transmissibles sont des maladies qui se propagent de personne � personne ou d\'animal � humain. ceci est du lorsque le pathog�ne (virus, bact�rie, champignons ou levures, prions, etc.) qui la provoque se propage entre humains ou animaux.'),nl,
        writeln('Nous vous recommendons cet infectiologue : '),
        writeln('Nom : Dr. BAKMANO Raissa marie josee'), Med = "Dr. BAKMANO Raissa marie josee",
        writeln('Cabinet : DOMICILE'),
        writeln('Adresse : Odza auberge bleue , Yaound�'),
        writeln('Consultation : 10000 FCFA'));
    (N = 24; N = 25; N = 26)
    -> (writeln('Une maladie mentale est un ensemble de d�r�glements au niveau des pens�es, des �motions et/ou du comportement qui refl�tent un trouble biologique, psychologique ou d�veloppemental des fonctions mentales.'),nl,
        writeln('Nous vous recommendons ce psychiatre : '),
        writeln('Nom : DR. KAMGA OLEN Jean-Pierre'), Med = "DR. KAMGA OLEN Jean-Pierre",
        writeln('Cabinet : CLINIQUE BASTOS'),
        writeln('Adresse : Nkol-eton , Yaound�'),
        writeln('Consultation : 15000 FCFA'));
    (N = 27; N = 28; N = 29; N = 30; N = 31; N = 32; N = 33)
    ->  (writeln('Les maladies de la peau (dermatoses) peuvent toucher l\'ensemble du corps et sont aussi nombreuses que leurs sympt�mes : boutons, t�ches de peau, rougeurs, transpiration excessive, ...'),nl,
        writeln('Nous vous recommendons ce dermatologue : '),
        writeln('Nom : Dr. LANDO MAKOUETE Marie Jeanne'), Med = "Dr. LANDO MAKOUETE Marie Jeanne",
        writeln('Cabinet : CLINIQUE BASTOS'),
        writeln('Adresse : Bastos , Yaound�'),
        writeln('Consultation : 10000 FCFA'));
    (N = 34; N = 35; N = 36; N = 37)
    -> (writeln('Les maladies oculaires peuvent toucher de nombreuses structures anatomiques : corn�e, iris, cristallin, vitr�, r�tine, nerf optique... Ces maladies peuvent �tre d\'origine infectieuse, inflammatoire, m�tabolique, tumorale, traumatique ou d�g�n�rative.'),nl,
        writeln('Nous vous recommendons cet ophtamologue : '),
        writeln('Nom : Dr. NYA Andr�'), Med = "Dr. NYA Andr�",
        writeln('Cabinet : JPOLYCLINIQUE TSINGA'),
        writeln('Adresse : Tsinga , Yaound�'),
        writeln('Consultation : 10000 FCFA'));
    (N = 38; N = 39; N = 40; N = 41; N = 42; N = 43; N = 44)
    -> (writeln('Le terme de rhumatologie d�signe une sp�cialit� m�dicale d�di�e au diagnostic et au traitement des troubles de l\'appareil locomoteur : c\'est-�-dire les pathologies des os, des muscles et des articulations.'),nl,
        writeln('Nous vous recommendons ce rhumatologue : '),
        writeln('Nom : Dr. AYI EFOUA Yolande Vanessa'), Med = "Dr. AYI EFOUA Yolande Vanessa",
        writeln('Cabinet : YOVA JOINT CARE'),
        writeln('Adresse : Essos , Yaound�'),
        writeln('Consultation : 15000 FCFA'));
    (N = 45; N = 46; N = 47; N = 48; N = 49; N = 50)
    -> (writeln('Les maladies neurod�g�n�ratives se caract�risent par la destruction progressive de certains neurones. Pour le moment, ces pathologies sont incurables. Elles posent un r�el probl�me de sant� publique �tant donn� leur retentissement sur les patients et sur leurs proches aidants.'),nl,
        writeln('Nous vous recommendons ce neurologue : '),
        writeln('Nom : Dr. NDOUMOU justin aime'), Med = "Dr. NDOUMOU justin aime",
        writeln('Cabinet : LIBERAL'),
        writeln('Adresse : mimboman , Yaound�'),
        writeln('Consultation : 0 FCFA'));
    (N = 51; N = 52; N = 53)
    -> (writeln('L\'h�matologie g�n�rale comprend: les maladies caus�es par une augmentation d\'un composant du sang. On distingue principalement la thrombocytose (exc�s de plaquettes sanguines), la polyglobulie (exc�s de globules rouges).'),nl,
        writeln('Nous vous recommendons cet h�matologue : '),
        writeln('Nom : Dr. EFFA Gaston'), Med = "Dr. EFFA Gaston",
        writeln('Cabinet : HOPITAL LAQUINTINIE'),
        writeln('Adresse : Akwa , Douala'),
        writeln('Consultation : 20000 FCFA'))
    ),
    info(N, M, Med).
        


% Exemple d'utilisation
:- initialization(main).
 main :-
%Les premiers sympt�mes qu'on pose au malade.
    demander_symptome("douleur thoracique intense", 0),
    demander_symptome("douleur et pression � la poitrine", 1),
    demander_symptome("essoufflement", 2),
    demander_symptome("douleur/sensibilit� � la jambe", 3),
    demander_symptome("essoufflement soudain", 4),
demander_symptome("maux de t�te fr�quents", 5),
demander_symptome("palpitations cardiaques", 6),
demander_symptome("essoufflement � l'effort", 7),
demander_symptome("soif excessive", 8),
demander_symptome("perte de poids inexpliqu�e", 9),
demander_symptome("fatigue", 10),
demander_symptome("prise de poids excessive", 11),
demander_symptome("respiration sifflante", 12),
demander_symptome("toux productive", 13),
% demander_symptome(essoufflement, 14),
demander_symptome("ronflements forts", 15),
demander_symptome("fi�vre", 16),
demander_symptome("congestion nasale", 17),
% demander_symptome("congestion nasale", 18),
% demander_symptome("fi�vre", 19),
% demander_symptome("fatigue", 20),
% demander_symptome("fatigue", 21),
demander_symptome("�ruption cutan�e", 22),
demander_symptome("toux persistante", 23),
demander_symptome("tristesse persistante", 24),
demander_symptome("hallucinations", 25),
demander_symptome("�pisodes maniaques", 26),
demander_symptome("points noirs", 27),
demander_symptome("d�mangeaisons cutan�es", 28),
demander_symptome("�ruptions cutan�es", 29),
demander_symptome("plaques rouges �paisses", 30),
demander_symptome("d�pigmentation de la peau", 31),
demander_symptome("�ruption cutan�e douloureuse", 32),
demander_symptome("cloques group�es", 33),
demander_symptome("vision brouill�e", 34),
demander_symptome("vision floue", 35),
% demander_symptome("vision floue", 36),
% demander_symptome("vision floue", 37),
demander_symptome("douleur articulaire", 38),
demander_symptome("douleur soutenue du bas du dos", 39),
demander_symptome("douleur irradiante dans une jambe", 40),
demander_symptome("douleur du bas du dos", 41),
demander_symptome("douleur locale", 42),
demander_symptome("fractures osseuses fr�quentes", 43),
demander_symptome("courbure anormale de la colonne vert�brale", 44),
demander_symptome("fatigue excessive", 45),
demander_symptome("douleur de t�te constante ou r�currente", 46),
demander_symptome("convulsions ou crises �pileptiques", 47),
demander_symptome("perte de m�moire", 48),
% demander_symptome("perte de m�moire", 49),
demander_symptome("engourdissement ou faiblesse d'un c�t� du corps", 50),
demander_symptome("fatigue persistante", 51),
demander_symptome("ganglions lymphatiques enfl�s", 52),
demander_symptome("infections fr�quentes", 53).

poser_question_B(N) :-
    ( N = 0 -> demander_symptome_B("essoufflement", N);
    N = 1 -> demander_symptome_B("essoufflement", N);
    N = 2 -> (demander_symptome_B("fatigue", N); demander_symptome_B("toux chronique", 14));
    N = 3 -> demander_symptome_B("gonflement rougeur jambe", N);
N = 4 -> demander_symptome_B("douleur thoracique", N);
N = 5 -> demander_symptome_B("vertiges", N);
N = 6 -> demander_symptome_B("battements cardiaques rapides lents", N);
N = 7 -> demander_symptome_B("fatigue", N);
N = 8 -> demander_symptome_B("augmentation app�tit", N);
N = 9 -> demander_symptome_B("augmentation app�tit", N);
N = 10 -> (demander_symptome_B("prise poids inexpliqu�e", N); demander_symptome_B("jaunisse", 20));
N = 11 -> demander_symptome_B("difficult� mouvements", N);
N = 12 -> demander_symptome_B("oppression thoracique", N);
N = 13 -> demander_symptome_B("essoufflement", N);
% N = 14 -> demander_symptome_B("toux chronique", N);
N = 15 -> demander_symptome_B("somnolence diurne", N);
N = 16 -> (demander_symptome_B("toux", N); demander_symptome_B("fatigue", 19));
N = 17 -> (demander_symptome_B("�ternuements fr�quents", N); demander_symptome_B("douleur faciale", 18));
% N = 18 -> demander_symptome_B(douleur_faciale, N);
% N = 19 -> demander_symptome_B(fatigue, N);
% N = 20 -> demander_symptome_B(jaunisse, N);
% N = 21 -> demander_symptome_B(jaunisse, N);
N = 22 -> demander_symptome_B("fi�vre", N);
N = 23 -> demander_symptome_B("fi�vre", N);
N = 24 -> demander_symptome_B("perte int�r�t activit�s", N);
N = 25 -> demander_symptome_B("d�lires", N);
N = 26 -> demander_symptome_B("�pisodes d�pressifs", N);
N = 27 -> demander_symptome_B("boutons inflammatoires", N);
N = 28 -> demander_symptome_B("rougeurs", N);
N = 29 -> demander_symptome_B("d�mangeaisons intenses", N);
N = 30 -> demander_symptome_B("desquamation", N);
N = 31 -> demander_symptome_B("taches blanches", N);
N = 32 -> demander_symptome_B("douleur locale intense", N);
N = 33 -> demander_symptome_B("d�mangeaisons cutan�es", N);
N = 34 -> demander_symptome_B("vision p�riph�rique r�duite", N);
N = 35 -> (demander_symptome_B("sensibilit� � la lumi�re", N); demander_symptome_B("vision d�form�e", 36); demander_symptome_B("vision d�form�e", 37));
% N = 36 -> demander_symptome_B(vision_deformee, N);
% N = 37 -> demander_symptome_B(vision_deformee, N);
N = 38 -> demander_symptome_B("raideur articulaire", N);
N = 39 -> demander_symptome_B("douleur irradiant dans les jambes", N);
N = 40 -> demander_symptome_B("douleur aigu� dans les fesses ou les jambes", N);
N = 41 -> demander_symptome_B("raideur du bas du dos", N);
N = 42 -> demander_symptome_B("douleur augmentant avec activit�", N);
N = 43 -> demander_symptome_B("diminution de la taille", N);
N = 44 -> demander_symptome_B("asym�trie des �paules ou des hanches", N);
N = 45 -> demander_symptome_B("faiblesse musculaire", N);
N = 46 -> demander_symptome_B("sensibilit� � la lumi�re ou au bruit", N);
N = 47 -> demander_symptome_B("perte de conscience ou absences", N);
N = 48 -> demander_symptome_B("difficult�s de langage", N);
% N = 49 -> demander_symptome_B("difficult�s de langage", N);
N = 50 -> demander_symptome_B("difficult� � parler ou � comprendre", N);
N = 51 -> demander_symptome_B("perte de poids", N);
N = 52 -> demander_symptome_B("sueurs nocturnes", N);
N = 53 -> demander_symptome_B("infections graves ou r�currentes", N)).

poser_question_C(N) :-
    (N = 0 -> demander_symptome_C("transpiration excessive", N);
N = 1 -> demander_symptome_C("fatigue", N);
N = 2 -> demander_symptome_C("�d�me jambes chevilles", N);
    N = 3 -> demander_symptome_C("chaleur au toucher", N);
N = 4 -> demander_symptome_C("battements cardiaques rapides", N);
N = 5 -> demander_symptome_C("essoufflement", N);
N = 6 -> demander_symptome_C("�tourdissements", N);
N = 7 -> demander_symptome_C("palpitations cardiaques", N);
N = 8 -> demander_symptome_C("mictions fr�quentes", N);
N = 9 -> demander_symptome_C("nervosit�", N);
N = 10 -> demander_symptome_C("frilosit�", N);
N = 11 -> demander_symptome_C("essoufflement", N);
N = 12 -> demander_symptome_C("toux", N);
N = 13 -> demander_symptome_C("fatigue", N);
N = 14 -> demander_symptome_C("fatigue", N);
N = 15 -> demander_symptome_C("fatigue", N);
    N = 16 -> demander_symptome_C("essoufflement", N);
N = 17 -> demander_symptome_C("�coulement nasal post�rieur", N);
N = 18 -> demander_symptome_C("�coulement nasal post�rieur", N);
N = 19 -> demander_symptome_C("perte de poids inexpliqu�e", N);
N = 20 -> demander_symptome_C("douleurs abdominales", N);
% N = 21 -> demander_symptome_C("douleurs abdominales", N);
N = 22 -> demander_symptome_C("fatigue", N);
N = 23 -> demander_symptome_C("perte de poids inexpliqu�e", N);
N = 24 -> demander_symptome_C("changements d'app�tit", N);
N = 25 -> demander_symptome_C("troubles de la pens�e", N);
N = 26 -> demander_symptome_C("fluctuations d'humeur", N);
N = 27 -> demander_symptome_C("peau grasse", N);
N = 28 -> demander_symptome_C("plaques s�ches", N);
N = 29 -> demander_symptome_C("plaques rouges", N);
N = 30 -> demander_symptome_C("d�mangeaisons cutan�es", N);
N = 31 -> demander_symptome_C("perte de couleur des cheveux", N);
N = 32 -> demander_symptome_C("picotements ou br�lures cutan�es", N);
    N = 33 -> demander_symptome_C("sensation de br�lure", N);
N = 34 -> demander_symptome_C("douleur oculaire", N);
N = 35 -> demander_symptome_C("vision diminu�e", N);
N = 36 -> demander_symptome_C("vision diminu�e", N);
N = 37 -> demander_symptome_C("vision diminu�e", N);
N = 38 -> demander_symptome_C("enflure articulaire", N);
N = 39 -> demander_symptome_C("engourdissement ou faiblesse des jambes", N);
N = 40 -> demander_symptome_C("engourdissement ou faiblesse dans les jambes", N);
N = 41 -> demander_symptome_C("douleur aggravant avec le mouvement", N);
N = 42 -> demander_symptome_C("raideur des tissus mous", N);
N = 43 -> demander_symptome_C("dos vo�t�", N);
N = 44 -> demander_symptome_C("douleur du dos", N);
N = 45 -> demander_symptome_C("troubles de l'�quilibre et de la coordination", N);
N = 46 -> demander_symptome_C("naus�es ou vomissements", N);
N = 47 -> demander_symptome_C("mouvements incontr�l�s des membres", N);
N = 48 -> demander_symptome_C("troubles d'orientation", N);
% N = 49 -> demander_symptome_C("troubles d'orientation", N);
N = 50 -> demander_symptome_C("troubles de la vision d'un c�t�", N);
N = 51 -> demander_symptome_C("saignements anormaux", N);
N = 52 -> demander_symptome_C("fi�vre", N);
N = 53 -> demander_symptome_C("gu�rison lente des infections", N)).

poser_question_D(N) :-
    (N = 0 -> demander_symptome_D("naus�es et vomissements", N);
N = 1 -> demander_symptome_D("douleurs irradiant des bras et de la m�choire", N);
N = 2 -> demander_symptome_D("prise de poids rapide", N);
    N = 3 -> demander_symptome_D("veines visibles et tendues", N);
N = 4 -> demander_symptome_D("toux avec sang ou crachats sanglants", N);
N = 5 -> demander_symptome_D("fatigue", N);
N = 6 -> demander_symptome_D("�vanouissement", N);
N = 7 -> demander_symptome_D("gonflement des chevilles et des jambes", N);
N = 8 -> demander_symptome_D("perte de poids inexpliqu�e", N);
N = 9 -> demander_symptome_D("tremblements", N);
N = 10 -> demander_symptome_D("peau s�che", N);
N = 11 -> demander_symptome_D("fatigue", N);
N = 12 -> demander_symptome_D("essoufflement", N);
N = 13 -> demander_symptome_D("sensation d'oppression thoracique", N);
N = 14 -> demander_symptome_D("perte de poids inexpliqu�e", N);
N = 15 -> demander_symptome_D("r�veils fr�quents pendant la nuit", N);
N = 16 -> demander_symptome_D("douleur thoracique", N);
N = 17 -> demander_symptome_D("d�mangeaisons nasales", N);
    N = 18 -> demander_symptome_D("maux de t�te", N);
N = 19 -> demander_symptome_D("ganglions lymphatiques enfl�s", N);
N = 20 -> (demander_symptome_D("perte d'app�tit", N); demander_symptome_D("urines fonc�es", 21));
N = 21 -> demander_symptome_D("urines fonc�es", N);
N = 22 -> demander_symptome_D("douleurs articulaires", N);
N = 23 -> demander_symptome_D("fatigue", N);
N = 24 -> demander_symptome_D("troubles du sommeil", N);
N = 25 -> demander_symptome_D("retrait social", N);
N = 26 -> demander_symptome_D("�nergie excessive", N);
N = 27 -> demander_symptome_D("cicatrices", N);
N = 28 -> demander_symptome_D("desquamation", N);
N = 29 -> demander_symptome_D("enflure cutan�e", N);
N = 30 -> demander_symptome_D("ongles �pais ou cassants", N);
N = 31 -> demander_symptome_D("sensibilit� au soleil", N);
N = 32 -> demander_symptome_D("sensibilit� cutan�e", N);
N = 33 -> demander_symptome_D("douleur locale", N);
N = 34 -> demander_symptome_D("vision tunnel", N);
N = 35 -> demander_symptome_D("vision double", N);
N = 36 -> demander_symptome_D("taches sombres dans le champ visuel", N);
N = 37 -> demander_symptome_D("vision double", N);
N = 38 -> demander_symptome_D("diminution de la mobilit� articulaire", N);
N = 39 -> demander_symptome_D("diminution de la sensation cutan�e", N);
N = 40 -> demander_symptome_D("sensation de picotements ou de br�lures", N);
N = 41 -> demander_symptome_D("douleur aggravant avec l'effort physique", N);
N = 42 -> demander_symptome_D("faiblesse musculaire locale", N);
N = 43 -> demander_symptome_D("douleur osseuse", N);
N = 44 -> demander_symptome_D("fatigue du dos lors de la position debout prolong�e", N);
N = 45 -> demander_symptome_D("probl�mes de vision", N);
N = 46 -> demander_symptome_D("troubles de la vision", N);
N = 47 -> demander_symptome_D("sensations anormales ou aura �pileptique", N);
N = 48 -> demander_symptome_D("changements de comportement et d'humeur", N);
%     N = 49 -> demander_symptome_D("changements de comportement et humeur", N);
N = 50 -> demander_symptome_D("perte de equilibre ou de la coordination", N);
N = 51 -> demander_symptome_D("douleurs osseuses", N);
N = 52 -> demander_symptome_D("perte de poids inexpliquee", N);
N = 53 -> demander_symptome_D("infections opportunistes", N)).
    
bilan(N) :-
    (N = 0 -> (write('Vous souffrez d\'un infarctus du myocarde'), M = "infarctus du myocarde");
N = 1 -> (write('Vous souffrez d\'une angine de la poitrine'), M = "angine de la poitrine");
N = 2 -> (write('Vous souffrez d\'une insuffisance cardiaque'), M = "insuffisance cardiaque");
N = 3 -> (write('Vous souffrez d\'une phl�bite'), M = "phl�bite");
N = 4 -> (write('Vous souffrez d\'une embolie pulmonaire'), M = "embolie pulmonaire");
N = 5 -> (write('Vous souffrez d\'une hypertension art�rielle'), M = "hypertension art�rielle");
N = 6 -> (write('Vous avez des troubles du rythme cardiaque'), M = "troubles du rythme cardiaque");
N = 7 -> (write('Vous souffrez d\'une valvulopathie'), M = "valvulopathie");
N = 8 -> (write('Vous avez le diab�te'), M = "diab�te");
N = 9 -> (write('Vous souffrez d\'une hyperthyro�die'), M = "hyperthyro�die");
N = 10 -> (write('Vous souffrez d\'une hypothyro�die'), M = "hypothyro�die");
N = 11 -> (write('Vous souffrez d\'ob�sit�'), M = "ob�sit�");
N = 12 -> (write('Vous avez de l\'asthme'), M = "asthme");
N = 13 -> (write('Vous souffrez d\'une bronchite chronique'), M = "bronchite chronique");
N = 14 -> (write('Vous souffrez d\'emphys�me'), M = "emphys�me");
N = 15 -> (write('Vous souffrez d\'une apn�e du sommeil'), M = "apn�e du sommeil");
N = 16 -> (write('Vous souffrez d\'une pneumopathie'), M = "pneumopathie");
N = 17 -> (write('Vous souffrez d\'une rhinite chronique'), M = "rhinite chronique");
N = 18 -> (write('Vous souffrez d\'une sinusite chronique'), M = "sinusite chronique");
N = 19 -> (write('Vous souffrez du VIH/SIDA'), M = "VIH/SIDA");
N = 20 -> (write('Vous souffrez d\'une h�patite C'), M = "h�patite C");
N = 21 -> (write('Vous souffrez d\'une h�patite B'), M = "h�patite B");
N = 22 -> (write('Vous �tes atteint de la maladie de Lyme'), M = "maladie de Lyme");
N = 23 -> (write('Vous souffrez de la tuberculose'), M = "tuberculose");
N = 24 -> (write('Vous souffrez d\'une d�pression'), M = "d�pression");
N = 25 -> (write('Vous souffrez d\'une schizophr�nie'), M = "schizophr�nie");
N = 26 -> (write('Vous avez des troubles bipolaires'), M = "troubles bipolaires");
N = 27 -> (write('Vous avez de l\'acn�'), M = "acn�");
N = 28 -> (write('Vous avez de l\'ecz�ma'), M = "ecz�ma");
N = 29 -> (write('Vous avez de l\'urticaire'), M = "urticaire");
N = 30 -> (write('Vous avez du psoriasis'), M = "psoriasis");
N = 31 -> (write('Vous avez du vitiligo'), M = "vitiligo");
N = 32 -> (write('Vous avez le zona'), M = "zona");
N = 33 -> (write('Vous �tes atteint de l\'herp�s'), M = "herp�s");
N = 34 -> (write('Vous �tes atteint du glaucome'), M = "glaucome");
N = 35 -> (write('Vous �tes atteint de la cataracte'), M = "cataracte");
N = 36 -> (write('Vous �tes atteint de laretinopathie'), M = "retinopathie");
N = 37 -> (write('Vous avez des troubles de vision'), M = "troubles de vision");
N = 38 -> (write('Vous �tes atteint de l\'arthrose'), M = "arthrose");
N = 39 -> (write('Vous avez une hernie discale'), M = "hernie discale");
N = 40 -> (write('Vous avez la sciatique'), M = "sciatique");
N = 41 -> (write('Vous avez la lombalgie'), M = "lombalgie");
N = 42 -> (write('Vous �tes atteint de tendinite chronique'), M = "tendinite chronique");
N = 43 -> (write('Vous �tes atteint de l\'ost�oporose'), M = "ost�oporose");
N = 44 -> (write('Vous avez la scoliose'), M = "scoliose");
N = 45 -> (write('Vous avez la scl�rose en plaques'), M = "scl�rose en plaques");
N = 46 -> (write('Vous avez des c�phal�es chroniques'), M = "c�phal�es chroniques");
N = 47 -> (write('Vous �tes atteint d\'�pilepsie'), M = "�pilepsie");
N = 48 -> (write('Vous �tes atteint d\'Alzheimer'), M = "Alzheimer");
N = 49 -> (write('Vous souffrez de d�mence'), M = "d�mence'");
N = 50 -> (write('Vous �tes atteint d\'AVC'), M = "AVC");
N = 51 -> (write('Vous souffrez de leuc�mie'), M = "leuc�mie");
N = 52 -> (write('Vous avez le lymphome'), M = "lymphome");
N = 53 -> (write('Vous souffrez d\'un d�ficit immunitaire'), M = "d�ficit immunitaire")
),nl,
medecin(N, M).
