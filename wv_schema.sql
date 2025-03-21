-- Table des parties
CREATE TABLE parties (
    id_party INT PRIMARY KEY IDENTITY(1,1), 
    title_party VARCHAR(100) NOT NULL
);

-- Table des rôles
CREATE TABLE roles (
    id_role INT PRIMARY KEY IDENTITY(1,1),
    description_role VARCHAR(50) NOT NULL
);

-- Table des joueurs
CREATE TABLE players (
    id_player INT PRIMARY KEY IDENTITY(1,1),
    pseudo VARCHAR(50) NOT NULL UNIQUE  -- Contrainte d'unicité pour éviter les doublons
);

-- Table des joueurs par partie
CREATE TABLE players_in_parties (
    id_party INT,
    id_player INT,
    id_role INT,
    is_alive BIT DEFAULT 1,  -- Utiliser un booléen (0/1) pour plus de clarté
    PRIMARY KEY (id_party, id_player),  -- Clé composite pour éviter les doublons
    FOREIGN KEY (id_party) REFERENCES parties(id_party),
    FOREIGN KEY (id_player) REFERENCES players(id_player),
    FOREIGN KEY (id_role) REFERENCES roles(id_role)
);

-- Table des tours
CREATE TABLE turns (
    id_turn INT PRIMARY KEY IDENTITY(1,1),
    id_party INT,
    start_time DATETIME NOT NULL,
    end_time DATETIME,
    FOREIGN KEY (id_party) REFERENCES parties(id_party)
);

-- Table des actions des joueurs
CREATE TABLE players_play (
    id_play INT PRIMARY KEY IDENTITY(1,1),
    id_player INT,
    id_turn INT,
    start_time DATETIME NOT NULL,
    end_time DATETIME,
    action VARCHAR(10) CHECK (action IN ('move', 'pass')),  -- Vérification des actions valides
    origin_position_col INT,
    origin_position_row INT,
    target_position_col INT,
    target_position_row INT,
    FOREIGN KEY (id_player) REFERENCES players(id_player),
    FOREIGN KEY (id_turn) REFERENCES turns(id_turn)
);

-- Index pour optimiser les requêtes fréquentes
CREATE INDEX idx_players_pseudo ON players(pseudo);
CREATE INDEX idx_turns_party ON turns(id_party);
CREATE INDEX idx_plays_player_turn ON players_play(id_player, id_turn);
