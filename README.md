# Heartbeat

Reusable ActiveRecord concerns and migration helpers for recurring task scheduling and execution tracking across Ecosystems engines.

## Installation

Add to your Gemfile:

```ruby
gem "heartbeat", path: "../../library/heartbeat"
```

Then:

```
bundle install
```

## What It Provides

- **HeartBeatConcern** -- ActiveRecord concern for heartbeat (scheduled task) models with scheduling, scoping, and execution recording
- **HeartBeatExecutionConcern** -- ActiveRecord concern for execution log records (started, completed, failed, retried)
- **MigrationHelpers** -- Prefixed table creation helpers (`create_heartbeats_table`, `create_heartbeat_executions_table`) so each engine uses its own table prefix

## Usage

### Migration

```ruby
class CreateHeartbeats < ActiveRecord::Migration[7.1]
  include Heartbeat::MigrationHelpers

  def change
    create_heartbeats_table("my_prefix_")
    create_heartbeat_executions_table("my_prefix_")
  end
end
```

### Model

```ruby
class MyEngine::HeartBeat < ApplicationRecord
  include Heartbeat::HeartBeatConcern

  self.table_name = "my_prefix_heartbeats"
end

class MyEngine::HeartBeatExecution < ApplicationRecord
  include Heartbeat::HeartBeatExecutionConcern

  self.table_name = "my_prefix_heartbeat_executions"
end
```

### Scheduling

```ruby
# Find tasks that are due
MyEngine::HeartBeat.due.by_priority.each do |hb|
  started = Time.current
  hb.record_execution!(status: "started", started_at: started)
  # ... run the task ...
  hb.record_execution!(status: "completed", started_at: started, completed_at: Time.current)
  hb.schedule_next!
end
```

## Development

```
bundle install
bundle exec rake spec
```

## License

MIT License. See [LICENSE.txt](LICENSE.txt).
