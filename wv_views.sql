
-- -- Vue 1 : ALL_PLAYERS
-- -- Affiche tous les joueurs ayant participé à au moins une partie, avec le tri des colonnes requis.
-- CREATE VIEW ALL_PLAYERS AS
-- SELECT 
--     p.pseudo AS nom_joueur,
--     COUNT(DISTINCT pip.id_party) AS nombre_parties_jouees,
--     COUNT(pp.id_turn) AS nombre_tours_joues,
--     MIN(pp.start_time) AS premiere_participation,
--     MAX(pp.end_time) AS derniere_action
-- FROM 
--     players AS p
-- JOIN 
--     players_in_parties AS pip ON p.id_player = pip.id_player
-- JOIN 
--     players_play AS pp ON p.id_player = pp.id_player
-- GROUP BY 
--     p.pseudo;



-- --  Vue 2 : ALL_PLAYERS_ELAPSED_GAME
-- -- Affiche le nombre de secondes écoulées pour chaque partie jouée.

-- CREATE VIEW ALL_PLAYERS_ELAPSED_GAME AS
-- SELECT 
--     p.pseudo AS nom_joueur,
--     pt.title_party AS nom_partie,
--     COUNT(DISTINCT pip.id_player) AS nombre_participants,
--     MIN(pp.start_time) AS premiere_action,
--     MAX(pp.end_time) AS derniere_action,
--     DATEDIFF(SECOND, MIN(pp.start_time), MAX(pp.end_time)) AS secondes_ecoulees
-- FROM 
--     players AS p
-- JOIN 
--     players_in_parties AS pip ON p.id_player = pip.id_player
-- JOIN 
--     parties AS pt ON pip.id_party = pt.id_party
-- JOIN 
--     players_play AS pp ON p.id_player = pp.id_player
-- GROUP BY 
--     p.pseudo, pt.title_party;
    


-- Vue 3 : ALL_PLAYERS_ELAPSED_TOUR
-- Affiche le temps moyen de chaque prise de décision par tour.
-- CREATE VIEW ALL_PLAYERS_ELAPSED_TOUR AS
-- SELECT 
--     p.pseudo AS nom_joueur,
--     pt.title_party AS nom_partie,
--     t.id_turn AS numero_tour,
--     t.start_time AS debut_tour,
--     pp.start_time AS prise_decision,
--     DATEDIFF(SECOND, t.start_time, pp.start_time) AS secondes_dans_le_tour
-- FROM 
--     players AS p
-- JOIN 
--     players_play AS pp ON p.id_player = pp.id_player
-- JOIN 
--     turns AS t ON pp.id_turn = t.id_turn
-- JOIN 
--     parties AS pt ON t.id_party = pt.id_party;


-- Vue 4 : ALL_PLAYERS_STATS
-- Affiche les statistiques de chaque joueur, y compris le temps moyen de prise de décision.
CREATE VIEW ALL_PLAYERS_STATS AS
SELECT 
    p.pseudo AS nom_joueur,
    r.description_role AS role,
    pt.title_party AS nom_partie,
    COUNT(pp.id_turn) AS nb_tours_joues,
    (
        SELECT COUNT(*) 
        FROM turns 
        WHERE id_party = pt.id_party
    ) AS nb_total_tours,
    CASE
        WHEN r.description_role = 'loup' AND pip.is_alive = 0 THEN 'loups'
        WHEN r.description_role = 'villageois' AND pip.is_alive = 1 THEN 'villageois'
        ELSE 'aucun'
    END AS vainqueur,
    AVG(DATEDIFF(SECOND, pp.start_time, pp.end_time)) AS temps_moyen_decision
FROM 
    players AS p
JOIN 
    players_in_parties AS pip ON p.id_player = pip.id_player
JOIN 
    roles AS r ON pip.id_role = r.id_role
JOIN 
    parties AS pt ON pip.id_party = pt.id_party
JOIN 
    players_play AS pp ON p.id_player = pp.id_player
GROUP BY 
    p.pseudo, r.description_role, pt.title_party, pip.is_alive, pt.id_party;
