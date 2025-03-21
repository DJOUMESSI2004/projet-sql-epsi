
-- Vue 1 : ALL_PLAYERS
-- Affiche tous les joueurs ayant participé à au moins une partie, avec le tri des colonnes requis.
CREATE VIEW ALL_PLAYERS AS
SELECT 
    p.pseudo AS nom_joueur,
    COUNT(DISTINCT pip.id_party) AS nombre_parties_jouees,
    COUNT(pp.id_turn) AS nombre_tours_joues,
    MIN(pp.start_time) AS premiere_participation,
    MAX(pp.end_time) AS derniere_action
FROM 
    players AS p
JOIN 
    players_in_parties AS pip ON p.id_player = pip.id_player
JOIN 
    players_play AS pp ON p.id_player = pp.id_player
GROUP BY 
    p.pseudo;
