# Heartbeat

Shared library gem. Reusable ActiveRecord concerns and migration helpers for recurring task scheduling and execution tracking.

- **HeartBeatConcern** (`lib/heartbeat/heart_beat_concern.rb`) -- Scheduling logic: `due?`, `schedule_next!`, `record_execution!`. Scopes: `enabled`, `due`, `by_priority`. Validates `task_name` (unique) and `interval_seconds`.
- **HeartBeatExecutionConcern** (`lib/heartbeat/heart_beat_execution_concern.rb`) -- Execution log: statuses `started`/`completed`/`failed`/`retried`. Scopes: `recent`, `failed`, `completed`.
- **MigrationHelpers** (`lib/heartbeat/migration_helpers.rb`) -- `create_heartbeats_table(prefix)` and `create_heartbeat_executions_table(prefix)` for engine-prefixed tables.

Each consuming engine includes the concerns in its own models and uses the migration helpers with its table prefix (e.g. `pl_` for planner).
