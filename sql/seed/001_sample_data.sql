INSERT INTO players (player_id, display_name)
VALUES
    ('p-001', 'Aino'),
    ('p-002', 'Mika'),
    ('p-003', 'Sami')
ON CONFLICT (player_id) DO NOTHING;

INSERT INTO game_sessions (session_id, started_at, ended_at)
VALUES
    ('session-001', '2026-09-01 18:00:00+03', '2026-09-01 18:32:00+03'),
    ('session-002', '2026-09-02 19:10:00+03', '2026-09-02 19:47:00+03')
ON CONFLICT (session_id) DO NOTHING;

INSERT INTO session_players (session_id, player_id, joined_at, left_at)
VALUES
    ('session-001', 'p-001', '2026-09-01 18:00:10+03', '2026-09-01 18:32:00+03'),
    ('session-001', 'p-002', '2026-09-01 18:00:20+03', '2026-09-01 18:32:00+03'),
    ('session-002', 'p-001', '2026-09-02 19:10:05+03', '2026-09-02 19:47:00+03'),
    ('session-002', 'p-003', '2026-09-02 19:10:10+03', '2026-09-02 19:47:00+03')
ON CONFLICT (session_id, player_id) DO NOTHING;

INSERT INTO telemetry_events
    (occurred_at, session_id, player_id, event_type, numeric_value, metadata)
VALUES
    ('2026-09-01 18:04:00+03', 'session-001', 'p-001', 'oxygen_changed', 96, '{"zone":"reef"}'),
    ('2026-09-01 18:12:00+03', 'session-001', 'p-001', 'oxygen_changed', 74, '{"zone":"trench"}'),
    ('2026-09-01 18:14:00+03', 'session-001', 'p-002', 'item_collected', 1, '{"item":"medkit"}'),
    ('2026-09-02 19:18:00+03', 'session-002', 'p-003', 'damage_taken', 22, '{"source":"creature"}'),
    ('2026-09-02 19:22:00+03', 'session-002', 'p-001', 'oxygen_changed', 68, '{"zone":"trench"}'),
    ('2026-09-02 19:30:00+03', 'session-002', 'p-003', 'oxygen_changed', 83, '{"zone":"cavern"}')
ON CONFLICT DO NOTHING;

