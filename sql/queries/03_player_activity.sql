SELECT
    p.player_id,
    p.display_name,
    COUNT(DISTINCT sp.session_id) AS sessions_played,
    COUNT(DISTINCT e.event_id) AS events_emitted,
    COUNT(DISTINCT e.event_id) FILTER (WHERE e.event_type = 'damage_taken') AS damage_events,
    COUNT(DISTINCT e.event_id) FILTER (WHERE e.event_type = 'item_collected') AS item_events
FROM players AS p
LEFT JOIN session_players AS sp ON sp.player_id = p.player_id
LEFT JOIN telemetry_events AS e ON e.player_id = p.player_id
GROUP BY p.player_id, p.display_name
ORDER BY events_emitted DESC, p.player_id;
