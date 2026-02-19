# frozen_string_literal: true

module Heartbeat
  module MigrationHelpers
    def create_heartbeats_table(prefix)
      table = :"#{prefix}heartbeats"
      create_table table do |t|
        t.string :task_name, null: false
        t.text :description
        t.integer :interval_seconds, null: false
        t.string :cron_expression
        t.datetime :last_run_at
        t.datetime :next_run_at
        t.boolean :enabled, null: false, default: true
        t.integer :priority, null: false, default: 0
        t.integer :max_retries, null: false, default: 3
        t.integer :retry_delay_seconds, null: false, default: 60
        t.json :metadata

        t.timestamps
      end

      add_index table, :task_name, unique: true
      add_index table, :next_run_at
    end

    def create_heartbeat_executions_table(prefix)
      hb_table = :"#{prefix}heartbeats"
      exec_table = :"#{prefix}heartbeat_executions"

      create_table exec_table do |t|
        t.references :heartbeat, null: false, foreign_key: { to_table: hb_table }
        t.string :status, null: false
        t.datetime :started_at, null: false
        t.datetime :completed_at
        t.integer :duration_ms
        t.text :error_message
        t.integer :attempt_number, null: false, default: 1

        t.timestamps
      end

      add_index exec_table, :status
    end
  end
end
