CREATE INDEX IF NOT EXISTS idx_events_session_time
    ON telemetry_events (session_id, occurred_at);

CREATE INDEX IF NOT EXISTS idx_events_player_time
    ON telemetry_events (player_id, occurred_at);

CREATE INDEX IF NOT EXISTS idx_events_type_time
    ON telemetry_events (event_type, occurred_at);

CREATE INDEX IF NOT EXISTS idx_memberships_player_joined
    ON session_players (player_id, joined_at);

