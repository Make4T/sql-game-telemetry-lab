# SQL Game Telemetry Lab

A portfolio-ready PostgreSQL project that turns game telemetry into queryable data. It models players, game sessions, session membership and timestamped gameplay events, then demonstrates practical analytics queries over that model.

## What this demonstrates

- Relational schema design with primary keys, foreign keys and integrity checks.
- JSONB metadata for event-specific details without losing a stable relational core.
- Indexing for session, player and event-type time-series lookups.
- Repeatable seed data and a PostgreSQL smoke test.
- Docker Compose for a consistent local database.
- GitHub Actions CI that starts PostgreSQL, applies the schema and runs the smoke test.

## Requirements

- Docker Desktop with Compose v2.
- Git Bash, WSL or another shell that can pipe SQL into `docker compose exec`.

## Quick start

Start PostgreSQL:

```bash
docker compose up -d
```

Apply schema, indexes and sample data:

```bash
for file in sql/schema/*.sql sql/seed/*.sql; do
  docker compose exec -T postgres psql -U telemetry -d telemetry_lab -v ON_ERROR_STOP=1 < "$file"
done
```

Run the smoke test:

```bash
docker compose exec -T postgres psql -U telemetry -d telemetry_lab -v ON_ERROR_STOP=1 < tests/smoke.sql
```

Run an analysis query:

```bash
docker compose exec -T postgres psql -U telemetry -d telemetry_lab -f /dev/stdin < sql/queries/01_session_summary.sql
```

On Windows PowerShell, the same setup is available through the included scripts:

```powershell
.\scripts\setup-db.ps1
.\scripts\run-query.ps1 -QueryFile sql/queries/01_session_summary.sql
```

Stop the database when finished:

```bash
docker compose down
```

## Repository map

| Path | Purpose |
| --- | --- |
| `sql/schema/` | Tables and indexes |
| `sql/seed/` | Deterministic sample records |
| `sql/queries/` | Reusable gameplay analytics |
| `tests/smoke.sql` | Fast integrity check |
| `.github/workflows/ci.yml` | Automated PostgreSQL validation |

## Data model

`players` and `game_sessions` are connected through `session_players`. Each `telemetry_events` row belongs to one player and one session; `metadata` stores event-specific JSONB such as zone, item or damage source.

## Next improvements

- Add partitioning for high-volume telemetry events.
- Expose the queries through a small FastAPI service.
- Add Grafana dashboards for live session health.
- Add migrations with a tool such as Flyway or Alembic.
