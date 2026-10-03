SELECT
    event_type,
    COUNT(*) AS event_count,
    ROUND(AVG(numeric_value)::NUMERIC, 2) AS average_value,
    MIN(occurred_at) AS first_seen,
    MAX(occurred_at) AS last_seen
FROM telemetry_events
GROUP BY event_type
ORDER BY event_count DESC, event_type;

