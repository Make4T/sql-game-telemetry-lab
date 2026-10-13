DO $$
BEGIN
    IF (SELECT COUNT(*) FROM players) <> 3 THEN
        RAISE EXCEPTION 'Expected 3 players';
    END IF;
    IF (SELECT COUNT(*) FROM game_sessions) <> 2 THEN
        RAISE EXCEPTION 'Expected 2 sessions';
    END IF;
    IF (SELECT COUNT(*) FROM telemetry_events) <> 6 THEN
        RAISE EXCEPTION 'Expected 6 telemetry events';
    END IF;
    IF (SELECT COUNT(*) FROM telemetry_events WHERE event_type = 'oxygen_changed') <> 4 THEN
        RAISE EXCEPTION 'Expected 4 oxygen events';
    END IF;
END;
$$;

