SELECT
    s.session_id,
    s.started_at,
    s.ended_at,
    EXTRACT(EPOCH FROM (s.ended_at - s.started_at))::INT AS duration_seconds,
    COUNT(DISTINCT sp.player_id) AS player_count,
    COUNT(DISTINCT e.event_id) AS event_count
FROM game_sessions AS s
LEFT JOIN session_players AS sp ON sp.session_id = s.session_id
LEFT JOIN telemetry_events AS e ON e.session_id = s.session_id
GROUP BY s.session_id, s.started_at, s.ended_at
ORDER BY s.started_at;

