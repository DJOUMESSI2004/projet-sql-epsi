-- Table des parties
CREATE TABLE parties (
    id_party INT PRIMARY KEY IDENTITY(1,1),  -- Utilisation d'une identité auto-incrémentée
    title_party VARCHAR(100) NOT NULL
);
create table roles (
    id_role INT PRIMARY KEY IDENTITY(1,1),
    description_role text
);

create table players (
    id_player int,
    pseudo text
);

create table players_in_parties (
    id_party INT PRIMARY KEY IDENTITY(1,1),
    id_player int,
    id_role int,
    is_alive text
);

create table turns (
    id_turn INT PRIMARY KEY IDENTITY(1,1),
    id_party int,
    start_time datetime,
    end_time datetime
);

create table players_play (
    id_player INT PRIMARY KEY IDENTITY(1,1),
    id_turn int,
    start_time datetime,
    end_time datetime,
    action varchar(10),
    origin_position_col text,
    origin_position_row text,
    target_position_col text,
    target_position_row text
);