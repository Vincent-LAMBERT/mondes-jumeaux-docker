-- DATABASES

CREATE DATABASE IF NOT EXISTS TwinWorlds;

-- USERS

GRANT ALL PRIVILEGES ON TwinWorlds.* TO 'TwinWorldsUser'@'%' IDENTIFIED BY 'Zordlon';

FLUSH PRIVILEGES;

USE TwinWorlds;

-- Race

CREATE TABLE Races
(
    NomRace             VARCHAR(30),
    DescriptionRace     VARCHAR(500),
    ImgRace             VARCHAR(250),
    CaCRace             INT,
    DistanceRace        INT,
    MagieRace           INT,
    EsRace              INT,
    PvRace              INT,
    EsperanceVie        INT,
    NatureRace          VARCHAR(20),
    TailleMoy           FLOAT,
    MasseMoy            INT,
    Sexes               VARCHAR(10),
    PRIMARY KEY(NomRace),
    CONSTRAINT Taille_Min_NomRace       CHECK (CHAR_LENGTH(NomRace)>2),
    CONSTRAINT Nature_connue       CHECK (NatureRace IN('Divine', 'Démoniaque', 'Divine/Démoniaque')),
    CONSTRAINT EsperanceVie_pos       CHECK (EsperanceVie >= 0),
    CONSTRAINT TailleMoy_pos       CHECK (TailleMoy >= 0),
    CONSTRAINT MasseMoy_pos       CHECK (MasseMoy >= 0),
    CONSTRAINT CaCRace_min       CHECK (CaCRace >= 35),
    CONSTRAINT DistanceRace_min       CHECK (DistanceRace >= 35),
    CONSTRAINT MagieRace_min       CHECK (MagieRace >= 35),
    CONSTRAINT CaCRace_max       CHECK (CaCRace <= 60),
    CONSTRAINT DistanceRace_max       CHECK (DistanceRace <= 60),
    CONSTRAINT MagieRace_max       CHECK (MagieRace <= 60),
    CONSTRAINT sexes_connus       CHECK (Sexes IN('MFI', 'M', 'F'))
);

-- Competences

CREATE TABLE Competences
(
    NomComp             VARCHAR(50),
    CompType            VARCHAR(50),
    ImgComp             VARCHAR(250),
    PRIMARY KEY(NomComp),
    CONSTRAINT type_comp       CHECK (CompType IN('Commune', 'Non-Commune'))
);

