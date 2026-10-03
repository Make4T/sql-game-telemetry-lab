SELECT
    p.player_id,
    p.display_name,
    MIN(e.numeric_value) AS minimum_oxygen,
    COUNT(*) FILTER (WHERE e.numeric_value < 80) AS low_oxygen_events,
    MAX(e.occurred_at) AS last_oxygen_event
FROM players AS p
JOIN telemetry_events AS e
    ON e.player_id = p.player_id
    AND e.event_type = 'oxygen_changed'
GROUP BY p.player_id, p.display_name
HAVING MIN(e.numeric_value) < 80
ORDER BY minimum_oxygen ASC;