CREATE TABLE Ethnies
(
    NomEthnie           VARCHAR(30),
    ImgEthnie           VARCHAR(250),
    DescriptionEthnie   VARCHAR(200),
    NomRace                VARCHAR(30),
    NomComp             VARCHAR(50),
    PRIMARY KEY(NomEthnie),
    CONSTRAINT Taille_Min_NomEthnie       CHECK (CHAR_LENGTH(NomEthnie)>2),
    CONSTRAINT ethnie_pour_race                 FOREIGN KEY (NomRace)               REFERENCES Races(NomRace)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT comp_pour_ethnie                 FOREIGN KEY (NomComp)            REFERENCES Competences(NomComp)             ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE CapacitesSpeciales
(
    CapSpec             VARCHAR(80),
    Equiv               INT,
    BonusArmureNat      INT,
    DescriptionCap      VARCHAR(500),
    CONSTRAINT Taille_Min_CapSpec       CHECK (CHAR_LENGTH(CapSpec)>2),
    CONSTRAINT Taille_Min_DescriptionCap       CHECK (CHAR_LENGTH(DescriptionCap)>10),
    PRIMARY KEY(CapSpec)
);

-- Personnage

CREATE TABLE Personnages
(
    Nom                 VARCHAR(30),
    Prenoms             VARCHAR(30),
    Sexe                VARCHAR(30),
    Genre               VARCHAR(30),
    Nature              VARCHAR(30),
    Age                 INT,
    Niveau              INT,
    Taille              FLOAT,
    Masse               FLOAT,
    Religion            VARCHAR(80),
    Specialisation      VARCHAR(80),
    Histoire            VARCHAR(5000),
    PNEs                INT,
    PNPv                INT,
    BonusFac            INT,
    BonusPos            INT,
    BonusBrut           INT,
    BonusPG             INT,
    SecondSouffle       INT,
    ArmureNat           INT,
    Ecus                INT,
    Parade              INT,
    Esquive             INT,
    Mental              INT,
    ModCaC              INT,
    ModDistance         INT,
    ModMagie            INT,
    ImgPerso            VARCHAR(250),
    Ethnie              VARCHAR(80),
    PRIMARY KEY(Nom, Prenoms),
    CONSTRAINT perso_a_ethnie                   FOREIGN KEY (Ethnie)                REFERENCES Ethnies(NomEthnie)           ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT sexe_connu      CHECK(Sexe IN ('M', 'F', 'MFI')),
    CONSTRAINT nature_simple       CHECK (Nature IN('Divine', 'Démoniaque')),
    CONSTRAINT ModCaC_min       CHECK (ModCaC >= -20),
    CONSTRAINT ModDistance_min       CHECK (ModDistance >= -20),
    CONSTRAINT ModMagie_min       CHECK (ModMagie >= -20),
    CONSTRAINT ModCaC_max       CHECK (ModCaC <= 20),
    CONSTRAINT ModDistance_max       CHECK (ModDistance <= 20),
    CONSTRAINT ModMagie_max       CHECK (ModMagie <= 20),
    CONSTRAINT age_pos       CHECK (Age >= 0),
    CONSTRAINT Niveau_pos       CHECK (Niveau >= 0),
    CONSTRAINT Taille_pos       CHECK (Taille >= 0),
    CONSTRAINT Masse_pos       CHECK (Masse >= 0),
    CONSTRAINT PNEs_pos       CHECK (PNEs >= 0),
    CONSTRAINT PNPv_pos       CHECK (PNPv >= 0),
    CONSTRAINT SS_pos       CHECK (SecondSouffle >= 0),
    CONSTRAINT ArmureNat_pos       CHECK (ArmureNat >= 0),
    CONSTRAINT Ecus_pos       CHECK (Ecus >= 0),
    CONSTRAINT Parade_pos       CHECK (Parade >= 0),
    CONSTRAINT Esquive_pos       CHECK (Esquive >= 0),
    CONSTRAINT Mental_pos       CHECK (Mental >= 0)
);

-- Themes

CREATE TABLE Themes
(
    Theme               VARCHAR(50),
    DescriptionTheme    VARCHAR(500),
    PRIMARY KEY(Theme),
    CONSTRAINT Taille_Min_Theme       CHECK (CHAR_LENGTH(Theme)>2)
);

-- Langues

CREATE TABLE Langues
(
    Langue              VARCHAR(50),
    DescriptionLangue   VARCHAR(500),
    PRIMARY KEY(Langue),
    CONSTRAINT Taille_Min_Langue       CHECK (CHAR_LENGTH(Langue)>2)
);

-- FacultesPostures

CREATE TABLE FacultesPostures
(
    NomFacPos           VARCHAR(80),
    Stade               VARCHAR(80),
    DescriptionFP       VARCHAR(500),
    CONSTRAINT Taille_Min_NomFP       CHECK (CHAR_LENGTH(NomFacPos)>3),
    CONSTRAINT Stade_connu      CHECK(Stade IN ('Posture additionnelle', 'Faculté de stade 1', 'Faculté de stade 2', 'Faculté de stade 3')),
    CONSTRAINT Taille_Min_DescriptionFP       CHECK (CHAR_LENGTH(DescriptionFP)>2),
    PRIMARY KEY(NomFacPos)
);

-- TypeBonus

CREATE TABLE TypeBonus
(
    TypeBonus           VARCHAR(50),
    Visible             BOOLEAN,
    PRIMARY KEY(TypeBonus),
    CONSTRAINT Taille_Min_TypeBonus       CHECK (CHAR_LENGTH(TypeBonus)>2)
);

-- Orientations

CREATE TABLE Orientations
(
    NomOrientation      VARCHAR(50),
    DescOrient          VARCHAR(500),
    TypeOrient          VARCHAR(50),
    Complement          VARCHAR(50),
    BoolComplement      BOOLEAN,
    ImgOrient           VARCHAR(250),
    PRIMARY KEY(NomOrientation),
    CONSTRAINT type_connu      CHECK(TypeOrient IN ("Maîtrise d'Arme", "Magie", "Formation")),
    CONSTRAINT Taille_Min_NomOrientation       CHECK (CHAR_LENGTH(NomOrientation)>2)
);


CREATE TABLE StylesCombat
(
    NomStyle            VARCHAR(50),
    ImgStyle            VARCHAR(50),
    PRIMARY KEY(NomStyle)
);

CREATE TABLE Organisations
(
    TypeOrga            VARCHAR(50),
    NomOrga             VARCHAR(50),
    MondeOrga           VARCHAR(50),
    ImgOrga             VARCHAR(250),
    DescriptionOrga     VARCHAR(500),
    SystemOrga          VARCHAR(50),
    AvisHomosex         VARCHAR(50),
    AvisBisex           VARCHAR(50),
    AvisTrans           VARCHAR(50),
    AvisPolya           VARCHAR(50),
    AvisAge             VARCHAR(50),
    PRIMARY KEY(TypeOrga, NomOrga),
    CONSTRAINT Taille_Min_NomOrga       CHECK (CHAR_LENGTH(NomOrga)>2),
    CONSTRAINT MondeOrga_Connu      CHECK(MondeOrga IN ("Isylgräm", "Jukingräm")),
    CONSTRAINT Taille_Min_DescriptionOrga       CHECK (CHAR_LENGTH(DescriptionOrga)>2),
    CONSTRAINT AvisHomosex_connu      CHECK(AvisHomosex IN ("Normalisée", "Tolérée", "Prohibée", "Criminalisée")),
    CONSTRAINT AvisBisex_connu      CHECK(AvisBisex IN ("Normalisée", "Tolérée", "Prohibée", "Criminalisée")),
    CONSTRAINT AvisTrans_connu      CHECK(AvisTrans IN ("Normalisée", "Tolérée", "Prohibée", "Criminalisée")),
    CONSTRAINT AvisPolya_connu      CHECK(AvisPolya IN ("Normalisée", "Tolérée", "Prohibée", "Criminalisée")),
    CONSTRAINT AvisAge_connu      CHECK(AvisAge IN ("Normalisée", "Tolérée", "Prohibée", "Criminalisée"))
);

CREATE TABLE Animaux 
(
    NomAnimal           VARCHAR(50),
    TypeAnimal          VARCHAR(50),
    DescriptionAnimal   VARCHAR(500),
    ImgAnimal           VARCHAR(250),
    CaCAnimal           INT,
    DistanceAnimal      INT,
    MagieAnimal         INT,
    EsAnimal            INT,
    PvAnimal            INT,
    ArmureNatAnimal     INT,
    EsperanceVieAnimal  INT,
    NatureAnimal        VARCHAR(20),
    TailleMoyAnimal     FLOAT,
    MasseMoyAnimal      INT,
    PRIMARY KEY(NomAnimal),
    CONSTRAINT Taille_Min_NomAnimal       CHECK (CHAR_LENGTH(NomAnimal)>2),
    CONSTRAINT Taille_Min_TypeAnimal       CHECK (CHAR_LENGTH(NomAnimal)>2),
    CONSTRAINT Type_MondeAnimal_Connu      CHECK(TypeAnimal IN ("Isylgräm", "Jukingräm")),
    CONSTRAINT CaCAnimal_min       CHECK (CaCAnimal >= 10),
    CONSTRAINT DistanceAnimal_min       CHECK (DistanceAnimal >= 10),
    CONSTRAINT MagieAnimal_min       CHECK (MagieAnimal >= 10),
    CONSTRAINT CaCAnimal_max       CHECK (CaCAnimal <= 90),
    CONSTRAINT DistanceAnimal_max       CHECK (DistanceAnimal <= 90),
    CONSTRAINT MagieAnimal_max       CHECK (MagieAnimal <= 90),
    CONSTRAINT EsperanceVieAnimal_pos       CHECK (EsperanceVieAnimal >= 0),
    CONSTRAINT PvAnimal_pos       CHECK (PvAnimal >= 0),
    CONSTRAINT EsAnimal_pos       CHECK (EsAnimal >= 0),
    CONSTRAINT ArmureNatAnimal_pos       CHECK (ArmureNatAnimal >= 0),
    CONSTRAINT TailleMoyAnimal_pos       CHECK (TailleMoyAnimal >= 0),
    CONSTRAINT MasseMoyAnimal_pos       CHECK (MasseMoyAnimal >= 0)
);

CREATE TABLE Plantes 
(
    NomPlante           VARCHAR(50),
    TypePlante          VARCHAR(50),
    DescriptionPlante   VARCHAR(500),
    ImgPlante           VARCHAR(250),
    PRIMARY KEY(NomPlante),
    CONSTRAINT Taille_Min_NomPlante       CHECK (CHAR_LENGTH(NomPlante)>2),
    CONSTRAINT Type_MondePlante_Connu      CHECK(TypePlante IN ("Isylgräm", "Jukingräm"))
);

-- RELATIONS ENTRE ENTITES

CREATE TABLE MagiesPartielles
(
    NomMagiePartielle         VARCHAR(50),
    NomMagie                  VARCHAR(50),
    PRIMARY KEY(NomMagiePartielle, NomMagie),
    CONSTRAINT magie_partielle_dans_orient      FOREIGN KEY (NomMagiePartielle)           REFERENCES Orientations(NomOrientation)      ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT magie_dans_orient_partielle                FOREIGN KEY (NomMagie)               REFERENCES Orientations(NomOrientation)      ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE MagiesFusionnees
(
    NomMagieFusionnee         VARCHAR(50),
    NomMagie                  VARCHAR(50),
    NomMagieBis               VARCHAR(50),
    PRIMARY KEY(NomMagieFusionnee, NomMagie, NomMagieBis),
    CONSTRAINT magie_fusionnee_dans_orient      FOREIGN KEY (NomMagieFusionnee)           REFERENCES Orientations(NomOrientation)      ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT magie_dans_orient                FOREIGN KEY (NomMagie)               REFERENCES Orientations(NomOrientation)      ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT magie_bis_dans_orient            FOREIGN KEY (NomMagieBis)               REFERENCES Orientations(NomOrientation)      ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE CapsRace
(
    NomRace             VARCHAR(30),
    CapSpec             VARCHAR(80),
    PRIMARY KEY(NomRace, CapSpec),
    CONSTRAINT races_connues_ayant_cap          FOREIGN KEY (NomRace)               REFERENCES Races(NomRace)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT cap_de_race                      FOREIGN KEY (CapSpec)               REFERENCES CapacitesSpeciales(CapSpec)      ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE OrientPerso
(
    Nom                 VARCHAR(30),
    Prenoms             VARCHAR(30),
    NomOrientation      VARCHAR(50),
    PRIMARY KEY(Nom, Prenoms, NomOrientation),
    CONSTRAINT perso_ayant_orient_nom                FOREIGN KEY (Nom, Prenoms)               REFERENCES Personnages(Nom, Prenoms)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT orient_pour_perso                 FOREIGN KEY (NomOrientation)        REFERENCES Orientations(NomOrientation)                   ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE OrientAnimaux
(
    NomAnimal           VARCHAR(30),
    NomOrientation      VARCHAR(50),
    PRIMARY KEY(NomAnimal, NomOrientation),
    CONSTRAINT animal_ayant_orient_nom                FOREIGN KEY (NomAnimal)               REFERENCES Animaux(NomAnimal)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT orient_pour_animal                 FOREIGN KEY (NomOrientation)        REFERENCES Orientations(NomOrientation)                   ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE OrientPlantes
(
    NomPlante           VARCHAR(30),
    NomOrientation      VARCHAR(50),
    PRIMARY KEY(NomPlante, NomOrientation),
    CONSTRAINT plante_ayant_orient_nom                FOREIGN KEY (NomPlante)               REFERENCES Plantes(NomPlante)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT orient_pour_plante                 FOREIGN KEY (NomOrientation)        REFERENCES Orientations(NomOrientation)                   ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE ThemesPerso
(
    Nom                 VARCHAR(30),
    Prenoms             VARCHAR(30),
    Theme               VARCHAR(50),
    PRIMARY KEY(Nom, Prenoms, Theme),
    CONSTRAINT perso_ayant_theme_nom                FOREIGN KEY (Nom, Prenoms)               REFERENCES Personnages(Nom, Prenoms)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT theme_pour_perso                 FOREIGN KEY (Theme)        REFERENCES Themes(Theme)                   ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE LanguesPerso
(
    Nom                 VARCHAR(30),
    Prenoms             VARCHAR(30),
    Langue              VARCHAR(50),
    PRIMARY KEY(Nom, Prenoms, Langue),
    CONSTRAINT perso_ayant_langue_nom                FOREIGN KEY (Nom, Prenoms)               REFERENCES Personnages(Nom, Prenoms)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT langue_pour_perso                 FOREIGN KEY (Langue)        REFERENCES Langues(Langue)                   ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE LanguesOrganisations
(
    TypeOrga            VARCHAR(50),
    NomOrga             VARCHAR(50),
    Langue              VARCHAR(50),
    PRIMARY KEY(TypeOrga, NomOrga, Langue),
    CONSTRAINT orga_ayant_langue_nom                FOREIGN KEY (TypeOrga, NomOrga)               REFERENCES Organisations(TypeOrga, NomOrga)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT langue_pour_orga                 FOREIGN KEY (Langue)        REFERENCES Langues(Langue)                   ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE FacPosPerso
(
    Nom                 VARCHAR(30),
    Prenoms             VARCHAR(30),
    NomFacPos            VARCHAR(80),
    PRIMARY KEY(Nom, Prenoms, NomFacPos),
    CONSTRAINT perso_ayant_FP_nom                FOREIGN KEY (Nom, Prenoms)               REFERENCES Personnages(Nom, Prenoms)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT FP_pour_perso                 FOREIGN KEY (NomFacPos)        REFERENCES FacultesPostures(NomFacPos)                   ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE CapSpecPerso
(
    Nom                 VARCHAR(30),
    Prenoms             VARCHAR(30),
    CapSpec             VARCHAR(80),
    PRIMARY KEY(Nom, Prenoms, CapSpec),
    CONSTRAINT perso_ayant_capspec_nom                FOREIGN KEY (Nom, Prenoms)               REFERENCES Personnages(Nom, Prenoms)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT cap_de_perso                      FOREIGN KEY (CapSpec)               REFERENCES CapacitesSpeciales(CapSpec)      ON DELETE CASCADE      ON UPDATE CASCADE
);


-- Relation des compétences

CREATE TABLE CompPerso
(
    Nom                 VARCHAR(30),
    Prenoms             VARCHAR(30),
    NomComp             VARCHAR(50),
    BonusPerso          INT,
    PRIMARY KEY(Nom, Prenoms, NomComp),
    CONSTRAINT perso_ayant_bonus_comp_nom                FOREIGN KEY (Nom, Prenoms)               REFERENCES Personnages(Nom, Prenoms)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT bonus_comp_pour_perso                 FOREIGN KEY (NomComp)        REFERENCES Competences(NomComp)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT BonusPerso_min       CHECK (BonusPerso >= 0)
);

CREATE TABLE CompFacPos
(
    NomFacPos           VARCHAR(80),
    NomComp             VARCHAR(50),
    BonusFP             INT,
    PRIMARY KEY(NomFacPos, NomComp),
    CONSTRAINT FP_ayant_bonus_comp                FOREIGN KEY (NomFacPos)               REFERENCES FacultesPostures(NomFacPos)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT bonus_comp_pour_FP                 FOREIGN KEY (NomComp)        REFERENCES Competences(NomComp)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT BonusFP_min       CHECK (BonusFP >= 0),
    CONSTRAINT BonusFP_max       CHECK (BonusFP <= 30)
);

CREATE TABLE CompRace
(
    NomRace             VARCHAR(30),
    NomComp             VARCHAR(50),
    BonusR              INT,
    PRIMARY KEY(NomRace, NomComp),
    CONSTRAINT race_ayant_bonus_comp                FOREIGN KEY (NomRace)               REFERENCES Races(NomRace)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT bonus_comp_pour_race                 FOREIGN KEY (NomComp)        REFERENCES Competences(NomComp)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT BonusR_min       CHECK (BonusR >= -30),
    CONSTRAINT BonusR_max       CHECK (BonusR <= 30)
);

CREATE TABLE CompOrient
(
    NomOrientation      VARCHAR(50),
    NomComp             VARCHAR(50),
    BonusO              INT,
    PRIMARY KEY(NomOrientation, NomComp),
    CONSTRAINT orient_ayant_bonus_comp                FOREIGN KEY (NomOrientation)               REFERENCES Orientations(NomOrientation)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT bonus_comp_pour_orient                 FOREIGN KEY (NomComp)        REFERENCES Competences(NomComp)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT BonusO_min       CHECK (BonusO >= 0),
    CONSTRAINT BonusO_max       CHECK (BonusO <= 80)
);

CREATE TABLE CompType
(
    TypeBonus           VARCHAR(50),
    NomComp             VARCHAR(50),
    BonusT              INT,
    PRIMARY KEY(TypeBonus, NomComp),
    CONSTRAINT type_ayant_bonus_comp                FOREIGN KEY (TypeBonus)               REFERENCES TypeBonus(TypeBonus)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT bonus_comp_pour_type                 FOREIGN KEY (NomComp)        REFERENCES Competences(NomComp)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT BonusT_min       CHECK (BonusT >= 0),
    CONSTRAINT BonusT_max       CHECK (BonusT <= 40)
);

CREATE TABLE FacPosRace
(
    NomFacPos           VARCHAR(80),
    NomRace             VARCHAR(30),
    PRIMARY KEY(NomFacPos, NomRace),
    CONSTRAINT race_associe               FOREIGN KEY (NomRace)               REFERENCES Races(NomRace)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT facPos_de_race             FOREIGN KEY (NomFacPos)        REFERENCES FacultesPostures(NomFacPos)                   ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE FacPosComp
(
    NomFacPos           VARCHAR(80),
    NomComp             VARCHAR(50),
    PRIMARY KEY(NomFacPos, NomComp),
    CONSTRAINT comp_associe               FOREIGN KEY (NomComp)               REFERENCES Competences(NomComp)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT facPos_de_comp             FOREIGN KEY (NomFacPos)        REFERENCES FacultesPostures(NomFacPos)                   ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE FacPosOrient
(
    NomFacPos           VARCHAR(80),
    NomOrientation      VARCHAR(50),
    PRIMARY KEY(NomFacPos, NomOrientation),
    CONSTRAINT orient_associe               FOREIGN KEY (NomOrientation)          REFERENCES Orientations(NomOrientation)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT facPos_de_orient             FOREIGN KEY (NomFacPos)        REFERENCES FacultesPostures(NomFacPos)                   ON DELETE CASCADE      ON UPDATE CASCADE
);

CREATE TABLE FacPosStyleCombat
(
    NomFacPos           VARCHAR(80),
    NomStyle            VARCHAR(50),
    PRIMARY KEY(NomFacPos, NomStyle),
    CONSTRAINT style_associe               FOREIGN KEY (NomStyle)          REFERENCES StylesCombat(NomStyle)                   ON DELETE CASCADE      ON UPDATE CASCADE,
    CONSTRAINT facPos_de_style             FOREIGN KEY (NomFacPos)        REFERENCES FacultesPostures(NomFacPos)                   ON DELETE CASCADE      ON UPDATE CASCADE
);

-- Entites

CREATE TABLE Entites
(
    NomEnt              VARCHAR(50),
    DescEnt             VARCHAR(2000),
    ImgEnt             VARCHAR(250),
    PRIMARY KEY(NomEnt)
);